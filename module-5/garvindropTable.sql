/*
 * Name:       Garvin Stewart
 * Date:       November 22, 2026
 * Assignment: CSD 430 Module 5 - Project Part 1 (Database Setup)
 * Purpose:    Drops the garvin_movies_data table so it can be recreated cleanly.
 *
 * Citation:   Script drafted with assistance from Claude (Anthropic AI), November 2026;
 *             reviewed and run by Garvin Stewart.
 *
 * Run as:     mysql -u student1 -p CSD430 < garvindropTable.sql   (password: pass)
 */


-- Section 1: make sure we are in the course database
USE CSD430;


-- Section 2: remove the table (IF EXISTS prevents an error on a fresh database)
DROP TABLE IF EXISTS garvin_movies_data;
