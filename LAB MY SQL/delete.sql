#Hago este SELECT para comprobar en primer lugar que sale
SELECT *
FROM dbo.Cars2
WHERE VIN = 'DAM41UDN3CHU2WVF6';

#Hago el DELETE
DELETE FROM [dbo].[Cars2] WHERE ID = 4;

#Vuelvo a hacer el select para verificar los datos
SELECT *
FROM dbo.Cars2
WHERE VIN = 'DAM41UDN3CHU2WVF6';
