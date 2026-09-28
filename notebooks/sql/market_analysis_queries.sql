
WITH TopSkills AS (
    SELECT skill, COUNT(*) as skill_demand
    FROM job_skills
    GROUP BY skill
    ORDER BY skill_demand DESC
    LIMIT 5
)
SELECT 
    j.title as job_role,
    s.skill as core_technology,
    COUNT(j.job_id) as total_postings,
    ROUND(AVG(j.salary_min), 0) as avg_min_pln,
    ROUND(AVG(j.salary_max), 0) as avg_max_pln
FROM warsaw_jobs j
JOIN job_skills s ON j.job_id = s.job_id
WHERE s.skill IN (SELECT skill FROM TopSkills)
GROUP BY j.title, s.skill
ORDER BY total_postings DESC, avg_max_pln DESC;
