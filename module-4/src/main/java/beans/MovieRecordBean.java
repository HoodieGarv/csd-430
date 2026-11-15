/*
 * Name:        Garvin Stewart
 * Date:        November 15, 2026
 * Assignment:  CSD 430 Module 4 - JavaBean Data Display
 *
 * Purpose:     JavaBean that holds one record (one fact) about a movie.
 *
 * Source note: Class structure and comments drafted with help from Claude
 *              (Anthropic), then reviewed and edited by the author. The movie
 *              data carries over from the Module 2 Java Scriptlet assignment.
 */
package beans;

import java.io.Serializable;

public class MovieRecordBean implements Serializable {

    // Version ID for serialization; change it only if the field layout changes
    private static final long serialVersionUID = 1L;

    // ---------------------------------------------------------------
    // FIELDS (five per record)
    //   recordId    - position of the record in the full data set
    //   category    - topical group the record belongs to
    //   attribute   - what the record describes
    //   value       - the data itself
    //   description - extra context about the record
    // ---------------------------------------------------------------
    private int recordId;
    private String category;
    private String attribute;
    private String value;
    private String description;

    // No-argument constructor, required by the JavaBean specification
    public MovieRecordBean() {
        this.recordId = 0;
        this.category = "";
        this.attribute = "";
        this.value = "";
        this.description = "";
    }

    // Convenience constructor used to load the data set in one line per record
    public MovieRecordBean(int recordId, String category, String attribute,
                           String value, String description) {
        this.recordId = recordId;
        this.category = category;
        this.attribute = attribute;
        this.value = value;
        this.description = description;
    }

    // ---------------------------------------------------------------
    // GETTERS AND SETTERS
    // ---------------------------------------------------------------
    public int getRecordId() {
        return recordId;
    }

    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAttribute() {
        return attribute;
    }

    public void setAttribute(String attribute) {
        this.attribute = attribute;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
