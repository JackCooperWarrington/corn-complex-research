# =====================================================================
# 03_fundamentals_vs_price.R
# ---------------------------------------------------------------------
# Tests the textbook relationship: tighter stocks-to-use (less cushion)
# goes with a HIGHER season-average price. Simple bivariate OLS on
# purpose - this is the ECON 2670 (bivariate regression) skill applied
# to a real market question, not a machine-learning exercise. The
# judgment in interpreting the misses matters more than the R-squared.
# =====================================================================

library(dplyr)
library(ggplot2)

corn_sd <- read.csv("data/processed/corn_sd.csv")

# ---- 1. correlation --------------------------------------------------
r <- cor(corn_sd$stocks_to_use, corn_sd$avg_farm_price)
cat("Correlation (stocks-to-use, price):", round(r, 3), "\n")

# ---- 2. OLS: price ~ stocks-to-use ------------------------------------
fit <- lm(avg_farm_price ~ stocks_to_use, data = corn_sd)
cat("\n--- Regression summary ---\n")
print(summary(fit))

b0 <- coef(fit)[1]; b1 <- coef(fit)[2]
cat(sprintf("\nFitted line: price = %.2f + (%.3f x stocks_to_use)\n", b0, b1))
cat(sprintf("R-squared: %.3f  |  n = %d marketing years\n",
            summary(fit)$r.squared, nrow(corn_sd)))

# ---- 3. residuals: where did the simple model miss? -------------------
corn_sd <- corn_sd |>
  mutate(fitted_price = predict(fit, newdata = corn_sd),
         residual      = avg_farm_price - fitted_price) |>
  arrange(desc(abs(residual)))

cat("\nLargest misses (model under/over-predicts price):\n")
print(corn_sd |>
        select(marketing_year, stocks_to_use, avg_farm_price, fitted_price, residual) |>
        head(5))

# ---- 4. this year's implied price -------------------------------------
current <- corn_sd |> filter(marketing_year == "2026/27")
implied <- predict(fit, newdata = current)
cat(sprintf("\n2026/27 stocks-to-use = %.1f%% -> model-implied price = $%.2f (WASDE actual: $%.2f)\n",
            current$stocks_to_use, implied, current$avg_farm_price))

# ---- 5. chart ----------------------------------------------------------
p <- ggplot(corn_sd, aes(stocks_to_use, avg_farm_price)) +
  geom_point(size = 2.6, colour = "#1F4E23") +
  geom_smooth(method = "lm", se = TRUE, colour = "grey40",
              linewidth = 0.6, linetype = "dashed") +
  geom_point(data = current, aes(stocks_to_use, avg_farm_price),
             colour = "firebrick", size = 3.6) +
  annotate("text", x = current$stocks_to_use, y = current$avg_farm_price,
           label = "2026/27", vjust = -1.1, colour = "firebrick", size = 3.3) +
  labs(
    title    = "Corn: Stocks-to-Use vs. Season-Average Price (2005/06-2026/27)",
    subtitle = sprintf("Simple OLS  |  R-sq = %.2f  |  corr = %.2f", summary(fit)$r.squared, r),
    x = "Stocks-to-use ratio (%)", y = "Season-avg farm price ($/bu)",
    caption = "USDA WASDE (2025/26, 2026/27 exact); earlier years compiled - verify vs. USDA Quick Stats."
  ) +
  theme_minimal(base_size = 12) +
  theme(plot.caption = element_text(size = 7, colour = "grey40"))

ggsave("figures/stu_vs_price.png", p, width = 9, height = 5.5, dpi = 150)
write.csv(corn_sd, "data/processed/corn_sd_with_fit.csv", row.names = FALSE)
cat("\nSaved figures/stu_vs_price.png\n")
