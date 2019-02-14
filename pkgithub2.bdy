CREATE OR REPLACE PACKAGE BODY github2 IS

  /*******************************************************************************
  
   Module Name : 
   File Name   : 
   Schema      : 
   Description :
  
   Change History:
   ===============
  
   Date         Author        Reference     Description
   ----------   -----------   -----------   --------------------------------------
   17/09/2018   XXXXX         Created
  
  *******************************************************************************/

  -------------------------------------------------------------------------------
  -- ** PRIVATE TYPE DECLARATIONS ***********************************************
  -------------------------------------------------------------------------------

  -------------------------------------------------------------------------------
  -- ** PRIVATE CONSTANT DECLARATIONS *******************************************
  -------------------------------------------------------------------------------

  -------------------------------------------------------------------------------
  -- ** PRIVATE VARIABLE DECLARATIONS *******************************************
  -------------------------------------------------------------------------------

  -------------------------------------------------------------------------------
  -- ** PRIVATE PROCEDURES/FUNCTIONS IMPLEMENTATIONS ****************************
  -------------------------------------------------------------------------------

  -------------------------------------------------------------------------------
  -- ** PUBLIC PROCEDURES/FUNCTIONS IMPLEMENTATIONS ****************************
  -------------------------------------------------------------------------------

  FUNCTION number_of_invalid_objects RETURN PLS_INTEGER AS
  
    CURSOR cur_invalid_objects IS
      SELECT COUNT(*)
      FROM   all_objects
      WHERE  (owner LIKE '%GITHUB' OR owner = 'GITHUB')
      AND    status = 'INVALID'
      AND    object_type <> 'SYNONYM';
  
    l_return PLS_INTEGER := 0;
  
  BEGIN
  
    OPEN cur_invalid_objects;
    FETCH cur_invalid_objects
      INTO l_return;
    CLOSE cur_invalid_objects;
  
    RETURN l_return;
  
  END number_of_invalid_objects;

  PROCEDURE compile_all_schemas AS
  
    CURSOR cur_object IS
      SELECT DISTINCT owner
      FROM   all_objects
      WHERE  (owner LIKE '%GITHUB' OR owner = 'GITHUB')
      AND    status = 'INVALID'
      AND    object_type <> 'SYNONYM';
  
  BEGIN
  
    FOR rec_object IN cur_object LOOP
      dbms_output.put_line(rec_object.owner);
      dbms_utility.compile_schema(SCHEMA      => rec_object.owner
                                 ,compile_all => FALSE);
    END LOOP;
  
  END compile_all_schemas;

  PROCEDURE add_github(ip_1 IN sonarqube.col1%TYPE
                      ,ip_2 sonarqube.col2%TYPE
                      ,ip_3 IN sonarqube.col3%TYPE
                      ,ip_4 IN sonarqube.col4%TYPE
                       --,ip_deployed_datetime IN DATE
                      ,ip_5 IN sonarqube.col5%TYPE
                      ,ip_6 IN sonarqube.col6%TYPE
                       --,op_deh_sid      OUT deployments.sid%TYPE
                       ) AS
  BEGIN
  
    INSERT INTO github
      (col1
      ,col2
      ,col3
      ,col4
      ,col5
      ,col6
      ,col7
      ,col8)
    VALUES
      (seq.nextval
      ,ip_1
      ,ip_2
      ,ip_3
      ,ip_4
      ,SYSDATE
      ,ip_5
      ,ip_6);
  
    COMMIT;
  
  END add_github;

  PROCEDURE add_github_details( --ip_1           IN NUMBER
                               --,
                               ip_2 IN sonarqube.col1%TYPE
                              ,ip_3 IN sonarqube.col2%TYPE
                              ,ip_4 IN sonarqube.col3%TYPE
                              ,ip_5 IN sonarqube.col4%TYPE) AS
  
    l_sq_sid sonarqube.sid%TYPE;
  
  BEGIN
  
    SELECT MAX(sid)
    INTO   l_sq_sid
    FROM   sonarqube;
  
    INSERT INTO github_details
      (col1
      ,col2
      ,col3
      ,col4
      ,col5
      ,col6)
    VALUES
      (sq_seq.nextval
      ,l_sq_sid
      ,ip_1
      ,ip_2
      ,ip_3
      ,ip_4);
  
    COMMIT;
  
  END add_github_details;

  FUNCTION github_is_successful(ip_1 github.col1%TYPE
                               ,ip_2 github.col2%TYPE
                               ,ip_3 github.col3%TYPE
                               ,ip_4 github.col4%TYPE
                               ,ip_5 github.col5%TYPE) RETURN BOOLEAN AS
  BEGIN
    RETURN NULL;
  END github_is_successful;

BEGIN
  NULL;
END github2;
/
show err
