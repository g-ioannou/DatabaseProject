DROP DATABASE IF EXISTS staffevaluation;
CREATE DATABASE staffevaluation;
USE staffevaluation;

CREATE TABLE user (
    username VARCHAR(12) NOT NULL,
    password VARCHAR(10) NOT NULL,
    name VARCHAR(25) NOT NULL,
    surname VARCHAR(35) NOT NULL,
    email VARCHAR(30) NOT NULL,
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (username)
)ENGINE=INNODB;

CREATE TABLE evaluator(
    username VARCHAR(12),
    exp_years TINYINT(4),
    firm CHAR(9),
    FOREIGN KEY (username) REFERENCES user(username)
)ENGINE=INNODB;

