<%--
    Name:       Garvin Stewart
    Date:       November 22, 2026
    Assignment: CSD 430 Module 6 - READ, JDBC, and JavaBeans
    Purpose:    Input page: uses MovieBean to list every key in garvin_movies_data in a dropdown,
                and links to the module's CRUD deliverables.

    Citation:   Drafted with assistance from Claude (Anthropic AI), November 2026;
                reviewed and tested by Garvin Stewart.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="csd430.module6.MovieBean" %>

<%-- Create the bean for this request --%>
<jsp:useBean id="movieBean" class="csd430.module6.MovieBean" scope="request" />

<%
    // Read every key (and its title) from the database through the bean
    Map<Integer, String> movieOptions = movieBean.getMovieOptions();
    String loadError = movieBean.getErrorMessage();
    boolean hasOptions = !movieOptions.isEmpty();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Garvin's Movies Database - Lookup</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <main class="container">

        <h1>Garvin's Movies Database</h1>

        <%-- Overall data description --%>
        <p class="description">
            This application reads from the <strong>garvin_movies_data</strong> table in the
            <strong>CSD430</strong> MySQL database. Each record describes one well-known feature
            film released between 1972 and 2018: its title, director, release year, genre,
            runtime, and MPAA rating. Choose a movie key below to view that record.
        </p>


        <%-- READ: lookup form --%>
        <h2>Read a Record</h2>

        <%-- Show a database error if the keys could not be loaded --%>
        <% if (loadError != null) { %>
            <p class="error"><%= MovieBean.escapeHtml(loadError) %></p>
        <% } %>

        <% if (hasOptions) { %>
            <form action="display.jsp" method="get" class="lookup-form">
                <label for="movieId">Movie key (movie_id):</label>

                <select id="movieId" name="movieId" required>
                    <option value="" disabled selected>-- Select a key --</option>

                    <%-- One option per key held in the database --%>
                    <% for (Map.Entry<Integer, String> entry : movieOptions.entrySet()) { %>
                        <option value="<%= entry.getKey() %>"><%= entry.getKey() %> - <%= MovieBean.escapeHtml(entry.getValue()) %></option>
                    <% } %>
                </select>

                <button type="submit">View Record</button>
            </form>

            <p class="note"><%= movieOptions.size() %> keys found in the database.</p>
        <% } else if (loadError == null) { %>
            <p class="error">The garvin_movies_data table is empty. Run garvinpopulateTable.sql first.</p>
        <% } %>


        <%-- Links to every CRUD deliverable for this module --%>
        <h2>Module Deliverables</h2>
        <table class="field-table">
            <thead>
                <tr>
                    <th>CRUD Operation</th>
                    <th>Deliverable</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Create</td>
                    <td><a href="sql/garvincreateTable.sql">garvincreateTable.sql</a></td>
                    <td>Creates the CSD430 database, grants student1 access, and creates the table.</td>
                </tr>
                <tr>
                    <td>Create</td>
                    <td><a href="sql/garvinpopulateTable.sql">garvinpopulateTable.sql</a></td>
                    <td>Inserts the 12 movie records.</td>
                </tr>
                <tr>
                    <td>Read</td>
                    <td><a href="index.jsp">index.jsp</a> &rarr; display.jsp</td>
                    <td>Selects a key from the dropdown above and displays that record through MovieBean.</td>
                </tr>
                <tr>
                    <td>Delete</td>
                    <td><a href="sql/garvindropTable.sql">garvindropTable.sql</a></td>
                    <td>Drops the table so it can be rebuilt.</td>
                </tr>
            </tbody>
        </table>

    </main>
</body>
</html>
