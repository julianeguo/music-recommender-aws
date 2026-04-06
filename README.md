### music-recommender-aws
A web app using AWS that recommends similar songs based on user input!

# To run the app:
Simply open the "frontend.html" file in the browser and use the app. Because we are simulating our ML model with a DB (containing 16 songs and 10 recommendations for each song), users would only able to select the songs in the autocomplete search bar. Start typing something to see recommendations. Some sample songs to try out: vampire by Olivia Rodrigo, As It Was by Harry Styles, among many other songs in autocomplete.

If you would like to launch the app without the frontend ui, open a new terminal and run the client.py. Ensure you have python requests installed. The API Gateway endpoint is separately provided in the .ini file.

Note: Our DB simulates the outputs of an ML model because we weren't able to deploy our model on AWS SageMaker due to SageMaker's version clashes. All the recommended songs included is from our actual ML model, which is also included in this .zip: the "sagemaker_spotify.ipynb" is the file directly downloaded from AWS SageMaker's Jupyter notebook. The "ml_model_google_colab_version.ipynb" is the file we used to run and produce our 160 recommended songs on Google Colab (as we were facing difficulties with running sagemaker). The two files are virtually the same except for some minor differences in imports.
These files for the machine learning models are not actually included in our deployed app, but are included for reference/in case you would like to run them.


# Setting up the API Gateway & Lambda function:

* The lambda function contents is included in the "recommend.py" file
* To set up:

Lambda:
	* Create a new lambda function called "recommend"; specify the runtime as python 3.x
	* Select the same VPC as the RDS instance
	* Connect the lambda function to two layers: a request layer and a layer for pymysql (both can be installed using a zip uploaded to either the bucket or directly from the local device
	* Go to the lambda function -> configuration, and enter the below fields:
	* DB_NAME = spotifySongs (provided in our SQL file)
	* PASSWORD = password of the DB (if you are recreating this I assume you will be making your own DB)
	* RDS_PROXY_HOST = mysql-julianeguo-cs310.cv4sisyoaten.us-east-2.rds.amazonaws.com for our server; it should be your own RDS endpoint (found in RDS -> your DB -> Connectivity & security -> Endpoint)
	* Then, go to this link: https://developer.spotify.com/dashboard, click create app, and get your own Spotify client ID and client secret. Then, click save, and you will be redirected to your app's landing page. Click settings to find the client ID and secret.
	* SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET = the fields you just retrieved
	* USER_NAME = username of the DB connection, e.g. admin
	* Attach the AWSLambdaVPCAccessExecutionRole IAM policy to the lambda function


# API Gateway:
	* Create a new REST API on API Gateway
	* Create a new resource called "recommend"
	* Under "recommend" create a new resource, "{songname}"
	* Under "{songname}" create a new resource, "{artistname}"
	* Under "{artistname}" create a method, GET; it should be connected with the lambda function "recommend"
	* Select "{artistname}" and click "Enable CORS"
	* Create a new stage called "prod" and deploy the API Gateway
	* Copy your API Gateway URL and update it in frontend.html

# Setting up the server:
* Right now, the relevant AWS databases are all running. However, if you would like to create your own, follow the below steps:
* Initialize a database with the same configuration as the previous assignments in this class
	* Make a connection to the DB and run the SQL code provided
	* Configure the DB with the lambda function as seen above

That should be it!

