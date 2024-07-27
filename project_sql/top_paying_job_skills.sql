/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analyst, offering insights into employment
*/
WITH tpj AS (
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
    LIMIT 10
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
FROM (
    SELECT
        tpj.job_id,
        job_title,
        job_location,
        job_schedule_type,
        skill_id,
        salary_year_avg,
        company_name,
        job_posted_date
    FROM tpj
    JOIN skills_job_dim sjd
        ON sjd.job_id = tpj.job_id
) AS tpjs
LEFT JOIN skills_dim sd
    ON sd.skill_id = tpjs.skill_id
;
