--Exercise n. 5
--Find the top 10 users (the id) who answered the most questions.
--Public Dataset: bigquery-public-data.stackoverflow
--Table involved: posts_answers, users



SELECT owner_user_id as user_id ,count(owner_user_id) as count FROM `bigquery-public-data.stackoverflow.posts_answers` 
where ( owner_user_id in (select id from `bigquery-public-data.stackoverflow.users`)
AND Extract(YEAR from creation_date)=2010)
group by owner_user_id
order by count DESC