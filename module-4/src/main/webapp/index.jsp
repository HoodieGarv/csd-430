<%--
    Name:        Garvin Stewart
    Date:        November 15, 2026
    Assignment:  CSD 430 Module 4 - JavaBean Data Display

    Purpose:     Reads movie data from a JavaBean and displays it in a formatted HTML table.

    Rules followed on this page:
      - The data lives in the JavaBeans (beans.MovieDataBean and
        beans.MovieRecordBean), not in this page.
      - All Java code lives inside scriptlet blocks.
      - Every HTML tag sits outside the scriptlet blocks; Java values reach the
        page only through JSP expressions.
      - All styling comes from the external stylesheet css/styles.css.

    Source note: Page structure and comments drafted with help from Claude (Anthropic),
                 then reviewed and edited by the author. Adapted from the author's
                 Module 2 Java Scriptlet - Data Display page.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="beans.MovieDataBean, beans.MovieRecordBean, java.util.List" %>

<%-- Create the data bean (its constructor loads the data set) --%>
<jsp:useBean id="movieData" class="beans.MovieDataBean" scope="request" />

<%
    // ---------------------------------------------------------------
    // PULL PAGE-LEVEL VALUES FROM THE BEAN
    // Values are escaped once here so the HTML below stays simple.
    // ---------------------------------------------------------------
    String movieTitle = MovieDataBean.escapeHtml(movieData.getMovieTitle());
    int releaseYear = movieData.getReleaseYear();
    String dataDescription = MovieDataBean.escapeHtml(movieData.getDataDescription());
    String[] categoryOrder = movieData.getCategoryOrder();
    String[] categoryDescriptions = movieData.getCategoryDescriptions();
    int totalRecords = movieData.getTotalRecords();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= movieTitle %> - JavaBean Data Display</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

    <!-- Page title -->
    <header class="page-header">
        <h1><%= movieTitle %> (<%= releaseYear %>)</h1>
        <p class="subtitle">Movie data served from a JavaBean</p>
    </header>

    <main>

        <!-- Overall data description -->
        <section class="data-description">
            <h2>About This Data</h2>
            <p><%= dataDescription %></p>
            <p>
                The table below shows <strong><%= totalRecords %></strong> records in
                <strong><%= categoryOrder.length %></strong> categories. Every record is a
                <code>MovieRecordBean</code> object stored inside a <code>MovieDataBean</code>.
                Both classes implement <code>java.io.Serializable</code>.
            </p>
        </section>

        <!-- Field descriptions: explains the five fields in each record -->
        <section class="field-descriptions">
            <h2>Field Descriptions</h2>
            <table class="legend-table">
                <thead>
                    <tr>
                        <th>Field</th>
                        <th>Bean Property</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Record ID</td>
                        <td><code>recordId</code></td>
                        <td>The record's position in the full data set (1 to <%= totalRecords %>).</td>
                    </tr>
                    <tr>
                        <td>Category</td>
                        <td><code>category</code></td>
                        <td>The topical group a record belongs to (shown as a header row).</td>
                    </tr>
                    <tr>
                        <td>Attribute</td>
                        <td><code>attribute</code></td>
                        <td>What the record describes, such as a crew role or a character name.</td>
                    </tr>
                    <tr>
                        <td>Value</td>
                        <td><code>value</code></td>
                        <td>The data for that attribute, such as a person, date, or amount.</td>
                    </tr>
                    <tr>
                        <td>Record Description</td>
                        <td><code>description</code></td>
                        <td>Extra context explaining the record.</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <!-- Main data table, grouped by category -->
        <section class="movie-data">
            <h2>Movie Records</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Attribute</th>
                        <th>Value</th>
                        <th>Record Description</th>
                    </tr>
                </thead>
                <tbody>
<%
    // ---------------------------------------------------------------
    // OUTER LOOP: one pass per category, in the order the bean provides
    // ---------------------------------------------------------------
    for (int categoryIndex = 0; categoryIndex < categoryOrder.length; categoryIndex++) {
        String currentCategory = categoryOrder[categoryIndex];
        List<MovieRecordBean> categoryRecords = movieData.getRecordsByCategory(currentCategory);
%>
                    <!-- Category header row -->
                    <tr class="category-row">
                        <td colspan="4">
                            <span class="category-name"><%= MovieDataBean.escapeHtml(currentCategory) %></span>
                            <span class="category-note"><%= MovieDataBean.escapeHtml(categoryDescriptions[categoryIndex]) %></span>
                            <span class="category-count">(<%= categoryRecords.size() %> records)</span>
                        </td>
                    </tr>
<%
        // -----------------------------------------------------------
        // INNER LOOP: one table row per record bean in this category
        // -----------------------------------------------------------
        for (MovieRecordBean record : categoryRecords) {
%>
                    <tr>
                        <td class="record-id"><%= record.getRecordId() %></td>
                        <td class="attribute"><%= MovieDataBean.escapeHtml(record.getAttribute()) %></td>
                        <td class="value"><%= MovieDataBean.escapeHtml(record.getValue()) %></td>
                        <td class="description"><%= MovieDataBean.escapeHtml(record.getDescription()) %></td>
                    </tr>
<%
        } // end inner loop (records)
    } // end outer loop (categories)
%>
                </tbody>
            </table>
        </section>

    </main>

    <!-- Footer -->
    <footer class="page-footer">
        <p>CSD 430 Module 4 &middot; JavaBean Data Display &middot; Garvin Stewart</p>
    </footer>

</body>
</html>
