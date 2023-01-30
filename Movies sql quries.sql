--TOPIC : Movies (1946-2022)
--Tool Used : MS SQL Server

--Show the all movies details

SELECT * FROM movies$;
SELECT * FROM languages$;
SELECT * FROM financials$;

--Show the Years

SELECT DISTINCT(RELEASE_YEAR) FROM movies$;

--Show the Title

SELECT DISTINCT(TITLE) FROM movies$;

--Total movies

SELECT COUNT(TITLE) AS TOTAL_MOVIES FROM movies$;

--Industry type

SELECT DISTINCT(INDUSTRY) FROM movies$;

--studios

SELECT DISTINCT(STUDIO) FROM movies$;

--Languages 

SELECT DISTINCT(NAME) FROM languages$;

--budget & revenue wise by bollywood & hollywood movies

SELECT SUM(BUDGET) FROM financials$
WHERE currency = 'INR';

SELECT SUM(BUDGET) FROM financials$
WHERE currency = 'USD';

SELECT SUM(REVENUE) FROM financials$
WHERE currency = 'INR';

SELECT SUM(REVENUE) FROM financials$
WHERE currency = 'USD';

--INR Thousands BUDGET & revenue
SELECT SUM(BUDGET) AS BUDGET,
       SUM(REVENUE) AS REVENUE
FROM financials$
WHERE currency = 'INR' AND
      unit = 'Thousands';

--INR Millions BUDGET & REVNUE
SELECT SUM(BUDGET) AS BUDGET,
        SUM(REVENUE) AS REVENUE
FROM financials$
WHERE currency = 'INR' AND
      unit = 'Millions';

--INR Billions BUDGET
SELECT SUM(BUDGET) AS BUDGET,
        SUM(REVENUE) AS REVENUE
FROM financials$
WHERE currency = 'INR' AND
      unit = 'Billions';

--total Budget for bollywood

SELECT M.INDUSTRY, SUM(F.BUDGET) AS 'TOTAL_BUDGET'
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'INR'
GROUP BY M.industry

--total Budget for hollywood

SELECT M.INDUSTRY, SUM(F.BUDGET) AS 'TOTAL_BUDGET'
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'USD'
GROUP BY M.industry

--total Revenue for bollywood

SELECT M.INDUSTRY, SUM(F.REVENUE) AS 'TOTAL_REVENUE'
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'INR'
GROUP BY M.industry

--total Revenue for hollywood

SELECT M.INDUSTRY, SUM(F.REVENUE) AS 'TOTAL_REVENUE'
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'USD'
GROUP BY M.industry

--Industry wise total budget

SELECT M.INDUSTRY,F.unit, SUM(F.BUDGET) AS 'TOTAL_BUDGET'
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency IN ('INR','USD')
GROUP BY M.industry,F.unit

--Industry wise total Revenue

SELECT M.INDUSTRY, SUM(F.REVENUE) AS 'TOTAL_REVENUE',F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency IN ('INR','USD')
GROUP BY M.industry,F.unit

--Bollywood movies wise total budget

SELECT M.TITLE,M.INDUSTRY,m.release_year, SUM(F.BUDGET) AS 'TOTAL_BUDGET',F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency IN ('INR')
GROUP BY M.title,M.industry,F.unit,m.release_year
ORDER BY TOTAL_BUDGET DESC;

--Hollywood movies wise total budget

SELECT M.TITLE,M.INDUSTRY,m.release_year, SUM(F.BUDGET) AS 'TOTAL_BUDGET',F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency IN ('USD')
GROUP BY M.title,M.industry,F.unit,m.release_year
ORDER BY TOTAL_BUDGET DESC;

--Bollywood movies and rating (8,8.4) wise total budget

SELECT M.TITLE,M.INDUSTRY,m.release_year, SUM(F.BUDGET) AS 'TOTAL_BUDGET',F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'INR' AND
      imdb_rating IN (8,8.4)
GROUP BY M.title,M.industry,F.unit,m.release_year
ORDER BY TOTAL_BUDGET DESC;

--Hollywood movies and rating (8,8.4) wise total budget

SELECT M.TITLE,M.INDUSTRY,m.release_year, SUM(F.BUDGET) AS 'TOTAL_BUDGET',F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'USD' AND
      imdb_rating IN (8,8.4)
GROUP BY M.title,M.industry,F.unit,m.release_year
ORDER BY TOTAL_BUDGET DESC;

--Bollywood Movies, rating(8,8.4) wise total budget and total revenue

SELECT M.TITLE,M.INDUSTRY, M.studio,m.release_year,
       SUM(F.BUDGET) AS 'TOTAL_BUDGET',
	   SUM(F.REVENUE) AS 'TOTAL_REVENUE',
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'INR' AND
      imdb_rating IN (8,8.4)
GROUP BY M.title,M.industry,M.studio,F.unit,m.release_year
ORDER BY TOTAL_BUDGET,TOTAL_REVENUE DESC;

--Hollywood Movies, rating(8,8.4) wise total budget and total revenue

SELECT M.TITLE,M.INDUSTRY, M.studio,m.release_year,
       SUM(F.BUDGET) AS 'TOTAL_BUDGET',
	   SUM(F.REVENUE) AS 'TOTAL_REVENUE',
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'USD' AND
      imdb_rating IN (8,8.4)
GROUP BY M.title,M.industry,M.studio,F.unit,m.release_year
ORDER BY TOTAL_BUDGET,TOTAL_REVENUE DESC;

--top 10 budget & revenue by bollywood movies 

SELECT top (10) M.TITLE,M.INDUSTRY, M.studio,m.release_year,
       SUM(F.BUDGET) AS 'TOTAL_BUDGET',
	   SUM(F.REVENUE) AS 'TOTAL_REVENUE',
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'INR' 
GROUP BY M.title,M.industry,M.studio,F.unit,m.release_year
ORDER BY TOTAL_BUDGET,TOTAL_REVENUE 

--top 10 budget & revenue by hollywood movies 

SELECT top (10) M.TITLE,M.INDUSTRY, M.studio,m.release_year,
       SUM(F.BUDGET) AS 'TOTAL_BUDGET',
	   SUM(F.REVENUE) AS 'TOTAL_REVENUE',
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'USD' 
GROUP BY M.title,M.industry,M.studio,F.unit,m.release_year
ORDER BY TOTAL_BUDGET,TOTAL_REVENUE 

--TOP 10 bollywood movies by languages

SELECT top (10) M.TITLE,M.INDUSTRY, M.studio,M.release_year,L.name,
       SUM(F.BUDGET) AS 'TOTAL_BUDGET',
	   SUM(F.REVENUE) AS 'TOTAL_REVENUE',
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
JOIN 
languages$ L ON
M.language_id = L.language_id
WHERE currency = 'INR' 
GROUP BY M.title,M.industry,M.studio,F.unit,M.release_year,L.name
ORDER BY TOTAL_BUDGET,TOTAL_REVENUE

--Hollywood Movies, rating(8,8.4) wise total budget and total revenue

SELECT top (10) M.TITLE,M.INDUSTRY, M.studio,M.release_year,L.name,
       SUM(F.BUDGET) AS 'TOTAL_BUDGET',
	   SUM(F.REVENUE) AS 'TOTAL_REVENUE',
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
JOIN 
languages$ L ON
M.language_id = L.language_id
WHERE currency = 'USD' 
GROUP BY M.title,M.industry,M.studio,F.unit,M.release_year,L.name
ORDER BY TOTAL_BUDGET,TOTAL_REVENUE

--top 10 budget & revenue by hollywood movies by years

SELECT top (10) M.TITLE,M.INDUSTRY, M.studio,M.release_year,
       SUM(F.BUDGET) AS 'TOTAL_BUDGET',
	   SUM(F.REVENUE) AS 'TOTAL_REVENUE',
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'USD' 
GROUP BY M.title,M.industry,M.studio,F.unit,M.release_year
ORDER BY TOTAL_BUDGET,TOTAL_REVENUE 

--top 10 budget & revenue by bollywood movies by years

SELECT top (10) M.TITLE,M.INDUSTRY, M.studio,M.release_year,
       SUM(F.BUDGET) AS 'TOTAL_BUDGET',
	   SUM(F.REVENUE) AS 'TOTAL_REVENUE',
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
WHERE currency = 'INR' 
GROUP BY M.title,M.industry,M.studio,F.unit,M.release_year
ORDER BY TOTAL_BUDGET,TOTAL_REVENUE

--Yearly wise budget and revenue BY BOLLYWOOD

SELECT M.RELEASE_YEAR,M.industry,M.title,L.NAME,
       SUM(F.BUDGET) AS BUDGET,
	   SUM(F.REVENUE) AS REVENUE,
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
JOIN
languages$ L ON
M.language_id = L.language_id
WHERE industry = 'BOLLYWOOD'
GROUP BY M.release_year,industry,M.title,F.unit,L.name
ORDER BY M.release_year DESC;

--Yearly wise budget and revenue BY Hollywood

SELECT M.RELEASE_YEAR,M.industry,M.title,L.NAME,
       SUM(F.BUDGET) AS BUDGET,
	   SUM(F.REVENUE) AS REVENUE,
	   F.unit
FROM movies$ M
JOIN
financials$ F ON
M.movie_id = F.movie_id
JOIN
languages$ L ON
M.language_id = L.language_id
WHERE industry = 'Hollywood'
GROUP BY M.release_year,industry,M.title,F.unit,L.name
ORDER BY M.release_year DESC;

--Language by budget & revenue

SELECT L.NAME,
      SUM(F.BUDGET) AS BUDGET,
	  SUM(F.REVENUE) AS REVENUE,
	  F.unit
FROM movies$ M
JOIN
languages$ L ON
M.language_id = L.language_id
JOIN 
financials$ F ON
M.movie_id = F.movie_id
WHERE M.industry  IN ('BOLLYWOOD','HOLLYWOOD')
GROUP BY L.NAME,F.unit 
ORDER BY REVENUE 

--Highest budget & revenue movies by bollywood

SELECT TOP(7) M.title,M.release_year,MAX(F.REVENUE) AS HIGHEST_REVENUE,
               max(F.BUDGET) AS HIGHEST_BUDGET,
			   L.NAME
FROM movies$ M 
JOIN 
financials$ F ON
M.movie_id = F.movie_id
JOIN
languages$ L ON
M.language_id = L.language_id
WHERE industry = 'BOLLYWOOD' AND
      currency = 'INR' AND
	  unit = 'BILLIONS'
GROUP BY M.title,M.release_year,L.NAME
ORDER BY HIGHEST_REVENUE DESC

---Highest budget & revenue movies by hollywoood

SELECT TOP(10) M.title,M.release_year,MAX(F.REVENUE) AS HIGHEST_REVENUE,
               max(F.BUDGET) AS HIGHEST_BUDGET,
			   L.NAME
FROM movies$ M 
JOIN 
financials$ F ON
M.movie_id = F.movie_id
JOIN
languages$ L ON
M.language_id = L.language_id
WHERE industry = 'HOLLYWOOD' AND
      currency = 'USD' AND
	  unit = 'MILLIONS'
GROUP BY M.title,M.release_year,L.NAME
ORDER BY HIGHEST_REVENUE DESC

