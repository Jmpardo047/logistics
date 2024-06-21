![logisticadrawio (2)](logisticadrawio (2).jpg)

**Caso de Uso 1: Registrar un Nuevo País** 

**Descripción:** Un administrador desea agregar un nuevo país a la base de datos. 

```
INSERT INTO countries VALUES ('COL','Colombia');
```



**Caso de Uso 2: Registrar una Nueva Ciudad** 

**Descripción:** Un administrador desea agregar una nueva ciudad asociada a un país existente. 

```
INSERT INTO cities VALUES ('BGA','Bucaramanga','COL');
```



**Caso de Uso 3: Registrar una Nueva Sucursal** 

**Descripción:** Un administrador desea agregar una nueva sucursal asociada a una ciudad existente.



**Caso de Uso 4: Registrar un Nuevo Cliente** 

**Descripción:** Un administrador desea registrar un nuevo cliente en la base de datos. 

```
INSERT INTO clients VALUES ('1097783634','John Doe','1','jjpp@gmail.com','Calle 89 #24-05','BGA');
```



**Caso de Uso 5: Registrar un Nuevo Teléfono para un Cliente** 

**Descripción:** Un administrador desea agregar un número de teléfono para un cliente existente.

```
INSERT INTO clientsphones (clientid,phonenumber) VALUES ('1097783634','3058199121');
```



 **Caso de Uso 6: Registrar un Nuevo Paquete** 

**Descripción:** Un administrador desea registrar un nuevo paquete en la base de datos. 

```
INSERT INTO packages (weight,measures,content,declaredvalue,servicetype) 
VALUES ('8.9','20cm*20cm','heavy weights','205.78','Regular shipping');
```



**Caso de Uso 7: Registrar un Nuevo Envío** 

**Descripción:** Un administrador desea registrar un nuevo envío, asociando un cliente, paquete, ruta y sucursal. 

```
INSERT INTO shippings (clientid,packageid,shippingdate,receiverid,routeid) 
VALUES ('1097783634','1','2024-06-14 12:00:00','63517661','1');
```



**Caso de Uso 8: Registrar un Nuevo Vehículo** 

**Descripción:** Un administrador desea agregar un nuevo vehículo a la base de datos. 

```
INSERT INTO vehicles (plate,modelid,branchid,driverid,status) 
VALUES ('ABS946','1','1','91297969','1');
```



**Caso de Uso 9: Registrar un Nuevo Conductor** 

**Descripción:** Un administrador desea agregar un nuevo conductor a la base de datos. 

```
INSERT INTO drivers VALUES ('91297969','Pepito Perez','1','2','1','2024-06-14');
```



**Caso de Uso 10: Registrar un Nuevo Teléfono para un Conductor** 

**Descripción:** Un administrador desea agregar un número de teléfono para un conductor existente. 

```
INSERT INTO driversphones (driverid,phonenumber) VALUES ('91297969','6360870');
```



**Caso de Uso 11: Asignar un Conductor a una Ruta y un Vehículo** 

**Descripción:** Un administrador desea asignar un conductor a una ruta específica utilizando un vehículo. 

```
INSERT INTO driversroutes VALUES ('91297969','1');

INSERT INTO vehiclesroutes VALUES ('1','1');
```



**Caso de Uso 12: Registrar un Nuevo Auxiliar** 

**Descripción:** Un administrador desea agregar un nuevo auxiliar de reparto a la base de datos. 

```
INSERT INTO assistants VALUES ('1937482947','Juan Rodriguez','1','1','2024-06-14');
```



**Caso de Uso 13: Asignar un Auxiliar a una Ruta** 

**Descripción:** Un administrador desea asignar un auxiliar de reparto a una ruta específica. 

```
INSERT INTO assitantsroutes VALUES ('1937482947','1');
```



**Caso de Uso 14: Registrar un Evento de Seguimiento para un Paquete** 

**Descripción:** Un administrador desea registrar un evento de seguimiento para un paquete.

```
INSERT INTO trackings (location,time_date,packagestatesid,packageid) 
VALUES ('calle 18#98-19','2024-06-14 12:00:00','1','1');
```



**Caso de Uso 15: Generar un Reporte de Envíos por Cliente** 

**Descripción:** Un administrador desea generar un reporte de todos los envíos realizados por un cliente específico. 

```
SELECT c.id AS clientid, sh.id AS shippingid, sh.shippingdate, pa.id AS packageid, pa.content AS packagecontent, re.id AS receiverid, re.name AS receivername
FROM shippings AS sh
INNER JOIN clients AS c ON c.id = sh.clientid
INNER JOIN packages AS pa ON pa.id = sh.packageid
INNER JOIN receivers AS re ON re.id = sh.receiverid
WHERE c.id = '1097783634';
```



**Caso de Uso 16: Actualizar el Estado de un Paquete** 

**Descripción:** Un administrador desea actualizar el estado de un paquete específico. 

```
UPDATE trackings 
SET packagestatesid = '2' 
WHERE id = '1';
```



**Caso de Uso 17: Rastrear la Ubicación Actual de un Paquete** 

**Descripción:** Un administrador desea rastrear la ubicación actual de un paquete específico. 

```
SELECT  pa.id AS Paqueteid, tr.location AS ubicacion, pa.content AS contenido 
FROM trackings AS tr
INNER JOIN packages AS pa ON pa.id = tr.packageid;
```



**Casos Multitabla** 

**Caso de Uso 1: Obtener Información Completa de Envíos** 

**Descripción:** Un administrador desea obtener la información completa de todos los envíos, incluyendo detalles del cliente, paquete, ruta, conductor, y sucursal. 

```
SELECT sh.id, cl.id AS clientid,br.name AS branchname, dr.driverid AS driverid,d.name AS drivername, pa.id AS packageid, pa.content AS contenido, sh.shippingdate, re.id AS receiverid, ro.id AS routeid
FROM shippings AS sh
INNER JOIN clients AS cl ON cl.id = sh.clientid
INNER JOIN packages AS pa ON pa.id = sh.packageid
INNER JOIN receivers AS re ON re.id = sh.receiverid
INNER JOIN routes AS ro ON ro.id = sh.routeid
INNER JOIN driversroutes AS dr ON dr.routeid = sh.routeid
INNER JOIN drivers AS d ON d.id = dr.driverid
INNER JOIN branches AS br ON br.id = ro.branchid;
```



**Caso de Uso 2: Obtener Historial de Envíos de un Cliente** 

**Descripción:** Un administrador desea obtener el historial completo de envíos de un cliente específico, incluyendo detalles de los paquetes y los eventos de seguimiento. 

```
SELECT c.id AS clientid, sh.id AS shippingid, sh.shippingdate, ps.name AS status, tr.time_date AS timedate
FROM shippings AS sh
INNER JOIN clients AS c ON c.id = sh.clientid
INNER JOIN packages AS pa ON pa.id = sh.packageid
INNER JOIN trackings AS tr ON tr.packageid = pa.id
INNER JOIN packagestates AS ps ON ps.id = tr.packagestatesid
WHERE c.id = '1097783634';
```



**Caso de Uso 3: Listar Conductores y sus Rutas Asignadas** 

**Descripción:** Un administrador desea obtener una lista de todos los conductores y las rutas a las que están asignados, incluyendo detalles del vehículo utilizado y la sucursal correspondiente. 

```
SELECT d.id AS driverid, d.name AS drivername, v.plate AS vehicleplate, m.name AS modelname, b.name AS branchname 
FROM drivers AS d
INNER JOIN driversroutes AS dr ON d.id = dr.driverid
INNER JOIN routes AS ro ON ro.id = dr.routeid
INNER JOIN branches AS br ON br.id = ro.branchid
INNER JOIN vehiclesroutes AS vr ON vr.routeid = ro.id
INNER JOIN vehicles AS v ON v.id = vr.vehicleid
INNER JOIN models AS m ON m.id = v.modelid
INNER JOIN branches AS b ON b.id = v.branchid;
```



**Caso de Uso 4: Obtener Detalles de Rutas y Auxiliares Asignados** 

**Descripción:** Un administrador desea obtener detalles de todas las rutas, incluyendo los auxiliares asignados a cada ruta. 

```
SELECT ro.id AS routeid, ro.description AS routedescription, a.id AS assistantid, a.name AS assistantname
FROM routes AS ro
LEFT JOIN assitantsroutes AS ar ON ro.id = ar.routeid
LEFT JOIN assistants AS a ON ar.assistantid = a.id
ORDER BY ro.id, a.id;
```



**Caso de Uso 5: Generar Reporte de Paquetes por Sucursal y Estado** 

**Descripción:** Un administrador desea generar un reporte de todos los paquetes agrupados por sucursal y estado. 

```
SELECT p.id AS packageid, p.content, br.id AS branchid, br.name AS branchname, ps.name AS packagestate
FROM packages AS p
INNER JOIN trackings AS tr ON tr.packageid = p.id
INNER JOIN shippings AS sh ON sh.packageid = p.id
INNER JOIN branches AS br ON br.id = sh.branchid
INNER JOIN packagestates AS ps ON ps.id = tr.packagestatesid
ORDER BY sh.id, ps.id;
```



**Caso de Uso 6: Obtener Información Completa de un Paquete y su Historial de Seguimiento** 

**Descripción:** Un administrador desea obtener la información completa de un paquete específico y su historial de seguimiento.

```
SELECT p.id AS packageid, p.weight, p.measures, p.content, p.declaredvalue, p.servicetype, tr.id AS trackingid, tr.location, tr.time_date, ps.name AS state
FROM packages AS p
INNER JOIN trackings AS tr ON tr.packageid = p.id
INNER JOIN packagestates As ps ON ps.id = tr.packagestatesid
WHERE p.id = '1';
```



**Casos de uso Between, In y Not In** 

**Caso de Uso 1: Obtener Paquetes Enviados Dentro de un Rango de Fechas** 

**Descripción:** Un administrador desea obtener todos los paquetes que fueron enviados dentro de un rango de fechas específico. 

```
SELECT p.id AS packageid, p.content, sh.id AS shippingid, sh.shippingdate
FROM packages AS p
INNER JOIN shippings AS sh ON sh.packageid = p.id
WHERE sh.shippingdate BETWEEN '2024-06-10 10:00:00' AND '2024-06-20 10:00:00';
```



**Caso de Uso 2: Obtener Paquetes con Ciertos Estados** 

**Descripción:** Un administrador desea obtener todos los paquetes que tienen ciertos estados específicos (por ejemplo, 'en tránsito' o 'entregado'). 

```
SELECT p.id AS packageid, p.content, tr.id AS trackingid, ps.name AS state
FROM packages AS p 
INNER JOIN trackings AS tr ON tr.packageid = p.id
INNER JOIN packagestates AS ps ON ps.id = tr.packagestatesid
WHERE ps.name IN ('entregado','Pending','Cancelled');
```



**Caso de Uso 3: Obtener Paquetes Excluyendo Ciertos Estados** 

**Descripción:** Un administrador desea obtener todos los paquetes excluyendo aquellos que tienen ciertos estados específicos (por ejemplo, 'recibido' o 'retenido en aduana'). 

```
SELECT p.id AS packageid, p.content, tr.id AS trackingid, ps.name AS state
FROM packages AS p 
INNER JOIN trackings AS tr ON tr.packageid = p.id
INNER JOIN packagestates AS ps ON ps.id = tr.packagestatesid
WHERE ps.name NOT IN ('entregado','Pending','Cancelled','Damaged','Transferred');
```



**Caso de Uso 4: Obtener Clientes con Envíos Realizados Dentro de un Rango de Fechas** 

**Descripción:** Un administrador desea obtener todos los clientes que realizaron envíos dentro de un rango de fechas específico. 

```
SELECT c.id AS clientid, c.name AS clientname, sh.id AS shippingid, sh.shippingdate
FROM shippings AS sh
INNER JOIN clients AS c ON c.id = sh.clientid   
WHERE shippingdate BETWEEN '2024-06-14 19:00:00' AND '2024-06-15 03:00:00'
ORDER BY shippingdate;
```



**Caso de Uso 5: Obtener Conductores Disponibles que No Están Asignados a Ciertas Rutas** 

**Descripción:** Un administrador desea obtener todos los conductores que no están asignados a ciertas rutas específicas. 

```
SELECT d.id, d.name, s.name AS state
FROM drivers AS d
INNER JOIN states AS s ON s.id = d.stateid
WHERE s.name = 'Disponible';
```



**Caso de Uso 6: Obtener Información de Paquetes con Valor Declarado Dentro de un Rango Específico** 

**Descripción:** Un administrador desea obtener todos los paquetes cuyo valor declarado está dentro de un rango específico. 

```
SELECT p.id, p.content, p.declaredvalue
FROM packages AS p
WHERE p.declaredvalue BETWEEN '75.00' AND '400.00';
```



**Caso de Uso 7: Obtener Auxiliares Asignados a Rutas Específicas** 

**Descripción:** Un administrador desea obtener todos los auxiliares de reparto que están asignados a ciertas rutas específicas. 

```
SELECT ro.id AS routeid, ro.description AS routedescription, a.id AS assistantid, a.name AS assistantname
FROM routes AS ro
LEFT JOIN assitantsroutes AS ar ON ro.id = ar.routeid
LEFT JOIN assistants AS a ON ar.assistantid = a.id
WHERE ro.id IN ('1','2')
ORDER BY ro.id, a.id;
```



**Caso de Uso 8: Obtener Envíos a Destinos Excluyendo Ciertas Ciudades** 

**Descripción:** Un administrador desea obtener todos los envíos cuyos destinos no están en ciertas ciudades específicas.

```
SELECT sh.id As shippingid, sh.clientid, sh.packageid,  sh.shippingdate, sh.receiverid, ci.name AS destinycity
FROM shippings AS sh
INNER JOIN receivers AS r ON r.id = sh.receiverid
INNER JOIN cities AS ci ON ci.id = r.cityid
WHERE ci.id NOT IN ('CT001','CT002','CT003');
```



**Caso de Uso 9: Obtener Seguimientos de Paquetes en un Rango de Fechas** 

**Descripción:** Un administrador desea obtener todos los eventos de seguimiento de paquetes que ocurrieron dentro de un rango de fechas específico. 

```
SELECT tr.id AS trackingid, p.id AS packageid, tr.time_date AS trackingdate
FROM trackings AS tr
INNER JOIN packages AS p ON tr.packageid = p.id
WHERE tr.time_date BETWEEN '2024-06-14 17:00:00' AND '2024-06-15 03:00:00'
ORDER BY tr.time_date;
```



**Caso de Uso 10: Obtener Clientes que Tienen Ciertos Tipos de Paquetes** 

**Descripción:** Un administrador desea obtener todos los clientes que tienen paquetes de ciertos tipos específicos (por ejemplo, 'nacional' o 'internacional').

```
SELECT c.id AS clientid, c.name AS clientname, sh.id AS shippingid, p.id AS packageid, p.content AS packagecontent, p.servicetype
FROM shippings AS sh
INNER JOIN clients AS c ON c.id = sh.clientid
INNER JOIN packages AS p on p.id = sh.packageid
WHERE p.servicetype IN ('Standard','Overnight');
```

