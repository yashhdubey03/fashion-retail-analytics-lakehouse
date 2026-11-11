# Fashion Retail Analytics Lakehouse

![Databricks](https://img.shields.io/badge/Databricks-Lakehouse-orange?logo=databricks)
![Python](https://img.shields.io/badge/Python-PySpark-blue?logo=python)
![SQL](https://img.shields.io/badge/SQL-Analytics-lightgrey)
![Delta Lake](https://img.shields.io/badge/Delta%20Lake-Storage-purple)
![Status](https://img.shields.io/badge/Status-Completed-success)

An end-to-end retail analytics project built using **Databricks, PySpark, Delta Lake and SQL**, simulating the data ecosystem of a fictional Indian fashion retailer, NOVA THREADS.

The project transforms programmatically generated retail data into structured, business-ready analytical datasets through a Bronze-Silver-Gold lakehouse architecture. It covers data generation, ETL transformations, data validation, SQL analytics, customer segmentation and interactive business dashboards.

---

## 1. Business Context

NOVA THREADS is a fictional fashion retail business operating through a website and mobile application across Mumbai, Pune, Delhi and Bengaluru.

As the business expands, different operational areas generate large volumes of customer, product, transaction, inventory and marketing data. Analysing these independently makes it difficult to understand sales performance, customer purchasing behaviour, product demand and marketing effectiveness.

**Project Objective:** Build a centralised analytics solution that consolidates these datasets, prepares reliable analytical tables and provides business stakeholders with actionable insights through SQL and interactive dashboards.

### Project Highlights

- Generated approximately **850,000 synthetic records** across six datasets.
- Implemented a three-layer Bronze-Silver-Gold lakehouse architecture.
- Developed PySpark transformations with business-rule and data quality validations.
- Built RFM-based customer segmentation and cohort retention analysis.
- Developed 10 SQL queries using CTEs, window functions and analytical aggregations.
- Created three interactive Databricks AI/BI dashboards covering sales, customers and marketing.

## 2. Technology Stack

| Technology | Application |
|---|---|
| Databricks | Lakehouse development and analytics |
| PySpark | Synthetic data generation and ETL |
| Python | Data generation and processing |
| Delta Lake | Structured, managed table storage |
| SQL | Business analysis and reporting |
| Databricks AI/BI | Interactive dashboards |
| GitHub | Source control and documentation |

## 3. Data Overview

To simulate a realistic fashion retail environment without relying on external or proprietary datasets, all six datasets were generated programmatically using Python and PySpark.

The generated data includes customer demographics, product attributes, warehouse inventory, order transactions, individual order items and marketing campaign performance.

| Dataset | Records |
|---|---:|
| Customers | 100,000 |
| Products | 10,000 |
| Inventory | 40,000 |
| Orders | 200,000 |
| Order Items | 499,765 |
| Marketing Campaigns | 200 |
| **Total** | **849,965** |

The datasets include realistic categorical distributions, transaction amounts, dates, customer attributes, product categories, order statuses and campaign metrics.

## 4. Lakehouse Architecture

The project follows the Medallion Architecture, separating raw data storage, data refinement and business-level analytics into three logical layers.

```mermaid
flowchart TD
    A["Programmatic Data Generation"] --> B["BRONZE LAYER"]
    B --> C["SILVER LAYER"]
    C --> D["GOLD LAYER"]
    D --> E["Databricks SQL Analytics"]
    E --> F["Executive Sales Dashboard"]
    E --> G["Customer Analytics Dashboard"]
    E --> H["Marketing Campaign Dashboard"]

    B --- B1["6 Raw Delta Tables"]
    C --- C1["6 Cleaned Delta Tables"]
    D --- D1["Business-ready Analytics Tables"]
```

### 4.1 Bronze Layer – Raw Data Ingestion

**Situation:** The simulated retail business requires a structured storage layer to retain its generated operational datasets before applying business transformations.

**Task:** Establish a centralised landing and storage layer for six independently generated datasets.

**Action:** Generated customer, product, inventory, order, order-item and marketing campaign data using Python and PySpark. Stored the datasets as managed Delta tables in the `fashion_bronze` schema using Databricks notebooks. Also explored CSV-based ingestion separately as an ingestion workflow demonstration.

**Result:** Established six Bronze Delta tables containing 849,965 records, providing a consistent starting point for downstream transformations.

### 4.2 Silver Layer – Data Cleaning and Validation

**Situation:** Raw operational data may contain inconsistent text formats, invalid values, missing fields and transaction-level inconsistencies.

**Task:** Prepare clean and reliable datasets while preserving legitimate business scenarios.

**Action:** Developed six PySpark transformation notebooks to standardise categorical fields, clean text values, validate dates and numeric fields, check duplicates and enforce business rules.

Key validation activities included:

- Customer age, email and registration-date validation.
- Product pricing and category-specific checks.
- Inventory stock and reorder-level validation.
- Order amount reconciliation and order-status validation.
- Order-item gross, discount and net amount verification.
- Marketing campaign funnel and KPI validation.

Legitimate guest orders with missing customer IDs and repeated order-product line items were preserved rather than incorrectly removed.

**Result:** Created six validated Silver Delta tables with zero invalid records across the implemented business-rule checks, while retaining valid transactional exceptions.

### 4.3 Gold Layer – Business Analytics

**Situation:** Cleaned operational datasets alone do not directly answer business questions. Stakeholders need aggregated metrics and analytical datasets organised around business functions.

**Task:** Convert Silver data into reusable datasets for sales, product, customer, inventory and marketing analysis.

**Action:** Developed PySpark aggregation and analytical workflows to create business-ready Gold tables.

| Business Area | Gold Tables | Purpose |
|---|---|---|
| Sales | `daily_sales_performance` | Daily revenue, orders, discounts and units sold |
| Products | `category_performance`, `brand_performance`, `product_performance` | Category, brand and product-level performance |
| Customers | `customer_analytics`, `customer_segment_summary` | Customer-level RFM metrics and segment summaries |
| Inventory | `inventory_analytics`, `inventory_replenishment` | Warehouse stock health and replenishment priorities |
| Marketing | `campaign_performance`, `campaign_channel_performance`, `campaign_type_performance`, `campaign_objective_performance`, `campaign_segment_performance`, `campaign_overview` | Campaign performance across business dimensions |

**Result:** Established reusable Gold Delta tables that support SQL analysis and interactive dashboards without repeatedly processing raw operational datasets.

## 5. SQL Analytics

**Objective:** Translate business questions into analytical SQL queries using the Gold layer as the primary source.

Developed 10 SQL queries in Databricks SQL, applying CTEs, window functions, conditional aggregations, ranking and date-based analysis.

| No. | Query | Business Question and Analysis |
|---:|---|---|
| 01 | Daily Sales Performance | Examines daily revenue, order volumes and units sold to understand overall sales activity and identify changes in performance. |
| 02 | Top Performing Products | Ranks products by net revenue to identify the highest-contributing products and their associated sales volumes. |
| 03 | Monthly Sales Trends | Uses monthly aggregation, `LAG()` and rolling three-month averages to evaluate month-over-month revenue changes and longer-term sales trends. |
| 04 | Category Revenue Analysis | Compares category-level revenue, order volumes and units sold, including revenue contribution and ranking against other categories. |
| 05 | Customer Segment Analysis | Evaluates customer segments using average recency, purchase frequency and monetary value to identify high-value and inactive customer groups. |
| 06 | Customer Cohort Retention | Groups customers by their first purchase month and tracks subsequent monthly purchasing activity to analyse cohort retention patterns. |
| 07 | Repeat Purchase Analysis | Classifies customers into one-time, repeat, frequent and loyal purchasing groups, comparing customer counts and lifetime revenue. |
| 08 | Discount Analysis | Evaluates gross revenue, discounts and net revenue across discount bands to understand discount distribution and its relationship with revenue. |
| 09 | Inventory Replenishment Analysis | Identifies low-stock and out-of-stock products across warehouses, estimating replenishment requirements and prioritising stock availability. |
| 10 | Marketing Channel ROI Analysis | Compares marketing channels using blended ROAS, click-through rate, conversion volumes and cost per conversion to evaluate campaign efficiency. |

**Key SQL concepts demonstrated:**
- Common Table Expressions (CTEs)
- Window functions: `LAG()`, `RANK()`, `NTILE()`
- Rolling averages and month-over-month comparisons
- Cohort analysis and retention calculations
- Conditional aggregations and `CASE WHEN`
- Revenue contribution and percentage calculations

## 6. Interactive Dashboards

Three Databricks AI/BI dashboards were developed to present the analytical results through business-focused KPIs, visualisations, interactive filters and detailed performance tables.

### 6.1 Executive Sales Dashboard

**Business Objective:** Provide an overview of the retailer's sales performance and identify the products and categories contributing most to revenue.

**Implementation:**
- KPI cards for total revenue, total orders, units sold and average order value.
- Monthly revenue trend to examine changes in sales performance over time.
- Category revenue comparison to identify the strongest product categories.
- Brand revenue share to compare revenue contribution across brands.
- Top 10 products table to highlight the highest-revenue products.

**Interactive Features:** Order date, product category and brand filters.

**Business Value:** Helps stakeholders monitor sales performance, identify revenue-driving categories and brands, and understand which products contribute most to overall business revenue.

**Dashboard Preview:**

![Executive Sales Dashboard](screenshots/executive-sales-dashboard.png)

### 6.2 Customer Analytics Dashboard

**Business Objective:** Understand customer distribution, purchasing behaviour and customer value to support segmentation and retention strategies.

**Implementation:**
- KPI cards for total customers, customer revenue and average customer spend.
- Geographic point map showing customer distribution across four Indian cities.
- Customer segment performance comparing revenue across seven RFM-based segments.
- Age distribution to examine the demographic composition of purchasing customers.
- Repeat purchase mix to distinguish one-time, repeat, frequent and loyal customers.

**Interactive Features:** City, gender and customer segment filters.

**Business Value:** Helps identify valuable customer groups, understand regional customer concentration and examine purchasing frequency, supporting more informed customer retention and engagement strategies.

**Dashboard Preview:**

![Customer Analytics Dashboard](screenshots/customer-analytics-dashboard.png)

### 6.3 Marketing Campaign Dashboard

**Business Objective:** Evaluate marketing campaign performance across channels, campaign types, objectives and target customer segments.

**Implementation:**
- KPI cards for total campaigns, marketing spend, customers reached, conversions, attributed revenue and average ROAS.
- Marketing channel performance to compare attributed revenue across advertising and communication channels.
- Campaign type performance to evaluate the contribution of promotional, seasonal, festive and other campaigns.
- Campaign objective distribution to compare conversion contribution across marketing objectives.
- Monthly marketing investment and returns using a combination chart.
- Campaign-level performance table for detailed examination of individual campaigns.

**Interactive Features:** Marketing channel, campaign type, target segment and campaign start-month filters.

**Business Value:** Helps stakeholders compare marketing efficiency, identify stronger-performing channels and campaign types, and examine the relationship between marketing expenditure and campaign-reported revenue.

**Dashboard Preview:**

![Marketing Campaign Dashboard](screenshots/marketing-campaign-dashboard.png)

*Marketing attribution note: Campaign attributed revenue is synthetic campaign-reported data and is not reconciled against order transactions. Monthly investment and return trends are grouped by campaign start month, not actual monthly revenue recognition.*

## 7. Key Business Results

The simulated dataset produced the following illustrative metrics:

| Metric | Result |
|---|---:|
| Total Orders | 200,000 |
| Delivered Orders | 166,872 |
| Delivered Order Revenue | ₹244.94 Crore |
| Average Order Value | ₹14,676.50 |
| Registered Purchasing Customers | 75,733 |
| Total Marketing Campaigns | 200 |
| Campaign Attributed Revenue | ₹10.86 Crore |
| Average Campaign ROAS | 2.75x |

These results demonstrate how operational retail data can be transformed into business metrics and analytical insights.

## 8. Repository Structure

```text
fashion-retail-analytics-lakehouse/
│
├── 00_project_setup/
├── 01_data_generation/
├── 02_bronze_ingestion/
├── 03_silver_transformations/
├── 04_gold_analytics/
├── 05_sql_analytics/
├── 06_data_quality/
├── 07_dashboards/
├── 08_performance_optimization/
├── 09_orchestration/
│
├── screenshots/
│
└── README.md
```

## 9. Key Learning Outcomes

Through this project, I gained practical experience in:

- Building a multi-layer lakehouse architecture using Databricks and Delta Lake.
- Generating and processing synthetic retail datasets using PySpark.
- Developing structured ETL transformations and validating business rules.
- Creating analytical datasets using aggregations and customer segmentation.
- Writing SQL queries for sales, customer, product, inventory and marketing analysis.
- Designing interactive dashboards to communicate business performance.
- Working with managed Delta tables and organising analytical workflows in Databricks.

## 10. Project Information

**Project:** Fashion Retail Analytics Lakehouse  
**Business:** NOVA THREADS (Fictional)  
**Platform:** Databricks Free Edition  
**Architecture:** Bronze-Silver-Gold (Medallion Architecture)  
**Author:** Yash Dubey

*All business entities, customer records, transactions and performance metrics in this project are synthetic and intended solely for learning and portfolio demonstration.*
