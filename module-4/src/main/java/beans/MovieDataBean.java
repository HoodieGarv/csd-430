/*
 * Name:        Garvin Stewart
 * Date:        November 15, 2026
 * Assignment:  CSD 430 Module 4 - JavaBean Data Display
 *
 * Purpose:     JavaBean that holds the full movie data set for the JSP page to display.
 *
 * Source note: Class structure and comments drafted with help from Claude
 *              (Anthropic), then reviewed and edited by the author. Movie facts
 *              come from public film records (used in Module 2).
 */
package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class MovieDataBean implements Serializable {

    // Version ID for serialization; change it only if the field layout changes
    private static final long serialVersionUID = 1L;

    // ---------------------------------------------------------------
    // FIELDS
    // ---------------------------------------------------------------
    private String movieTitle;
    private int releaseYear;
    private String dataDescription;

    // Category names, in the order they appear on the page
    private String[] categoryOrder;

    // Plain-language description of each category (same order as categoryOrder)
    private String[] categoryDescriptions;

    // Every record in the data set
    private List<MovieRecordBean> records;

    // ---------------------------------------------------------------
    // NO-ARGUMENT CONSTRUCTOR
    // Required by the JavaBean specification. <jsp:useBean> calls it,
    // so the data set is loaded here.
    // ---------------------------------------------------------------
    public MovieDataBean() {
        movieTitle = "The Dark Knight";
        releaseYear = 2008;
        dataDescription = "A data record of a movie I have enjoyed watching. "
                + "Each record is one fact about the film, grouped into "
                + "production details, principal cast, and reception.";

        categoryOrder = new String[] {"Production", "Cast", "Reception"};

        categoryDescriptions = new String[] {
            "Who made the film and how it was made",
            "Principal actors and the characters they played",
            "How the film performed with audiences and critics"
        };

        records = new ArrayList<>();
        loadRecords();
    }

    // Loads the Module 2 data set; record IDs are assigned in load order
    private void loadRecords() {
        addRecord("Production", "Director", "Christopher Nolan",
                "Also co-wrote the screenplay with Jonathan Nolan.");
        addRecord("Production", "U.S. Release Date", "July 18, 2008",
                "Opened in theaters and on IMAX screens.");
        addRecord("Production", "Runtime", "152 minutes",
                "Theatrical running time.");
        addRecord("Production", "Budget", "About $185 million",
                "Reported production budget.");
        addRecord("Production", "Original Score", "Hans Zimmer and James Newton Howard",
                "Second collaboration on the series.");

        addRecord("Cast", "Bruce Wayne / Batman", "Christian Bale",
                "Lead role, returning from Batman Begins.");
        addRecord("Cast", "The Joker", "Heath Ledger",
                "The performance most associated with the film.");
        addRecord("Cast", "Harvey Dent / Two-Face", "Aaron Eckhart",
                "Gotham's district attorney.");
        addRecord("Cast", "Lt. James Gordon", "Gary Oldman",
                "Gotham police lieutenant.");
        addRecord("Cast", "Alfred Pennyworth", "Michael Caine",
                "Wayne family butler.");

        addRecord("Reception", "Worldwide Box Office", "About $1 billion",
                "Among the highest-grossing films of 2008.");
        addRecord("Reception", "Academy Award Nominations", "8",
                "Nominated at the 81st Academy Awards.");
        addRecord("Reception", "Academy Award Wins", "2",
                "Best Supporting Actor (Heath Ledger) and Best Sound Editing.");
    }

    // Builds one record bean and adds it to the list with the next record ID
    private void addRecord(String category, String attribute, String value, String description) {
        int nextId = records.size() + 1;
        records.add(new MovieRecordBean(nextId, category, attribute, value, description));
    }

    // ---------------------------------------------------------------
    // HELPER METHODS USED BY THE JSP
    // ---------------------------------------------------------------

    // Returns only the records that belong to one category
    public List<MovieRecordBean> getRecordsByCategory(String categoryName) {
        List<MovieRecordBean> matchingRecords = new ArrayList<>();
        for (MovieRecordBean record : records) {
            if (record.getCategory().equals(categoryName)) {
                matchingRecords.add(record);
            }
        }
        return matchingRecords;
    }

    // Total number of records, shown in the data description
    public int getTotalRecords() {
        return records.size();
    }

    // Escapes HTML special characters so values such as "Fast & Furious"
    // display as text instead of breaking the page markup
    public static String escapeHtml(String rawText) {
        if (rawText == null) {
            return "";
        }
        StringBuilder safeText = new StringBuilder(rawText.length());
        for (char character : rawText.toCharArray()) {
            switch (character) {
                case '&':  safeText.append("&amp;");  break;
                case '<':  safeText.append("&lt;");   break;
                case '>':  safeText.append("&gt;");   break;
                case '"':  safeText.append("&quot;"); break;
                case '\'': safeText.append("&#39;");  break;
                default:   safeText.append(character);
            }
        }
        return safeText.toString();
    }

    // ---------------------------------------------------------------
    // GETTERS AND SETTERS
    // Arrays are copied so outside code cannot change the bean's data
    // by accident.
    // ---------------------------------------------------------------
    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    public String getDataDescription() {
        return dataDescription;
    }

    public void setDataDescription(String dataDescription) {
        this.dataDescription = dataDescription;
    }

    public String[] getCategoryOrder() {
        return categoryOrder.clone();
    }

    public void setCategoryOrder(String[] categoryOrder) {
        this.categoryOrder = categoryOrder.clone();
    }

    public String[] getCategoryDescriptions() {
        return categoryDescriptions.clone();
    }

    public void setCategoryDescriptions(String[] categoryDescriptions) {
        this.categoryDescriptions = categoryDescriptions.clone();
    }

    public List<MovieRecordBean> getRecords() {
        return new ArrayList<>(records);
    }

    public void setRecords(List<MovieRecordBean> records) {
        this.records = new ArrayList<>(records);
    }
}
