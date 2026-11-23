/*
 * Name:       Garvin Stewart
 * Date:       November 22, 2026
 * Assignment: CSD 430 Module 6 - READ, JDBC, and JavaBeans
 * Purpose:    JavaBean that reads movie records from CSD430.garvin_movies_data over JDBC for the JSP pages.
 *
 * Citation:   Drafted with assistance from Claude (Anthropic AI), November 2026;
 *             reviewed and tested by Garvin Stewart.
 */
package csd430.module6;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class MovieBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // ---------------------------------------------------------------
    // Connection settings required by the assignment. Shared with
    // MovieTableManager so both use the same database, user, and table.
    // ---------------------------------------------------------------
    public static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    public static final String DB_URL      = "jdbc:mysql://localhost:3306/CSD430";
    public static final String DB_USER     = "student1";
    public static final String DB_PASSWORD = "pass";
    public static final String TABLE_NAME  = "garvin_movies_data";


    // ---------------------------------------------------------------
    // Properties for one movie record (one per table column)
    // ---------------------------------------------------------------
    private int    movieId;
    private String title;
    private String director;
    private int    releaseYear;
    private String genre;
    private int    runtimeMinutes;
    private String mpaaRating;

    // Last database error, so the JSP can show it instead of crashing
    private String errorMessage;


    /** Required public no-argument constructor for a JavaBean. */
    public MovieBean() {
    }


    // ---------------------------------------------------------------
    // Database access
    // ---------------------------------------------------------------

    /**
     * Opens a JDBC connection using the student1 account.
     * The driver is loaded explicitly because Tomcat does not always
     * auto-register drivers found in WEB-INF/lib.
     */
    public static Connection openConnection() throws SQLException {
        try {
            Class.forName(JDBC_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver not found. "
                    + "Place mysql-connector-j in WEB-INF/lib.", e);
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    /**
     * Returns every primary key in the table, in order, mapped to its title.
     * The key becomes the dropdown value; the title is a readable label.
     * Returns an empty map (and sets errorMessage) on failure.
     */
    public Map<Integer, String> getMovieOptions() {
        Map<Integer, String> options = new LinkedHashMap<>();
        String sql = "SELECT movie_id, title FROM " + TABLE_NAME + " ORDER BY movie_id";

        try (Connection conn = openConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                options.put(rs.getInt("movie_id"), rs.getString("title"));
            }
        } catch (SQLException e) {
            errorMessage = "Could not load movie keys: " + e.getMessage();
        }
        return options;
    }

    /**
     * Loads the record with the given key into this bean's properties.
     * A PreparedStatement keeps the submitted key from injecting SQL.
     *
     * @param id the movie_id selected by the user
     * @return true if a record was found, false otherwise
     */
    public boolean loadMovie(int id) {
        String sql = "SELECT movie_id, title, director, release_year, genre, "
                   + "runtime_minutes, mpaa_rating FROM " + TABLE_NAME
                   + " WHERE movie_id = ?";

        try (Connection conn = openConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    movieId        = rs.getInt("movie_id");
                    title          = rs.getString("title");
                    director       = rs.getString("director");
                    releaseYear    = rs.getInt("release_year");
                    genre          = rs.getString("genre");
                    runtimeMinutes = rs.getInt("runtime_minutes");
                    mpaaRating     = rs.getString("mpaa_rating");
                    return true;
                }
                errorMessage = "No movie exists with key " + id + ".";
            }
        } catch (SQLException e) {
            errorMessage = "Could not load movie " + id + ": " + e.getMessage();
        }
        return false;
    }


    // ---------------------------------------------------------------
    // Helper: makes database text safe to place inside HTML
    // ---------------------------------------------------------------
    public static String escapeHtml(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }


    // ---------------------------------------------------------------
    // Getters and setters
    // ---------------------------------------------------------------
    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    public int getReleaseYear() { return releaseYear; }
    public void setReleaseYear(int releaseYear) { this.releaseYear = releaseYear; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public int getRuntimeMinutes() { return runtimeMinutes; }
    public void setRuntimeMinutes(int runtimeMinutes) { this.runtimeMinutes = runtimeMinutes; }

    public String getMpaaRating() { return mpaaRating; }
    public void setMpaaRating(String mpaaRating) { this.mpaaRating = mpaaRating; }

    public String getErrorMessage() { return errorMessage; }
    public void setErrorMessage(String errorMessage) { this.errorMessage = errorMessage; }
}
