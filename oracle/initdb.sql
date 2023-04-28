CREATE USER EMIAS_SCHOOL IDENTIFIED BY EMIAS_SCHOOL
DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE TO EMIAS_SCHOOL;
GRANT EXECUTE ON DBMS_AQELM TO EMIAS_SCHOOL;
GRANT EXECUTE ON DBMS_AQIN TO EMIAS_SCHOOL;
GRANT CREATE DATABASE LINK TO EMIAS_SCHOOL;
GRANT CREATE ANY INDEX TO EMIAS_SCHOOL;
GRANT CREATE ANY JOB TO EMIAS_SCHOOL;