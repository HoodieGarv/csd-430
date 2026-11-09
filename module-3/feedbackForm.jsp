<%--
    Name:       Garvin Stewart
    Date:       11/08/2026
    Assignment: CSD 430 Module 3 - JSP Forms (Programming Assignment)
    Purpose:    Collect restaurant meal/service feedback from a customer and
                submit it to feedbackResults.jsp for display.

    Source citation: Structure based on Prof. Payne's Module 3
    examples (Form_01.jsp - Form_04.jsp). Initial draft generated with
    assistance from Claude (Anthropic AI), then reviewed and edited by me.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Today's date, used as the default and the max value for the visit date
    // field so a customer cannot pick a date in the future.
    String todayDate = java.time.LocalDate.now().toString();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Restaurant Experience Feedback</title>
        <style>
            body     { font-family: Arial, Helvetica, sans-serif; margin: 30px; max-width: 700px; }
            fieldset { margin-bottom: 18px; padding: 12px 18px; }
            legend   { font-weight: bold; }
            label    { display: inline-block; margin: 4px 0; }
            .note    { color: #555; font-size: 0.9em; }
        </style>
    </head>
    <body>
        <h1>Stewart's Grill &mdash; Customer Feedback</h1>
        <p class="note">
            Thank you for dining with us. Please tell us about your meal and the
            service you received. Fields marked * are required.
        </p>

        <!-- Form posts every field to the separate display page -->
        <form method="post" action="feedbackResults.jsp">

            <!-- Section 1: customer and visit information (text, email, date, number, select) -->
            <fieldset>
                <legend>About Your Visit</legend>

                <label for="customerName">Full name *</label><br>
                <input type="text" id="customerName" name="customerName" maxlength="50" required><br>

                <label for="customerEmail">Email address *</label><br>
                <input type="email" id="customerEmail" name="customerEmail" maxlength="60" required><br>

                <label for="visitDate">Date of visit *</label><br>
                <input type="date" id="visitDate" name="visitDate"
                       value="<%= todayDate %>" max="<%= todayDate %>" required><br>

                <label for="partySize">Number of guests in your party *</label><br>
                <input type="number" id="partySize" name="partySize" min="1" max="20" value="2" required><br>

                <label for="mealPeriod">Meal period</label><br>
                <select id="mealPeriod" name="mealPeriod">
                    <option value="Breakfast">Breakfast</option>
                    <option value="Lunch">Lunch</option>
                    <option value="Dinner" selected>Dinner</option>
                    <option value="Late Night">Late Night</option>
                </select>
            </fieldset>

            <!-- Section 2: ratings (radio buttons, 1 = poor, 5 = excellent) -->
            <fieldset>
                <legend>Ratings (1 = Poor, 5 = Excellent)</legend>

                <p>Food quality *<br>
                    <label><input type="radio" name="foodRating" value="1" required> 1</label>
                    <label><input type="radio" name="foodRating" value="2"> 2</label>
                    <label><input type="radio" name="foodRating" value="3"> 3</label>
                    <label><input type="radio" name="foodRating" value="4"> 4</label>
                    <label><input type="radio" name="foodRating" value="5"> 5</label>
                </p>

                <p>Service quality *<br>
                    <label><input type="radio" name="serviceRating" value="1" required> 1</label>
                    <label><input type="radio" name="serviceRating" value="2"> 2</label>
                    <label><input type="radio" name="serviceRating" value="3"> 3</label>
                    <label><input type="radio" name="serviceRating" value="4"> 4</label>
                    <label><input type="radio" name="serviceRating" value="5"> 5</label>
                </p>

                <p>Would you dine with us again? *<br>
                    <label><input type="radio" name="returnVisit" value="Yes" required> Yes</label>
                    <label><input type="radio" name="returnVisit" value="Maybe"> Maybe</label>
                    <label><input type="radio" name="returnVisit" value="No"> No</label>
                </p>
            </fieldset>

            <!-- Section 3: courses ordered (checkboxes share one name, so multiple values may be sent) -->
            <fieldset>
                <legend>What did you order? (check all that apply)</legend>
                <label><input type="checkbox" name="itemsOrdered" value="Appetizer"> Appetizer</label><br>
                <label><input type="checkbox" name="itemsOrdered" value="Entree"> Entr&eacute;e</label><br>
                <label><input type="checkbox" name="itemsOrdered" value="Dessert"> Dessert</label><br>
                <label><input type="checkbox" name="itemsOrdered" value="Beverage"> Beverage</label>
            </fieldset>

            <!-- Section 4: open-ended comments (textarea) -->
            <fieldset>
                <legend>Comments</legend>
                <label for="comments">Anything else you would like us to know?</label><br>
                <textarea id="comments" name="comments" rows="5" cols="60" maxlength="500"></textarea>
            </fieldset>

            <input type="submit" value="Submit Feedback">
            <input type="reset" value="Clear Form">
        </form>
    </body>
</html>
