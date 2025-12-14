# COVID-19 Analysis in R

This project analyzes COVID-19 data using R. The goal is to explore the dataset, summarize cumulative and daily measures, rank countries by various metrics, and draw conclusions about the most and least affected countries.

---

## Project Overview

The analysis includes:

1. **Data Loading and Cleaning**
   - The dataset `covid19.csv` was loaded using the `readr` package.
   - Rows related to “All States” were filtered to focus on country-level data.
   - Relevant columns for cumulative and daily measures were selected.

2. **Data Summarization**
   - Computed maximum deaths by country and continent.
   - Calculated positive-tested ratios and identified top countries.
   - Aggregated daily cases and tests by country.
   - Adjusted measures relative to population size using matrices.

3. **Ranking and Insights**
   - Ranked countries based on tested cases, positive cases, active cases, and hospitalized cases.
   - Identified top countries with highest deaths, highest positive/tested ratios, best testing efforts, most affected, and least affected countries.

---

## Project Files

- `covid_analysis.R` – Main R script containing all code and analysis steps.
- `covid19.csv` – COVID-19 dataset used for the analysis.
- `plots/` – (Optional) Folder containing exported plots from the analysis.
- `README.md` – Project description (this file).

---

## Key Findings

- **Highest deaths:** RU, TR, BD, IT, GB, BE, US, CA, CR, NZ, AU  
- **Highest positive/tested ratio:** United Kingdom (0.113), United States (0.109), Turkey (0.081)  
- **Best effort in testing relative to population:** India, United Kingdom, Turkey  
- **Most affected country (population-adjusted):** Italy  
- **Least affected country (population-adjusted):** India  

---

## How to Use

1. **Open the project in RStudio**  
   - Open the folder `covid_analysis_R` as an RStudio Project (if you have a `.Rproj` file).  
   - Opening the `.Rproj` file automatically sets the working directory to the project folder.  

2. **Run the main analysis script**  
   ```r
   source("covid_analysis.R")