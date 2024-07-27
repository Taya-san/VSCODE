WITH top_skills_demand AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS total_skill
    FROM job_postings_fact jpf
    JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home IS TRUE
    GROUP BY sd.skill_id
    HAVING COUNT(sjd.job_id) >10
),
top_paying_skills AS (
    SELECT
        skill_salary_average_year,
        ssay.skill_id,
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
    )

SELECT 
    tsd.skill_id,
    tsd.skills,
    total_skill,
    skill_salary_average_year
FROM top_skills_demand tsd
JOIN top_paying_skills tps ON tsd.skill_id = tps.skill_id
WHERE total_skill > 10
ORDER BY
    skill_salary_average_year DESC,
    total_skill DESC
LIMIT 25;