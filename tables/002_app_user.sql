CREATE TABLE APP_USER (
                          ID           NUMBER PRIMARY KEY,
                          USERNAME     VARCHAR2(100) NOT NULL,
                          FULL_NAME    VARCHAR2(200),
                          EMAIL        VARCHAR2(200),
                          DEPT_ID      NUMBER,
                          STATUS       NUMBER(1) DEFAULT 1,
                          CREATE_TIME  TIMESTAMP DEFAULT SYSTIMESTAMP,
                          UPDATE_TIME  TIMESTAMP,

                          CONSTRAINT FK_APP_USER_DEPARTMENT
                              FOREIGN KEY (DEPT_ID)
                                  REFERENCES DEPARTMENT(ID)
);

CREATE UNIQUE INDEX UK_APP_USER_USERNAME
    ON APP_USER(USERNAME);