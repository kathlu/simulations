# Simulate Comorbidities

# Set up 
pop <- rep(0, 100)
prevalences <- list(malaria = .3, hiv = .2)
disability_weights <- list(malaria = .2, hiv = .4)

# A function to simulate comorbid ylds
simulate_ylds <- function(pop, prevs, dws) {
  # A data object to store the simulated cases
  sim_data <- data.frame(pop = pop)
  
  # Iterate through each disease and compute YLDs -- store result in sim_data
  for (i in names(prevs)) {
    # Compute a simulated # of cases and YLDs
    simulated_cases <- rbinom(pop, 1, prevs[[i]])
    simulated_ylds <- simulated_cases * dws[[i]]
    sim_data[[i]] <- simulated_ylds
  }  
  
  # Compute unadjusted, adjusted YLDs
  unadjusted_ylds <- sum(sim_data$malaria + sim_data$hiv)
  adjusted_ylds <- sum(1 - (1 - sim_data$malaria) * (1 - sim_data$hiv))
  return(list(unadjusted = unadjusted_ylds, adjusted = adjusted_ylds))
}

# Try passing the data to your function
sim_run <- simulate_ylds(pop, prevalences, disability_weights)

# Repeat 1000 times because of randomness
all_unadjusted <- vector()
all_adjusted <- vector()
for(i in 1:1000) {
  results <- simulate_ylds(pop, prevalences, disability_weights)
  all_unadjusted <- c(all_unadjusted, results$unadjusted)
  all_adjusted <- c(all_adjusted, results$adjusted)
}

# Graph variation in results (histogram of all_unadjusted)
results <- data.frame(all_unadjusted, all_adjusted)
ggplot(results) +
  geom_histogram(aes(x = all_unadjusted)) +
  labs(title="Distribution of Unadjusted YLDs in Simulation",
       x = "Unadjusted YLDs Experienced in Simulation")

# Show overall impact (histogram of all_adjusted / all_unadjusted)
ggplot(results) +
  geom_histogram(aes(x = all_adjusted / all_unadjusted)) +
  labs(title = "Distribution of Adjusted YLD / YLD Ratio", 
       x = "Adjusted YLD / YLD Ratio")
