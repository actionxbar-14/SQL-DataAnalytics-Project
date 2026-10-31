# SQL Data Analytics Project

**End-to-End SQL Analytics | Exploratory Data Analysis | Advanced Analytics | Business Intelligence**

---

## 📊 Project Overview

This project demonstrates an end-to-end **SQL Data Analytics workflow** using Microsoft SQL Server. It focuses on transforming raw data into meaningful business insights through SQL-based data exploration, analysis, and reporting.

The project covers fundamental to advanced SQL concepts, including data exploration, aggregations, joins, window functions, ranking, time-based analysis, and data segmentation.

The primary objective is to analyze customer and product data, identify business trends, evaluate performance, and generate actionable insights to support data-driven decision-making.

## ⚙️ Technology Stack

| Category | Tools & Technologies |
|---|---|
| Database Management System | Microsoft SQL Server 2022+ |
| SQL Environment | SQL Server Management Studio (SSMS) |
| Query Language | T-SQL |
| Data Sources | CSV Files, SQL Server Backup (.bak) |
| Version Control | Git & GitHub |
| Documentation | Markdown |
| Development Environment | Windows / Docker (Mac setup) |

## 🏗️ Project Architecture

```text
sql-data-analytics-project/
│
│
├── 01_datasets/
│   ├── DataWarehouseAnalytics.bak
│   └── csv-files/
│
├── 02_docs/
│   └── Project roadmap and documentation
│
├── 03_scripts/
│   ├── 00_init_database.sql
│   └── SQL analysis scripts
│
└── README.md
```

### Directory Description

| Directory | Description |
|---|---|
| `00_setup/` | Environment setup instructions and Docker configuration |
| `01_datasets/` | Database backup and source CSV datasets |
| `02_docs/` | Project roadmap, notes, and documentation |
| `03_scripts/` | SQL scripts organized by analytical workflow |

## 🗄️ Database Setup

You can initialize the project database using either of the following methods.

### Method 1: Restore Database Backup

1. Open SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. Right-click **Databases**.
4. Select **Restore Database**.
5. Choose `01_datasets/DataWarehouseAnalytics.bak`.
6. Complete the restoration process.

**Requirement:** SQL Server 2022 or newer.

### Method 2: Build Database Using CSV Files

Alternatively, execute the initialization script:

```sql
03_scripts/00_init_database.sql
```

The script builds the database using CSV files located in:

```text
C:\sql\sql-data-analytics-project\01_datasets\csv-files\
```

**Note:** Update the file paths in the initialization script according to your local environment if required.

## 📈 Analytical Workflow & Project Roadmap

The project is divided into two major analytical phases, followed by business reporting.

![Project Roadmap](https://github.com/user-attachments/assets/e2aa2251-37a9-4cd8-a7ec-63e2d3be95cd)

### Phase 1: Exploratory Data Analysis (EDA)

**Scripts: 01–06**

The objective is to understand the underlying dataset, its structure, and key business metrics.

**Key Activities:**

- Database and table exploration
- Dimension and measure exploration
- Date-range analysis
- Data distribution analysis
- Magnitude analysis
- Ranking and performance analysis

**Business Perspective:** Understand the overall business landscape, identify key metrics, and discover initial patterns in customer and product data.

### Phase 2: Advanced Data Analytics

**Scripts: 07–13**

This phase focuses on deeper analytical techniques to identify trends, measure performance, and understand business relationships.

**Key Activities:**

- Change-over-time analysis
- Cumulative analysis
- Performance analysis
- Data segmentation
- Part-to-whole analysis
- Customer reporting
- Product reporting

**Business Perspective:** Identify growth patterns, evaluate performance, understand customer behavior, and generate meaningful business insights.


## ⌨️ Key SQL Concepts Demonstrated

This project provides practical exposure to the following SQL concepts:

| SQL Concept | Analytical Application |
|---|---|
| SELECT & Filtering | Data extraction and filtering |
| Aggregate Functions | Business KPI calculations |
| GROUP BY & HAVING | Aggregated business analysis |
| JOINS | Combining multiple datasets |
| Subqueries & CTEs | Complex analytical queries |
| CASE Statements | Conditional categorization |
| Window Functions | Advanced analytical calculations |
| RANK, DENSE_RANK & ROW_NUMBER | Performance ranking |
| LAG & LEAD | Period-over-period comparisons |
| Date Functions | Time-based analysis |
| Running Totals | Cumulative business performance |
| Data Segmentation | Customer and product classification |

## 📉 Business & Analytics Applications

The analytical workflow demonstrates how SQL can support real-world business intelligence requirements.

- **Customer Analytics:** Understand customer distribution, purchasing behavior, and contribution.
- **Product Analytics:** Identify high-performing products and revenue contribution.
- **Trend Analysis:** Evaluate changes in business performance over time.
- **Performance Analysis:** Compare business performance across different dimensions.
- **Data Segmentation:** Categorize customers and products based on analytical metrics.
- **Business Reporting:** Transform raw datasets into structured analytical reports.

## 🎯 Project Objectives

- Develop practical expertise in SQL-based data analytics.
- Strengthen exploratory and advanced analytical skills.
- Apply SQL concepts to business-oriented problems.
- Understand customer and product performance.
- Build a foundation for Business Intelligence and Data Analytics roles.

## 📊 Key Learning Outcomes

By completing this project, I aim to strengthen my understanding of:

- End-to-end SQL analytics workflows.
- Business-oriented problem-solving using SQL.
- Advanced querying and analytical techniques.
- Data exploration and interpretation.
- Customer and product performance reporting.
- Translating raw data into actionable business insights.

## 👤 About the Author

Hi, I'm **Anubhav Pathak**, a Computer Science Engineering student passionate about **Data Analytics, Business Intelligence, and Data Engineering**.

I enjoy working with data, solving analytical problems, and building projects that connect technical skills with real-world business requirements.

Currently, I am focusing on developing my expertise in SQL, Python, Power BI, and data analytics, with a particular interest in the **FinTech and BFSI domains**.

### Technical Skills

- **Query Languages:** SQL (T-SQL), Python
- **Databases:** Microsoft SQL Server, MySQL, PostgreSQL
- **Data Analytics:** Pandas, NumPy, Exploratory Data Analysis
- **Data Visualization:** Power BI
- **Development Tools:** SSMS, Jupyter Notebook, Git, GitHub

### Professional Links

- **GitHub:** [Anubhav Pathak](https://github.com/actionxbar-14)
- **LinkedIn:** [Connect with me](YOUR_LINKEDIN_URL)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

You are free to use, modify, and distribute this project with appropriate attribution.

---

**Learning SQL | Exploring Data | Generating Business Insights**
