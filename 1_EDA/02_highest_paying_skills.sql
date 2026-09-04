/*
Question: What are the highest-paying skills for data Scientists?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities
*/


SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd 
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Scientist'
    AND jpf.job_work_from_home = False
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 25;

/*

┌──────────────┬───────────────┬──────────────┐
│    skills    │ median_salary │ demand_count │
│   varchar    │    double     │    int64     │
├──────────────┼───────────────┼──────────────┤
│ atlassian    │      217500.0 │          133 │
│ slack        │      175000.0 │          148 │
│ dynamodb     │      174500.0 │          106 │
│ neo4j        │      165000.0 │          146 │
│ c            │      163500.0 │          654 │
│ go           │      163500.0 │         1261 │
│ gdpr         │      162500.0 │          271 │
│ redis        │      162500.0 │          127 │
│ zoom         │      161250.0 │          150 │
│ hugging face │      160500.0 │          213 │
│ terraform    │      160500.0 │          230 │
│ opencv       │      160000.0 │          214 │
│ sheets       │      152500.0 │          150 │
│ scala        │      151250.0 │         1280 │
│ bigquery     │      150000.0 │          841 │
│ flow         │      150000.0 │          847 │
│ airflow      │      150000.0 │         1009 │
│ php          │      150000.0 │          109 │
│ pytorch      │      149288.0 │         3546 │
│ kubernetes   │      149000.0 │          849 │
│ redshift     │      146000.0 │          893 │
│ snowflake    │      146000.0 │         1520 │
│ jira         │      145250.0 │          577 │
│ tensorflow   │      145000.0 │         3905 │
│ matplotlib   │      145000.0 │         1249 │
└──────────────┴───────────────┴──────────────┘
  25 rows                           3 columns

*/
