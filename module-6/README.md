# CSD 430 Modules 5 & 6 – READ, JDBC, and JavaBeans

Garvin Stewart · November 22, 2026

`index.jsp` uses the `MovieBean` JavaBean to list every key in the `garvin_movies_data` table in a dropdown menu. When the user submits a key, `display.jsp` uses the same bean to read that record. It then shows the record's 7 fields in an HTML table, followed by a record summary and a field-description table.

## Database settings (used everywhere)

| Setting  | Value                |
|----------|----------------------|
| Database | `CSD430`             |
| User     | `student1`           |
| Password | `pass`               |
| Table    | `garvin_movies_data` |

These values are defined once, as constants at the top of `MovieBean.java`.

## Files

```
src/main/java/csd430/module6/MovieBean.java          JavaBean: JDBC reads (list of keys, single record)
src/main/java/csd430/module6/MovieTableManager.java  Java CLI: create | populate | drop | reset | show
src/main/webapp/index.jsp                            input page: dropdown of all keys + CRUD links
src/main/webapp/display.jsp                          output page: record table + descriptions
src/main/webapp/sql/garvincreateTable.sql            creates DB, grants student1, creates table
src/main/webapp/sql/garvinpopulateTable.sql          inserts 12 records
src/main/webapp/sql/garvindropTable.sql              drops the table
src/main/webapp/css/styles.css                       styles
src/main/webapp/WEB-INF/web.xml                      deployment descriptor
src/main/webapp/WEB-INF/lib/mysql-connector-j-8.4.0.jar   JDBC driver
csd430-module6.war                                   ready-to-deploy web archive
```

## Instructor setup

1. **Set up permissions and the table (as MySQL root).** An administrator grants student1 its permissions in this step, not the bean:
   ```
   mysql -u root -p < src/main/webapp/sql/garvincreateTable.sql
   mysql -u student1 -p CSD430 < src/main/webapp/sql/garvinpopulateTable.sql
   ```
2. **Or create, populate, and delete the table from Java.** This needs the database and user from step 1 to exist first:
   ```
   javac -d classes src/main/java/csd430/module6/*.java
   java -cp "classes:src/main/webapp/WEB-INF/lib/mysql-connector-j-8.4.0.jar" csd430.module6.MovieTableManager reset
   java -cp "classes:src/main/webapp/WEB-INF/lib/mysql-connector-j-8.4.0.jar" csd430.module6.MovieTableManager drop
   ```
   (On Windows, use `;` instead of `:` in the classpath.)
3. **Deploy.** Copy `csd430-module6.war` into the `webapps/` folder of Tomcat 10.1, then open
   `http://localhost:8080/csd430-module6/`.

Tested on Java 17 bytecode, Tomcat 10.1, and Connector/J 8.4.0.

Citation: Code drafted with assistance from Claude (Anthropic AI), November 2026, and reviewed and tested by Garvin Stewart.
