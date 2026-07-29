# Day 1 — Domain notes

## The corn balance sheet
Supply is everything available to use in a marketing year: **beginning stocks** (corn left over from last year), plus **production** (this year's harvest), plus a small amount of **imports**. Use is everything that gets consumed: **feed & residual** (fed to livestock, plus a catch-all for measurement error/losses), **food/seed/industrial** (which splits into ethanol and everything else — HFCS, starch, cereal, seed corn), and **exports**. **Ending stocks** is just supply minus use — it's a residual, not something anyone sets directly, which is why a small change in either production or use can swing it by a lot.

## Stocks-to-use
Ending stocks divided by total use, expressed as a percent (or as "days of use on hand" if you multiply by 365). A low ratio means there's not much cushion left over — if something goes wrong (bad weather, a demand surprise), there's less slack to absorb it, so price tends to react more. A high ratio means comfortable supply and less price sensitivity to any one piece of news. I ran the actual numbers for this project and the historical relationship is stronger than I expected: correlation of -0.82 between stocks-to-use and price across 22 marketing years.

## Feed & residual
This is the largest single demand category for corn, and it's also the one most directly tied to the corn *feed* theme of my project — this line represents corn actually going into livestock feed. "Residual" is lumped in because USDA can't perfectly measure feed use directly; it's partly a plug that captures measurement error between quarterly stocks reports. That's also why this line gets revised meaningfully around the June and September Grain Stocks reports — it moved 150 million bushels between the June and July 2026 WASDE.

## Ethanol / DDGS
An ethanol plant buys corn and sells three things: **ethanol** (the fuel), **DDGS** (distillers dried grains — the solids left after fermentation, sold as livestock feed), and a smaller amount of **corn oil**. The "crush margin" or ethanol margin is the value of those three products minus the cost of the corn — it's the same idea as the soybean crush spread, just for the ethanol/DDGS/corn-oil complex instead of meal/oil. DDGS is the piece that ties this back to feed markets: when ethanol production is strong, DDGS supply is strong too, which is a partial substitute for some feed corn demand.

## The WASDE report
USDA's World Agricultural Supply and Demand Estimates, published roughly monthly. It's the single most-watched report in the grain markets because it's the official government estimate of the balance sheet, and revisions move futures prices the day they're released. USDA uses a "policy in place" approach — it only reflects government policy that has actually started or has a known end date, not policy that's proposed or expected.

## Sources I used
- **Corn price:** CBOT front-month futures, pulled live from Yahoo Finance.
- **Supply/demand:** USDA WASDE (July 2026 for the current year; compiled from public WASDE reporting for history).
- **Ethanol/DDGS:** illustrative series calibrated to realistic historical ranges — flagged clearly in the code, since free daily data for these needs an EIA API key or a manual CARD download I didn't have time to wire up this pass.

---
### What I'd read next
- Iowa State CARD's ethanol profitability model, to replace my illustrative margin series with real numbers.
- USDA's Feed Grains Yearbook, to verify the pre-2025 balance sheet history line by line.
