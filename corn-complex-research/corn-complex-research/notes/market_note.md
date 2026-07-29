# Corn Market Note
**Marketing year: 2026/27  |  Data as of: July 2026 WASDE**

## View in one line
Modestly constructive on 2026/27 corn. Stocks-to-use has tightened to 11.0% — historically consistent with prices above where USDA's own farm-price forecast sits — but a record-second-largest crop and comfortable feed/ethanol demand cap how far that support can carry the market absent a weather scare.

## Balance sheet
Production comes in at 16.0 billion bushels (183 bu/ac, 87.4M harvested acres) — the second-largest U.S. corn crop on record. Total use of 16.255 bb (feed & residual 6.1 bb, ethanol 5.6 bb, exports 3.2 bb) draws that down to ending stocks of 1.79 bb, for a stocks-to-use ratio of **11.0%** — about 40 days of use on hand. That's on the tighter side of the last decade: the 2016/17–2019/20 stretch ran in the 14–16% range, while 2026/27 sits closer to the tighter 2020–2022 seasons (8–10%). *(Source: USDA WASDE, July 2026; my balance sheet ties out exactly to the WASDE ending-stocks figure.)*

## Fundamentals vs. price
I ran a simple OLS regression of season-average farm price on stocks-to-use across 22 marketing years (2005/06–2026/27). The relationship is exactly the direction theory predicts and stronger than I expected going in: **correlation of -0.82**, R² of 0.67, and the stocks-to-use coefficient significant well past the 1% level. At an 11.0% stocks-to-use ratio, the fitted line implies a price near $4.73/bu — above USDA's own $4.40 forecast for the year.

That gap is worth sitting with rather than treating as a trading signal. The biggest historical misses in the model are informative: 2006/07 priced well *below* what its stocks-to-use alone would predict ($3.04 actual vs. a fitted $4.51) — this was the tail end of the pre-ethanol-boom pricing regime, before the mid-2000s ethanol mandate had fully repriced corn's demand floor upward, which is exactly why the farmdoc research I read for this project treats pre- and post-2007 as different eras with a different price/stocks-to-use relationship. In the other direction, 2022/23 priced well *above* the fitted line (a war-driven export/price shock), and 2020/21 undershot it (COVID-era demand uncertainty weighed on price even as stocks tightened). My read: the current $4.40 WASDE forecast is plausible as a *conservative* anchor — USDA's forecasting process incorporates information (input costs, basis, and forward contracting) that a single-variable model can't see — but the historical relationship suggests the risk to that forecast leans slightly to the upside barring a large 2026 harvest surprise.

## Processing economics — the ethanol/DDGS margin
The modeled ethanol crush margin (ethanol + DDGS + corn oil revenue, minus corn cost) has averaged **$1.24/bu** since 2015 and currently sits near **$1.20/bu** — in line with its historical average, i.e. neither unusually rich nor squeezed. Margins show a clear seasonal pattern, running strongest in August–September (~$1.3–1.5/bu) and softest in April–May (~$1.0–1.1/bu), which lines up with the pre-harvest corn-cost cycle. A margin sitting near its historical average implies ethanol plants are running at a normal, sustainable pace rather than either pulling back or maximizing output — a mild, not a strong, signal for corn demand from this channel. *(Caveat: my ethanol/DDGS price inputs are an illustrative series calibrated to realistic historical ranges, not the live CARD/EIA feed — see the data note in `01_data_pipeline.R`. The margin's level and seasonal shape are the honest takeaway; I would not quote the specific $1.20 figure outside this project without swapping in the real series first.)*

## Demand watch
- **Feed & residual (6.1 bb):** the single largest and most volatile domestic use category; USDA raised this line 150 million bushels in the July WASDE off the June Grain Stocks report, which is worth tracking into the next quarterly stocks release.
- **Ethanol (5.6 bb):** essentially flat year over year, tracking gasoline demand and blending economics rather than swinging independently.
- **Exports (3.2 bb):** the most headline-sensitive line, given ongoing global trade dynamics; a positive surprise here is the most likely source of further tightening.

## Risks to the view
**Upside (bullish) risks:** a weaker-than-expected August survey yield, an export surge, or a feed-demand upside surprise similar to July's revision.
**Downside (bearish) risks:** a larger final yield print, softer-than-expected exports, or a broader commodity/macro pullback.

## Bottom line
The fundamentals point the same direction as the regression: an 11.0% stocks-to-use ratio is tight enough historically to be modestly price-supportive, and the gap between the model-implied $4.73 and USDA's $4.40 forecast is a reasonable, data-grounded reason to lean slightly constructive rather than neutral — while recognizing a single-variable model is a starting point for a view, not a forecast on its own. The number I'd watch next is the August 12 USDA survey-based yield; a downside yield surprise there would tighten the balance sheet further and be the cleanest confirmation of this lean.

---
*Personal research project. Historical S&D data for years prior to 2025/26 is compiled from public USDA WASDE reporting and flagged for verification; ethanol/DDGS pricing is an illustrative series. Not investment advice.*
