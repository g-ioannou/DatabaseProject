-- --------------------------------------------- -
-- ---------------PROCEDURES-------------------- -
-- --------------------------------------------- -


DROP PROCEDURE IF EXISTS add_user;
DELIMITER $
CREATE PROCEDURE add_user
(IN inpUsername VARCHAR(12), IN inpPassword VARCHAR(10), IN inpName VARCHAR(25), IN inpSurname VARCHAR(35), IN inpEmail VARCHAR(30), IN inpUser_type VARCHAR(10))
BEGIN
	INSERT INTO system_user (username,password,name,surname,email,user_type)
    VALUES (inpUsername, inpPassword,inpName,inpSurname,inpEmail,inpUser_type);
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


