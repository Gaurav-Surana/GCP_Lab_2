--Exercise n. 7
--Find the most popular programming language
--Public Dataset: bigquery-public-data.github_repos
--Table involved: languages


SELECT l.name as languages_name,count(l.name) as count FROM `bigquery-public-data.github_repos.languages`,unnest(language) as l
group by l.name
order by count DESC 
limit 1
