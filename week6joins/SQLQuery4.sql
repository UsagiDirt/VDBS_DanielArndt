SELECT a.City,
       COUNT(p.Persons_ID) AS Number_of_People
FROM dbo.Address AS a
INNER JOIN dbo.person AS p
    ON a.Address_ID = p.Address_ID
GROUP BY a.City
ORDER BY Number_of_People DESC;