SELECT
    sjd.skill_id,
    total_skill,
    skills
FROM (SELECT
        skill_id,
        COUNT(skill_id) AS total_skill
    FROM skills_job_dim
    WHERE job_id IN (
        SELECT job_id
        FROM job_postings_fact
        WHERE job_title_short = 'Data Analyst'
    )
    GROUP BY skill_id
    ORDER BY total_skill 
    DESC) AS sjd
LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
LIMIT 5;
