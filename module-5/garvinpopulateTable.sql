/*
 * Name:       Garvin Stewart
 * Date:       November 22, 2026
 * Assignment: CSD 430 Module 5 - Project Part 1 (Database Setup)
 * Purpose:    Inserts 12 movie records into garvin_movies_data and displays them.
 *
 * Citation:   Script structure drafted with assistance from Claude (Anthropic AI), November 2026;
 *             reviewed and run by Garvin Stewart.
 *
 * Run as:     mysql -u student1 -p CSD430 < garvinpopulateTable.sql   (password: pass)
 */


-- Section 1: make sure we are in the course database
USE CSD430;


-- Section 2: insert the records
-- movie_id is omitted because it is AUTO_INCREMENT.
INSERT INTO garvin_movies_data
    (title, director, release_year, genre, runtime_minutes, mpaa_rating)
VALUES
    ('The Shawshank Redemption', 'Frank Darabont',          1994, 'Drama',     142, 'R'),
    ('The Godfather',            'Francis Ford Coppola',    1972, 'Crime',     175, 'R'),
    ('Jurassic Park',            'Steven Spielberg',        1993, 'Adventure', 127, 'PG-13'),
    ('Pulp Fiction',             'Quentin Tarantino',       1994, 'Crime',     154, 'R'),
    ('Forrest Gump',             'Robert Zemeckis',         1994, 'Drama',     142, 'PG-13'),
    ('Toy Story',                'John Lasseter',           1995, 'Animation',  81, 'G'),
    ('The Matrix',               'Lana and Lilly Wachowski',1999, 'Sci-Fi',    136, 'R'),
    ('Spirited Away',            'Hayao Miyazaki',          2001, 'Animation', 125, 'PG'),
    ('The Dark Knight',          'Christopher Nolan',       2008, 'Action',    152, 'PG-13'),
    ('Inception',                'Christopher Nolan',       2010, 'Sci-Fi',    148, 'PG-13'),
    ('Get Out',                  'Jordan Peele',            2017, 'Horror',    104, 'R'),
    ('Black Panther',            'Ryan Coogler',            2018, 'Action',    134, 'PG-13');


-- Section 3: display every record (screenshot this output)
SELECT * FROM garvin_movies_data;
