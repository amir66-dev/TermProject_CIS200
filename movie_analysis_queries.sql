-- ============================================================
-- 1. Data Quality Checks
-- ============================================================

SELECT COUNT(*) AS total_movies
FROM cleaned_movies_metadata;

SELECT COUNT(*) AS missing_release_dates
FROM cleaned_movies_metadata
WHERE release_date IS NULL;

SELECT COUNT(*) AS missing_revenue
FROM cleaned_movies_metadata
WHERE revenue IS NULL OR revenue = 0;


-- ============================================================
-- 2. Year-Based Movie Trends
-- ============================================================

SELECT 
  YEAR(release_date) AS release_year,
  COUNT(*) AS movie_count,
  AVG(vote_average) AS avg_rating,
  SUM(revenue) AS total_revenue
FROM cleaned_movies_metadata
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
ORDER BY release_year;


-- ============================================================
-- 3. Language Distribution
-- ============================================================

SELECT 
  language,
  COUNT(*) AS movie_count,
  AVG(vote_average) AS avg_rating
FROM cleaned_movies_metadata
GROUP BY language
ORDER BY movie_count DESC;


-- ============================================================
-- 4. Genre-Based Analysis
-- ============================================================

SELECT 
  movie_genre,
  COUNT(*) AS movie_count,
  AVG(tmdb_rating) AS avg_tmdb_rating,
  AVG(movielens_rating) AS avg_movielens_rating
FROM combined_movies
GROUP BY movie_genre
ORDER BY avg_tmdb_rating DESC;


-- ============================================================
-- 5. Cross-Platform Rating Comparison
-- ============================================================

SELECT           
  movie_title,
  movie_genre,
  tmdb_rating,
  movielens_rating,
  tmdb_rating - movielens_rating AS rating_gap
FROM combined_movies
WHERE tmdb_rating IS NOT NULL
  AND movielens_rating IS NOT NULL
ORDER BY rating_gap DESC
LIMIT 20;
