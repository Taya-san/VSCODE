SELECT
    skill_salary_average_year,
    skills AS skill
FROM ( 
    SELECT
        ROUND(AVG(salary_year_avg),0) AS skill_salary_average_year,
        skill_id
    FROM job_postings_fact jpf
    JOIN skills_job_dim sjd ON sjd.job_id = jpf.job_id
    WHERE job_title_short = 'Data Analyst'
        AND job_work_from_home IS TRUE
    GROUP BY skill_id

) AS ssay
LEFT JOIN skills_dim sd ON ssay.skill_id = sd.skill_id
WHERE skill_salary_average_year IS NOT NULL
ORDER BY skill_salary_average_year DESC
;
