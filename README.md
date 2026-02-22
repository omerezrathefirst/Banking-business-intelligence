# 🏦 SQL Financial Data Analysis - Banking Case Study

This repository contains a comprehensive SQL project focused on financial data analysis, customer behavior, and risk assessment for a digital banking system.

## 📊 Overview
The project simulates a real-world banking database environment (`banking_practice`) including customers, multi-currency-ready accounts, and transaction histories. The goal is to solve complex business intelligence requests using advanced SQL techniques.

## 🏗️ Database Schema
The project is built on three main entities:
* **Customers**: Demographic data, KYC (Know Your Customer) levels, and account status.
* **Accounts**: Branch information, account opening, and closing timestamps.
* **Transactions**: Financial records including deposits, withdrawals, and card purchases with approval statuses.

## 🧠 Skills Demonstrated
In this project, I implemented several advanced SQL concepts:
* **Window Functions**: Using `LAG()`, `LEAD()`, and `RANK()` for trend analysis and fraud detection.
* **Common Table Expressions (CTEs)**: Organizing complex logic into readable, modular queries.
* **Data Cleaning**: Handling `NULL` values with `COALESCE` and avoiding division errors with `NULLIF`.
* **Date Manipulation**: Complex calculations using `DATEDIFF`, `DATE_FORMAT`, and temporal grouping.
* **Financial Logic**: Calculating Month-over-Month (MoM) growth, churn indicators, and branch performance ratios.

## 🚀 Key Business Questions Solved
The `solutions.sql` file includes queries for:
1.  **Identifying Activity Gaps**: Detecting customers with more than 45 days of inactivity between transactions.
2.  **Monthly Growth Analysis**: Calculating percentage growth in transaction volume per branch.
3.  **Fraud Detection**: Highlighting accounts with high-frequency transactions within the same day.
4.  **KYC Revenue Impact**: Analyzing the average transaction value across different regulatory tiers.
5.  **Branch Efficiency**: Calculating the ratio between approved and declined transactions.

## 📁 Repository Structure
* `schema.sql`: DDL script to create the database and tables.
* `data_seed.sql`: DML script to populate the database with practice data.
* `practice_queries.sql`: The challenge questions (commented out).
* `solutions.sql`: My optimized SQL solutions for each business case.

## 🛠️ How to Use
1. Clone the repository.
2. Run `schema.sql` and `data_seed.sql` in your SQL environment (MySQL / PostgreSQL / SQL Server).
3. Explore the `solutions.sql` to see the logic behind the financial reports.

---
**Author**: Omer Ezra
**Topic**: Advanced SQL for Data Analytics & BI
