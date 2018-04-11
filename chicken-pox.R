# Chicken Pox Simulation
library(dplyr)
library(tidyr)
library(ggplot2)

# Initial settings
pop <- rep("S", 1000)
pr_pox <- .2
data <- data.frame(id = 1:1000, 
  year_0 = pop, 
  stringsAsFactors = F
)

# Iterate over 15 years
for(i in 1:15) {
  # Store column names in variables
  this_year <- paste0("year_", i)
  last_year <- paste0("year_", i - 1)
  print(data[last_year])
  # Set this year as status from last year
  data[this_year] <- data[last_year]
  # Randomly sample new infected cases this year
  data[rbinom(pop, 1, pr_pox) == 1, this_year] <- "I"
  # Set infected/resistant from last year to resistent this year
  data[data[last_year] == "I" | data[last_year] == "R", this_year] <- "R"
}

# Compute cases by year to graph over time
by_year <- data %>%
  gather(key = year, value = status, -id) %>% 
  separate(year, c("label", "year"), convert = T) %>% #sep="_"
  group_by(year, status) %>% 
  count()

# Plot results 
ggplot(by_year) +
  geom_line(aes(x = year, y = n, colour = status))
