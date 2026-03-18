--- creating database ---

create database JobMarketAnalysis;

--- using the database ---

use JobMarketAnalysis

--- adding jobID column in jobs table ---

alter table jobs
add jobID int

--- populating the jobID column ---

with cte as (
		select jobID,
			   row_number() over (order by (select NULL)) as rn
		from jobs 
		)
update cte
set jobID = rn 


--- creating skills table ---

create table skills (
skillID int primary key,
skillName varchar(50)
)

--- inserting the data into skills table ---

insert into skills (skillID, skillName) values
(1, 'SQL'),
(2, 'Excel'),
(3, 'Python'),
(4, 'Power BI'),
(5, 'Tableau'),
(6, 'R')

--- creating jobskills table ---
create table jobskills (
jobID int,
skillID int
)

--- making jobID column not null ---

alter table jobs
alter column jobID int not null

--- adding primary key to the jobs table ---

alter table jobs
add constraint PK_jobs primary key (jobID) 

--- populating jobskills table ---

insert into jobskills (jobID, SkillID)
select jobID, 1
from jobs
where sql = 1

insert into jobskills (jobID, SkillID)
select jobID, 2
from jobs
where excel = 1

insert into jobskills (jobID, SkillID)
select jobID, 3
from jobs
where python = 1

insert into jobskills (jobID, SkillID)
select jobID, 4
from jobs
where power_bi = 1

insert into jobskills (jobID, SkillID)
select jobID, 5
from jobs
where tableau = 1

insert into jobskills (jobID, SkillID)
select jobID, 6
from jobs
where r = 1

--- previewing the table ---

select top 5 * from jobs
select top 5 * from skills
select top 5 * from jobskills

--- Top 10 hiring cities ---

select top 10 with ties
	   city,
	   count(*)as job_demand
from jobs
where city is not null
group by city
order by count(*) desc

--- Top hiring companies ---

select Top 10
	   company,
	   count(*) as job_postings
from jobs 
where company is not null
group by company
order by count(*) desc

--- skill demand analysis ---

select s.skillName,
       count(js.jobID)as demand
from skills s
join jobskills js
on s.skillID = js.skillID
group by s.skillName
order by count(distinct js.jobID) desc

--- skills by location ---

select j.city,
       s.skillName,
	   count(js.jobID) as demand
from jobs j
join jobskills js
on js.jobID = j.jobID
join skills s
on js.skillID = s.skillID
where j.city is not null
group by j.city,  s.skillName 
order by j.city, count(js.jobID) desc

--- skills required across seniority level ---

select j.seniority_level,
       s.skillName,
	   count(js.jobID)as demand
from jobs j
join jobskills js
on j.jobID = js.jobID
join skills s
on s.skillID = js.skillID
where j.seniority_level is not null 
group by j.seniority_level, s.skillName
order by j.seniority_level, count(js.jobID) desc

--- skills co-occurance analysis --- 

select s1.skillName,
	   s2.skillName,
	   count(*) as frequency
from jobskills js1
join jobskills js2
on js1.jobID = js2.jobID
join skills s1 on js1.skillID = s1.skillID
join skills s2 on js2.skillID = s2.skillID
where js1.skillID < js2.skillID
group by s1.skillName, s2.skillName
order by count(*) desc


--- location vs salary distribution ---

select city,
	   round(avg(min_salary),2)as average_min_salary,
	   round(avg(max_salary),2)as average_max_salary
from jobs
where city is not null
and min_salary is not null
and max_salary is not null 
group by city
order by avg(max_salary) desc

--- skill gap analysis for a given candidate who have skills like only sql and excel ---

select skillName
from skills 
where skillName not in ('sql', 'excel')

--- highest paying skill --- 

select s.skillName,
       round(avg(j.max_salary),2)as average_salary
from jobs j
join jobskills js
on j.jobID = js.jobID
join skills s 
on js.skillID = s.skillID
where j.max_salary is not null
group by s.skillName
order by avg(j.max_salary) desc

--- skill needed per job --- 

select jobID,
	   count(*) as no_of_skill_needed
from jobskills
group by jobID
order by jobID 

--- no of skills need for a job --- 

select avg(no_of_skill_needed)as avg_skills,
	   max(no_of_skill_needed)as max_skills,
	   min(no_of_skill_needed)as min_skills
from (
select jobID,
	   count(*)as no_of_skill_needed
from jobskills
group by jobID
)t 


Insights from this analysis: 

--- Top Hiring Cities ---
Insight:
Bangalore leads the job market with the highest number of postings, followed by Mumbai and Chennai, confirming that major tech and 
financial hubs dominate data analyst hiring in India.

--- Top Hiring Companies ---
Insight:
Consulting and IT service firms such as Accenture, TCS, and Deloitte appear among the top recruiters, indicating that data analyst roles 
are heavily concentrated in service-based organizations.

--- Top In-Demand Skills ---
Insight:
SQL emerges as the most critical skill with approximately 338 job mentions, significantly higher than Python (~155), highlighting SQL as a 
foundational requirement for data analyst roles, while Python serves as a differentiating skill.

--- Skills by Location ---
Insight:
Bangalore shows strong demand for SQL and Python, indicating a more technical job market, whereas other cities show relatively higher 
emphasis on Excel and Power BI, suggesting a mix of reporting and business-oriented roles.

--- Skills by Experience Level ---
Insight:
Mid-level roles (2–4 years) show the highest demand across all major skills, particularly Python and Power BI, indicating that employers 
expect broader technical capabilities as experience increases, while entry-level roles focus more on Excel and SQL basics.

--- Skill Co-occurrence Analysis ---
Insight:
SQL most frequently co-occurs with Python and Excel, indicating that employers expect candidates to combine data querying skills with 
analytical and reporting capabilities rather than relying on a single tool.

--- Salary Analysis by City ---
Insight:
Higher average salaries are concentrated in cities like Bangalore and Mumbai, suggesting that demand intensity and cost of living 
significantly influence compensation levels in the data analyst job market.

--- High-Paying Skills ---
Insight:
Roles requiring Python and Power BI are associated with higher average salaries compared to Excel-focused roles, indicating that advanced 
analytical and visualization skills command a premium in the job market.

--- Multi-Skill Jobs Analysis ---
Insight:
On average, each job requires approximately 3 skills, with some roles demanding even more, highlighting that employers prefer multi-skilled 
candidates capable of handling end-to-end data tasks.

--- Skill Gap Analysis ---
Insight:
A candidate with only SQL and Excel lacks key in-demand skills such as Python and Power BI, which are frequently required in mid-level and 
high-paying roles, making them critical areas for upskilling.

