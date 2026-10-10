USE [Home-cook];
GO

SELECT
    r.RecipeName,
    i.IngredientName,
    ri.Quantity,
    ri.MeasurementUnit,
    ri.PreparationNote
FROM dbo.Recipe AS r
INNER JOIN dbo.RecipeIngredient AS ri
    ON r.RecipeID = ri.RecipeID
INNER JOIN dbo.Ingredient AS i
    ON ri.IngredientID = i.IngredientID
ORDER BY
    r.RecipeName,
    i.IngredientName;