<%--
    Name:       Garvin Stewart
    Date:       11/08/2026
    Assignment: CSD 430 Module 3 - JSP Forms (Programming Assignment)
    Purpose:    Receive the restaurant feedback form submission and display
                the data in an HTML table with field descriptions.

    Source citation: Request-handling pattern based on Prof. Darrell Payne's
    Module 3 examples (Form_04.jsp). Initial draft generated with assistance
    from Claude,  then reviewed and edited by me.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    // Helper methods (JSP declaration block) shared by the scriptlets below.

    /**
     * Escapes HTML special characters so user input is displayed as plain
     * text and cannot inject markup or scripts into the results page.
     */
    private String escapeHtml(String rawText) {
        if (rawText == null) {
            return "";
        }
        return rawText.replace("&", "&amp;")
                      .replace("<", "&lt;")
                      .replace(">", "&gt;")
                      .replace("\"", "&quot;")
                      .replace("'", "&#39;");
    }

    /**
     * Returns the escaped, trimmed value, or "Not provided" when the
     * field was left blank or never sent.
     */
    private String displayValue(String rawText) {
        if (rawText == null || rawText.trim().isEmpty()) {
            return "Not provided";
        }
        return escapeHtml(rawText.trim());
    }

    /**
     * Converts a 1-5 rating into a short text description.
     */
    private String describeRating(String ratingText) {
        if (ratingText == null) {
            return "Not rated";
        }
        switch (ratingText) {
            case "1": return "1 - Poor";
            case "2": return "2 - Fair";
            case "3": return "3 - Good";
            case "4": return "4 - Very Good";
            case "5": return "5 - Excellent";
            default:  return "Invalid rating";
        }
    }
%>

<%
    // Make sure request parameters are read as UTF-8 (names with accents, etc.)
    request.setCharacterEncoding("UTF-8");

    // Only a POST from the form should reach this page; a direct GET has no data.
    boolean isFormSubmission = "POST".equalsIgnoreCase(request.getMethod());

    // Read each single-value field from the request.
    String customerName  = displayValue(request.getParameter("customerName"));
    String customerEmail = displayValue(request.getParameter("customerEmail"));
    String visitDate     = displayValue(request.getParameter("visitDate"));
    String partySize     = displayValue(request.getParameter("partySize"));
    String mealPeriod    = displayValue(request.getParameter("mealPeriod"));
    String foodRating    = describeRating(request.getParameter("foodRating"));
    String serviceRating = describeRating(request.getParameter("serviceRating"));
    String returnVisit   = displayValue(request.getParameter("returnVisit"));
    String comments      = displayValue(request.getParameter("comments"));

    // Checkboxes can send several values under one name, or none at all.
    String[] itemsOrdered = request.getParameterValues("itemsOrdered");
    boolean hasItemsOrdered = (itemsOrdered != null && itemsOrdered.length > 0);

    // Count the fields the customer actually filled in, for the summary line.
    int fieldsCompleted = 0;
    String[] singleValueFields = { customerName, customerEmail, visitDate, partySize,
                                   mealPeriod, returnVisit, comments };
    for (String fieldValue : singleValueFields) {
        if (!"Not provided".equals(fieldValue)) {
            fieldsCompleted++;
        }
    }
    if (!"Not rated".equals(foodRating))    { fieldsCompleted++; }
    if (!"Not rated".equals(serviceRating)) { fieldsCompleted++; }
    if (hasItemsOrdered)                    { fieldsCompleted++; }
    int totalFields = 10;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Received</title>
        <style>
            body    { font-family: Arial, Helvetica, sans-serif; margin: 30px; max-width: 900px; }
            table   { border-collapse: collapse; width: 100%; }
            th, td  { border: 1px solid #999; padding: 8px 10px; text-align: left; vertical-align: top; }
            th      { background-color: #2f4f4f; color: #ffffff; }
            tr:nth-child(even) td { background-color: #f2f2f2; }
            caption { font-weight: bold; padding-bottom: 8px; text-align: left; }
            .note   { color: #555; font-size: 0.9em; }
        </style>
    </head>
    <body>
        <h1>Stewart's Grill &mdash; Feedback Received</h1>

<%
    if (!isFormSubmission) {
%>
        <!-- Shown when the page is opened directly instead of through the form -->
        <p>No feedback was submitted. Please fill out the
           <a href="feedbackForm.jsp">feedback form</a> first.</p>
<%
    } else {
%>
        <!-- Overall description of the data being displayed -->
        <p>
            Thank you, <strong><%= customerName %></strong>. The table below shows the
            restaurant experience feedback you submitted. Each record lists the form field,
            a description of what that field captures, and the value you entered.
            You completed <strong><%= fieldsCompleted %></strong> of
            <strong><%= totalFields %></strong> fields.
        </p>

        <!-- Submitted data in table format: field name, field description, value -->
        <table>
            <caption>Customer Feedback Record</caption>
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Description</th>
                    <th>Your Response</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Full Name</td>
                    <td>Name of the customer submitting feedback</td>
                    <td><%= customerName %></td>
                </tr>
                <tr>
                    <td>Email Address</td>
                    <td>Contact address for any follow-up from management</td>
                    <td><%= customerEmail %></td>
                </tr>
                <tr>
                    <td>Date of Visit</td>
                    <td>Day the customer dined at the restaurant (YYYY-MM-DD)</td>
                    <td><%= visitDate %></td>
                </tr>
                <tr>
                    <td>Party Size</td>
                    <td>Number of guests seated together</td>
                    <td><%= partySize %></td>
                </tr>
                <tr>
                    <td>Meal Period</td>
                    <td>Time of day the meal was served</td>
                    <td><%= mealPeriod %></td>
                </tr>
                <tr>
                    <td>Food Quality</td>
                    <td>Rating of the food on a 1 (Poor) to 5 (Excellent) scale</td>
                    <td><%= foodRating %></td>
                </tr>
                <tr>
                    <td>Service Quality</td>
                    <td>Rating of the staff and service on a 1 to 5 scale</td>
                    <td><%= serviceRating %></td>
                </tr>
                <tr>
                    <td>Items Ordered</td>
                    <td>Courses the party ordered (multiple selections allowed)</td>
                    <td>
<%
        if (hasItemsOrdered) {
%>
                        <ul>
<%
            // Loop over each checked box; the <li> tag stays outside the scriptlet.
            for (String orderedItem : itemsOrdered) {
%>
                            <li><%= escapeHtml(orderedItem) %></li>
<%
            }
%>
                        </ul>
<%
        } else {
%>
                        None selected
<%
        }
%>
                    </td>
                </tr>
                <tr>
                    <td>Return Visit</td>
                    <td>Whether the customer would dine here again</td>
                    <td><%= returnVisit %></td>
                </tr>
                <tr>
                    <td>Comments</td>
                    <td>Open-ended feedback about the meal or service</td>
                    <td><%= comments %></td>
                </tr>
            </tbody>
        </table>

        <p class="note">
            Submitted on <%= java.time.LocalDate.now() %>.
            <a href="feedbackForm.jsp">Submit another response</a>.
        </p>
<%
    }
%>
    </body>
</html>
