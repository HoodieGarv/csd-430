<%--
    Name:       Garvin Stewart
    Date:       November 22, 2026
    Assignment: CSD 430 Module 5 - Project Part 1 (Database Setup)
    Purpose:    Landing page linking to this module's CRUD deliverables for the CSD430 movies database.

    Citation:   Page drafted with assistance from Claude (Anthropic AI), November 2026;
                reviewed by Garvin Stewart.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD 430 - Garvin's Movies Database</title>

    <%-- Minimal styling so the link list is readable --%>
    <style>
        body  { font-family: Arial, sans-serif; margin: 40px; max-width: 760px; }
        h1    { margin-bottom: 4px; }
        .sub  { color: #555; margin-top: 0; }
        table { border-collapse: collapse; width: 100%; margin-top: 16px; }
        th, td { border: 1px solid #ccc; padding: 8px 10px; text-align: left; }
        th    { background: #f0f0f0; }
    </style>
</head>
<body>

    <%-- Page header --%>
    <h1>Garvin's Movies Database</h1>
    <p class="sub">CSD 430 Server Side Development &middot; Database: CSD430 &middot; Table: garvin_movies_data</p>


    <%-- Module 5 deliverables: database creation (the "C" in CRUD) --%>
    <h2>Module 5 &ndash; Create and Populate</h2>
    <table>
        <tr>
            <th>CRUD Operation</th>
            <th>Deliverable</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Create</td>
            <td><a href="garvincreateTable.sql">garvincreateTable.sql</a></td>
            <td>Creates the CSD430 database, the student1 user, and the movies table.</td>
        </tr>
        <tr>
            <td>Create</td>
            <td><a href="garvinpopulateTable.sql">garvinpopulateTable.sql</a></td>
            <td>Inserts 12 movie records and displays them.</td>
        </tr>
        <tr>
            <td>Delete</td>
            <td><a href="garvindropTable.sql">garvindropTable.sql</a></td>
            <td>Drops the movies table so it can be rebuilt.</td>
        </tr>
    </table>

</body>
</html>
