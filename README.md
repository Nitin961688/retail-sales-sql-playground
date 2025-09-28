# retail-sales-sql-playground
# Data Analyst Internship — Task 4: SQL for Data Analysis

## 📌 Project Overview

This repository contains solutions for **Task 4: SQL for Data Analysis** as part of the Data Analyst Internship program. The goal is to practice SQL queries on an e-commerce dataset (or similar structured dataset) to extract, analyze, and optimize insights.

---

## 🛠 Tools & Setup

* **Database:** MySQL / PostgreSQL / SQLite (choose any)
* **Data:** Sample Ecommerce database (customers, orders, products, revenue)
* **Files:**

  * `task4.sql` → SQL queries written for this task
  * `screenshots/` → screenshots of query outputs
  * `README.md` → documentation of the task and approach

---

## 🔍 Objectives

1. Learn to manipulate and query structured data using SQL.
2. Use SQL to answer typical data analysis interview questions.
3. Apply filtering, joining, aggregations, subqueries, and views.
4. Explore query optimization using indexes.

---

## 📤 Deliverables

* A `.sql` file with all queries.
* Screenshots showing query execution and outputs.
* Short documentation (this README).

---

## ❓ Interview Questions & Answers with SQL Examples

### 1. Difference between **WHERE** and **HAVING**

* **WHERE** → Filters rows *before* aggregation.
* **HAVING** → Filters groups *after* aggregation.

**Example:**

```sql
-- Total revenue per customer, only show those with revenue > 500
SELECT customer_id, SUM(total_amount) AS total_revenue
FROM purchases
GROUP BY customer_id
HAVING SUM(total_amount) > 500;
```

---

### 2. Types of Joins

* **INNER JOIN** → Matching records in both tables
* **LEFT JOIN** → All from left + matches from right
* **RIGHT JOIN** → All from right + matches from left
* **FULL OUTER JOIN** → All records from both tables

**Example:**

```sql
-- Get all purchases with customer details
SELECT c.customer_id, c.first_name, p.purchase_id, p.total_amount
FROM customers c
INNER JOIN purchases p ON c.customer_id = p.customer_id;
```

---

### 3. Calculate **Average Revenue per User (ARPU)**

```sql
SELECT ROUND(SUM(total_amount) / COUNT(DISTINCT customer_id), 2) AS ARPU
FROM purchases;
```

---

### 4. Subqueries

Subqueries are queries nested inside another query.

**Example:**

```sql
-- Find customers who spent more than the average spending
SELECT customer_id, SUM(total_amount) AS customer_spending
FROM purchases
GROUP BY customer_id
HAVING SUM(total_amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(total_amount) AS total_spent
        FROM purchases
        GROUP BY customer_id
    ) t
);
```

---

### 5. SQL Query Optimization

* Create **indexes** on frequently used columns (`customer_id`, `product_id`).
* Avoid `SELECT *`, use only needed columns.
* Use proper **joins** instead of nested subqueries when possible.

**Example:**

```sql
CREATE INDEX idx_customer_id ON purchases(customer_id);
CREATE INDEX idx_product_id ON purchases(product_id);
```

---

### 6. Views in SQL

Views are saved queries that can be reused.

**Example:**

```sql
CREATE VIEW customer_spending AS
SELECT customer_id, SUM(total_amount) AS total_spent
FROM purchases
GROUP BY customer_id;
```

---

### 7. Handling NULL values

* Use `COALESCE()` to replace nulls.
* Use `IS NULL` / `IS NOT NULL` filters.

**Example:**

```sql
-- Replace NULL city with 'Unknown'
SELECT customer_id, COALESCE(city, 'Unknown') AS city
FROM customers;
```

---

## 📁 Repository Structure

```
├── data/
│   └── ecommerce_sample.csv  # Example dataset
├── sql/
│   └── task4.sql             # All SQL queries
├── screenshots/              # Query outputs
├── README.md                 # Documentation (this file)
```

---

## 📸 Screenshots

Screenshots of query execution and results are saved in the `screenshots/` folder.

---

## ✅ Outcome

By completing this task, you will:

* Be confident in writing SQL queries for data analysis.
* Understand joins, subqueries, views, and optimizations.
* Know how to handle nulls and aggregate data effectively.

---

## 📌 Submission

* Push code, datasets, and screenshots to a **new GitHub repository**.
* Add this `README.md`.


---
.
