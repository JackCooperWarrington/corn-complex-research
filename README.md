# Corn Complex Research Tool

A fundamentals-driven research project on the U.S. corn complex: the supply/demand balance sheet, the ethanol/DDGS processing margin, and the historical stocks-to-use/price relationship, ending in a written market note with a data-grounded directional view.

Built in **R** (dplyr, ggplot2, base R) and **Excel**. Marketing year of record: **2026/27**.

**Why corn:** demand splits cleanly into three stories — feed, ethanol, and exports — and the ethanol crush margin is the corn-complex analogue of the soybean crush a trading desk watches daily. DDGS, a byproduct of ethanol production, is itself a livestock feed, so the "feed" thread runs through both the demand side and the processing side of this project.

📄 **[Read the market note](notes/market_note.md)** · 📊 **[Open the dashboard preview](dashboard_preview.html)** · 📈 **[Open the Excel balance sheet](excel/corn_balance_sheet.xlsx)**

---

## Key results

**The 2026/27 balance sheet ties out exactly** to the July 2026 USDA WASDE: production 16.0 billion bushels, total use 16.255 bb, ending stocks 1.79 bb, for a **stocks-to-use ratio of 11.0%** (~40 days of use on hand).

![Stocks-to-use vs price](figures/stu_vs_price.png)

A simple OLS regression of season-average price on stocks-to-use, across 22 marketing years (2005/06–2026/27), shows a correlation of **-0.82** and an R² of **0.67** (p < 0.001) — a strong result for a single variable in a commodity market. At today's 11.0% stocks-to-use, the fitted line implies a price near **$4.73/bu**, above USDA's own $4.40 forecast. The full reasoning, including why the 2006/07 and 2022/23 outliers make economic sense rather than breaking the model, is in the [market note](notes/market_note.md).

![Ethanol crush margin](figures/ethanol_margin.png)

The modeled ethanol crush margin (ethanol + DDGS + corn oil revenue, minus corn cost) averages **$1.24/bu** since 2015 and currently sits near **$1.20/bu** — close to its historical average, with a seasonal peak in Aug–Sep and a trough in Apr–May.

---

## Repo structure

| Path | What it is |
|---|---|
| `domain_notes/day1_learning_notes.md` | What I learned before writing any code |
| `R/01_data_pipeline.R` | Pulls & cleans corn price, ethanol/DDGS, and USDA S&D data |
| `R/02_ethanol_margin.R` | Computes and charts the ethanol crush margin |
| `R/03_fundamentals_vs_price.R` | OLS regression: stocks-to-use vs. price |
| `R/04_dashboard.Rmd` | flexdashboard source (knit locally) |
| `excel/corn_balance_sheet.xlsx` | Corn balance sheet, live formulas, ties to WASDE |
| `dashboard_preview.html` | Static preview of the dashboard charts |
| `notes/market_note.md` | The written deliverable — my actual view and why |
| `figures/` | Generated chart PNGs |
| `data/` | Raw inputs and cleaned outputs |

## Data sources & honesty notes

- **Corn price:** real daily CBOT front-month futures (`ZC=F`) via Yahoo Finance, 2015–2026.
- **Supply/demand:** the 2025/26 and 2026/27 columns are sourced directly to the July 2026 USDA WASDE and verified to tie out exactly. Earlier years (2005/06–2024/25) are compiled from public USDA WASDE reporting to give the regression a full sample — flagged `compiled_estimate_verify` in the data, and I'd re-check them against USDA Quick Stats before relying on them outside a portfolio project.
- **Ethanol/DDGS/corn oil:** free daily series require an EIA API key or a manual Iowa State CARD download I didn't have set up this pass, so I built an illustrative monthly series calibrated to realistic historical ranges. This is flagged in the code and in the market note — the margin's *level and seasonal shape* are the honest takeaway; I wouldn't quote the exact dollar figure outside this project without swapping in the real feed.

## How to reproduce

```bash
Rscript R/01_data_pipeline.R
Rscript R/02_ethanol_margin.R
Rscript R/03_fundamentals_vs_price.R
# then, with rmarkdown + flexdashboard installed locally:
Rscript -e 'rmarkdown::render("R/04_dashboard.Rmd")'
```

## What I'd do next

- Swap in real CARD/EIA ethanol and DDGS data.
- Verify the pre-2025 balance sheet history line by line against USDA Quick Stats.
- Add a second regressor (e.g. crude oil or DDGS price) to the price model, once econometrics this year covers multiple regression properly.

---
*Personal research/portfolio project. Not investment advice.*
