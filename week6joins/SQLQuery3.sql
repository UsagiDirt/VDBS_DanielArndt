SELECT p.Persons_ID,
       p.First_Name,
       p.Last_Name,
       a.street_1,
       a.City,
       a.State,
       a.Zip
FROM dbo.person AS p
LEFT JOIN dbo.Address AS a
    ON p.Address_ID = a.Address_ID
WHERE a.City = 'Winona';