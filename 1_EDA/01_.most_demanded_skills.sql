/* 
Question: What are the most in-demand skills for data Scientists?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

-- connect to DW in motherduck using the followning command
duckdb md:data_jobs
-- overview of the tables included in the DW
PRAGMA show_tables;
-- description of the tables we'd like to join
DESCRIBE job_postings_fact;
DESCRIBE skills_job_dim;
DESCRIBE skills_dim;

-- Inner join to preserve only the job postings that actually mention
-- an associated skill in the skills_dim table
SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd 
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Scientist'
    AND jpf.job_work_from_home = False
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 10;


/*
OUTPUT
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ python     │       187461 │
│ sql        │       129656 │
│ r          │        94088 │
│ tableau    │        47220 │
│ aws        │        45757 │
│ sas        │        45746 │
│ spark      │        39128 │
│ azure      │        38783 │
│ tensorflow │        33350 │
│ excel      │        28917 │
└────────────┴──────────────┘
  10 rows         2 columns

*/
