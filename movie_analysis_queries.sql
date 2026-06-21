-- ============================================================
-- Movie Metadata SQL Analysis
-- Dataset: cleaned_movies_metadata, combined_movies
-- Purpose: Explore movie counts, ratings, revenue, language,
--          genre trends, and cross-platform rating differences.
-- ============================================================


-- ============================================================
-- 1. Dataset Overview
-- ============================================================

SELECT COUNT(*) AS total_movies
FROM cleaned_movies_metadata;

SELECT 
  MIN(release_date) AS earliest_release_date,
  MAX(release_date) AS latest_release_date
FROM cleaned_movies_metadata;

SELECT COUNT(*) AS missing_release_dates
FROM cleaned_movies_metadata
WHERE release_date IS NULL;


-- ============================================================
-- 2. Year-Based Analysis
-- ============================================================

SELECT 
  YEAR(release_date) AS release_year,
  COUNT(*) AS movie_count
FROM cleaned_movies_metadata
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
ORDER BY release_year;

SELECT 
  YEAR(release_date) AS release_year,
  AVG(vote_average) AS avg_rating
FROM cleaned_movies_metadata
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
ORDER BY release_year;

SELECT 
  YEAR(release_date) AS release_year,
  SUM(revenue) AS total_revenue
FROM cleaned_movies_metadata
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
ORDER BY release_year;


-- ============================================================
-- 3. Language-Based Analysis
-- ============================================================

SELECT 
  language,
  COUNT(*) AS movie_count
FROM cleaned_movies_metadata
GROUP BY language
ORDER BY movie_count DESC;

SELECT 
  language,
  AVG(vote_average) AS avg_rating
FROM cleaned_movies_metadata
GROUP BY language
ORDER BY avg_rating DESC;


-- ============================================================
-- 4. Year and Language Analysis
-- ============================================================

SELECT 
  YEAR(release_date) AS release_year,
  language,
  COUNT(*) AS movie_count,
  AVG(vote_average) AS avg_rating,
  SUM(revenue) AS total_revenue
FROM cleaned_movies_metadata
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date), language
ORDER BY release_year, movie_count DESC;


-- ============================================================
-- 5. Genre-Based Analysis
-- ============================================================

SELECT 
  movie_genre,
  AVG(tmdb_rating) AS avg_tmdb_rating
FROM combined_movies
GROUP BY movie_genre
ORDER BY avg_tmdb_rating DESC
LIMIT 10;


-- ============================================================
-- 6. Cross-Platform Rating Comparison
-- ============================================================

SELECT           
  movie_title,
  tmdb_rating,
  movielens_rating,
  tmdb_rating - movielens_rating AS rating_gap
FROM combined_movies
ORDER BY rating_gap DESC
LIMIT 20;


-- ============================================================
-- 7. Rating Distribution
-- ============================================================

SELECT 
  tmdb_rating,
  COUNT(*) AS rating_count 
FROM combined_movies
GROUP BY tmdb_rating
ORDER BY tmdb_rating
LIMIT 15;


-- ============================================================
-- 8. Genre-Specific Rating Gaps
-- ============================================================

SELECT
  movie_genre,
  AVG(tmdb_rating - movielens_rating) AS avg_rating_gap
FROM combined_movies
GROUP BY movie_genre
ORDER BY avg_rating_gap DESC
LIMIT 10;

