DECLARE
    V_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO V_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'APP_USER';

    IF V_COUNT = 0 THEN
        EXECUTE IMMEDIATE '
        CREATE TABLE APP_USER (
                                  ID          NUMBER PRIMARY KEY,
                                  USERNAME    VARCHAR2(100) NOT NULL,
                                  FULL_NAME   VARCHAR2(200),
                                  EMAIL       VARCHAR2(200),
                                  DEPT_ID     NUMBER,
                                  STATUS      NUMBER(1) DEFAULT 1,
                                  CREATE_TIME TIMESTAMP DEFAULT SYSTIMESTAMP,
                                  UPDATE_TIME TIMESTAMP,
                                  CONSTRAINT FK_APP_USER_DEPARTMENT
                                      FOREIGN KEY (DEPT_ID)
                                          REFERENCES DEPARTMENT(ID)
        )
        ';

        EXECUTE IMMEDIATE '
        CREATE UNIQUE INDEX UK_APP_USER_USERNAME
            ON APP_USER(USERNAME)
        ';

        DBMS_OUTPUT.PUT_LINE('Created table APP_USER');
    ELSE
        DBMS_OUTPUT.PUT_LINE('APP_USER already exists - skip');
    END IF;
END;
/