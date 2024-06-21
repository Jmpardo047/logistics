DROP DATABASE IF EXISTS logistics;
CREATE DATABASE logistics;
USE logistics;

CREATE TABLE IF NOT EXISTS countries(
    id VARCHAR(5) NOT NULL, 
    name VARCHAR(40) NOT NULL,
    CONSTRAINT Pk_Id_country PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS packagestates(
    id INT(2) AUTO_INCREMENT, 
    name VARCHAR(20) NOT NULL,
    CONSTRAINT Pk_Id_packagestates PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS states(
    id INT(2) AUTO_INCREMENT, 
    name VARCHAR(20) NOT NULL,
    CONSTRAINT Pk_Id_states PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS licensetypes(
    id INT(2) AUTO_INCREMENT, 
    name VARCHAR(15) NOT NULL,
    CONSTRAINT Pk_Id_licensetypes PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS brands(
    id INT(3) AUTO_INCREMENT, 
    name VARCHAR(20) NOT NULL,
    CONSTRAINT Pk_Id_brands PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS packages(
    id INT AUTO_INCREMENT, 
    weight DECIMAL (10,2) NOT NULL,
    measures VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    declaredvalue DECIMAL (10,2) NOT NULL,
    servicetype VARCHAR (30),
    CONSTRAINT Pk_Id_packages PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS documenttypes(
    id INT(2) AUTO_INCREMENT, 
    name VARCHAR(15) NOT NULL,
    CONSTRAINT Pk_Id_documenttypes PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS cities(
    id VARCHAR(5) NOT NULL, 
    name VARCHAR(50) NOT NULL,
    countryid VARCHAR(5) NOT NULL,
    CONSTRAINT Pk_Id_cities PRIMARY KEY (id),
    CONSTRAINT Fk_countryid_cities FOREIGN KEY (countryid) REFERENCES countries(id)
);

CREATE TABLE IF NOT EXISTS branches(
    id INT AUTO_INCREMENT, 
    name VARCHAR(50) NOT NULL,
    adress VARCHAR(100) NOT NULL,
    cityid VARCHAR(5) NOT NULL,
    CONSTRAINT Pk_Id_branches PRIMARY KEY (id),
    CONSTRAINT Fk_cityid_branches FOREIGN KEY (cityid) REFERENCES cities(id)
);

CREATE TABLE IF NOT EXISTS routes(
    id INT(8) AUTO_INCREMENT, 
    description VARCHAR(200) NOT NULL,
    branchid INT(11) NOT NULL,
    CONSTRAINT Pk_Id_routes PRIMARY KEY (id),
    CONSTRAINT Fk_branchid_routes FOREIGN KEY (branchid) REFERENCES branches(id)
);

CREATE TABLE IF NOT EXISTS models(
    id INT(7) AUTO_INCREMENT, 
    name VARCHAR(40) NOT NULL,
    capacity DECIMAL (10,2) NOT NULL,
    brandid INT (7) NOT NULL,
    CONSTRAINT Pk_Id_models PRIMARY KEY (id),
    CONSTRAINT Fk_brandid_models FOREIGN KEY (brandid) REFERENCES brands(id)
);

CREATE TABLE IF NOT EXISTS trackings(
    id INT AUTO_INCREMENT, 
    location VARCHAR(80) NOT NULL,
    time_date TIMESTAMP,
    packagestatesid INT(2),
    packageid INT(11),
    CONSTRAINT Pk_Id_trackings PRIMARY KEY (id),
    CONSTRAINT Fk_packagestatesid_trackings FOREIGN KEY (packagestatesid) REFERENCES packagestates(id),
    CONSTRAINT Fk_packageid_trackings FOREIGN KEY (packageid) REFERENCES packages(id)
);

CREATE TABLE IF NOT EXISTS assistants(
    id VARCHAR(20) NOT NULL, 
    name VARCHAR(40) NOT NULL,
    documenttypeid INT(2),
    stateid INT(2),
    hiredate DATE,
    CONSTRAINT Pk_Id_assistants PRIMARY KEY (id),
    CONSTRAINT Fk_documenttypeid_assistants FOREIGN KEY (documenttypeid) REFERENCES documenttypes(id),
    CONSTRAINT Fk_stateid_assistants FOREIGN KEY (stateid) REFERENCES states(id)
);

CREATE TABLE IF NOT EXISTS assistantsphones(
    id INT(7) AUTO_INCREMENT, 
    assistantid VARCHAR(20),
    phonenumber VARCHAR(20),
    CONSTRAINT Pk_Id_assistantsphones PRIMARY KEY (id),
    CONSTRAINT Fk_assistantid_assistantsphones FOREIGN KEY (assistantid) REFERENCES assistants(id)
);

CREATE TABLE IF NOT EXISTS drivers(
    id VARCHAR(20) NOT NULL, 
    name VARCHAR(40) NOT NULL,
    documenttypeid INT(2),
    licensetypeid INT(2),
    stateid INT(2),
    hiredate DATE,
    CONSTRAINT Pk_Id_drivers PRIMARY KEY (id),
    CONSTRAINT Fk_documenttypeid_drivers FOREIGN KEY (documenttypeid) REFERENCES documenttypes(id),
    CONSTRAINT Fk_licensetypeid_drivers FOREIGN KEY (licensetypeid) REFERENCES licensetypes(id)
);

CREATE TABLE IF NOT EXISTS driversphones(
    id INT(7) AUTO_INCREMENT, 
    driverid VARCHAR(20),
    phonenumber VARCHAR(20),
    CONSTRAINT Pk_Id_driversphones PRIMARY KEY (id),
    CONSTRAINT Fk_driverid_driversphones FOREIGN KEY (driverid) REFERENCES drivers(id)
);

CREATE TABLE IF NOT EXISTS receivers(
    id VARCHAR(20) NOT NULL, 
    name VARCHAR(40) NOT NULL,
    documenttypeid INT(2),
    adress VARCHAR (100),
    cityid VARCHAR (5),
    phonenumber VARCHAR (20),
    CONSTRAINT k_Id_receivers PRIMARY KEY (id),
    CONSTRAINT Fk_documenttypeid_receivers FOREIGN KEY (documenttypeid) REFERENCES documenttypes(id),
    CONSTRAINT Fk_cityid_receivers FOREIGN KEY (cityid) REFERENCES cities(id)
);

CREATE TABLE IF NOT EXISTS clients(
    id VARCHAR(20) NOT NULL, 
    name VARCHAR(40) NOT NULL,
    documenttypeid INT(2),
    email VARCHAR (80),
    adress VARCHAR (100),
    cityid VARCHAR (5),
    CONSTRAINT k_Id_cients PRIMARY KEY (id),
    CONSTRAINT Fk_documenttypeid_clients FOREIGN KEY (documenttypeid) REFERENCES documenttypes(id),
    CONSTRAINT Fk_cityid_clients FOREIGN KEY (cityid) REFERENCES cities(id)
);

CREATE TABLE IF NOT EXISTS clientsphones(
    id INT(7) AUTO_INCREMENT, 
    clientid VARCHAR(20),
    phonenumber VARCHAR(20),
    CONSTRAINT Pk_Id_clientsphones PRIMARY KEY (id),
    CONSTRAINT Fk_clientid_clientsphones FOREIGN KEY (clientid) REFERENCES clients(id)
);

CREATE TABLE IF NOT EXISTS vehicles(
    id INT AUTO_INCREMENT,
    plate VARCHAR(10),
    modelid INT(7),
    branchid INT(11),
    driverid VARCHAR(20),
    status BOOLEAN,
    CONSTRAINT Pk_Id_vehicles PRIMARY KEY (id),
    CONSTRAINT Fk_modelid_vehicles FOREIGN KEY (modelid) REFERENCES models(id),
    CONSTRAINT Fk_branchid_vehicles FOREIGN KEY (branchid) REFERENCES branches(id),
    CONSTRAINT Fk_driverid_vehicles FOREIGN KEY (driverid) REFERENCES drivers(id)
);

CREATE TABLE IF NOT EXISTS shippings(
    id INT AUTO_INCREMENT,
    clientid VARCHAR(20),
    packageid INT (11),
    shippingdate TIMESTAMP,
    receiverid VARCHAR (20),
    routeid INT (8),
    branchid INT (11),
    CONSTRAINT Pk_Id_shippings PRIMARY KEY (id),
    CONSTRAINT Fk_clientid_shippings FOREIGN KEY (clientid) REFERENCES clients(id),
    CONSTRAINT Fk_packageid_shippings FOREIGN KEY (packageid) REFERENCES packages(id),
    CONSTRAINT Fk_receiverid_shippings FOREIGN KEY (receiverid) REFERENCES receivers(id),
    CONSTRAINT Fk_routeid_shippings FOREIGN KEY (routeid) REFERENCES routes(id),
    CONSTRAINT Fk_branchid_shippings FOREIGN KEY (branchid) REFERENCES branches(id)
);

CREATE TABLE IF NOT EXISTS driversroutes(
    driverid VARCHAR (20),
    routeid INT (8),
    CONSTRAINT Pk_Id_driversroutes PRIMARY KEY (driverid, routeid),
    CONSTRAINT Fk_driverid_driversroutes FOREIGN KEY (driverid) REFERENCES drivers(id),
    CONSTRAINT Fk_routeid_driversroutes FOREIGN KEY (routeid) REFERENCES routes(id)
);

CREATE TABLE IF NOT EXISTS vehiclesroutes(
    vehicleid INT(11),
    routeid INT (8),
    CONSTRAINT Pk_Id_vehiclesroutes PRIMARY KEY (vehicleid, routeid),
    CONSTRAINT Fk_vehicleid_vehiclesroutes FOREIGN KEY (vehicleid) REFERENCES vehicles(id),
    CONSTRAINT Fk_routeid_vehiclesroutes FOREIGN KEY (routeid) REFERENCES routes(id)
);

CREATE TABLE IF NOT EXISTS assitantsroutes(
    assistantid VARCHAR (20),
    routeid INT (8),
    CONSTRAINT Pk_Id_assistantsroutes PRIMARY KEY (assistantid, routeid),
    CONSTRAINT Fk_assistantid_assistantsroutes FOREIGN KEY (assistantid) REFERENCES assistants(id),
    CONSTRAINT Fk_routeid_assistantsroutes FOREIGN KEY (routeid) REFERENCES routes(id)
);


