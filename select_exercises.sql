-- 1. Create a new file called select_exercises.sql. Store your code for this exercise in that file. You should be testing your code in MySQL Workbench as you go.
-- 2. Use the albums_db database.
USE albums_db;

-- 3. Explore the structure of the albums table.
DESCRIBE albums;

-- a. How many rows are in the albums table?
-- 31
SELECT COUNT(id) FROM albums;

-- b. How many unique artist names are in the albums table?
-- 23
SELECT COUNT(DISTINCT artist) FROM albums;

-- c. What is the primary key for the albums table?
-- id

-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
-- oldest release date = 1967, most recent release date = 2011
SELECT MAX(release_date) FROM albums;
SELECT MIN(release_date) FROM albums;

-- 4. Write queries to find the following information:
-- a. The name of all albums by Pink Floyd
-- 'The Dark Side of the Moon', 'The Wall'
SELECT name FROM albums WHERE artist = 'Pink Floyd';

-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
-- 1967
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- c. The genre for the album Nevermind
-- Grunge, Alternative rock
SELECT genre FROM albums WHERE name = 'Nevermind';

-- d. Which albums were released in the 1990s
SELECT name FROM albums WHERE release_date BETWEEN 1990 and 1999;
-- 11 albums: 
-- The Bodyguard
-- Jagged Little Pill
-- Come On Over
-- Falling into You
-- Let's Talk About Love
-- Dangerous
-- The Immaculate Collection
-- Titanic: Music from the Motion Picture
-- Metallica
-- Nevermind
-- Supernatural

-- e. Which albums had less than 20 million certified sales
SELECT name FROM albums WHERE sales < 20;
-- 13 albums:
-- Grease: The Original Soundtrack from the Motion Picture
-- Bad
-- Sgt. Pepper's Lonely Hearts Club Band
-- Dirty Dancing
-- Let's Talk About Love
-- Dangerous
-- The Immaculate Collection
-- Abbey Road
-- Born in the U.S.A.
-- Brothers in Arms
-- Titanic: Music from the Motion Picture
-- Nevermind
-- The Wall

-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
-- They do, if you use the LIKE function and the % wildcard
SELECT name, genre FROM albums WHERE genre LIKE '%Rock%';

-- 5. Be sure to add, commit, and push your work.