# ==============================================================
# main.R
# Student Data Explorer
#
# Entry point of the application. Run this file to start the
# program. It loads the student dataset, shows a menu, and calls
# the appropriate function from functions.R for each choice.
#
# HOW TO RUN:
#   1. Open this project as your working directory in RStudio.
#   2. Open R/main.R
#   3. Click "Source" (or run: source("R/main.R"))
# ==============================================================

# Load helper functions
source("R/functions.R")

# Load the student dataset into a data frame
data_file <- "data/sample_data.csv"
students <- load_data(data_file)

print_menu <- function() {
  cat("\n----------------------------------------\n")
  cat("          STUDENT DATA EXPLORER\n")
  cat("----------------------------------------\n")
  cat("1. View All Students\n")
  cat("2. View Selected Columns\n")
  cat("3. Search Student by ID\n")
  cat("4. Filter Students\n")
  cat("5. View Marks Summary\n")
  cat("6. View Department / Year Averages\n")
  cat("7. View Frequency Tables\n")
  cat("8. Add a New Student Record\n")
  cat("9. Exit\n")
  cat("----------------------------------------\n")
}

run_filter_menu <- function(df) {
  cat("\nFilter by:\n")
  cat("a. Department\n")
  cat("b. Year\n")
  cat("c. Marks above a value\n")
  cat("d. Marks below a value\n")
  choice <- trimws(readline("Choose an option (a-d): "))

  if (choice == "a") {
    dept <- trimws(readline(paste0("Enter department (",
                                    paste(levels(df$Department), collapse = "/"), "): ")))
    if (is_valid_department(df, dept)) {
      filter_by_department(df, dept)
    } else {
      cat("Invalid department entered.\n")
    }

  } else if (choice == "b") {
    yr <- trimws(readline(paste0("Enter year (",
                                  paste(levels(df$Year), collapse = " / "), "): ")))
    if (is_valid_year_choice(df, yr)) {
      filter_by_year(df, yr)
    } else {
      cat("Invalid year entered.\n")
    }

  } else if (choice == "c") {
    val <- trimws(readline("Enter marks threshold: "))
    if (is_valid_number(val)) {
      filter_marks_above(df, as.numeric(val))
    } else {
      cat("Invalid number entered.\n")
    }

  } else if (choice == "d") {
    val <- trimws(readline("Enter marks threshold: "))
    if (is_valid_number(val)) {
      filter_marks_below(df, as.numeric(val))
    } else {
      cat("Invalid number entered.\n")
    }

  } else {
    cat("Invalid filter option.\n")
  }
}

run_table_menu <- function(df) {
  cat("\nFrequency Tables:\n")
  cat("a. Department Table\n")
  cat("b. Year Table\n")
  cat("c. Performance Table\n")
  cat("d. Department vs Performance (cross table)\n")
  choice <- trimws(readline("Choose an option (a-d): "))

  if (choice == "a") {
    department_table(df)
  } else if (choice == "b") {
    year_table(df)
  } else if (choice == "c") {
    performance_table(df)
  } else if (choice == "d") {
    department_performance_crosstable(df)
  } else {
    cat("Invalid option.\n")
  }
}

run_add_record_menu <- function(df) {
  cat("\nEnter new student details:\n")
  student_id <- trimws(readline("Student ID (e.g. S125): "))
  name <- trimws(readline("Name: "))
  department <- trimws(readline(paste0("Department (",
                                        paste(levels(df$Department), collapse = "/"), "): ")))
  year_choice <- trimws(readline("Year (1/2/3/4): "))
  marks_input <- trimws(readline("Marks (0-100): "))
  attendance_input <- trimws(readline("Attendance % (0-100): "))

  if (!is_valid_department(df, department)) {
    cat("Invalid department. Record not added.\n")
    return(df)
  }
  if (!(year_choice %in% c("1", "2", "3", "4"))) {
    cat("Invalid year. Record not added.\n")
    return(df)
  }
  if (!is_valid_number(marks_input) || !is_valid_number(attendance_input)) {
    cat("Marks and Attendance must be numbers. Record not added.\n")
    return(df)
  }

  year_labels <- c("1st Year", "2nd Year", "3rd Year", "4th Year")
  year_label <- year_labels[as.numeric(year_choice)]

  updated_df <- add_student_record(
    df, student_id, name, department, year_label,
    as.numeric(marks_input), as.numeric(attendance_input)
  )
  return(updated_df)
}

# ---- Main program loop ----
repeat {
  print_menu()
  user_choice <- trimws(readline("Enter your choice (1-9): "))

  if (user_choice == "1") {
    display_all(students)

  } else if (user_choice == "2") {
    cat("Available columns:", paste(names(students), collapse = ", "), "\n")
    cols_input <- trimws(readline("Enter column names separated by commas: "))
    cols <- trimws(strsplit(cols_input, ",")[[1]])
    display_columns(students, cols)

  } else if (user_choice == "3") {
    id_input <- trimws(readline("Enter Student ID: "))
    display_student_by_id(students, id_input)

  } else if (user_choice == "4") {
    run_filter_menu(students)

  } else if (user_choice == "5") {
    summarize_marks(students)

  } else if (user_choice == "6") {
    average_marks_by_department(students)
    average_attendance_by_year(students)

  } else if (user_choice == "7") {
    run_table_menu(students)

  } else if (user_choice == "8") {
    students <- run_add_record_menu(students)

  } else if (user_choice == "9") {
    cat("Exiting Student Data Explorer. Goodbye!\n")
    break

  } else {
    cat("Invalid choice. Please enter a number from 1 to 9.\n")
  }
}
