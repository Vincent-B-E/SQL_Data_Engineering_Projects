/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
--    COUNT(jpf.salary_year_avg) AS demand_count,
    ROUND(LN(COUNT(jpf.salary_year_avg))) AS ln_demand_count,
    MEDIAN(jpf.salary_year_avg)*LN(COUNT(jpf.*))/1_000_000 AS ranking
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd 
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY ranking DESC
LIMIT 25;

/*
┌────────────┬───────────────┬─────────────────┬────────────────────┐
│   skills   │ median_salary │ ln_demand_count │      ranking       │
│  varchar   │    double     │     double      │       double       │
├────────────┼───────────────┼─────────────────┼────────────────────┤
│ terraform  │      184000.0 │             5.0 │ 0.9683349947584989 │
│ python     │      135000.0 │             7.0 │ 0.9494042752387809 │
│ aws        │      137320.0 │             7.0 │ 0.9149834640424246 │
│ sql        │      130000.0 │             7.0 │ 0.9136661861675406 │
│ airflow    │      150000.0 │             6.0 │ 0.8933756054197246 │
│ spark      │      140000.0 │             6.0 │ 0.8708826238139635 │
│ snowflake  │      135500.0 │             6.0 │ 0.8241406623560085 │
│ kafka      │      145000.0 │             6.0 │ 0.8231293013289008 │
│ azure      │      128000.0 │             6.0 │ 0.7889042949164341 │
│ java       │      135000.0 │             6.0 │ 0.7713539287437647 │
│ scala      │      137290.0 │             6.0 │ 0.7563865933456305 │
│ kubernetes │      150500.0 │             5.0 │ 0.7510601043101998 │
│ git        │      140000.0 │             5.0 │ 0.7472553311581844 │
│ databricks │      132750.0 │             6.0 │ 0.7412091349907706 │
│ redshift   │      130000.0 │             6.0 │ 0.7297066538304492 │
│ gcp        │      136000.0 │             5.0 │ 0.7178235936553503 │
│ hadoop     │      135000.0 │             5.0 │ 0.7139160491437622 │
│ nosql      │      134415.0 │             5.0 │ 0.7073845017416501 │
│ pyspark    │      140000.0 │             5.0 │ 0.7033432729184788 │
│ docker     │      135000.0 │             5.0 │ 0.6709247954427601 │
│ mongodb    │      135750.0 │             5.0 │ 0.6668929007386691 │
│ go         │      140000.0 │             5.0 │ 0.6618342946197278 │
│ r          │      134775.0 │             5.0 │ 0.6590968037560868 │
│ github     │      135000.0 │             5.0 │ 0.6539652566719099 │
│ bigquery   │      135000.0 │             5.0 │ 0.6496448879752763 │
└────────────┴───────────────┴─────────────────┴────────────────────┘
  25 rows                                                 4 columns

*/