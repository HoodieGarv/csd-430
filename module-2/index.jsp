<%--
    Name:        Garvin Stewart
    Date:        November 1, 2026
    Assignment:  CSD 430 Module 2 Assignment - JSP Scriptlets
    Purpose:     Display a categorized character record set from "The Count of Monte Cristo"
                 in an HTML table, using scriptlets for Java code and external CSS for styling.

    Citation:    Code drafted with assistance from Claude (Anthropic AI), November 2026,
                 and reviewed/edited by the author. Character facts from Alexandre Dumas,
                 "The Count of Monte Cristo" (1844-1846, public domain).
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, java.util.LinkedHashMap, java.util.List, java.util.Map" %>

<%
    // ---------------------------------------------------------------
    // Page-level metadata: title, book details, and overall description
    // ---------------------------------------------------------------
    String pageTitle       = "The Count of Monte Cristo: Character Records";
    String bookTitle       = "The Count of Monte Cristo";
    String bookAuthor      = "Alexandre Dumas";
    String bookPublished   = "1844-1846";
    String dataDescription = "This data set records seven major characters from the novel. "
                           + "Each record captures the character's name, the role they play in the story, "
                           + "and their most important contribution to the plot. Records are grouped into "
                           + "three categories based on where each character stands in relation to "
                           + "Edmond Dantès and his revenge.";

    // ---------------------------------------------------------------
    // Field descriptions: {field name, description}
    // Order matches the column order of every record below.
    // ---------------------------------------------------------------
    String[][] fieldDescriptions = {
        {"Character",        "The character's name as it appears in the novel."},
        {"Role",             "The character's function or position in the story."},
        {"Key Contribution", "The most important thing the character does to move the plot forward."}
    };

    // ---------------------------------------------------------------
    // Category descriptions: {category name, description}
    // These double as the record (group) descriptions shown above the table.
    // ---------------------------------------------------------------
    String[][] categoryDescriptions = {
        {"The Avenger",     "The central character whose imprisonment and revenge drive the story."},
        {"Allies & Mentors","Characters who help, teach, or are protected by Dantès."},
        {"The Conspirators","The men whose betrayal sends Dantès to prison and who become targets of his revenge."}
    };

    // ---------------------------------------------------------------
    // Build the grouped record set.
    // LinkedHashMap keeps categories in insertion order so the table
    // displays them in the same order as the category descriptions.
    // Each record is a String array: {character, role, key contribution}
    // ---------------------------------------------------------------
    Map<String, List<String[]>> recordsByCategory = new LinkedHashMap<>();

    for (String[] category : categoryDescriptions) {
        recordsByCategory.put(category[0], new ArrayList<String[]>());
    }

    recordsByCategory.get("The Avenger").add(new String[] {
        "Edmond Dantès", "Protagonist; later the Count of Monte Cristo",
        "Escapes the Château d'If after 14 years and uses a hidden fortune to punish those who betrayed him."
    });

    recordsByCategory.get("Allies & Mentors").add(new String[] {
        "Abbé Faria", "Fellow prisoner and mentor",
        "Educates Dantès in prison and reveals the location of the treasure on the island of Monte Cristo."
    });
    recordsByCategory.get("Allies & Mentors").add(new String[] {
        "Maximilien Morrel", "Son of Dantès's former employer",
        "Represents the loyalty Dantès rewards; his story balances the novel's revenge with mercy."
    });
    recordsByCategory.get("Allies & Mentors").add(new String[] {
        "Mercédès", "Dantès's former fiancée",
        "Recognizes the Count and pleads for her son's life, pushing Dantès to question his revenge."
    });

    recordsByCategory.get("The Conspirators").add(new String[] {
        "Fernand Mondego", "Rival for Mercédès; later Count de Morcerf",
        "Mails the false accusation against Dantès, then marries Mercédès."
    });
    recordsByCategory.get("The Conspirators").add(new String[] {
        "Danglars", "Ship's accountant; later a wealthy banker",
        "Writes the anonymous letter accusing Dantès of being a Bonapartist agent."
    });
    recordsByCategory.get("The Conspirators").add(new String[] {
        "Gérard de Villefort", "Deputy crown prosecutor",
        "Buries Dantès in prison to protect his own political career."
    });

    // ---------------------------------------------------------------
    // Summary values computed from the data for the table caption/footer
    // ---------------------------------------------------------------
    int totalRecords = 0;
    for (List<String[]> group : recordsByCategory.values()) {
        totalRecords += group.size();
    }
    int totalFields     = fieldDescriptions.length;
    int totalCategories = recordsByCategory.size();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

    <!-- Page header: title and book details -->
    <header class="page-header">
        <h1><%= pageTitle %></h1>
        <p class="book-meta">
            <em><%= bookTitle %></em> by <%= bookAuthor %> (<%= bookPublished %>)
        </p>
    </header>

    <main>

        <!-- Overall data description -->
        <section class="panel">
            <h2>About This Data</h2>
            <p><%= dataDescription %></p>
        </section>

        <!-- Field descriptions, generated from the fieldDescriptions array -->
        <section class="panel">
            <h2>Field Descriptions</h2>
            <dl class="description-list">
            <% for (String[] field : fieldDescriptions) { %>
                <dt><%= field[0] %></dt>
                <dd><%= field[1] %></dd>
            <% } %>
            </dl>
        </section>

        <!-- Record category descriptions, generated from the categoryDescriptions array -->
        <section class="panel">
            <h2>Record Categories</h2>
            <dl class="description-list">
            <% for (String[] category : categoryDescriptions) { %>
                <dt><%= category[0] %></dt>
                <dd><%= category[1] %></dd>
            <% } %>
            </dl>
        </section>

        <!-- Main data table: one tbody per category so records are grouped -->
        <section class="panel">
            <h2>Character Records</h2>
            <table class="record-table">
                <caption>
                    <%= totalRecords %> records, <%= totalFields %> fields, <%= totalCategories %> categories
                </caption>

                <!-- Column headers built from the field names -->
                <thead>
                    <tr>
                    <% for (String[] field : fieldDescriptions) { %>
                        <th scope="col"><%= field[0] %></th>
                    <% } %>
                    </tr>
                </thead>

                <!-- Outer loop: one group per category. Inner loop: one row per record. -->
                <% for (Map.Entry<String, List<String[]>> group : recordsByCategory.entrySet()) { %>
                <tbody>
                    <tr class="category-row">
                        <th scope="colgroup" colspan="<%= totalFields %>">
                            <%= group.getKey() %>
                            <span class="record-count">(<%= group.getValue().size() %>)</span>
                        </th>
                    </tr>
                    <% for (String[] record : group.getValue()) { %>
                    <tr>
                        <td class="character-name"><%= record[0] %></td>
                        <td><%= record[1] %></td>
                        <td><%= record[2] %></td>
                    </tr>
                    <% } %>
                </tbody>
                <% } %>
            </table>
        </section>

    </main>

    <!-- Footer with source citation -->
    <footer class="page-footer">
        <p>Source: Alexandre Dumas, <em><%= bookTitle %></em> (<%= bookPublished %>). CSD 430 Module 2.</p>
    </footer>

</body>
</html>
