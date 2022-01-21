--Exercise n. 9
--Find for each commit on Github on a .c file of the Linux kernel, the previous and the next commit.
--Public Dataset: bigquery-public-data.github_repos
--Table involved: sample_commits
--Tip: Lag and Lead functions can be useful.


SELECT
  repo_name,d.old_path AS file,committer.date as date
  ,LAG(commit,1,null)
  OVER (ORDER BY committer.date) AS previous_commit,
commit
  ,
  LEAD(commit,1,null) OVER (ORDER BY committer.date) AS next_commit
FROM
  `bigquery-public-data.github_repos.sample_commits`,
  UNNEST(difference) AS d
where d.old_path='kernel/acct.c' 
order by date