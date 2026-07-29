# =====================================================================
# 02_ethanol_margin.R
# ---------------------------------------------------------------------
# Builds the corn ETHANOL CRUSH MARGIN: the value of what an ethanol
# plant sells (ethanol + DDGS + corn oil) minus what it pays for corn.
# This is the corn-complex analogue of the soybean crush spread, and it
# ties the "corn feed" thread through the processing side, since DDGS
# (distillers dried grains) is itself a livestock feed product.
#
# NOTE: ethanol/DDGS/corn-oil inputs are the illustrative series
# described in 01_data_pipeline.R - see that script's header before
# quoting these margin levels as real.
# =====================================================================

library(dplyr)
library(ggplot2)
library(lubridate)

prices <- read.csv("data/processed/prices.csv") |> mutate(date = as.Date(date))

# ---- 1. yield assumptions (per bushel of corn) -----------------------
# Sourced to typical dry-mill ethanol plant yields (verify against a
# specific plant's numbers if used beyond this practice project).
ETH_GAL_PER_BU    <- 2.8    # gallons ethanol
DDGS_LB_PER_BU    <- 16     # lbs DDGS
CORNOIL_LB_PER_BU <- 0.6    # lbs corn oil

margin <- prices |>
  mutate(
    ethanol_rev  = ETH_GAL_PER_BU * ethanol_usd_gal,
    ddgs_rev     = (DDGS_LB_PER_BU / 2000) * ddgs_usd_ton,
    cornoil_rev  = CORNOIL_LB_PER_BU * cornoil_usd_lb,
    crush_margin = ethanol_rev + ddgs_rev + cornoil_rev - corn_usd
  ) |>
  filter(!is.na(crush_margin))

write.csv(margin, "data/processed/ethanol_margin.csv", row.names = FALSE)

cat("Margin summary ($/bu):\n")
print(summary(margin$crush_margin))
cat("Current (latest month):", round(tail(margin$crush_margin, 1), 2), "\n")
cat("Full-period average   :", round(mean(margin$crush_margin), 2), "\n")

# ---- 2. chart: margin over time --------------------------------------
p1 <- ggplot(margin, aes(date, crush_margin)) +
  geom_hline(yintercept = 0, linewidth = 0.3, colour = "grey60") +
  geom_line(linewidth = 0.7, colour = "#1F4E23") +
  labs(
    title    = "Corn Ethanol Crush Margin, 2015-2026",
    subtitle = "Ethanol + DDGS + corn oil revenue, minus corn cost, per bushel",
    x = NULL, y = "$ / bushel",
    caption  = "Corn price: CBOT front-month futures (Yahoo Finance). Ethanol/DDGS/corn oil: illustrative series - see 01_data_pipeline.R."
  ) +
  theme_minimal(base_size = 12) +
  theme(plot.caption = element_text(size = 7, colour = "grey40"))

ggsave("figures/ethanol_margin.png", p1, width = 9, height = 5, dpi = 150)

# ---- 3. seasonality: average margin by calendar month -----------------
seasonality <- margin |>
  mutate(month = month(date, label = TRUE)) |>
  group_by(month) |>
  summarize(avg_margin = mean(crush_margin), .groups = "drop")

p2 <- ggplot(seasonality, aes(month, avg_margin)) +
  geom_col(fill = "#1F4E23") +
  labs(title = "Average Ethanol Crush Margin by Calendar Month",
       subtitle = "2015-2026 average",
       x = NULL, y = "$ / bushel") +
  theme_minimal(base_size = 12)

ggsave("figures/margin_seasonality.png", p2, width = 9, height = 5, dpi = 150)

cat("\nSaved figures/ethanol_margin.png and figures/margin_seasonality.png\n")
cat("Seasonality table:\n")
print(seasonality)
