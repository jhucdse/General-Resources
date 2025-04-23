# Load required libraries
library(survival)
library(survminer)
library(ggplot2)

# Simulate example data
set.seed(123)
n <- 200 #number in the sample

#data set up: 3 columns = time in sample, event at end of time (1 = event, 0 = censor), exposure status
data <- data.frame(
  time = rexp(n, rate = 0.1),
  status = sample(0:1, n, replace = TRUE),
  exposure = factor(sample(c("Treatment", "Control"), n, replace = TRUE))
)

# Fit a Kaplan-Meier survival curve
surv_object <- Surv(time = data$time, event = data$status)
km_fit <- survfit(surv_object ~ exposure, data = data)

# Plot using ggsurvplot (from survminer, uses ggplot2 under the hood)
km_plot <- ggsurvplot(
  km_fit,
  data = data,
  risk.table = TRUE,            # Include number at risk table
  pval = TRUE,                  # Show p-value from log-rank test
  censor = FALSE,               # Remove censoring marks
  conf.int = TRUE,              # Add confidence interval
  palette = c("#E69F00", "#56B4E9"),  # Custom color palette for exposure groups
  title = "Kaplan-Meier Survival Curve by Exposure Group",  # Add plot title
  xlab = "Time in days",
  ylab = "Survival probability",
  legend.title = "Exposure Group",
  legend.labs = c("Control", "Treatment"),
  ggtheme = theme_minimal()
)

# Print the plot
print(km_plot)
