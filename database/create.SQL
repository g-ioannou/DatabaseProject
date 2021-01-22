-- --------------------
-- ΟΝΟΜΑ: ΓΙΩΡΓΟΣ
-- ΕΠΩΝΥΜΟ: ΙΩΑΝΝΟΥ
-- ΑΜ:1056280
-- ΕΤΟΣ: 5ο
-- ---------------------


-- ---------------------------------------------- --
-- -------------------TABLES--------------------- --
-- ---------------------------------------------- --

DROP DATABASE IF EXISTS staffevaluation;
CREATE DATABASE staffevaluation;
USE staffevaluation;



CREATE TABLE system_user (
    username VARCHAR(12) NOT NULL,
    password VARCHAR(10) NOT NULL,
    name VARCHAR(25) NOT NULL,
    surname VARCHAR(35) NOT NULL,
    email VARCHAR(30) NOT NULL,
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP(),
    user_type VARCHAR(10) NOT NULL,
    timesLoggedIn BIGINT DEFAULT '0',
    PRIMARY KEY (username)
)ENGINE=INNODB;

CREATE TABLE evaluator(
    username VARCHAR(12) NOT NULL,
    exp_years TINYINT(4) ,
    firm CHAR(9) ,
    AM INT(10) AUTO_INCREMENT,
    PRIMARY KEY (AM,username),
    FOREIGN KEY (username) REFERENCES system_user(username)
    ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;



CREATE TABLE company (
    AFM CHAR(9) NOT NULL,
    DOY VARCHAR(15) NOT NULL,
    name VARCHAR(35) NOT NULL,
    phone BIGINT(16) NOT NULL,
    street VARCHAR(15) NOT NULL,
    num TINYINT(4) NOT NULL,
    city VARCHAR(15) NOT NULL,
    country VARCHAR(15) NOT NULL,
    PRIMARY KEY (AFM)
)ENGINE=INNODB;

CREATE TABLE manager (
    managerUsername VARCHAR(12) NOT NULL,
    exp_years TINYINT(4) ,
    firm CHAR(9) ,
    PRIMARY KEY (managerUsername),
    FOREIGN KEY (firm) REFERENCES company(AFM)
    ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

CREATE TABLE employee (
    works_for CHAR(9) ,
    username VARCHAR(12) NOT NULL,
    AM INT AUTO_INCREMENT,
    sistatikes VARCHAR(35) ,
    awards VARCHAR(35) ,
    PRIMARY KEY (AM,username),
    FOREIGN KEY (works_for) REFERENCES company(AFM)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (username) REFERENCES system_user(username)
    ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

CREATE TABLE project(
    empl VARCHAR(12) NOT NULL,
    num TINYINT(4) AUTO_INCREMENT,
    descr TEXT ,
    url VARCHAR(60),
    PRIMARY KEY (num, empl),
    FOREIGN KEY (empl) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

CREATE TABLE degree(
    titlos VARCHAR(50) NOT NULL,
    idryma VARCHAR(40) NOT NULL,
    bathmida SET('LYKEIO','UNIV','MASTER', 'PHD'),
    PRIMARY KEY (titlos,idryma)
)ENGINE=INNODB;


CREATE TABLE has_degree(
    empl_username VARCHAR(12) NOT NULL,
    degr_title VARCHAR(50) NOT NULL,
    degr_idryma VARCHAR(12) NOT NULL,
    empl_usrname VARCHAR(12) NOT NULL,
    etos YEAR(4) NOT NULL,
    grade FLOAT(3,1) NOT NULL,
    PRIMARY KEY(degr_title,degr_idryma,empl_username),
    FOREIGN KEY (degr_title,degr_idryma) REFERENCES degree(titlos,idryma)
    ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

CREATE TABLE job (
    id INT(4) NOT NULL,
    start_date DATE NOT NULL,
    salary FLOAT(6,1) NOT NULL,
    position VARCHAR(40) NOT NULL,
    edra VARCHAR(45) NOT NULL,
    evaluator VARCHAR(12) NOT NULL,
    announce_date DATETIME DEFAULT CURRENT_TIMESTAMP(),
    submission_date DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (evaluator) REFERENCES evaluator(username)
    ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

CREATE TABLE antikeim (
    title VARCHAR(36) NOT NULL,
    descr TINYTEXT NOT NULL,
    belongs_to VARCHAR(36) NOT NULL,
    PRIMARY KEY (title),
    FOREIGN KEY (belongs_to) REFERENCES antikeim(title)
   
)ENGINE=INNODB;

CREATE TABLE needs(
    job_id INT(4) NOT NULL,
    antikeim_title VARCHAR (36) NOT NULL,
    PRIMARY KEY (job_id,antikeim_title),
    FOREIGN KEY (job_id) REFERENCES job(id),
    FOREIGN KEY (antikeim_title) REFERENCES antikeim(title)
    
)ENGINE=INNODB;

CREATE TABLE requestsevalution(
    empl_usrname VARCHAR(12) NOT NULL,
    job_id INT(4) NOT NULL,
    PRIMARY KEY(empl_usrname, job_id) ,
    FOREIGN KEY (empl_usrname) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (job_id) REFERENCES job(id)
    ON DELETE CASCADE ON UPDATE CASCADE


)ENGINE=INNODB;

CREATE TABLE evaluationresult(
    empl_username VARCHAR(12) NOT NULL,
    EvId  INT AUTO_INCREMENT,
    comments VARCHAR(255) DEFAULT 'No Comments',
    job_id INT(4) NOT NULL,
    grade INT(4) NOT NULL,
    PRIMARY KEY (EvId,empl_username),
    FOREIGN KEY (empl_username) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (job_id) REFERENCES job(id)
    ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

CREATE TABLE languages(
    employee VARCHAR(12) NOT NULL,
    lang SET('FR','GR','EN','SP') NOT NULL,
    PRIMARY KEY(employee,lang),
    FOREIGN KEY (employee) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;





-- ----------------------------------------------------- --
-- -----------------------INSERT------------------------ --
-- ----------------------------------------------------- --

-- -------------------COMPANY INSERT-------------------- --
INSERT INTO `company` (`AFM`, `DOY`, `name`, `phone`, `street`, `num`, `city`, `country`) 
VALUES 
('PPOAFKLOL', 'Xalandriou', 'Mpananofloudes A.E.', '697926566', 'Mesogeion', '23', 'Xalandri', 'Greece'),
('234AAGG36','Pallinis', 'Odontoglifides A.E.', '212301230', 'Aiolou','12','Pallini', 'Greece'),
('OMGKAI3LO', 'Elefsinas', 'Vazeliakos' ,'555555','Roulas', '33', 'Saronikou','Greece'),
('BURYRDUM', 'EKSOTERIKO','TurkLoukoum' , '534552341', 'Mpriki', '55', 'Baklesi', 'Turkey');


-- --------------------------------------------- --
-- ------------------TRIGGERS ------------------ --
-- --------------------------------------------- --

-- -----------------MY TRIGGERS-------------------
DROP TRIGGER IF EXISTS categorize_user
DELIMITER $
CREATE TRIGGER categorize_user
AFTER INSERT
ON system_user
FOR EACH ROW
BEGIN 
    IF (NEW.user_type= 'Manager') THEN
        INSERT INTO manager(managerUsername) VALUES (NEW.username);
    END IF;

    IF (NEW.user_type= 'Evaluator') THEN
        INSERT INTO evaluator(username) VALUES (NEW.username);
    END IF;

    IF (NEW.user_type= 'Employee') THEN
        INSERT INTO employee(username) VALUES (NEW.username);
    END IF;
END$

-- --------------------------------------------- --
-- ---------------PROCEDURES-------------------- --
-- --------------------------------------------- --

DROP PROCEDURE IF EXISTS add_user;
DELIMITER $
CREATE PROCEDURE add_user
(IN inpUsername VARCHAR(12), IN inpPassword VARCHAR(10), IN inpName VARCHAR(25), IN inpSurname VARCHAR(35), IN inpEmail VARCHAR(30), IN inpUser_type VARCHAR(10))
BEGIN
 	
        INSERT INTO system_user (username,password,name,surname,email,user_type)
        VALUES (inpUsername, inpPassword,inpName,inpSurname,inpEmail,inpUser_type);
   
END$
DELIMITER ;



DROP PROCEDURE IF EXISTS identify_user;
DELIMITER $
CREATE PROCEDURE identify_user 
(IN inpUsername VARCHAR(12), IN inpPassword VARCHAR(10))
BEGIN
    SELECT * FROM system_user WHERE username = inpUsername AND password = inpPassword;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS show_companies;
DELIMITER $
CREATE PROCEDURE show_companies() 
BEGIN 
    SELECT * FROM company ORDER BY name; 
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS manager_info;
DELIMITER $
CREATE PROCEDURE manager_info
(IN username VARCHAR(12), IN managerCompany VARCHAR(35), IN managerExperience TINYINT(4))
BEGIN
    UPDATE manager SET exp_years = managerExperience
    WHERE managerUsername = username;
    
	SET @companyAFM = (SELECT AFM FROM company
    WHERE name = managerCompany);
    
    UPDATE manager SET firm = @companyAFM 
    WHERE  managerUsername = username;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS get_user;
DELIMITER $
CREATE PROCEDURE get_user (IN user VARCHAR(12))
BEGIN   
    SELECT * FROM system_user WHERE user = username;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS increment_login;
DELIMITER $
CREATE PROCEDURE increment_login(IN user VARCHAR(12))
BEGIN
    SELECT timesLoggedIn FROM system_user WHERE username= user;
    UPDATE system_user SET timesLoggedIn = timesLoggedIn +1 WHERE username = user;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_company;
DELIMITER $
CREATE PROCEDURE get_company(IN username VARCHAR(12))
BEGIN   
    SET @managerFirm = (SELECT firm FROM manager WHERE username = managerUsername);
    SELECT * FROM company WHERE AFM = @managerFirm;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_email;
DELIMITER $
CREATE PROCEDURE get_company(IN usrnm VARCHAR(12))
BEGIN   
    SELECT email FROM system_user WHERE usrnm = username;
END$
DELIMITER ;

-- 000000000000000000000000000000000
DROP PROCEDURE IF EXISTS new_company_phone;
DELIMITER $
CREATE PROCEDURE new_company_phone(IN c_name VARCHAR(35),IN new_phone BIGINT(16))
BEGIN   
    UPDATE company SET phone = new_phone WHERE c_name =name;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS new_company_street;
DELIMITER $
CREATE PROCEDURE new_company_street(IN c_name VARCHAR(35),IN new_street VARCHAR(15))
BEGIN   
    UPDATE company SET street = new_street WHERE c_name =name;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS new_company_street_num;
DELIMITER $
CREATE PROCEDURE new_company_street_num(IN c_name VARCHAR(35),IN new_street_num TINYINT(4))
BEGIN   
    UPDATE company SET num = new_street_num WHERE c_name =name;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS new_company_city;
DELIMITER $
CREATE PROCEDURE new_company_city(IN c_name VARCHAR(35),IN new_city VARCHAR(15))
BEGIN   
    UPDATE company SET city = new_city WHERE c_name =name;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS new_company_country;
DELIMITER $
CREATE PROCEDURE new_company_country(IN c_name VARCHAR(35),IN new_country VARCHAR(15))
BEGIN   
    UPDATE company SET country = new_country WHERE c_name =name;
END$
DELIMITER ;

