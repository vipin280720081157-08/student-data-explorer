# ==============================================================
# functions.R
# Student Data Explorer
#
# This file contains all the reusable functions used by the
# application. Keeping them separate from main.R keeps the
# menu/control flow easy to read.
#
# Concepts demonstrated in this file (from the R syllabus,
# Unit 3 - Data Frames and Tables):
#   - Creating Data Frames
#   - Accessing Data Frames (rows, columns, values)
#   - Other Matrix-Like Operations
#   - Factors and Levels
#   - Working with Tables
#   - Table Operations
#   - Math Functions
# ==============================================================


## --------------------------------------------------------------
## 1. LOADING THE DATA
## --------------------------------------------------------------
# A data frame is the natural choice for this project because the
# student dataset has columns of different types (character, numeric,
# categorical) that all need to stay lined up row by row - exactly
# what a data frame is designed for (unlike a plain matrix, which
# only holds one data type).

load_data <- function(file_path) {
  # read.csv() loads the CSV directly into a data frame (Base R)
  student_df <- read.csv(file_path, stringsAsFactors = FALSE)

  # ---- Factors and Levels ----
  # Department and Year are categorical fields, so they are converted
  # to factors. This lets R treat them as a fixed set of categories
  # (rather than free text) and makes table()/summary() work correctly.
  student_df$Department <- factor(student_df$Department)
  student_df$Year <- factor(student_df$Year,
                             levels = c(1, 2, 3, 4),
                             labels = c("1st Year", "2nd Year",
                                        "3rd Year", "4th Year"))

  # A derived categorical column: Performance band.
  # This is created FROM the Marks column, and is itself stored as a
  # factor with a meaningful level order (not just alphabetical).
  student_df$Performance <- cut(
    student_df$Marks,
    breaks = c(-Inf, 49, 69, 84, Inf),
    labels = c("Needs Improvement", "Average", "Good", "Excellent")
  )

  return(student_df)
}


## --------------------------------------------------------------
## 2. VIEWING / ACCESSING THE DATA FRAME
## --------------------------------------------------------------

# Display the full data frame
display_all <- function(df) {
  print(df)
  cat("\nTotal records:", nrow(df), "\n")
}

# Display only chosen columns (column access)
display_columns <- function(df, columns) {
  valid_columns <- columns[columns %in% names(df)]

  if (length(valid_columns) == 0) {
    cat("None of the requested columns exist in the dataset.\n")
    return(invisible(NULL))
  }

  print(df[, valid_columns, drop = FALSE])
}

# Display a single student's full record by Student_ID (row access)
display_student_by_id <- function(df, student_id) {
  matching_row <- df[df$Student_ID == student_id, ]

  if (nrow(matching_row) == 0) {
    cat("No student found with ID:", student_id, "\n")
  } else {
    print(matching_row)
  }
}


## --------------------------------------------------------------
## 3. FILTERING THE DATA FRAME
## --------------------------------------------------------------

filter_by_department <- function(df, dept) {
  result <- df[df$Department == dept, ]

  if (nrow(result) == 0) {
    cat("No students found in department:", dept, "\n")
  } else {
    print(result)
  }
  invisible(result)
}

filter_by_year <- function(df, yr_label) {
  result <- df[df$Year == yr_label, ]

  if (nrow(result) == 0) {
    cat("No students found for:", yr_label, "\n")
  } else {
    print(result)
  }
  invisible(result)
}

filter_marks_above <- function(df, threshold) {
  result <- df[df$Marks > threshold, ]

  if (nrow(result) == 0) {
    cat("No students found with marks above", threshold, "\n")
  } else {
    print(result)
  }
  invisible(result)
}

filter_marks_below <- function(df, threshold) {
  result <- df[df$Marks < threshold, ]

  if (nrow(result) == 0) {
    cat("No students found with marks below", threshold, "\n")
  } else {
    print(result)
  }
  invisible(result)
}


## --------------------------------------------------------------
## 4. TABLES AND TABLE OPERATIONS
## --------------------------------------------------------------

# Frequency table: number of students per department
department_table <- function(df) {
  dept_table <- table(df$Department)
  cat("\nStudents per Department:\n")
  print(dept_table)
  invisible(dept_table)
}

# Frequency table: number of students per year
year_table <- function(df) {
  yr_table <- table(df$Year)
  cat("\nStudents per Year:\n")
  print(yr_table)
  invisible(yr_table)
}

# Frequency table: number of students per performance band
performance_table <- function(df) {
  perf_table <- table(df$Performance)
  cat("\nStudents per Performance Category:\n")
  print(perf_table)
  invisible(perf_table)
}

# Cross table: Department vs Performance
# (a simple matrix-like operation on top of a table: rows and
#  columns of the cross-tabulation can be accessed just like a matrix)
department_performance_crosstable <- function(df) {
  cross_tab <- table(df$Department, df$Performance)
  cat("\nDepartment vs Performance (cross table):\n")
  print(cross_tab)

  # Matrix-like operations on the table: row/column totals
  cat("\nTotal students per department (row totals):\n")
  print(rowSums(cross_tab))

  cat("\nTotal students per performance band (column totals):\n")
  print(colSums(cross_tab))

  invisible(cross_tab)
}


## --------------------------------------------------------------
## 5. MATHEMATICAL ANALYSIS
## --------------------------------------------------------------

# Overall statistics on the Marks column
summarize_marks <- function(df) {
  cat("\n---- Marks Summary (All Students) ----\n")
  cat("Average Marks :", round(mean(df$Marks), 2), "\n")
  cat("Highest Marks :", max(df$Marks), "\n")
  cat("Lowest Marks  :", min(df$Marks), "\n")
  cat("Range         :", diff(range(df$Marks)), "\n")
  cat("Median Marks  :", median(df$Marks), "\n")
}

# Average marks per department (grouped math function using tapply)
average_marks_by_department <- function(df) {
  dept_avg <- tapply(df$Marks, df$Department, mean)
  cat("\nAverage Marks by Department:\n")
  print(round(dept_avg, 2))
  invisible(dept_avg)
}

# Average attendance per year
average_attendance_by_year <- function(df) {
  yr_avg <- tapply(df$Attendance, df$Year, mean)
  cat("\nAverage Attendance by Year:\n")
  print(round(yr_avg, 2))
  invisible(yr_avg)
}


## --------------------------------------------------------------
## 6. ADDING A NEW RECORD
## --------------------------------------------------------------
# Demonstrates that a data frame can grow by adding a new row,
# while still keeping Department/Year/Performance as factors.

add_student_record <- function(df, student_id, name, department,
                                year_number, marks, attendance) {

  new_row <- data.frame(
    Student_ID = student_id,
    Name = name,
    Department = department,
    Year = year_number,
    Marks = marks,
    Attendance = attendance,
    stringsAsFactors = FALSE
  )

  # Re-apply the same factor levels used when the data was loaded,
  # so the new row fits into the existing categories.
  new_row$Department <- factor(new_row$Department, levels = levels(df$Department))
  new_row$Year <- factor(new_row$Year, levels = levels(df$Year))
  new_row$Performance <- cut(
    new_row$Marks,
    breaks = c(-Inf, 49, 69, 84, Inf),
    labels = c("Needs Improvement", "Average", "Good", "Excellent")
  )

  updated_df <- rbind(df, new_row)
  cat("New record added successfully.\n")
  return(updated_df)
}


## --------------------------------------------------------------
## 7. SMALL VALIDATION HELPERS
## --------------------------------------------------------------

is_valid_number <- function(input_text) {
  !is.na(suppressWarnings(as.numeric(input_text)))
}

is_valid_department <- function(df, dept_input) {
  dept_input %in% levels(df$Department)
}

is_valid_year_choice <- function(df, yr_input) {
  yr_input %in% levels(df$Year)
}
