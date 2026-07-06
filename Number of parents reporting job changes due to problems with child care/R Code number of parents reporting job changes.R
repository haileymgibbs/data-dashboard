library(haven)
library(dplyr)
library(survey)
library(tidyr)

# Read the 2024 NSCH topical file
nsch <- read_dta(
  "C:/Users/cnesmith/OneDrive - Center For American Progress/Desktop/Data Dashboard/Number of parents reporting job changes due to problems with child care/nsch_2024e_topical.dta"
)

# Convert variable names to lowercase
names(nsch) <- tolower(names(nsch))

# Rename variable and create grouped strata
nsch <- nsch %>%
  rename(jobchange = k6q27) %>%
  mutate(
    stratumgroup = interaction(fipsst, stratum, drop = TRUE)
  )

# Define survey design
design <- svydesign(
  ids = ~hhid,
  strata = ~stratumgroup,
  weights = ~fwc,
  data = nsch,
  nest = TRUE
)

# Create weighted counts
jobchange_table <- as.data.frame(
  svytable(~fipsst + jobchange, design)
)

# State lookup
state_lookup <- data.frame(
  fipsst = c(1,2,4,5,6,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,
             24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,
             42,44,45,46,47,48,49,50,51,53,54,55,56),
  state = c(
    "Alabama","Alaska","Arizona","Arkansas","California","Colorado",
    "Connecticut","Delaware","District of Columbia","Florida",
    "Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa",
    "Kansas","Kentucky","Louisiana","Maine","Maryland",
    "Massachusetts","Michigan","Minnesota","Mississippi",
    "Missouri","Montana","Nebraska","Nevada","New Hampshire",
    "New Jersey","New Mexico","New York","North Carolina",
    "North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania",
    "Rhode Island","South Carolina","South Dakota","Tennessee",
    "Texas","Utah","Vermont","Virginia","Washington",
    "West Virginia","Wisconsin","Wyoming"
  )
)

# Convert factor variables and add labels
jobchange_table <- jobchange_table %>%
  mutate(
    fipsst = as.numeric(as.character(fipsst)),
    jobchange = as.character(jobchange)
  ) %>%
  left_join(state_lookup, by = "fipsst") %>%
  mutate(
    jobchange = recode(
      jobchange,
      "1" = "Yes",
      "2" = "No"
    )
  )

# Create wide table
jobchange_table_wide <- jobchange_table %>%
  select(state, jobchange, Freq) %>%
  pivot_wider(
    names_from = jobchange,
    values_from = Freq
  ) %>%
  arrange(state)

# View table
jobchange_table_wide
