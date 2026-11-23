<%--
    Name:       Garvin Stewart
    Date:       November 22, 2026
    Assignment: CSD 430 Module 6 - READ, JDBC, and JavaBeans
    Purpose:    Display page: uses MovieBean to read the record for the selected key and shows every field in an HTML table.

    Citation:   Drafted with assistance from Claude (Anthropic AI), November 2026;
                reviewed and tested by Garvin Stewart.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="csd430.module6.MovieBean" %>

<%-- Create the bean for this request --%>
<jsp:useBean id="movieBean" class="csd430.module6.MovieBean" scope="request" />

<%
    // Read and validate the key submitted from index.jsp
    String keyParam = request.getParameter("movieId");
    boolean recordFound = false;
    String problem = null;

    if (keyParam == null || keyParam.trim().isEmpty()) {
        problem = "No movie key was submitted.";
    } else {
        try {
            int selectedId = Integer.parseInt(keyParam.trim());

            // Ask the bean to load that record from the database
            recordFound = movieBean.loadMovie(selectedId);
            if (!recordFound) {
                problem = movieBean.getErrorMessage();
            }
        } catch (NumberFormatException e) {
            problem = "The movie key must be a whole number.";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Garvin's Movies Database - Record</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <main class="container">

        <h1>Movie Record</h1>

        <%-- Overall data description --%>
        <p class="description">
            Record retrieved from the <strong>garvin_movies_data</strong> table in the
            <strong>CSD430</strong> database through the MovieBean JavaBean. The table holds one
            row per film, keyed by <code>movie_id</code>.
        </p>

        <% if (recordFound) { %>

            <%-- Record description: a plain-language summary of the selected row --%>
            <p class="record-summary">
                Record <%= movieBean.getMovieId() %> describes
                <em><%= MovieBean.escapeHtml(movieBean.getTitle()) %></em>, a
                <%= movieBean.getReleaseYear() %> <%= MovieBean.escapeHtml(movieBean.getGenre()).toLowerCase() %>
                film directed by <%= MovieBean.escapeHtml(movieBean.getDirector()) %>. It runs
                <%= movieBean.getRuntimeMinutes() %> minutes and is rated
                <%= MovieBean.escapeHtml(movieBean.getMpaaRating()) %>.
            </p>

            <%-- The selected record: one column per field, titles in thead --%>
            <table class="record-table">
                <caption>Selected record (key <%= movieBean.getMovieId() %>)</caption>
                <thead>
                    <tr>
                        <th>Movie ID</th>
                        <th>Title</th>
                        <th>Director</th>
                        <th>Release Year</th>
                        <th>Genre</th>
                        <th>Runtime (min)</th>
                        <th>MPAA Rating</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= movieBean.getMovieId() %></td>
                        <td><%= MovieBean.escapeHtml(movieBean.getTitle()) %></td>
                        <td><%= MovieBean.escapeHtml(movieBean.getDirector()) %></td>
                        <td><%= movieBean.getReleaseYear() %></td>
                        <td><%= MovieBean.escapeHtml(movieBean.getGenre()) %></td>
                        <td><%= movieBean.getRuntimeMinutes() %></td>
                        <td><%= MovieBean.escapeHtml(movieBean.getMpaaRating()) %></td>
                    </tr>
                </tbody>
            </table>

            <%-- Field descriptions --%>
            <h2>Field Descriptions</h2>
            <table class="field-table">
                <thead>
                    <tr>
                        <th>Field</th>
                        <th>Column</th>
                        <th>Type</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td>Movie ID</td><td>movie_id</td><td>INT, primary key</td><td>Unique, auto-numbered key for the record; the value chosen in the dropdown.</td></tr>
                    <tr><td>Title</td><td>title</td><td>VARCHAR(100)</td><td>Official title of the film.</td></tr>
                    <tr><td>Director</td><td>director</td><td>VARCHAR(100)</td><td>Credited director (or directing team).</td></tr>
                    <tr><td>Release Year</td><td>release_year</td><td>YEAR</td><td>Year the film opened in U.S. theaters.</td></tr>
                    <tr><td>Genre</td><td>genre</td><td>VARCHAR(30)</td><td>Primary genre the film is classified under.</td></tr>
                    <tr><td>Runtime (min)</td><td>runtime_minutes</td><td>SMALLINT</td><td>Theatrical running time in minutes.</td></tr>
                    <tr><td>MPAA Rating</td><td>mpaa_rating</td><td>VARCHAR(5)</td><td>Motion Picture Association content rating (G, PG, PG-13, R).</td></tr>
                </tbody>
            </table>

        <% } else { %>

            <p class="error"><%= MovieBean.escapeHtml(problem) %></p>

        <% } %>

        <p><a href="index.jsp" class="back-link">&larr; Look up another movie</a></p>

    </main>
</body>
</html>
