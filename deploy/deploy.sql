WHENEVER SQLERROR EXIT SQL.SQLCODE;

SET DEFINE OFF;
SET SERVEROUTPUT ON;
SET FEEDBACK ON;

PROMPT ==========================================
PROMPT START ORACLE DEPLOY
PROMPT ==========================================


PROMPT
PROMPT ===== TABLES =====
PROMPT

@@../tables/001_department.sql
@@../tables/002_app_user.sql


PROMPT
PROMPT ===== SEQUENCES =====
PROMPT

@@../sequences/001_seq_app_user.sql


PROMPT
PROMPT ===== VIEWS =====
PROMPT

@@../views/vw_app_user.sql
@@../views/vv_active_user.sql


PROMPT
PROMPT ===== FUNCTIONS =====
PROMPT

@@../functions/fn_get_user_name.sql


PROMPT
PROMPT ===== PROCEDURES =====
PROMPT

@@../procedures/pr_update_user_email.sql


PROMPT
PROMPT ===== PACKAGE SPEC =====
PROMPT

@@../packages/pkg_user_spec.sql


PROMPT
PROMPT ===== PACKAGE BODY =====
PROMPT

@@../packages/pkg_user_body.sql


PROMPT
PROMPT ==========================================
PROMPT CHECK INVALID OBJECTS
PROMPT ==========================================

COLUMN OBJECT_NAME FORMAT A40
COLUMN OBJECT_TYPE FORMAT A20
COLUMN STATUS FORMAT A10

SELECT
    OBJECT_NAME,
    OBJECT_TYPE,
    STATUS
FROM USER_OBJECTS
WHERE STATUS = 'INVALID'
ORDER BY OBJECT_TYPE, OBJECT_NAME;


PROMPT
PROMPT ==========================================
PROMPT COMPILE ERRORS
PROMPT ==========================================

COLUMN NAME FORMAT A40
COLUMN TYPE FORMAT A20
COLUMN TEXT FORMAT A100

SELECT
    NAME,
    TYPE,
    LINE,
    POSITION,
    TEXT
FROM USER_ERRORS
ORDER BY NAME, SEQUENCE;


PROMPT
PROMPT ==========================================
PROMPT VALIDATE DEPLOY
PROMPT ==========================================

DECLARE
V_COUNT NUMBER;
BEGIN

SELECT COUNT(*)
INTO V_COUNT
FROM USER_OBJECTS
WHERE STATUS = 'INVALID'
  AND OBJECT_TYPE IN (
                      'VIEW',
                      'FUNCTION',
                      'PROCEDURE',
                      'PACKAGE',
                      'PACKAGE BODY',
                      'TRIGGER'
    );

IF V_COUNT > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20099,
            'DEPLOY FAILED. INVALID OBJECT COUNT = ' || V_COUNT
        );
END IF;

END;
/

COMMIT;

PROMPT
PROMPT ==========================================
PROMPT DEPLOY SUCCESS
PROMPT ==========================================

EXIT;