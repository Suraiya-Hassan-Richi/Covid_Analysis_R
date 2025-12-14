setwd("C:/Users/dj/Downloads/R projects")
getwd()
covid_df <- read_csv("covid19.csv")
dim(covid_df)
vector_cols <- colnames(covid_df)
vector_cols
class(vector_cols)
head(vector_cols)
library(tibble)
glimpse(covid_df)
library(dplyr)
covid_df_all_states <- covid_df %>%
  filter(Province_State == "All States") %>%
  select(-Province_State)
head(covid_df_all_states)

covid_df_all_states_cumulative <- covid_df_all_states %>%
  select(Date,
         Continent_Name,
         Two_Letter_Country_Code,
         positive,
         hospitalized,
         recovered,
         death,
         total_tested
         )
colnames(covid_df_all_states)

covid_df_all_states_daily <- covid_df_all_states %>%
  select(
    Date,
    Country_Region,
    active,
    hospitalizedCurr,
    daily_tested,
    daily_positive
  )

glimpse(covid_df_all_states_cumulative)
glimpse(covid_df_all_states_daily)

library(dplyr)
library(ggplot2)

covid_df_all_states_cumulative_max <- covid_df_all_states_cumulative %>%
  group_by(Continent_Name,Two_Letter_Country_Code) %>%
  summarise(max_death = max(death, na.rm = TRUE))

covid_df_all_states_cumulative_max

covid_df_all_states_cumulative_max <- covid_df_all_states_cumulative_max %>%
  filter(max_death > 0)
glimpse(covid_df_all_states_cumulative_max)

ggplot(
  data = covid_df_all_states_cumulative_max,
  aes(
    x = Two_Letter_Country_Code,
    y = max_death,
    color = Continent_Name
  )
) +
  geom_point() +
  labs(
    title = "Maximum Covid 19 Deaths by Country",
    x = "Country Code",
    y = "Maximum Death Count"
  )

top_3_df <- covid_df_all_states_cumulative_max %>%
  arrange(desc(max_death)) %>%
  slice(1:3)
top_3_df

death_top_3 <- top_3_df$Two_Letter_Country_Code
death_top_3

library(dplyr)

covid_df_all_states_daily_sum <- covid_df_all_states_daily %>%
  group_by(Country_Region) %>%
  summarize(
    tested = sum(daily_tested, na.rm = TRUE),
    positive = sum(daily_positive, na.rm = TRUE),
    active = sum(active, na.rm = TRUE),
    hospitalized = sum(hospitalizedCurr, na.rm = TRUE)
  ) %>%
  arrange(desc(tested))

covid_df_all_states_daily_sum

covid_top_10 <- head(covid_df_all_states_daily_sum, 10)
covid_top_10

countries <- covid_top_10$Country_Region
tested_cases <- covid_top_10$tested
positive_cases <- covid_top_10$positive
active_cases <- covid_top_10$active
hospitalized_cases <- covid_top_10$hospitalized


names(tested_cases) <- countries
names(positive_cases) <- countries
names(active_cases) <- countries
names(hospitalized_cases) <- countries

positive_tested_ratio <- positive_cases / tested_cases

positive_tested_top_3 <- sort(positive_tested_ratio, decreasing = TRUE)[1:3]
positive_tested_top_3

covid_mat <- cbind(
  tested_cases,
  positive_cases,
  active_cases,
  hospitalized_cases
)


population <- c(
  331002651,
  145934462,
  60461826,
  1380004385,
  84339067,
  37742154,
  67886011,
  25499884,
  32971854,
  37846611
)

covid_mat <- covid_mat * 100 / population
covid_mat 

tested_cases_rank <- rank(covid_mat[, "tested_cases"])
positive_cases_rank <- rank(covid_mat[, "positive_cases"])
active_cases_rank <- rank(covid_mat[, "active_cases"])
hospitalized_cases_rank <- rank(covid_mat[, "hospitalized_cases"])

covid_mat_rank <- rbind(
  tested_cases_rank,
  positive_cases_rank,
  active_cases_rank,
  hospitalized_cases_rank
)

covid_mat_rank

covid_mat_rank[1,]

covid_mat_rank_no_tested <- covid_mat_rank[-1, ]

aggregated_rank <- colSums(covid_mat_rank_no_tested)
aggregated_rank

best_effort_tested_cased_top_3 <- names(sort(covid_mat_rank[1, ]))[1:3]
best_effort_tested_cased_top_3

most_affected_country <- names(which.max(aggregated_rank))
most_affected_country

least_affected_country <- names(which.min(aggregated_rank))
least_affected_country


question_list <- list(
  "Which countries have had the highest number of deaths due to COVID-19?",
  "Which countries have had the highest number of positive cases against the number of tests?",
  "Which countries have made the best effort in terms of the number of COVID-19 tests conducted related to their population?",
  "Which countries were ultimately the most and least affected related to their population?"
)

answer_list <- list(
  "Death" = death_top_3,
  "Postive_tested_cases" = positive_tasted_top_3,
  "The best effort in test related to the population" = best_effort_tested_cased_top_3,
  "The most affected country related to its population" = most_affected_country,
  "The least affected country related to its population" = least_affected_country
)

answer_list

dataframe_list <- list(
  covid_df,
  covid_df_all_states,
  covid_df_all_states_cumulative,
  covid_df_all_states_daily,
  covid_df_all_states_cumulative_max,
  covid_df_all_states_daily_sum,
  covid_top_10
)


matrix_list <- list(
  covid_mat,
  covid_mat_rank
)

vector_list <- list(
  countries,
  tested_cases,
  positive_cases,
  active_cases,
  hospitalized_cases,
  population,
  aggregated_rank,
  death_top_3,
  positive_tasted_top_3,
  best_effort_tested_cased_top_3,
  most_affected_country,
  least_affected_country
)


data_structure_list <- list(
  "Dataframes" = dataframe_list,
  "Matrices" = matrix_list,
  "Vectors" = vector_list
)


covid_analysis_list <- list(
  question_list = question_list,
  answer_list = answer_list,
  data_structure_list = data_structure_list
)

covid_analysis_list



# Conclusion
#
# In this project, we analyzed a COVID-19 dataset using R to evaluate how different
# countries were affected by the pandemic in terms of deaths, positive cases, testing
# effort, and population size. After cleaning and filtering the dataset by selecting
# aggregated national-level records, we summarized cumulative and daily COVID-19
# indicators and applied grouping, ranking, and normalization techniques. The analysis
# revealed that the countries with the highest number of COVID-19 related deaths include
# Russia, Turkey, Bangladesh, Italy, the United Kingdom, Belgium, the United States,
# Canada, Costa Rica, New Zealand, and Australia. Additionally, the highest ratios of
# positive cases relative to the number of tests conducted were observed in the United
# Kingdom, the United States, and Turkey.
#
# To ensure fair comparisons across countries, the indicators were adjusted relative to
# population size. Based on this population-normalized analysis, India, the United
# Kingdom, and Turkey demonstrated the strongest testing efforts. Italy emerged as the
# most affected country when considering cumulative COVID-19 impacts relative to
# population, whereas India appeared to be the least affected. Overall, this project
# illustrates a complete and reproducible data analysis workflow in R, including data
# preprocessing, aggregation, matrix operations, ranking, and interpretation, and
# highlights the importance of population-adjusted metrics when assessing the global
# impact of COVID-19.
