# Test Cases — Student Data Explorer

These are manual test cases to be run by using the application's
menu in RStudio. Each test matches an actual menu option in
`R/main.R`. No automated test framework is used, since this is a
small console application intended for a beginner-level academic
project.

---

### TC-01: View all records

- **Input condition:** Choose menu option `1`.
- **Expected behavior:** All 24 student records are printed as a
  data frame, followed by the total record count.
- **Purpose:** Verify that the full dataset loads and displays
  correctly.

---

### TC-02: View selected columns

- **Input condition:** Choose option `2`, then enter
  `Name, Marks`.
- **Expected behavior:** Only the `Name` and `Marks` columns are
  displayed for all students.
- **Purpose:** Verify column-based access on the data frame.

---

### TC-03: Search student by a valid ID

- **Input condition:** Choose option `3`, enter `S104`.
- **Expected behavior:** The single matching row (Ishita Rao) is
  displayed.
- **Purpose:** Verify row access by a specific condition.

---

### TC-04: Search student by an invalid ID

- **Input condition:** Choose option `3`, enter `S999`.
- **Expected behavior:** Message: "No student found with ID: S999"
  is shown; the program does not crash.
- **Purpose:** Verify handling of a search with no match.

---

### TC-05: Filter by department (valid)

- **Input condition:** Choose option `4`, then `a`, then `CSE`.
- **Expected behavior:** Only CSE students are displayed.
- **Purpose:** Verify department-based filtering.

---

### TC-06: Filter by department (invalid)

- **Input condition:** Choose option `4`, then `a`, then `AERO`.
- **Expected behavior:** Message: "Invalid department entered." is
  shown; no records are printed.
- **Purpose:** Verify input validation for filtering.

---

### TC-07: Filter by year

- **Input condition:** Choose option `4`, then `b`, then
  `3rd Year`.
- **Expected behavior:** Only 3rd Year students are displayed.
- **Purpose:** Verify filtering using the Year factor.

---

### TC-08: Filter by marks above a threshold

- **Input condition:** Choose option `4`, then `c`, then `90`.
- **Expected behavior:** Only students with marks greater than 90
  are displayed (e.g. Ishita Rao, Ananya Gupta, Siddharth Rao,
  Sanya Kapoor).
- **Purpose:** Verify numeric filtering logic.

---

### TC-09: Filter by marks below a threshold with no matches

- **Input condition:** Choose option `4`, then `d`, then `10`.
- **Expected behavior:** Message: "No students found with marks
  below 10" is shown; program continues normally.
- **Purpose:** Verify handling of an empty filter result.

---

### TC-10: Filter with a non-numeric marks value

- **Input condition:** Choose option `4`, then `c`, then `abc`.
- **Expected behavior:** Message: "Invalid number entered." is
  shown; no filtering is attempted.
- **Purpose:** Verify input validation for numeric fields.

---

### TC-11: Generate department frequency table

- **Input condition:** Choose option `7`, then `a`.
- **Expected behavior:** A table showing the count of students in
  each of CSE, ECE, MECH, and CIVIL is displayed, summing to 24.
- **Purpose:** Verify `table()` usage on the Department factor.

---

### TC-12: Generate performance table

- **Input condition:** Choose option `7`, then `c`.
- **Expected behavior:** A table showing counts for "Needs
  Improvement", "Average", "Good", and "Excellent" is displayed.
- **Purpose:** Verify the derived Performance factor and its
  frequency table.

---

### TC-13: Generate department vs performance cross table

- **Input condition:** Choose option `7`, then `d`.
- **Expected behavior:** A cross table of Department by
  Performance is printed, followed by row totals (per department)
  and column totals (per performance band).
- **Purpose:** Verify matrix-like row/column operations on a table.

---

### TC-14: Calculate marks summary

- **Input condition:** Choose option `5`.
- **Expected behavior:** Average, highest, lowest, range, and
  median marks are printed, matching the values computable
  directly from `data/sample_data.csv`.
- **Purpose:** Verify Base R math functions on the Marks column.

---

### TC-15: Department and year averages

- **Input condition:** Choose option `6`.
- **Expected behavior:** Average marks per department and average
  attendance per year are printed.
- **Purpose:** Verify grouped calculations using `tapply()`.

---

### TC-16: Add a new valid student record

- **Input condition:** Choose option `8`; enter ID `S125`, name
  `Test Student`, department `CSE`, year `2`, marks `88`,
  attendance `90`.
- **Expected behavior:** Message: "New record added successfully."
  is shown. Choosing option `1` afterward shows 25 records,
  including the new one with Performance = "Excellent".
- **Purpose:** Verify that a new row can be appended to the data
  frame with correct factor levels.

---

### TC-17: Add a record with an invalid department

- **Input condition:** Choose option `8`; enter a department such
  as `IT` (not in the existing levels).
- **Expected behavior:** Message: "Invalid department. Record not
  added." is shown; record count stays unchanged.
- **Purpose:** Verify validation before appending a new row.

---

### TC-18: Add a record with non-numeric marks

- **Input condition:** Choose option `8`; enter marks as `ninety`.
- **Expected behavior:** Message: "Marks and Attendance must be
  numbers. Record not added." is shown.
- **Purpose:** Verify numeric validation on new record input.

---

### TC-19: Invalid main menu selection

- **Input condition:** At the main menu, enter `15`.
- **Expected behavior:** Message: "Invalid choice. Please enter a
  number from 1 to 9." is shown; the menu is displayed again.
- **Purpose:** Verify that out-of-range menu input does not crash
  the program.

---

### TC-20: Exit the application

- **Input condition:** At the main menu, enter `9`.
- **Expected behavior:** Message: "Exiting Student Data Explorer.
  Goodbye!" is shown, and the program loop ends.
- **Purpose:** Verify a clean exit path.
