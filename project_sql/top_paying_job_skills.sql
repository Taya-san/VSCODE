/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analyst, offering insights into employment
*/
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
