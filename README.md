# **Parents Reporting Job Changes Due to Child Care Problems**

## **Author: Carter Nesmith**

#### **Last Updated: July 2026**

This repository contains code and outputs for estimating the number of parents reporting job changes due to problems with child care, using the 2024 National Survey of Children’s Health (NSCH). Estimates are produced at the state level using survey-weighted data.

### **Overview**

This analysis uses the 2024 NSCH topical file to measure whether parents reported changing or leaving a job due to child care-related problems. The dataset is weighted using the NSCH survey design to produce population-representative estimates.


**The code:**

1. Imports NSCH 2024 microdata

2. Applies survey weights and design variables

3. Constructs a weighted state-level tabulation of job change responses

4. Merges results with state FIPS identifiers

5. Produces a final wide-format table with Yes/No counts by state


### **Data Sources**

Dataset	Description	File
National Survey of Children’s Health (2024 Topical File)	Individual-level survey microdata containing child and household characteristics, including employment disruptions due to child care problems	nsch_2024e_topical.dta

Note: The NSCH data file must be downloaded separately from the NSCH Data Resource Center and stored locally. It is not included in the repository due to size and data use restrictions.


### **Methodology**

Data import — The NSCH 2024 Stata .dta file is imported into R using the haven package.

Variable standardization — All variable names are converted to lowercase for consistency across NSCH releases.

Outcome definition — The variable k6q27 is renamed to jobchange, representing whether a parent reported changing or leaving a job due to child care problems.

Survey design specification — A survey design object is created using:

Strata defined by fipsst × stratum

Final weight variable fwc

Weighted estimation — Weighted cross-tabulations are generated for job change status by state (FIPS code).

State labeling — Numeric FIPS codes are matched to state names using a lookup table.

Reshaping output — The final dataset is pivoted into wide format, producing separate columns for “Yes” and “No” responses.


### **Repository Structure**

├── analysis.R                       # Main analysis script

├── nsch_2024e_topical.dta          # NSCH 2024 topical microdata (local file, not included)

├── outputs/

│   └── jobchange_table_wide.xlsx   # Final state-level estimates

└── README.md


### **Output Files**

jobchange_table_wide.xlsx

State-level weighted estimates of parental job changes due to child care problems.

Column	Description
state	State name
Yes	Weighted count of parents reporting job change due to child care problems
No	Weighted count of parents not reporting job change due to child care problems


### **Requirements**

*R Packages*

haven

dplyr

survey

tidyr

writexl


### **Notes**

Survey weights (fwc) are applied to produce population-representative estimates.

Standard NSCH survey design structure is used for variance estimation.

All results are state-level aggregates derived from individual survey responses.


#### **Geographic Scope**

All 50 U.S. states and Washington, D.C. are included in the analysis using FIPS state identifiers from the NSCH public-use file.


### **Data Access Requirements**


To run this analysis, users must:

Download the NSCH 2024 topical Stata file (nsch_2024e_topical.dta)

Store it in a local directory

Update the file path in the script or set a working directory:
setwd("YOUR/LOCAL/PATH/HERE")

or directly reference the file path in read_dta().

**Contact**

For questions about the code or methodology, contact Carter Nesmith.
