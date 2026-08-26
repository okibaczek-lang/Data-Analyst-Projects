# Customer Segmentation Dashboard (RFM Analysis) — Power BI

## Problem

Which customers are the most valuable, and which segments need attention to avoid churn? Using RFM (Recency, Frequency, Monetary) segmentation to identify and prioritize customer groups.

## Data

- Source: Superstore Sales dataset
- Columns used: `Customer ID`, `Order Date`, `Order ID`, `Sales`
- Scope: all orders, 2015-2018

## Approach

- Power BI Desktop with DAX calculated columns (not measures — see note below) for the full RFM model
- **Recency**: days since a customer's most recent order (relative to the latest date in the dataset)
- **Frequency**: distinct count of orders per customer
- **Monetary**: total sales per customer
- Each dimension scored 1-3 based on thresholds, summed into an `RFM Score` (3-9), then mapped to a segment: **Champions**, **Loyal Customer**, **At Risk**, **Lost**

### A key technical note

RFM values were originally built as DAX *measures* using `CALCULATE` + `ALLEXCEPT` to compute per-customer values. This worked fine in tables, but Power BI does not allow measures to be used for grouping (axis/legend) in charts — only physical columns can be used that way. All RFM logic was rebuilt as **calculated columns** instead, which solved this and is the reason `Customer Segment` can be used as a chart category throughout this dashboard.

A second issue surfaced once charts were built: because Recency/Frequency/Monetary are the same value repeated across every order row for a given customer, the default **Sum** aggregation on a chart was adding up duplicate values, artificially inflating outliers (one customer showed a Recency of ~15,800 days — over 40 years — despite real order dates in 2015-2016). Switching the chart-level aggregation to **Max** fixed this, since all repeated values per customer are identical.

## Dashboard

<img width="1315" height="809" alt="image" src="https://github.com/user-attachments/assets/056161b0-3ecd-4407-b356-b5b82e25bcca" />

### KPI Cards
793 total customers, only 19 of them (2.4%) classified as Champions, with $34.87M in total revenue across the customer base.

### Customer Count per Segment
The distribution skews heavily toward lower-value segments: At Risk is the largest group, followed by Loyal Customer, then Lost, with Champions the smallest by far. Most of the customer base is not currently highly engaged.

### Total Monetary by Segment (decomposition tree) vs. Average Monetary by Segment
These two views tell different, complementary stories. By **total** revenue, Loyal Customer contributes the most ($19.7M) simply because it's a large group, while Champions contribute the least in total ($2.7M) due to their small size. But by **average** revenue per customer, Champions rank highest of all four segments — they are individually the most valuable customers in the dataset, just few in number.

### Recency vs Frequency (scatter plot)
Each point is one customer, sized by Monetary value and colored by segment. Champions cluster in the low-Recency, high-Frequency corner (recent and frequent buyers); Lost customers spread across high Recency and low Frequency, confirming the segmentation logic behaves as expected.

## Overall Recommendations

1. **Prioritize retention of the Champions segment** — despite being only 2.4% of customers, they generate the highest average revenue per customer. Losing them would be disproportionately costly relative to their small headcount.
2. **Design a win-back campaign for the At Risk segment** — this is the single largest group and represents the greatest opportunity for improving overall engagement, since even a modest recovery rate would affect a large number of customers.
3. **Investigate what distinguishes Champions from Loyal Customers** — understanding this could help develop a path to "upgrade" high-frequency Loyal Customers into Champions.

## Repo Structure

```
├── README.md
├── superstore_rfm_dashboard.pbix   (if file size allows upload)
└── charts/
    └── rfm_dashboard.png
```
