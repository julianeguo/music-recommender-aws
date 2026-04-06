import sys
import logging
import pymysql
import os
import json
import boto3
import base64
import requests
from urllib.parse import unquote

### code for setting up connection to DB, adapted from Amazon RDS docs
# rds settings
user_name = os.environ['USER_NAME']
password = os.environ['PASSWORD']
rds_proxy_host = os.environ['RDS_PROXY_HOST']
db_name = os.environ['DB_NAME']

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# create the database connection outside of the handler to allow connections to be
# re-used by subsequent function invocations.
# makes dbConn
try:
    dbConn = pymysql.connect(host=rds_proxy_host, user=user_name, passwd=password, db=db_name, connect_timeout=5)
except pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)
    sys.exit(1)

logger.info("SUCCESS: Connection to RDS for MySQL instance succeeded")

# adapted from Spotify API docs: https://developer.spotify.com/documentation/web-api/tutorials/client-credentials-flow
def get_spotify_token():
    client_id = os.environ["SPOTIFY_CLIENT_ID"]
    client_secret = os.environ["SPOTIFY_CLIENT_SECRET"]
    
    # base64 encode "client_id:client_secret" (what the docs describe)
    credentials = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()
    
    response = requests.post(
        "https://accounts.spotify.com/api/token",
        headers={
            "Authorization": f"Basic {credentials}",
            "Content-Type": "application/x-www-form-urlencoded"
        },
        data={"grant_type": "client_credentials"}
    )
    
    return response.json()["access_token"]


def lambda_handler(event, context):
    print("FULL EVENT:", json.dumps(event))
    params = event["pathParameters"]
    songname = unquote(params["songname"])
    artistname = unquote(params["artistname"])
    # locates 10 songrecs in DB (ML simulator)
    def finds_songrecs():
        try:
            print("** Search in DB for user-entered songs **")

            dbCursor = dbConn.cursor() #dbCursor
            
            sql =   """
                    SELECT recs.songrecname, recs.artistname FROM recs
                    JOIN songs ON recs.songid = songs.songid
                    WHERE songs.songname = %s AND songs.artistname = %s;
                    """
            dbCursor.execute(sql, [songname, artistname])
            rows = dbCursor.fetchall()
            songrecs = [{"songname": row[0], "artistname": row[1]} for row in rows]
            return songrecs
        
        except Exception as err:
            logging.error("error in finds_songrecs():")
            logging.error(str(err))
            raise

        finally:
            try: 
                dbCursor.close()
            except:
                pass

    # returns list of 10 dictionaries of found song information
    def search_10_songs(songrecs):
        try:
            print("** Calls Spotify API and searches 10 songs **")

            # spotify auth process
            token = get_spotify_token()
            headers = {"Authorization": f"Bearer {token}"}

            baseurl = "https://api.spotify.com/v1/search"

            songrec_info = []

            for song in songrecs:
                params = {
                    "q": f"track:{song['songname']} artist:{song['artistname']}",
                    "type": "track",
                    "limit": 1
                }
                response = requests.get(baseurl, headers=headers, params=params)
                data = response.json()
                track = data["tracks"]["items"][0]

                spotify_url = track["external_urls"]["spotify"]
                track_id = track["id"]

                songrec_info.append(
                    {"songname": track["name"],
                    "artistname": track["artists"][0]["name"],
                    "spotify_url": track["external_urls"]["spotify"],
                    "track_id": track["id"],
                    "album_art": track["album"]["images"][0]["url"]}
                    )
            return songrec_info 
        
        except Exception as err:
            logging.error("error in finds_songrecs():")
            logging.error(str(err))
            raise

        finally:
            pass

    def search_artist(artist):
        try:
            print("** Calls Spotify API and searches artist **")
            # spotify auth process
            token = get_spotify_token()
            headers = {"Authorization": f"Bearer {token}"}

            baseurl = "https://api.spotify.com/v1/search"

            params = {
                "q": f"artist:{artist}",
                "type": "artist",
                "limit": 1
            }
            response = requests.get(baseurl, headers=headers, params=params)
            data = response.json()
            artists = data["artists"]["items"]
            
            if not artists:
                logging.error("no artists found in search_artist()")
                return []
            
            artist_id = artists[0]["id"]  # this is what the docs show

            baseurl1 = f"https://api.spotify.com/v1/artists/{artist_id}/albums"
            params1 = {
                "include_groups": "album, single, appears_on",
                "limit": 5
            }
            response1 = requests.get(baseurl1, headers=headers, params=params1)
            data1 = response1.json()
            albums = []
            for album in data1["items"]:
                albums.append({
                    "albumname": album["name"],
                    "release_date": album["release_date"],
                    "spotify_url": album["external_urls"]["spotify"],
                    "album_art": album["images"][0]["url"]
                })
            
            return albums
        except Exception as err:
            logging.error("error in search_artist():")
            logging.error(str(err))
            raise

        finally:
            pass      

    try:
        songrecs = finds_songrecs() # 10 songs!! each song is dictionary item in array
        # if song not in DB, return empty immediately
        if not songrecs:
            return {
                'statusCode': 200,
                'headers': {'Access-Control-Allow-Origin': '*'},
                'body': json.dumps({
                    "message": "success",
                    "songrec_info": [],
                    "albums": []
                })
            }
        songrec_info = search_10_songs(songrecs) # link, info, cover art of all 10 songs!!
        albums = search_artist(artistname)

        print("**Responding...")
        body = {
        "message": "success",
        "songrec_info": songrec_info,
        "albums": albums,
        }

        return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'GET'
        },
        'body': json.dumps({
            "message": "success",
            "songrec_info": songrec_info,
            "albums": albums
        })
    }
        
    #
    # exception handling:
    #
    except Exception as e:
        print("**Exception")
        print("**Message:", str(e))

        #
        # server-side error:
        #
        return {
            'statusCode': 500,
            'body': json.dumps({
                "message": str(e),
                "songrec_info": None,
                "albums": None,
            })
        }
