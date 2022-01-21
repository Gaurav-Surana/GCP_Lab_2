--Find how many times a page it was visited in July 2017. Group by date the result
--Public Dataset: bigquery-public-data.google_analytics_sample
--Table involved: ga_sessions_201707* (wildcard)


--Data size=approx 10 MB

select date,pagePath,Counter  
from
(
SELECT
  PARSE_DATE('%Y%m%d',date) date,
  h.page.pagePath as pagePath,
  COUNT(*) AS Counter
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST(hits) AS h
GROUP BY
  date,
  h.page.pagePath
)
order by date