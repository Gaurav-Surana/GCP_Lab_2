--Exercise n. 8
--Find the top 10 committers in 2016 on Github repositories that uses the Java language
--Public Dataset: bigquery-public-data.github_repos
--Tables involved: languages, sample_commits



WITH custom_data AS (SELECT repo_name FROM
`bigquery-public-data.github_repos.languages`,unnest(language) 
where name='Java'
)
select committer.name,count(*) as count FROM
`bigquery-public-data.github_repos.sample_commits`
where repo_name in (SELECT repo_name FROM custom_data)
and EXTRACT(YEAR FROM committer.date)=2016
group by (committer.name)
order by count DESC 
limit 10;
