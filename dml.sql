INSERT INTO assistants VALUES ('1937482947','Juan Rodriguez','1','1','2024-06-14');
INSERT INTO assitantsroutes VALUES ('1937482947','1');
INSERT INTO branches (name,adress,cityid) VALUES ('Sucursal 1','cra 36 #35-01','BGA');
INSERT INTO brands (name) VALUES ('Mercedes-Benz');
INSERT INTO cities VALUES ('BGA','Bucaramanga','COL');
INSERT INTO clients VALUES ('1097783634','John Doe','1','jjpp@gmail.com','Calle 89 #24-05','BGA');
INSERT INTO clientsphones (clientid,phonenumber) VALUES ('1097783634','3058199121');
INSERT INTO countries VALUES ('COL','Colombia');
INSERT INTO documenttypes (name) VALUES ('CC'),('CE'),('RC');
INSERT INTO drivers VALUES ('91297969','Pepito Perez','1','2','1','2024-06-14');
INSERT INTO driversphones (driverid,phonenumber) VALUES ('91297969','6360870');
INSERT INTO driversroutes VALUES ('91297969','1');
INSERT INTO licensetypes (name) VALUES ('A'),('B1'),('C2');
INSERT INTO models (name,capacity,brandid) VALUES ('camión 1','20','1');
INSERT INTO packages (weight,measures,content,declaredvalue,servicetype) VALUES ('8.9','20cm*20cm','heavy weights','205.78','Regular shipping');
INSERT INTO packagestates (name) VALUES ('en camino'),('entregado'),('en espera');
INSERt INTO receivers VALUES ('63517661','JmPP','1','Calle 89 #24-05','BGA','3004638899');
INSERT INTO routes (description,branchid) VALUES ('Cruza toda la ciudad de sur a norte','1');
INSERT INTO shippings (clientid,packageid,shippingdate,receiverid,routeid) VALUES ('1097783634','1','2024-06-14 12:00:00','63517661','1');
INSERT INTO states (name) VALUES ('Disponible'),('Ocupado'),('En espera');
INSERT INTO trackings (location,time_date,packagestatesid,packageid) VALUES ('calle 18#98-19','2024-06-14 12:00:00','1','1');
INSERT INTO vehicles (plate,modelid,branchid,driverid,status) VALUES ('ABS946','1','1','91297969','1');
INSERT INTO vehiclesroutes VALUES ('1','1');

SELECT c.id AS clientid, sh.id AS shippingid, sh.shippingdate, pa.id AS packageid, pa.content AS packagecontent, re.id AS receiverid, re.name AS receivername
FROM shippings AS sh
INNER JOIN clients AS c ON c.id = sh.clientid
INNER JOIN packages AS pa ON pa.id = sh.packageid
INNER JOIN receivers AS re ON re.id = sh.receiverid
WHERE c.id = '1097783634';

UPDATE trackings 
SET packagestatesid = '2' 
WHERE id = '1';


SELECT  pa.id AS Paqueteid, tr.location AS ubicacion, pa.content AS contenido 
FROM trackings AS tr
INNER JOIN packages AS pa ON pa.id = tr.packageid;


SELECT sh.id, cl.id AS clientid,br.name AS branchname, dr.driverid AS driverid,d.name AS drivername, pa.id AS packageid, pa.content AS contenido, sh.shippingdate, re.id AS receiverid, ro.id AS routeid
FROM shippings AS sh
INNER JOIN clients AS cl ON cl.id = sh.clientid
INNER JOIN packages AS pa ON pa.id = sh.packageid
INNER JOIN receivers AS re ON re.id = sh.receiverid
INNER JOIN routes AS ro ON ro.id = sh.routeid
INNER JOIN driversroutes AS dr ON dr.routeid = sh.routeid
INNER JOIN drivers AS d ON d.id = dr.driverid
INNER JOIN branches AS br ON br.id = ro.branchid;

SELECT c.id AS clientid, sh.id AS shippingid, sh.shippingdate, ps.name AS status, tr.time_date AS timedate
FROM shippings AS sh
INNER JOIN clients AS c ON c.id = sh.clientid
INNER JOIN packages AS pa ON pa.id = sh.packageid
INNER JOIN trackings AS tr ON tr.packageid = pa.id
INNER JOIN packagestates AS ps ON ps.id = tr.packagestatesid
WHERE c.id = '1097783634';

SELECT d.id AS driverid, d.name AS drivername, v.plate AS vehicleplate, m.name AS modelname, b.name AS branchname 
FROM drivers AS d
INNER JOIN driversroutes AS dr ON d.id = dr.driverid
INNER JOIN routes AS ro ON ro.id = dr.routeid
INNER JOIN branches AS br ON br.id = ro.branchid
INNER JOIN vehiclesroutes AS vr ON vr.routeid = ro.id
INNER JOIN vehicles AS v ON v.id = vr.vehicleid
INNER JOIN models AS m ON m.id = v.modelid
INNER JOIN branches AS b ON b.id = v.branchid;


SELECT ro.id AS routeid, ro.description AS routedescription, a.id AS assistantid, a.name AS assistantname
FROM routes AS ro
LEFT JOIN assitantsroutes AS ar ON ro.id = ar.routeid
LEFT JOIN assistants AS a ON ar.assistantid = a.id
ORDER BY ro.id, a.id;


SELECT p.id AS packageid, p.content, br.id AS branchid, br.name AS branchname, ps.name AS packagestate
FROM packages AS p
INNER JOIN trackings AS tr ON tr.packageid = p.id
INNER JOIN shippings AS sh ON sh.packageid = p.id
INNER JOIN branches AS br ON br.id = sh.branchid
INNER JOIN packagestates AS ps ON ps.id = tr.packagestatesid
ORDER BY sh.id, ps.id;


SELECT p.id AS packageid, p.weight, p.measures, p.content, p.declaredvalue, p.servicetype, tr.id AS trackingid, tr.location, tr.time_date, ps.name AS state
FROM packages AS p
INNER JOIN trackings AS tr ON tr.packageid = p.id
INNER JOIN packagestates As ps ON ps.id = tr.packagestatesid
WHERE p.id = '1';


SELECT p.id AS packageid, p.content, sh.id AS shippingid, sh.shippingdate
FROM packages AS p
INNER JOIN shippings AS sh ON sh.packageid = p.id
WHERE sh.shippingdate BETWEEN '2024-06-10 10:00:00' AND '2024-06-20 10:00:00';


SELECT p.id AS packageid, p.content, tr.id AS trackingid, ps.name AS state
FROM packages AS p 
INNER JOIN trackings AS tr ON tr.packageid = p.id
INNER JOIN packagestates AS ps ON ps.id = tr.packagestatesid
WHERE ps.name IN ('entregado','Pending','Cancelled');


SELECT p.id AS packageid, p.content, tr.id AS trackingid, ps.name AS state
FROM packages AS p 
INNER JOIN trackings AS tr ON tr.packageid = p.id
INNER JOIN packagestates AS ps ON ps.id = tr.packagestatesid
WHERE ps.name NOT IN ('entregado','Pending','Cancelled','Damaged','Transferred');


SELECT c.id AS clientid, c.name AS clientname, sh.id AS shippingid, sh.shippingdate
FROM shippings AS sh
INNER JOIN clients AS c ON c.id = sh.clientid   
WHERE shippingdate BETWEEN '2024-06-14 19:00:00' AND '2024-06-15 03:00:00'
ORDER BY shippingdate;

SELECT d.id, d.name, s.name AS state
FROM drivers AS d
INNER JOIN states AS s ON s.id = d.stateid
WHERE s.name = 'Disponible';

SELECT p.id, p.content, p.declaredvalue
FROM packages AS p
WHERE p.declaredvalue BETWEEN '75.00' AND '400.00';

SELECT ro.id AS routeid, ro.description AS routedescription, a.id AS assistantid, a.name AS assistantname
FROM routes AS ro
LEFT JOIN assitantsroutes AS ar ON ro.id = ar.routeid
LEFT JOIN assistants AS a ON ar.assistantid = a.id
WHERE ro.id IN ('1','2')
ORDER BY ro.id, a.id;


SELECT sh.id As shippingid, sh.clientid, sh.packageid,  sh.shippingdate, sh.receiverid, ci.name AS destinycity
FROM shippings AS sh
INNER JOIN receivers AS r ON r.id = sh.receiverid
INNER JOIN cities AS ci ON ci.id = r.cityid
WHERE ci.id NOT IN ('CT001','CT002','CT003');


SELECT tr.id AS trackingid, p.id AS packageid, tr.time_date AS trackingdate
FROM trackings AS tr
INNER JOIN packages AS p ON tr.packageid = p.id
WHERE tr.time_date BETWEEN '2024-06-14 17:00:00' AND '2024-06-15 03:00:00'
ORDER BY tr.time_date;


SELECT c.id AS clientid, c.name AS clientname, sh.id AS shippingid, p.id AS packageid, p.content AS packagecontent, p.servicetype
FROM shippings AS sh
INNER JOIN clients AS c ON c.id = sh.clientid
INNER JOIN packages AS p on p.id = sh.packageid
WHERE p.servicetype IN ('Standard','Overnight');