# Project Background: Product Analysis Overview

The company is a leading innovator in the **audio technology industry**, dedicated to providing **high-quality audio solutions** for professionals and enthusiasts alike. The company has built a reputation for **exceptional sound clarity, advanced engineering, and user-friendly designs**, making it a trusted name among **musicians, content creators, and audio engineers worldwide**.

To support data-driven decision-making, the company has requested the development of a **high-level Product Analytics Dashboard**. This dashboard will provide insights into **key product performance metrics**, enabling Asces Sound to **track sales trends, evaluate profitability, and optimise discount strategies** across different markets.

## Insights and Recommendations

Insights and recommendations are provided on the following key areas:

- **Revenue by Country:** Identifying top-performing regions and their corresponding revenue contributions.  
- **Revenue Trends by Date & Year:** Analysing sales patterns and comparative year-on-year (YoY) trends.  
- **Profit and Unit Sales Growth:** Evaluating overall profitability and unit sales YoY changes to measure business growth.  
- **Revenue Breakdown by Discount Band:** Understanding how different discount categories impact total revenue.  
- **Detailed Revenue & Profit Table:** Providing granular insights into revenue and profit by country and year.  

## SQL & Dashboard Links

- The **SQL queries** used to inspect and clean the data for this analysis can be found **[here](#)**.  
- Targeted **SQL queries** regarding various business questions can be found **[here](#)**.  
- An **interactive Power BI dashboard** used to report and explore sales trends can be found **[here](https://app.powerbi.com/links/f69OO0mMV7?ctid=467ebcdc-88be-415f-a596-b3bb27570812&pbi_source=linkShare)**.  


# Data Structure & Initial Checks

The database consists of **three core tables**—`ProductData`, `ProductSales`, and `DiscountData`—which were joined and structured to create a final dataset for analysis. Each row in the final dataset represents a sales transaction, including product details, pricing, discounting, and revenue calculations.

## Final Dataset Schema

After structuring and cleaning, the final dataset contains the following key fields:

| Column Name        | Data Type   | Description |
|-------------------|------------|-------------------------------------------------|
| **Product**       | TEXT       | Name of the audio product. |
| **Category**      | TEXT       | Product category (e.g., microphones, speakers). |
| **Brand**         | TEXT       | Manufacturer of the product. |
| **Description**   | TEXT       | Short description of product features. |
| **Cost_Price**    | MONEY      | Cost price per unit. |
| **Sale_Price**    | MONEY      | Selling price per unit. |
| **Image_url**     | TEXT       | URL link to the product image. |
| **Date**          | DATE       | Date of the transaction. |
| **Customer_Type** | TEXT       | Type of customer (e.g., Education, Individual, Corporate). |
| **Country**       | TEXT       | Country where the sale occurred. |
| **Discount_Band** | TEXT       | Discount category applied. |
| **Units_Sold**    | INTEGER    | Number of units sold in the transaction. |
| **Revenue**       | DECIMAL    | Total revenue (`Sale_Price * Units_Sold`). |
| **Total_Cost**    | DECIMAL    | Total cost (`Cost_Price * Units_Sold`). |
| **Discounted_Revenue** | DECIMAL | Revenue adjusted for discount percentage. |
| **Month**         | TEXT       | Month extracted from transaction date. |
| **Year**          | INTEGER    | Year extracted from transaction date. |


## Initial Data Quality Checks & Improvements

Before performing any analysis, the following checks and cleaning steps were conducted:

**Joined `ProductSales` with `ProductData` and `DiscountData`**  
- Merged tables using `Product_ID` and `Discount_Band` to form a.  
- Ensured that all sales records have corresponding product details.  

**Checked for Missing Values**  
- Found and **removed 1 row with a missing product name** in `ProductSales`.  
- Ensured no missing values in critical fields like `Sale_Price`, `Units_Sold`, and `Date`.

**Handled Duplicates**  
- Verified that `Product_ID` is unique in `ProductData`.  
- No duplicate transactions found in `ProductSales`.

**Formatted Date Columns**  
- Extracted Month & Year from transaction dates for time-series analysis.  

**Created New Calculated Columns**  
- Revenue
- Total Cost
- Discounted Revenue ;’


# Executive Summary

## Overview of Findings
This analysis and dashboard provide key insights into sales performance, revenue trends, and profitability drivers. The findings focus on revenue distribution, year-over-year growth, discount trends, and customer segmentation, highlighting key areas for potential improvements.
Revenue distribution across regions reveals that Canada, the USA, and France collectively contribute approximately 60% of total revenue. Both Mexico and Germany are declining markets both in Units Sold YoY and Profit YoY. Despite this regional performance, overall profit has grown by 7% YoY, with June and October standing out as the strongest-performing months.
In terms of customer segmentation, Government clients generate the highest share of revenue. However, a decline in units sold and a small YoY profit loss suggest potential inefficiencies in this segment. Meanwhile, Small Businesses experienced a 28% increase in units sold YoY but suffered a 7% decline in profit YoY, raising concerns about the effectiveness of the current discounting strategy, particularly in the USA.
Additionally, the QuadCast S is seeing a decline in both units sold and profit YoY, signalling a potential shift in product demand. This presents an opportunity to reassess its pricing strategy or explore the introduction and marketing of a replacement product with stronger profit margins.
<Insert dashboard image>

---

# Insights Deep Dive

This section provides a detailed breakdown of key insights into **sales performance, discounting trends, customer segmentation, and product profitability**.

---

## Revenue by Country
- **Canada, the USA, and France** remain the **top-performing markets**, contributing **~60% of total revenue**.
- **Mexico and Germany are declining markets**, showing a **drop in both units sold and profit YoY**. This suggests challenges in maintaining demand, which may require adjustments in pricing, marketing, or regional sales strategies.
- **Small Business sales in the USA have increased**, but profitability has declined due to **aggressive discounting**.
- **France** presents a growth opportunity, with **largest increase in unit sales band Profit**, indicating potential for further **expansion with and targeted marketing efforts**.

📊 _[Insert visualization: Revenue breakdown by country]_  

---

## Revenue Trends & Year-over-Year Growth
- **Revenue has grown by 7% YoY**, with **June and October** emerging as the **strongest-performing months**.
- **Seasonal trends indicate fluctuations in demand**, highlighting the importance of **strategic inventory planning and promotional efforts** Particularly around June and October times.
- **Despite higher revenue, profit growth is lagging**, largely due to declining sales in **Mexico and Germany**, as well as **margin erosion from high discount usage**.

📊 _[Insert visualization: Monthly revenue trends and YoY comparison]_  

---

## Discounting Strategies & Impact on Profitability
- **A significant portion of total revenue** is tied to **heavily discounted products**, driving sales but **reducing overall profitability**.
- **Small Business clients** saw a **28% increase in units sold YoY**, but **profit dropped by 7%**, raising concerns about **over-discounting in this segment**.
- **Government clients generate the highest revenue**, but **unit sales are declining**, and **profits are slightly negative YoY**, suggesting a need to **reassess pricing and discount structures**.
- **Germany and Mexico are not only seeing a decline in unit sales but also experiencing negative profit growth**, indicating that discounting in these markets may not be stimulating enough demand to sustain profitability.

📊 _[Insert visualization: Discount band impact on revenue and profitability]_  

---

## Product Performance & Market Trends
- **QuadCast S is experiencing a decline in both units sold and profit YoY**, signalling a potential **drop in demand or increased competition**.
- **Scarlett 2i2** is also showing a large lag in profitability, suggesting an opportunity to introduce a replacement product with better margins or a reassessment of the discount strategy. 
- **Mexico and Germany may require market-specific adjustments**, such as **price optimisations, targeted promotions, or inventory realignments**, to improve performance.


📊 _[Insert visualization: Product performance breakdown]_  


# Recommendations

Based on the insights from the sales analysis, revenue trends, and discounting strategies, the following recommendations aim to optimise profitability, enhance regional sales performance, and refine product and discount strategies.

---

## Optimising Regional Performance
- Mexico and Germany require market-specific adjustments due to declining unit sales and negative profit growth. 
  - Reassess pricing strategies to improve competitiveness without eroding margins.  
  - Introduce targeted marketing campaigns to drive demand in underperforming regions.  
  - Evaluate product demand trends and adjust inventory accordingly.  

- Small Business sales in the USA saw significant unit growth, but profitability declined.  
  - Reduce over-reliance on deep discounting, as heavy discounts may not be translating into sustainable revenue.  
  - Implement tiered discount structures that encourage bulk purchasing while maintaining profit margins.  

---

## Refining Discount Strategies
- Government clients generate high revenue but declining unit sales and slight profit losses.  
  - Reassess discount policies for this segment to ensure sustainable sales growth.  
  - Explore alternative pricing models such as volume-based incentives rather than broad discounting.  

- Discounting is driving unit sales but impacting profitability across key segments. 
  - Focus on optimising discount allocation by prioritising high-margin products.  
  - Conduct an A/B test on discount bands to determine the most effective price points for revenue retention.  

---

## Product Strategy & Market Positioning
- QuadCast S is experiencing a decline in sales and profit YoY, indicating a potential drop in demand.  
  - Assess whether market saturation, pricing, or competitive alternatives are driving this decline.  
  - Consider introducing a replacement product with improved margins and updated features.  

- Scarlett 2i2 is showing a lag in profitability, suggesting an opportunity for product innovation or repositioning.  
  - Potentially launching targeted campaigns to boost product awareness in strong-performing regions.  
  - Conduct competitor benchmarking to identify differentiation strategies.  

---

## Leveraging Seasonal Trends
- June and October are the strongest sales months, highlighting the potential for seasonal marketing campaigns.  
  - Introduce pre-season promotions leading up to peak months to maximise revenue.  
  - Align inventory and production planning to prevent stock issues during high-demand periods.  

---

# Assumptions & Caveats  

Throughout the analysis, several assumptions were made to address data limitations and ensure meaningful insights. Additionally, some caveats should be considered when interpreting the results.  


- Discount percentages: It was assumed that discount bands accurately reflect the actual discount applied to sales transactions.  
- Product-category mapping: Products were categorised based on available metadata, with no adjustments made for potential misclassifications.  
- Regional sales performance: Declining sales in Mexico and Germany were attributed to market trends and discount strategies, but external economic factors such as inflation, geopolitical factors or supply chain disruptions were not considered.  
- Pricing & discounting impacts: While discount bands were analysed, the **actual purchasing behaviour in response to discounts (e.g., whether customers would have bought the product at full price) remains an assumption.  
- Product performance analysis: The decline in **QuadCast S sales** was flagged as a concern, but additional external factors (e.g., competitor launches, market saturation) were not incorporated into the analysis.  
- Currency & inflation adjustments: The analysis was performed using nominal sales values, without adjustments for currency fluctuations or inflation, which may impact profitability trends over time.  


