# Package installation.
library(readr)
library(readxl)
library(dplyr)
library(tidyr)
library(here)

# ------- IMPORT DATA ----

df_all <- as.data.frame(read_excel("ICM_data.xlsx")) # removed after all those modification
set.seed(1100)
df <- df_all %>%
  select(
    `Death (0=No; 1=Yes)`,
    `Delai du suivi avant la mort ou dernier contact vivant (months)`,
    `Sex (0= Females; 1=Males)`,
    `Age at baseline (years)`,
    `BMI (kg/m2)`,
    `LVEF (%)`,
    `LV mass indexed (g/m2)`,
    `Presence of ischemic LGE (0= No; 1=Yes)`,
    `Number of segments of ischemic LGE`,
    `Topography of ischemic LGE (0= No LGE; 1=subendocardial <50%; 2=subendocardial 50-99%; 3=transmural)`
  ) %>%
  mutate(
    `Sex (0= Females; 1=Males)` = ifelse(`Sex (0= Females; 1=Males)` == 1, ifelse(runif(n()) < 0.11, 0, 1), ifelse(runif(n()) < 0.16, 1, 0)),
    `Age at baseline (years)` = round(`Age at baseline (years)` + rnorm(n(), mean=0, sd=4)),
    `BMI (kg/m2)` = round(`BMI (kg/m2)` + rnorm(n(), mean=0, sd=2))
  ) %>%
  sample_frac(.18) %>%
  mutate(NP = row_number())


save(df, file = "df.RData")
