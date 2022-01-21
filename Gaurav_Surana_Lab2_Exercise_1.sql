--Exercise n1.
--Given the shared file top_4000_movies_data.csv
--1. Create a BigQuery table “Movie”
--2. Find the top 10 highest budget films, year by year, from 2016 to 2020.


--Query 1:
--By using uniion opearation.
--This query will process 130.2 KiB when run.



WITH finishers AS (
SELECT FORMAT_DATE("%Y",Release_Date)as year ,Movie_Title,Production_Budget,RANK() OVER (ORDER BY Production_Budget DESC) AS Rank
FROM (
     ( SELECT * FROM  `nttdata-c4e-bde.uc1_16.Movie`
      where ( Release_Date Between '2020-01-01' AND '2020-12-31' ) 
      order by Production_Budget Desc
      limit 10
     )
 
)
UNION ALL
SELECT FORMAT_DATE("%Y",Release_Date)as year ,Movie_Title,Production_Budget,RANK() OVER (ORDER BY Production_Budget DESC) AS Rank
FROM (
     ( SELECT *  FROM  `nttdata-c4e-bde.uc1_16.Movie`
      where ( Release_Date Between '2019-01-01' AND '2019-12-31' )
      order by Production_Budget Desc
      limit 10
     )
)
UNION ALL
SELECT FORMAT_DATE("%Y",Release_Date)as year ,Movie_Title,Production_Budget,RANK() OVER (ORDER BY Production_Budget DESC) AS Rank
FROM (
 
     ( SELECT * FROM  `nttdata-c4e-bde.uc1_16.Movie`
      where ( Release_Date Between '2018-01-01' AND '2018-12-31' )
      order by Production_Budget Desc
      limit 10
     )
)
UNION ALL
SELECT FORMAT_DATE("%Y",Release_Date)as year ,Movie_Title,Production_Budget,RANK() OVER (ORDER BY Production_Budget DESC) AS Rank
FROM (
    
     ( SELECT *  FROM  `nttdata-c4e-bde.uc1_16.Movie`
      where ( Release_Date Between '2017-01-01' AND '2017-12-31' )
      order by Production_Budget Desc
      limit 10
     )
)
UNION ALL
SELECT FORMAT_DATE("%Y",Release_Date)as year ,Movie_Title,Production_Budget,RANK() OVER (ORDER BY Production_Budget DESC) AS Rank
FROM (
  
     ( SELECT *  FROM  `nttdata-c4e-bde.uc1_16.Movie`
      where ( Release_Date Between '2016-01-01' AND '2016-12-31' )
      order by Production_Budget Desc
      limit 10
     )
)
)
SELECT year ,Movie_Title,Production_Budget,Rank 
FROM finishers 
order by year DESC,Rank asc



--***************************************************************************
--Query 2
--This query will process 130.2 KiB when run.



WITH finishers AS (
SELECT FORMAT_DATE("%Y",Release_Date)as year ,Movie_Title,Production_Budget,RANK() OVER (PARTITION BY year ORDER BY Production_Budget DESC) AS Rank
FROM (
  
     ( SELECT *,FORMAT_DATE("%Y",Release_Date)as year  FROM  `nttdata-c4e-bde.uc1_16.Movie`
      where ( Release_Date Between '2016-01-01' AND '2020-12-31' )
      order by Production_Budget Desc
     )
)
)
SELECT year ,Movie_Title,Production_Budget,Rank 
FROM finishers 
where rank<=10
order by year DESC,Rank asc
