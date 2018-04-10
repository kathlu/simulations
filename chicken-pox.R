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

  # Store column names in variables

  # Set this year as status from last year

  # Randomly sample new infected cases this year

  # Set infected/resistant from last year to resistent this year

# Compute cases by year to graph over time

# Plot results 
