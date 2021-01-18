DROP PROCEDURE IF EXISTS add_user;
DELIMITER $
CREATE PROCEDURE add_user
(IN inpUsername VARCHAR(12), IN inpPassword VARCHAR(10), IN inpName VARCHAR(25), IN inpSurname VARCHAR(35), IN inpEmail VARCHAR(30), IN inpUser_type VARCHAR(10))
BEGIN
	INSERT INTO system_user (username,password,name,surname,email,user_type)
    VALUES (inpUsername, inpPassword,inpName,inpSurname,inpEmail,inpUser_type);
END$