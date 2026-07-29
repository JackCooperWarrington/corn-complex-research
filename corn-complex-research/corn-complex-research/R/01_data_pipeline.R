# =====================================================================
# 01_data_pipeline.R
# ---------------------------------------------------------------------
# Pulls and cleans the three inputs to the project:
#   1. Corn futures price (CBOT front month, via yfinance CSV export)
#   2. Ethanol / DDGS / corn oil prices (illustrative - see note below)
#   3. USDA corn supply & demand history (compiled from WASDE)
# and writes tidy CSVs to data/processed/ for the analysis scripts.
#
# NOTE ON DATA SOURCES (read this before you present the project):
#   - Corn price is REAL: pulled from Yahoo Finance (ticker ZC=F).
#   - Ethanol/DDGS/corn oil is ILLUSTRATIVE: free daily series for these
#     aren't available without an API key (EIA) or a manual download
#     (Iowa State CARD). I generated a monthly series calibrated to
#     realistic historical ranges so the margin math and charts work
#     end-to-end. Before relying on this for a real view, swap in the
#     real CARD/EIA series - the column names already match what
#     02_ethanol_margin.R expects, so it's a straight drop-in.
#   - The USDA S&D history is compiled from USDA WASDE reports and public
#     ag-econ writeups. The most recent 2 years (2025/26, 2026/27) are
#     sourced directly to the July 2026 WASDE and tie out exactly. Older
#     years are flagged data_quality = "compiled_estimate_verify" -
#     cross-check these against USDA Quick Stats before citing them
#     anywhere outside this practice project.
# =====================================================================

library(dplyr)
library(lubridate)

# ---- 1. Corn futures price ------------------------------------------
raw <- read.csv("data/raw/corn_futures_raw.csv", skip = 2, header = FALSE,
                 col.names = c("date","close","high","low","open","volume"))

corn_px <- raw |>
  mutate(date = as_date(date)) |>
  filter(!is.na(close)) |>
  transmute(
    date        = date,
    corn_cents  = close,          # CBOT quotes corn in cents/bushel
    corn_usd    = corn_cents / 100
  ) |>
  arrange(date)

cat("Corn price rows:", nrow(corn_px), "| range:",
    as.character(min(corn_px$date)), "to", as.character(max(corn_px$date)), "\n")

# ---- 2. Ethanol / DDGS / corn oil (illustrative, monthly) ------------
ddgs_eth <- read.csv("data/raw/ethanol_ddgs_illustrative.csv") |>
  mutate(date = as_date(date))

# ---- 3. Join corn price onto the ethanol/DDGS monthly calendar -------
# Ethanol/DDGS are monthly; corn is daily. Resample corn to monthly mean
# so the two line up, then left_join on date.
corn_monthly <- corn_px |>
  mutate(month = floor_date(date, "month")) |>
  group_by(month) |>
  summarize(corn_usd = mean(corn_usd), .groups = "drop") |>
  rename(date = month)

prices <- ddgs_eth |>
  left_join(corn_monthly, by = "date") |>
  filter(!is.na(corn_usd))

# ---- 4. USDA supply/demand history -----------------------------------
corn_sd <- read.csv("data/raw/corn_sd_history.csv")

# ---- 5. Save cleaned outputs ------------------------------------------
dir.create("data/processed", showWarnings = FALSE, recursive = TRUE)
write.csv(corn_px,  "data/processed/corn_px.csv",  row.names = FALSE)
write.csv(prices,   "data/processed/prices.csv",   row.names = FALSE)
write.csv(corn_sd,  "data/processed/corn_sd.csv",  row.names = FALSE)

cat("\nSaved: data/processed/corn_px.csv, prices.csv, corn_sd.csv\n")
cat("corn_sd.csv rows:", nrow(corn_sd), "(", min(corn_sd$marketing_year),
    "to", max(corn_sd$marketing_year), ")\n")
