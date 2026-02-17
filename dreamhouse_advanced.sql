SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; 

DROP SCHEMA IF EXISTS `dreamhouse` ;
CREATE SCHEMA IF NOT EXISTS `dreamhouse` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `dreamhouse` ;

CREATE TABLE `dreamhouse`.`branch` (
`branch_id` VARCHAR(5) NOT NULL,
`street` VARCHAR (25) NOT NULL,
`city` VARCHAR (15) NOT NULL,
`postcode` VARCHAR (10) NOT NULL,
Constraint `branch_pkey` Primary Key (`branch_id`)
);

CREATE TABLE `dreamhouse`.`staff` (
`staff_id` VARCHAR(5) NOT NULL,
`fname` VARCHAR (10) NOT NULL,
`lname` VARCHAR (10) NOT NULL,
`position` VARCHAR (15) NOT NULL,
`sex` CHAR(1) NOT NULL,
`dob` date NOT NULL,
`salary` numeric NOT NULL,
`branch_id` VARCHAR(5) NOT NULL,
Constraint `staff_pkey` Primary Key (`staff_id`)
);

CREATE TABLE `dreamhouse`.`property4rent` (
`property_id` VARCHAR(5) NOT NULL,
`street` VARCHAR (25) NOT NULL,
`city` VARCHAR (15) NOT NULL,
`postcode` VARCHAR (10) NOT NULL,
`type` VARCHAR (8) NOT NULL,
`rooms` numeric NOT NULL,
`rent` numeric NOT NULL,
`owner_id` VARCHAR (5) NOT NULL,
`staff_id` VARCHAR (5),
`branch_id` VARCHAR (5) NOT NULL,
Constraint `propert4rent_pkey` Primary Key (`property_id`)
);	

CREATE TABLE `dreamhouse`.`client` (
`client_id` VARCHAR(5) NOT NULL,
`fname` VARCHAR (10) NOT NULL,
`lname` VARCHAR (10) NOT NULL,
`telnumber` numeric NOT NULL,
`pref_type` VARCHAR (8) NOT NULL,
`max_rent` numeric NOT NULL,
Constraint `client_pkey` Primary Key (`client_id`)
);

CREATE TABLE `dreamhouse`.`privateowner` (
`privateowner_id` VARCHAR (5) NOT NULL,
`fname` VARCHAR (10) NOT NULL,
`lname` VARCHAR (10) NOT NULL,
`address` VARCHAR (50) NOT NULL,
`telnumber` numeric NOT NULL,
Constraint `privateowner_pkey` Primary Key (`privateowner_id`)
);

CREATE TABLE `dreamhouse`.`viewing` (
`client_id` VARCHAR (5) NOT NULL,
`property_id` VARCHAR (5) NOT NULL,
`viewdate` date NOT NULL,
`comment` text,
Constraint `viewing_pkey` Primary Key (`client_id`, `property_id`)
);

CREATE TABLE `dreamhouse`.`registration` (
`client_id` VARCHAR (5) NOT NULL,
`branch_id` VARCHAR (5) NOT NULL,
`staff_id` VARCHAR (5) NOT NULL,
`date_joined` date NOT NULL,
Constraint `registration_pkey` Primary Key (`client_id`, `branch_id`)
);

ALTER TABLE dreamhouse.registration
 	 ADD CONSTRAINT client_FK_registration FOREIGN KEY (client_id) REFERENCES client(client_id),
	 ADD CONSTRAINT branch_FK_registration FOREIGN KEY (branch_id) REFERENCES branch (branch_id) ON DELETE CASCADE,
	 ADD CONSTRAINT staff_FK_registration FOREIGN KEY (staff_id) REFERENCES staff (staff_id);


ALTER TABLE dreamhouse.viewing
	ADD CONSTRAINT client_FK_viewing FOREIGN KEY (client_id) REFERENCES client (client_id),
	ADD CONSTRAINT property_id_viewing FOREIGN KEY (property_id) REFERENCES property4rent (property_id);

ALTER TABLE dreamhouse.staff 
    ADD CONSTRAINT staff_FK_staff FOREIGN KEY(branch_id) REFERENCES branch (branch_id) ON DELETE CASCADE;


ALTER TABLE dreamhouse.property4rent
	ADD CONSTRAINT owner_FK_property FOREIGN KEY (owner_id) REFERENCES privateowner(privateowner_id),
	ADD CONSTRAINT staff_FK_property FOREIGN KEY (staff_id) REFERENCES staff (staff_id),
	ADD CONSTRAINT branch_FK_property FOREIGN KEY (branch_id) REFERENCES branch (branch_id) ON DELETE CASCADE;

INSERT INTO branch VALUES ('B005','22 Deer Rd', 'London', 'SW1 4EH');

INSERT INTO branch VALUES ('B007','16 Argyll St', 'Aberdeen', 'AB2 3SU');

INSERT INTO branch VALUES ('B003','163 Main St', 'Glasgow', 'G11 9QX');

INSERT INTO branch VALUES ('B004','32 Manse Rd', 'Bristol', 'BS99 1NZ');

INSERT INTO branch VALUES ('B002','56 Clover Dr', 'London', 'NW10 6EU');

INSERT INTO staff VALUES ('SL21','John','White','Manager','M','1950-10-01',30000,'B005');

INSERT INTO staff VALUES ('SG37','Ann','Beech','Assistant','F','1960-11-10',12000,'B003');

INSERT INTO staff VALUES ('SG14','David','Ford','Supervisor','M','1958-03-24',18000,'B003');

INSERT INTO staff VALUES ('SA9','Mary','Howe','Assistant','F','1970-02-19',9000,'B007');

INSERT INTO staff VALUES ('SG5','Susan','Brand','Manager','F','1955-06-03',24000,'B003');

INSERT INTO staff VALUES ('SL41','Julie','Lee','Assistant','F','1965-06-13',9000,'B005');

INSERT INTO privateowner VALUES ('CO46','Joe','Keogh','2 Fergus Dr, Aberdeen AB2 7SX',01224861212);

INSERT INTO privateowner VALUES ('CO87','Carol','Farrel','6 Achray St, Glasgow G32 9DX',01413577419);

INSERT INTO privateowner VALUES ('CO40','Tina','Murphy','63 Well St, Glasgow G42',01419431728);

INSERT INTO privateowner VALUES ('CO93','Tony','Shaw','12 Park Pl, Glasgow G4 0QR',01412257025);

INSERT INTO property4rent VALUES ('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007');

INSERT INTO property4rent VALUES ('PL94','6 Argyll St','London','NW2','Flat',4,400,'CO87','SL41','B005');

INSERT INTO property4rent VALUES ('PG4','6 Lawrence St','Glasgow','G11 9QX','Flat',3,350,'CO40',NULL,'B003');

INSERT INTO property4rent VALUES ('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003');

INSERT INTO property4rent VALUES ('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003');

INSERT INTO property4rent VALUES ('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'CO93','SG14','B003');

INSERT INTO client VALUES ('CR76','John','Kay',02077745632,'Flat',425);

INSERT INTO client VALUES ('CR56','Aline','Stewart',01418481825,'Flat',350);

INSERT INTO client VALUES ('CR74','Mike','Ritchie',01475392178,'House',750);

INSERT INTO client VALUES ('CR62','Mary','Tregear',01224196720,'Flat',600);

INSERT INTO viewing VALUES ('CR56','PA14','2016-005-24','too small');

INSERT INTO viewing VALUES ('CR76','PG4','2016-04-20','too remote');

INSERT INTO viewing VALUES ('CR56', 'PG4','2016-05-26', NULL);

INSERT INTO viewing VALUES ('CR62','PA14','2016-05-14','no dinning room');

INSERT INTO viewing VALUES ('CR56','PG36','2016-04-28', NULL);

INSERT INTO registration VALUES ('CR76','B005','SL41','2004-01-02');

INSERT INTO registration VALUES ('CR56','B003','SG37','2003-04-11');

INSERT INTO registration VALUES ('CR74','B003','SG37','2002-04-16');

INSERT INTO registration VALUES ('CR62','B007','SA9','2003-03-04');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;