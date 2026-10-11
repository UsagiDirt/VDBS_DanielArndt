SELECT p.Persons_ID,
       CONCAT(p.First_Name, ' ',
              ISNULL(p.Middle_initial + '. ', ''),
              p.Last_Name) AS Full_Name,
       CONCAT(a.street_1,
              ISNULL(' ' + a.Street_2, ''), ', ',
              a.City, ', ', a.State, ' ', a.Zip) AS Full_Address
FROM dbo.person AS p
INNER JOIN dbo.Address AS a
    ON p.Address_ID = a.Address_ID
ORDER BY p.Last_Name, p.First_Name;