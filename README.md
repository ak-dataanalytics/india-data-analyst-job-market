# 📊 Job Market Analysis — Data Analyst Hiring Trends in India

> An end-to-end SQL + Power BI project analyzing **500+ data analyst job postings** across **10+ Indian cities** to uncover skill demand, salary trends, and hiring patterns.

---

## 📌 Project Overview

This project answers a core question every aspiring data analyst should ask:

> **"What does the Indian job market actually demand — and am I building the right skills?"**

Using SQL Server for data modeling and querying, and Power BI for visualization, this project delivers a complete picture of the data analyst hiring landscape in India — covering top hiring cities, in-demand skills, salary distributions, and skill gaps.

---

## 🗂️ Database Schema

A normalized relational schema was designed from scratch to enable multi-dimensional analysis:

```
jobs         → Core job posting data (city, company, seniority, salary)
skills       → Master list of 6 key skills (SQL, Python, Excel, Power BI, Tableau, R)
jobskills    → Junction table linking jobs to required skills
```

**Schema Design Highlights:**
- Added `jobID` as primary key using `ROW_NUMBER()` window function
- Populated `jobskills` junction table via conditional `INSERT` statements for each skill
- Enforced referential integrity with `NOT NULL` and `PRIMARY KEY` constraints

---

## 🔍 Analysis Performed

| Analysis | Key Technique |
|---|---|
| Top 10 Hiring Cities | `GROUP BY` + `COUNT` + `TOP WITH TIES` |
| Top Hiring Companies | Aggregation + `ORDER BY` |
| Skill Demand Analysis | Multi-table `JOIN` + `GROUP BY` |
| Skills by Location | 3-table join across jobs, jobskills, skills |
| Skills by Seniority Level | Filtered join + grouped aggregation |
| Skill Co-occurrence Analysis | Self-join on `jobskills` |
| Salary Distribution by City | `AVG`, `ROUND`, conditional filters |
| Highest Paying Skills | Join + salary aggregation |
| Skill Gap Analysis | `NOT IN` filter for candidate profiling |
| Multi-Skill Job Analysis | Subquery + `AVG`, `MAX`, `MIN` |

---

## 💡 Key Insights

### 🏙️ Top Hiring Cities
> **Bangalore** leads all cities in job postings, followed by Mumbai and Chennai — confirming that major tech and financial hubs dominate data analyst hiring in India.

### 🏢 Top Hiring Companies
> Consulting and IT service firms — **Accenture, TCS, Deloitte** — are the biggest recruiters, indicating that data analyst roles are heavily concentrated in service-based organizations.

### 🛠️ Skill Demand
> **SQL** is the most critical skill with ~338 job mentions, significantly ahead of **Python** (~155). SQL is the *baseline* requirement; Python is the *differentiator*.

### 📍 Skills by Location
> Bangalore demands **SQL + Python** heavily (technical market), while other cities show stronger emphasis on **Excel and Power BI** — a mix of reporting and business-oriented roles.

### 🎯 Skills by Seniority
> Mid-level roles (2–4 years) show the highest demand across all skills, especially **Python and Power BI** — employers expect broader technical depth as experience grows.

### 🔗 Skill Co-occurrence
> **SQL + Python** and **SQL + Excel** are the most frequent pairings — employers expect combined data querying, analysis, and reporting capability, not single-tool specialization.

### 💰 Salary by City
> Higher salaries are concentrated in **Bangalore and Mumbai** — demand intensity and cost of living significantly influence compensation in the data analyst market.

### 💸 High-Paying Skills
> Roles requiring **Python and Power BI** are associated with higher average salaries compared to Excel-focused roles — advanced analytical and visualization skills command a clear premium.

### 📦 Multi-Skill Jobs
> On average, each job requires **~3 skills** — employers prefer multi-skilled candidates capable of handling end-to-end data tasks.

### 🚧 Skill Gap
> A candidate with only **SQL + Excel** lacks **Python and Power BI** — the two skills most linked to higher salaries and mid-level roles — making them critical areas for upskilling.

---

## 🧰 Tools & Technologies

| Tool | Usage |
|---|---|
| **SQL Server** | Database design, ETL, all analytical queries |
| **CTEs** | Populating jobID, complex aggregations |
| **Window Functions** | `ROW_NUMBER()` for ID generation |
| **Power BI** | Dashboard and visualization |
| **Git & GitHub** | Version control |

---

## 📁 Project Structure

```
📦 Job-Market-Analysis
 ┣ 📄 Job_Market_Analysis.sql     ← All SQL queries (schema + analysis)
 ┣ 📊 Job_Market_Analysis.pbix    ← Power BI dashboard file
 ┗ 📄 README.md
```

---

## 🚀 How to Run

1. **Clone the repo**
   ```bash
   git clone https://github.com/ak-dataanalytics/Job-Market-Analysis.git
   ```

2. **Set up the database**
   - Open SQL Server Management Studio (SSMS)
   - Run `Job_Market_Analysis.sql` to create the database, schema, and populate all tables

3. **Open the dashboard**
   - Open `Job_Market_Analysis.pbix` in Power BI Desktop
   - Connect to your local SQL Server instance if prompted

---

## 📬 Connect

**Aditya Kumar** — Data Analyst

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://linkedin.com/in/xaditya)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?logo=github)](https://github.com/ak-dataanalytics)
[![Email](https://img.shields.io/badge/Email-Contact-red?logo=gmail)](mailto:adityaadi2028@gmail.com)

---

*If you found this project useful, consider giving it a ⭐ — it helps others discover it too!*
