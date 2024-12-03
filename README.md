# QuantAQ Air Pollution Analysis Repository

## Overview
This repository contains scripts, reports, and data preparation tools for analyzing air pollution data from QuantAQ sensors. I access the monitor data through QuantAQ's API and R wrapper. The specific monitors that I access in my R markdowns are part of a fleet of monitors in Ghana, Uganda, Kenya, and Ethiopia. These monitors are not available to the public, but creating a QuantAQ account allows you to access a suite of public monitors. 

There is a specific focus on analayzing data completeness from the monitors and comparing the data completeness from cloud transmitted data to the data obtained through SD cards. Analyzing pollution trends in Bono East region of Ghana is another focus. 

The repository supports creating dashboards, generating reports, and conducting exploratory data analysis.

---

## Repository Structure

### Folders
- **`air_pollution_dashboard/`**
  - Contains scripts and resources for building the air pollution dashboard.

- **`archive_functions/`**
  - Archived scripts and functions for reference.

- **`archive_reports/`**
  - Archived reports and analyses.

- **`plots/`**
  - Contains output plots used in reports. 

- **`src/` key functions include:**
  - load_pollution_datasets.R (loads specified variables of interest with timestamp and monitor)
  - process_multiple_pollutants.R (uses merge_sd_data.R and summarize_pollution_times.R to create merged data for the measurement of interest and summarizes the resulting data by hour and day)
  - merge_sd_data.R (merges the sd card data to the cloud data for times when the cloud data is missing)
  - summarize_pollution_times.R (summarizes monitor and fleet averages for hourly/daily periods)
  - compare_fleet_regression.R (calculates regression of monitor reading compared to fleet average — used for applying correction to colocated data)
  - Other functions primarily focus on specific analysis and the creation of plots 
    

## Key Analysis Scripts
### Data Preparation

- **`load_ghana_AQ_data.Rmd`**
  - Modular script for loading data from QuantAQ monitors.
  - Specify start date of interest, end data of interest, and serial ID numbers for the monitors to obtain data for each monitor in the input time range.
 
- **`cloud_vs_sd_completeness.R`**
  - Compares data completeness between cloud and SD card sources.

- **`gas_pm_completeness.Rmd`**
  - Script to compare the completeness of gas and PM data for MOD units. 

- **`temp_humidity_data_prep.Rmd`**
  - Prepares temperature and humidity data for analysis.

### Reports and Dashboards
- **`ghana_AQ_analysis.Rmd`**
  - Analysis report focusing on Ghana's air quality data.

- **`ghana_pollution_report.Rmd`**
  - Detailed report on Ghana pollution trends.

- **`ghana_pollution_report_clean.Rmd`**
  - Updated to load corrected data from CSV/RDS files.
 



The missing_data_report R Markdown contains code that allows you to obtain data by specifing a list of monitors, a start date, and an end date. With this data, I create a table that specifies the number of hours of missing data for each date/monitor pairing. 
