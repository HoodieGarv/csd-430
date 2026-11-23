/*
 * Name:       Garvin Stewart
 * Date:       November 22, 2026
 * Assignment: CSD 430 Module 6 - READ, JDBC, and JavaBeans
 * Purpose:    Command-line utility that creates, populates, and deletes CSD430.garvin_movies_data.
 *
 * Usage (MySQL Connector/J jar on the classpath; use ; instead of : on Windows):
 *     java -cp "classes:mysql-connector-j-8.4.0.jar" csd430.module6.MovieTableManager create
 *     ... populate | drop | reset | show
 *
 * Prerequisite: the CSD430 database and the student1 account already exist.
 * Those are set up by an administrator with garvincreateTable.sql, not
 * through the bean (the bean only connects with student1's credentials).
 *
 * Citation:   Drafted with assistance from Claude (Anthropic AI), November 2026;
 *             reviewed and tested by Garvin Stewart.
 */
package csd430.module6;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MovieTableManager {

    private static final String TABLE = MovieBean.TABLE_NAME;

    // Seed data, identical to garvinpopulateTable.sql:
    // title, director, release_year, genre, runtime_minutes, mpaa_rating
    private static final Object[][] MOVIES = {
        {"The Shawshank Redemption", "Frank Darabont",           1994, "Drama",     142, "R"},
        {"The Godfather",            "Francis Ford Coppola",     1972, "Crime",     175, "R"},
        {"Jurassic Park",            "Steven Spielberg",         1993, "Adventure", 127, "PG-13"},
        {"Pulp Fiction",             "Quentin Tarantino",        1994, "Crime",     154, "R"},
        {"Forrest Gump",             "Robert Zemeckis",          1994, "Drama",     142, "PG-13"},
        {"Toy Story",                "John Lasseter",            1995, "Animation",  81, "G"},
        {"The Matrix",               "Lana and Lilly Wachowski", 1999, "Sci-Fi",    136, "R"},
        {"Spirited Away",            "Hayao Miyazaki",           2001, "Animation", 125, "PG"},
        {"The Dark Knight",          "Christopher Nolan",        2008, "Action",    152, "PG-13"},
        {"Inception",                "Christopher Nolan",        2010, "Sci-Fi",    148, "PG-13"},
        {"Get Out",                  "Jordan Peele",             2017, "Horror",    104, "R"},
        {"Black Panther",            "Ryan Coogler",             2018, "Action",    134, "PG-13"}
    };


    /** Creates the table with the same structure as garvincreateTable.sql. */
    public static void createTable(Connection conn) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS " + TABLE + " ("
                   + "movie_id INT NOT NULL AUTO_INCREMENT, "
                   + "title VARCHAR(100) NOT NULL, "
                   + "director VARCHAR(100) NOT NULL, "
                   + "release_year YEAR NOT NULL, "
                   + "genre VARCHAR(30) NOT NULL, "
                   + "runtime_minutes SMALLINT NOT NULL, "
                   + "mpaa_rating VARCHAR(5) NOT NULL, "
                   + "PRIMARY KEY (movie_id))";
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
        }
        System.out.println("Table " + TABLE + " created (or already present).");
    }

    /**
     * Empties the table and inserts the seed records.
     * TRUNCATE (not DELETE) resets AUTO_INCREMENT, so keys always run 1-12.
     */
    public static void populateTable(Connection conn) throws SQLException {
        String insert = "INSERT INTO " + TABLE + " (title, director, release_year, genre, "
                      + "runtime_minutes, mpaa_rating) VALUES (?, ?, ?, ?, ?, ?)";

        try (Statement clear = conn.createStatement();
             PreparedStatement stmt = conn.prepareStatement(insert)) {

            clear.executeUpdate("TRUNCATE TABLE " + TABLE);

            // Queue one insert per movie, then send them together
            for (Object[] movie : MOVIES) {
                stmt.setString(1, (String) movie[0]);
                stmt.setString(2, (String) movie[1]);
                stmt.setInt(3, (Integer) movie[2]);
                stmt.setString(4, (String) movie[3]);
                stmt.setInt(5, (Integer) movie[4]);
                stmt.setString(6, (String) movie[5]);
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
        System.out.println(MOVIES.length + " records inserted into " + TABLE + ".");
    }

    /** Deletes the table entirely. */
    public static void dropTable(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("DROP TABLE IF EXISTS " + TABLE);
        }
        System.out.println("Table " + TABLE + " dropped.");
    }

    /** Prints every record to confirm the table contents. */
    public static void showTable(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM " + TABLE + " ORDER BY movie_id")) {
            while (rs.next()) {
                System.out.printf("%-3d %-25s %-25s %d  %-10s %3d min  %s%n",
                        rs.getInt("movie_id"), rs.getString("title"),
                        rs.getString("director"), rs.getInt("release_year"),
                        rs.getString("genre"), rs.getInt("runtime_minutes"),
                        rs.getString("mpaa_rating"));
            }
        }
    }


    /** Entry point: runs the action named in the first argument. */
    public static void main(String[] args) {
        String action = (args.length > 0) ? args[0].toLowerCase() : "";

        try (Connection conn = MovieBean.openConnection()) {
            switch (action) {
                case "create":   createTable(conn);                     break;
                case "populate": populateTable(conn);                   break;
                case "drop":     dropTable(conn);                       break;
                case "reset":    dropTable(conn);
                                 createTable(conn);
                                 populateTable(conn);                   break;
                case "show":     showTable(conn);                       break;
                default:
                    System.out.println("Usage: MovieTableManager create | populate | drop | reset | show");
            }
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            System.exit(1);
        }
    }
}
