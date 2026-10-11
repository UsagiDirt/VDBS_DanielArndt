USE [PropertyManager];
GO

SELECT
    a.*,
    b.*
FROM dbo.Apartment AS a
INNER JOIN dbo.[Building_ID] AS b
    ON a.Building_ID = b.Building_ID
ORDER BY b.Building_name;