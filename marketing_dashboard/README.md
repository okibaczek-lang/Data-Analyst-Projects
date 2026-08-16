# Marketing Campaign Performance Dashboard (Power BI)

## Problem

Which marketing campaigns and channels deliver the best return on investment, and how does the conversion funnel look from impression to final conversion?

## Data

- Source: [Marketing Dataset (Hugging Face)](https://huggingface.co/datasets/alsayed7/marketing_dataset)
- Columns used: `Marketing_Channel`, `Campaign_Name`, `Impressions`, `Clicks`, `Conversions`, `Total_Spend`, `Revenue_Generated`, `Location`, `Age_Group`, `Gender`, `Start_Date`, `End_Date`
- Scope: campaigns running 2022-2024

## Approach

- Power BI Desktop for the full model and dashboard
- Power Query for data cleaning (headers, data types, US-locale number/date parsing)
- DAX measures: `Total Spend`, `Total Revenue`, `Total Conversions`, `ROI = DIVIDE([Total Revenue] - [Total Spend], [Total Spend])`, `Cost per Conversion`
- A separate `DateTable` (built with `CALENDAR()` and marked as a date table) to support time-based analysis

## Dashboard

<img width="1314" height="808" alt="image" src="https://github.com/user-attachments/assets/39e1ce8c-ae9b-4a34-b5f2-eb7b38e03f65" />


### KPI Cards
Total Revenue (21.22M), Total Spend (8.16M), and overall ROI (1.60) give the headline numbers at a glance before drilling into any detail.

### Conversion Funnel
Impressions -> Clicks -> Conversions drops from 80.19M to 40.28M to 20.26M, an overall conversion rate of 25.3%. The steepest drop-off happens between impressions and clicks, suggesting ad creative/targeting has more room for improvement than the clicks-to-conversion step.

### ROI by Campaign
ROI is nearly flat when measured at the broad `Marketing_Channel` level (all channels cluster around ~1.6), but becomes more differentiated when broken down by individual `Campaign_Name` -- some campaigns meaningfully outperform others even within the same channel. This is a useful finding on its own: channel-level ROI isn't granular enough to guide budget decisions here, and campaign-level analysis is needed instead.

### Conversions by Location
Conversions vary noticeably by location, with Galati leading (~4.6M) and Bacau trailing (~3.7M) -- a ~22% spread across the top 5 locations.

## Overall Recommendations

1. **Evaluate budget allocation at the campaign level, not the channel level** -- channel-level ROI is too uniform to distinguish strong from weak performers; individual campaign performance is where the real differences show up.
2. **Investigate the impressions-to-clicks drop-off** -- this is the largest single loss in the funnel and the most likely place to improve overall conversion efficiency.
3. **Consider location-based targeting adjustments** -- the ~22% spread in conversions across top locations suggests geographic performance isn't uniform and may be worth factoring into future campaign planning.

## Repo Structure

```
|-- README.md
|-- marketing_dashboard.pbix   (if file size allows upload)
+-- charts/
    +-- dashboard_overview.png
```
