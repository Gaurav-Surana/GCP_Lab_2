--Exercise n. 6
--Find the top 10 StackOverflow users (the id) by accepted responses on 2010 posts
--Public Dataset: bigquery-public-data.stackoverflow
--Table involved: stackoverflow_posts, posts_answers, users


SELECT owner_user_id as id_user,count(owner_user_id) as count FROM `bigquery-public-data.stackoverflow.posts_answers` 
where id in (SELECT accepted_answer_id FROM `bigquery-public-data.stackoverflow.stackoverflow_posts` 
where Extract(YEAR from creation_date)=2010)
group by owner_user_id
order by count DESC