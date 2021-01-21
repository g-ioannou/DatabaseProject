-- ----------------------------------------------
-- ------------------TRIGGERS ------------------
-- ---------------------------------------------

-- -----------------MY TRIGGERS----------------- --
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

