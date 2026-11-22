/*
 * Name:       Garvin Stewart
 * Date:       November 22, 2026
 * Assignment: CSD 430 Module 5 - Project Part 1 (Database Setup)
 * Purpose:    Creates the CSD430 database, the student1 user, and the garvin_movies_data table.
 *
 * Citation:   Script structure drafted with assistance from Claude (Anthropic AI), November 2026;
 *             reviewed and run by Garvin Stewart.
 *
 * Run as:     root (needed for CREATE USER / GRANT), e.g.
 *             mysql -u root -p < garvincreateTable.sql
 */


-- Section 1: create the database (skipped if it already exists)
CREATE DATABASE IF NOT EXISTS CSD430;


-- Section 2: create the course user and give it full rights on CSD430 only
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;


-- Section 3: switch to the course database
USE CSD430;


-- Section 4: create the movies table
-- movie_id is the primary key and auto-increments so the JSP/JavaBean
-- inserts in later modules do not have to supply an ID.
CREATE TABLE garvin_movies_data (
    movie_id        INT           NOT NULL AUTO_INCREMENT,
    title           VARCHAR(100)  NOT NULL,
    director        VARCHAR(100)  NOT NULL,
    release_year    YEAR          NOT NULL,
    genre           VARCHAR(30)   NOT NULL,
    runtime_minutes SMALLINT      NOT NULL,
    mpaa_rating     VARCHAR(5)    NOT NULL,
    PRIMARY KEY (movie_id)
);


-- Section 5: confirm the table structure (screenshot this output)
DESCRIBE garvin_movies_data;
