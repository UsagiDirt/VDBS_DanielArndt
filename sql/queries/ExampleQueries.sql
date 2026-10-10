-- Example queries for Home-cookinng app
-- Ensure schema exists and review scripts before executing.

SET NOCOUNT ON;
GO

-- 1) Basic select: latest recipes with author
SELECT TOP (100)
	r.RecipeId,
	r.Title,
	u.UserName,
	r.PrepTimeMinutes,
	r.CookTimeMinutes,
	r.CreatedDate
FROM dbo.Recipes AS r
JOIN dbo.Users AS u
	ON r.UserId = u.UserId
ORDER BY r.CreatedDate DESC;
GO

-- 2) Recipe with its ingredients (one row per ingredient)
SELECT
	r.RecipeId,
	r.Title,
	ri.Quantity,
	COALESCE(ri.Unit, i.DefaultUnit) AS Unit,
	i.Name AS IngredientName
FROM dbo.Recipes AS r
JOIN dbo.RecipeIngredients AS ri
	ON r.RecipeId = ri.RecipeId
JOIN dbo.Ingredients AS i
	ON ri.IngredientId = i.IngredientId
WHERE r.RecipeId = @RecipeId; -- set or replace parameter before executing
GO

-- 3) Top-rated recipes (average rating) with at least 3 ratings
SELECT TOP (50)
	r.RecipeId,
	r.Title,
	COUNT(*) AS RatingsCount,
	AVG(CAST(rt.Rating AS FLOAT)) AS AvgRating
FROM dbo.Recipes AS r
JOIN dbo.Ratings AS rt
	ON r.RecipeId = rt.RecipeId
GROUP BY r.RecipeId, r.Title
HAVING COUNT(*) >= 3
ORDER BY AvgRating DESC, RatingsCount DESC;
GO

-- 4) Top 3 recipes per user by average rating (window)
WITH RecipeAvg AS (
	SELECT
		r.RecipeId,
		r.UserId,
		r.Title,
		AVG(CAST(rt.Rating AS FLOAT)) AS AvgRating,
		COUNT(rt.RatingId) AS RatingsCount
	FROM dbo.Recipes AS r
	LEFT JOIN dbo.Ratings AS rt ON r.RecipeId = rt.RecipeId
	GROUP BY r.RecipeId, r.UserId, r.Title
)
SELECT RecipeId, UserId, Title, AvgRating, RatingsCount
FROM (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY UserId ORDER BY AvgRating DESC NULLS LAST) AS rn
	FROM RecipeAvg
) t
WHERE rn <= 3
ORDER BY UserId, AvgRating DESC;
GO

-- 5) Paging example: recipes page
-- Replace @PageNumber and @PageSize before executing
DECLARE @PageNumber INT = 1;
DECLARE @PageSize INT = 20;

SELECT r.RecipeId, r.Title, u.UserName, r.CreatedDate
FROM dbo.Recipes AS r
JOIN dbo.Users AS u ON r.UserId = u.UserId
ORDER BY r.CreatedDate DESC
OFFSET (@PageNumber - 1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY;
GO

-- End of example queries
