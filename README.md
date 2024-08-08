# Introduction
This project explores the top paying jobs for data analyst, in-demand skills, and top paying skills.

SQL queries and python script [in here](/project_sql/)
# Background
Driven by the curiosity of which skill should be learned first before diving to the world of data jobs especially in this forum is data analyst job.

Data hails from [SQL Course](https://lukebarousse.com/sql)

### The Questions
1. What are the top-paying data analyst job?
2. What skills are required to apply for these top-paying data analyst job?
3. Which skill are associated with higher salaries?
# Tools I Used
For my deep dive into the data analyst job market, i use several powerful key tools :

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The database management system, ideal for handling the job posting data.
- **Visual Studio Code** : My go-to for database management, executing SQL queries, and executing python script.
- **Git & Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
- **Python** : The tool for plotting the necessary data to increase clarity of what is happening in the data
# The Analysis
Each query for this projcet aimed at investigating specifiq aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    cd.name AS company_name,
    job_posted_date
FROM
    job_postings_fact jpf
LEFT JOIN company_dim cd ON
    cd.company_id = jpf.company_id
WHERE job_location = 'Anywhere'
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analysts jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![top paying job](assets\top_paying_roles.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts*

### 2. Required skills to apply for these top-paying data analyst job
Next i joined the previous table with the skills table so we can see the name of the skills and analyze the data. This query is used to joined the tables.

``` sql
WITH tpj AS (
    SELECT
        jpf.job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        sjd.skill_id,
        cd.name AS company_name,
        job_posted_date
    FROM
        (
        SELECT *
        FROM job_postings_fact
        WHERE job_location = 'Anywhere'
            AND job_title_short = 'Data Analyst'
            AND salary_year_avg IS NOT NULL
        ORDER BY salary_year_avg DESC
        LIMIT 10
        ) jpf
    LEFT JOIN company_dim cd ON
        cd.company_id = jpf.company_id
    LEFT JOIN skills_job_dim sjd
        ON sjd.job_id = jpf.job_id
)

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    skills,
    salary_year_avg,
    company_name,
    job_posted_date
FROM tpj
LEFT JOIN skills_dim sd
    ON sd.skill_id = tpj.skill_id
;
```
Required Skills for High-Paying Data Analyst Jobs

- **SQL for Data Querying:** SQL is crucial for extracting and managing data from databases, making it a fundamental skill for data analysts.
  
- **Python for Analysis and Automation:** Python is highly valued for its flexibility in data analysis, machine learning, and automation, making it a key tool in the field.

- **Tableau for Visualization:** Tableau is popular for creating interactive and insightful data visualizations, which helps in making complex data understandable.

- **Excel for Data Management:** Excel remains a staple for basic data manipulation, reporting, and initial data exploration due to its wide accessibility and ease of use.

- **Power BI for Business Analytics:** Power BI is used for building comprehensive dashboards and reports, facilitating data-driven decision-making in business contexts.

- **Big Data Tools like Hadoop and Spark:** Familiarity with Hadoop and Spark is important for handling and analyzing large datasets effectively.

- **Cloud Platforms like AWS and Azure:** Cloud services are essential for scalable data storage and processing, enabling efficient data management in the cloud.

- **Data Engineering Tools like Databricks:** Tools like Databricks support advanced data processing and integration tasks, important for managing large-scale data projects.

![top paying job](assets\Data_Analyst_Skill_Distribution.png)
*Pie chart visualizing the distribution of the reqired skills for the top 10 salaries for data analysts*

### 3. Skill that are associated with higher salaries
To get the skill with the high salaries we still can use the previous quetion data and with the same queries.

Skills Linked to Higher Salaries

- **SQL**
   - **Salary Range:** $205,000 - $336,500
   - **Reason:** SQL is crucial for data manipulation and management. High proficiency in SQL often correlates with higher-paying roles due to the demand for advanced data querying and reporting skills.

- **Python**
   - **Salary Range:** $205,000 - $336,500
   - **Reason:** Python is widely used for data analysis, machine learning, and automation. Its versatility and importance in handling complex data tasks contribute to higher salaries for those skilled in it.

- **Tableau**
   - **Salary Range:** $189,000 - $336,500
   - **Reason:** Tableau is a leading tool for data visualization. Advanced skills in Tableau can drive higher salaries due to the need for effective data presentation and dashboard creation.

- **Power BI**
   - **Salary Range:** $189,000 - $336,500
   - **Reason:** Similar to Tableau, Power BI is essential for business intelligence and data visualization. Expertise in Power BI often results in higher compensation due to its role in delivering actionable insights.

- **Advanced Analytics Techniques (e.g., Statistical Modeling, Machine Learning)**
   - **Salary Range:** $189,000 - $336,500
   - **Reason:** Skills in advanced analytics and machine learning are highly valued for their ability to provide deep insights and predictive capabilities, leading to higher salaries.

Summary
- **Skills with Broad Application:** SQL and Python are common across various high-paying roles.
- **Skills with Specific Tools:** Tableau and Power BI are key for roles focused on data visualization.
- **Advanced Techniques:** Expertise in advanced analytics and machine learning can significantly boost salary potential.

# What I Learned

1. **Top Paying Data Analyst Jobs**
   - **Wide Salary Range:** The highest-paying data analyst roles range from $184,000 to $650,000, indicating significant earning potential.
   - **Diverse Employers:** High salaries are offered by various companies, including SmartAsset, Meta, and AT&T.
   - **Job Title Variety:** Positions vary widely, from Data Analyst to Director of Analytics, showing diverse roles within the field.

2. **Required Skills for High-Paying Roles**
   - **SQL:** Essential for data querying and management.
   - **Python:** Valuable for data analysis, machine learning, and automation.
   - **Tableau & Power BI:** Important for data visualization and business analytics.
   - **Excel:** Useful for basic data manipulation and reporting.
   - **Big Data Tools (Hadoop, Spark):** Important for handling large datasets.
   - **Cloud Platforms (AWS, Azure):** Key for scalable data storage and processing.
   - **Data Engineering Tools (Databricks):** Support advanced data processing and integration.

3. **Skills Associated with Higher Salaries**
   - **SQL & Python:** Both skills are linked to higher salaries due to their broad application and importance in data handling and analysis.
   - **Tableau & Power BI:** Proficiency in these tools is associated with higher compensation due to their role in effective data visualization.
   - **Advanced Analytics Techniques:** Expertise in statistical modeling and machine learning contributes to significantly higher salaries.

# Conclusions

The analysis revealed several key insights:
- **Skills with High Earning Potential:** SQL and Python stand out as highly valuable skills for securing high-paying data analyst positions. Their broad application across different data tasks contributes to their high salary potential.
- **Importance of Visualization Tools:** Skills in Tableau and Power BI are crucial for roles focused on data visualization and business intelligence, often resulting in higher salaries.
- **Advanced Analytics Skills:** Proficiency in advanced analytics techniques like statistical modeling and machine learning can substantially boost earning potential.

In summary, to maximize earning potential in data analyst roles, focusing on acquiring and mastering SQL, Python, Tableau, Power BI, and advanced analytics techniques is highly beneficial. Understanding the demand for these skills can guide career development and educational choices effectively.