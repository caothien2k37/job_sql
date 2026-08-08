CREATE TABLE DEPARTMENT (
                            ID           NUMBER PRIMARY KEY,
                            DEPT_CODE    VARCHAR2(50) NOT NULL,
                            DEPT_NAME    VARCHAR2(200) NOT NULL,
                            IS_ACTIVE    NUMBER(1) DEFAULT 1,
                            CREATE_TIME  TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE UNIQUE INDEX UK_DEPARTMENT_CODE
    ON DEPARTMENT(DEPT_CODE);