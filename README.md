# Student Data Explorer

[![R](https://img.shields.io/badge/R-4.0%2B-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![Base R](https://img.shields.io/badge/Dependencies-Base%20R-blue)](#)
[![Frontend](https://img.shields.io/badge/Frontend-HTML%20%2F%20CSS%20%2F%20JS-cyan)](#)

A tabular data exploration and summary application built with **Base R** and an interactive web dashboard for inspecting, querying, subsetting, and summarizing student records using native data frames and frequency tables.

---

## Key Features

- **Tabular Data Inspection**: Explores dataset dimensions (`dim()`), column schemas, summary statistics (`summary()`), and row head/tail samples (`head()`, `tail()`) from CSV records.
- **Conditional Subsetting**: Filters records based on logical criteria using Base R `subset()` and bracket indexing (`df[rows, cols]`).
- **Frequency & Proportional Tables**: Computes categorical frequency distributions (`table()`) and percentage breakdowns (`prop.table()`) across departments and performance groups.
- **Dual Execution Interfaces**:
  - **Interactive CLI Program**: Modular console application (`R/main.R`) offering structured interactive menus.
  - **Web Dashboard**: Single-page browser application (`index.html`) featuring search filters, department selectors, dynamic frequency tables, and statistical summaries.
- **Zero Heavy Dependencies**: Pure Base R and vanilla HTML/CSS/JS without external libraries such as `dplyr` or `tidyverse`.

---

## Repository Structure

```
student-data-explorer/
├── R/
│   ├── main.R            # CLI interactive menu entry point
│   └── functions.R       # Modular data frame and table functions
├── data/
│   └── sample_data.csv   # Student records CSV dataset
├── index.html            # Interactive Web Dashboard
├── docs/
│   └── workflow.png      # Data frame exploration flowchart
├── tests/
│   └── test-cases.md     # Verification test suite & query tests
├── .gitignore
└── README.md
```

---

## Getting Started

### Option 1: Base R Console Application

Run the interactive console program from your terminal:

```bash
Rscript R/main.R
```

Or from within an R/RStudio environment:

```r
source("R/main.R")
```

Follow the menu prompts to load data, preview records, filter by department or marks, and compute frequency tables.

### Option 2: Interactive Web Dashboard

Open `index.html` directly in any web browser to explore records, apply interactive filters, and examine summary tables in real time.

---

## Core Operations Demonstrated

```r
# Load tabular dataset
df <- read.csv("data/sample_data.csv")

# Dimensions and head preview
dimensions <- dim(df)
preview    <- head(df, n = 5)

# Conditional subsetting
top_performers <- subset(df, Department == "CS" & Marks >= 80)

# Categorical frequency and proportional distributions
dept_counts <- table(df$Department)
dept_pcts   <- prop.table(dept_counts) * 100

# Column statistical summary
summary(df$Marks)
```

---

## License

This project is licensed under the [MIT License](LICENSE).
