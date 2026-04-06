-- start of writing for final project

-- 
-- create the database of Spotify songs:
--
USE sys;


DROP DATABASE IF EXISTS spotifySongs;
CREATE DATABASE spotifySongs;


-- 
-- now create the table:
--
USE spotifySongs;


DROP TABLE IF EXISTS songs;


CREATE TABLE songs
(
    songid          int not null AUTO_INCREMENT,
    songname        varchar(256) not null,
    artistname      varchar(256) not null,
    PRIMARY KEY  (songid)
);

ALTER TABLE songs AUTO_INCREMENT = 70001;  -- starting value

CREATE TABLE recs
(
    songid          int not null,
    songrecname     varchar(256) not null,
    artistname      varchar(256) not null,
    FOREIGN KEY (songid) REFERENCES songs(songid)
);

-- adding 16 songs that can be tested
-- LALA
INSERT INTO songs(songname, artistname)
VALUES ('LALA','Myke Towers');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Call Out My Name','The Weeknd'),
(@songid,'98 Braves','Morgan Wallen'),
(@songid,'Romantic Homicide','d4vd'),
(@songid,'Hold My Hand','Lady Gaga'),
(@songid,'Do They Know It''s Christmas? - 1984 Version','Band Aid'),
(@songid,'Miss You','Southstar'),
(@songid,'Cigarettes','Juice WRLD'),
(@songid,'For Youth','BTS'),
(@songid,'Overdrive','Post Malone'),
(@songid,'abcdefu','Gayle');


-- vampire
INSERT INTO songs(songname, artistname)
VALUES ('vampire','Olivia Rodrigo');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Wild Flower (with Youjeen)','RM'),
(@songid,'Yonaguni','Bad Bunny'),
(@songid,'Blinding Lights','The Weeknd'),
(@songid,'Plan A','Paulo Londra'),
(@songid,'10 Things I Hate About You','Leah Kate'),
(@songid,'Would''ve, Could''ve, Should''ve','Taylor Swift'),
(@songid,'Snooze','SZA'),
(@songid,'Notice Me','SZA'),
(@songid,'Underneath The Tree','Kelly Clarkson'),
(@songid,'Unstoppable','Sia');


-- Cruel Summer
INSERT INTO songs(songname, artistname)
VALUES ('Cruel Summer','Taylor Swift');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Poland','Lil Yachty'),
(@songid,'Master Of Puppets (Remastered)','Metallica'),
(@songid,'Metamorphosis','Interworld'),
(@songid,'Makeba','Jain'),
(@songid,'Freaks','Surf Curse'),
(@songid,'After Dark','Mr.Kitty'),
(@songid,'Apocalypse','Cigarettes After Sex'),
(@songid,'Forever','Labrinth'),
(@songid,'Alien Blues','Vundabar'),
(@songid,'Static','Steve Lacy');


-- WHERE SHE GOES
INSERT INTO songs(songname, artistname)
VALUES ('WHERE SHE GOES','Bad Bunny');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Music For A Sushi Restaurant','Harry Styles'),
(@songid,'Happy','NF'),
(@songid,'Still Life','BIGBANG'),
(@songid,'Me Fui De Vacaciones','Bad Bunny'),
(@songid,'All Too Well (10 Minute Version)','Taylor Swift'),
(@songid,'Void','Melanie Martinez'),
(@songid,'Need To Know','Doja Cat'),
(@songid,'Snowman','Sia'),
(@songid,'Devil Don''t Know','Morgan Wallen'),
(@songid,'Por Las Noches','Peso Pluma');


-- fukumean
INSERT INTO songs(songname, artistname)
VALUES ('fukumean','Gunna');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Hope','XXXTENTACION'),
(@songid,'Another Love','Tom Odell'),
(@songid,'Love Again','The Kid LAROI'),
(@songid,'Running Up That Hill','Kate Bush'),
(@songid,'Take Me To Church','Hozier'),
(@songid,'Say Yes To Heaven','Lana Del Rey'),
(@songid,'Let Me Down Slowly','Alec Benjamin'),
(@songid,'TV','Billie Eilish'),
(@songid,'Blind','SZA'),
(@songid,'A Tale By Quincy','The Weeknd');


-- Super Shy
INSERT INTO songs(songname, artistname)
VALUES ('Super Shy','NewJeans');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Aguacero','Bad Bunny'),
(@songid,'Polaroid Love','ENHYPEN'),
(@songid,'La Bachata','Manuel Turizo'),
(@songid,'Last Christmas','Wham!'),
(@songid,'Forget Me','Lewis Capaldi'),
(@songid,'About Damn Time','Lizzo'),
(@songid,'Truth Hurts','Lizzo'),
(@songid,'Out Of Time','The Weeknd'),
(@songid,'Cardigan','Taylor Swift'),
(@songid,'Infinity','Jaymes Young');


-- Flowers
INSERT INTO songs(songname, artistname)
VALUES ('Flowers','Miley Cyrus');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Special','SZA'),
(@songid,'Happier Than Ever','Billie Eilish'),
(@songid,'Sparks','Coldplay'),
(@songid,'Boyfriends','Harry Styles'),
(@songid,'It''ll Be Okay','Shawn Mendes'),
(@songid,'Nobody Gets Me','SZA'),
(@songid,'Falling','Harry Styles'),
(@songid,'All Of Me','John Legend'),
(@songid,'San Lucas','Kevin Kaarl'),
(@songid,'Matilda','Harry Styles');


-- Daylight
INSERT INTO songs(songname, artistname)
VALUES ('Daylight','David Kushner');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Like Crazy (English Version)','Jimin'),
(@songid,'Overdrive','Post Malone'),
(@songid,'Ginseng Strip 2002','Yung Lean'),
(@songid,'Hits Different','Taylor Swift'),
(@songid,'Do They Know It''s Christmas? - 1984 Version','Band Aid'),
(@songid,'Permission To Dance','BTS'),
(@songid,'F2F','SZA'),
(@songid,'Ghost','Justin Bieber'),
(@songid,'Watermelon Sugar','Harry Styles'),
(@songid,'Betty (Get Money)','Yung Gravy');


-- As It Was
INSERT INTO songs(songname, artistname)
VALUES ('As It Was','Harry Styles');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'I Ain''t Worried','OneRepublic'),
(@songid,'I Wrote The Book','Morgan Wallen'),
(@songid,'Have You Ever Seen The Rain?','Creedence Clearwater Revival'),
(@songid,'Sacrifice','The Weeknd'),
(@songid,'Supermodel','Måneskin'),
(@songid,'Flowers','Miley Cyrus'),
(@songid,'Late Night Talking','Harry Styles'),
(@songid,'Circles','Post Malone'),
(@songid,'The Feels','TWICE'),
(@songid,'Why''d You Only Call Me When You''re High?','Arctic Monkeys');


-- Kill Bill
INSERT INTO songs(songname, artistname)
VALUES ('Kill Bill','SZA');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Shut Up My Moms Calling','Hotel Ugly'),
(@songid,'Die For You','The Weeknd'),
(@songid,'Viva La Vida','Coldplay'),
(@songid,'Atlantis','Seafret'),
(@songid,'Don''t Blame Me','Taylor Swift'),
(@songid,'The Color Violet','Tory Lanez'),
(@songid,'Cool For The Summer','Demi Lovato'),
(@songid,'Alien Superstar','Beyonce'),
(@songid,'Summertime Sadness','Lana Del Rey'),
(@songid,'The Hills','The Weeknd');


-- Like Crazy
INSERT INTO songs(songname, artistname)
VALUES ('Like Crazy','Jimin');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'I Am','IVE'),
(@songid,'Under The Influence','Chris Brown'),
(@songid,'Gasoline','The Weeknd'),
(@songid,'Counting Stars','OneRepublic'),
(@songid,'Star Walkin''','Lil Nas X'),
(@songid,'Take My Breath','The Weeknd'),
(@songid,'Super Shy','NewJeans'),
(@songid,'Slomo','Chanel'),
(@songid,'Set Me Free Pt.2','Jimin'),
(@songid,'Don''t Start Now','Dua Lipa');


-- Last Night
INSERT INTO songs(songname, artistname)
VALUES ('Last Night','Morgan Wallen');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Daydreaming','Harry Styles'),
(@songid,'Tacones Rojos','Sebastian Yatra'),
(@songid,'El Gordo Trae El Mando','Chino Pacas'),
(@songid,'Space Song','Beach House'),
(@songid,'Sabor Fresa','Fuerza Regida'),
(@songid,'TQM','Fuerza Regida'),
(@songid,'Merry Christmas Everyone','Shakin Stevens'),
(@songid,'Sugar Rush Ride','Tomorrow X Together'),
(@songid,'Mi Bello Angel','Natanael Cano'),
(@songid,'Malvada','Ze Felipe');


-- Rush
INSERT INTO songs(songname, artistname)
VALUES ('Rush','Troye Sivan');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Chemical','Post Malone'),
(@songid,'Unstoppable','Sia'),
(@songid,'Wild Flower (with Youjeen)','RM'),
(@songid,'10 Things I Hate About You','Leah Kate'),
(@songid,'Plan A','Paulo Londra'),
(@songid,'Less Than Zero','The Weeknd'),
(@songid,'Somewhere Only We Know','Keane'),
(@songid,'505','Arctic Monkeys'),
(@songid,'Cruel Summer','Taylor Swift'),
(@songid,'Radio','Lana Del Rey');


-- Anti-Hero
INSERT INTO songs(songname, artistname)
VALUES ('Anti-Hero','Taylor Swift');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'N95','Kendrick Lamar'),
(@songid,'The Business','Tiesto'),
(@songid,'New Jeans','NewJeans'),
(@songid,'Antes De Perderte','Duki'),
(@songid,'Dance Monkey','Tones And I'),
(@songid,'Money','LISA'),
(@songid,'Todo De Ti','Rauw Alejandro'),
(@songid,'Punto G','Quevedo'),
(@songid,'Celebrando','Rauw Alejandro'),
(@songid,'Vista Al Mar','Quevedo');


-- TQM
INSERT INTO songs(songname, artistname)
VALUES ('TQM','Fuerza Regida');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Softcore','The Neighbourhood'),
(@songid,'Happier Than Ever - Edit','Billie Eilish'),
(@songid,'Perfect','Ed Sheeran'),
(@songid,'Do I Wanna Know?','Arctic Monkeys'),
(@songid,'Creep','Radiohead'),
(@songid,'Thousand Miles','The Kid LAROI'),
(@songid,'All Too Well (10 Minute Version)','Taylor Swift'),
(@songid,'Me And Your Mama','Childish Gambino'),
(@songid,'How Do I Say Goodbye','Dean Lewis'),
(@songid,'In The Stars','Benson Boone');


-- People
INSERT INTO songs(songname, artistname)
VALUES ('People','Libianca');

SET @songid = LAST_INSERT_ID();

INSERT INTO recs(songid,songrecname,artistname) VALUES
(@songid,'Celestial','Ed Sheeran'),
(@songid,'Sweater Weather','The Neighbourhood'),
(@songid,'You Belong With Me (Taylor''s Version)','Taylor Swift'),
(@songid,'Acapulco','Jason Derulo'),
(@songid,'Take My Breath','The Weeknd'),
(@songid,'Just The Way You Are','Bruno Mars'),
(@songid,'Pepas','Farruko'),
(@songid,'Dandelions','Ruth B.'),
(@songid,'Adore You','Harry Styles'),
(@songid,'Style','Taylor Swift');


FLUSH PRIVILEGES;