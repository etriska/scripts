--Rebuild ROOT schema over network link
--Must run job as system user
--Must create database link to FMS as system user
--EXECUTE IMMEDIATE 'CREATE DATABASE LINK FMS.UMICH CONNECT TO ROOT IDENTIFIED BY ******** USING 'FMS.UMICH'';

DECLARE
  H1 NUMBER;               -- Datapump Handle
  job_state VARCHAR2(30);  -- To keep track of job state
  STS KU$_STATUS;          -- The status object returned by get_status
  le ku$_LogEntry;         -- For WIP and error messages
  JS KU$_JOBSTATUS;        -- The job status from get_status
  JD KU$_JOBDESC;          -- The job description from get_status
  PERCENT_DONE NUMBER;     -- Percentage of job complete
  ind NUMBER;              -- Loop index
  SPOS NUMBER;             -- String starting position
  slen NUMBER;             -- String length for output
  
BEGIN
--  EXECUTE IMMEDIATE 'drop user root cascade';
  H1 := DBMS_DATAPUMP.OPEN(OPERATION=>'IMPORT', JOB_MODE=>'SCHEMA', REMOTE_LINK=>'FMS.UMICH', JOB_NAME=> 'Root_Schema_Ref', VERSION=>'COMPATIBLE');
  DBMS_DATAPUMP.METADATA_FILTER(HANDLE=>H1, NAME=>'SCHEMA_LIST', VALUE=>'''ROOT''');
--  DBMS_DATAPUMP.SET_PARALLEL(HANDLE => H1, DEGREE => 12);
  DBMS_DATAPUMP.ADD_FILE(HANDLE => H1, FILENAME => 'impFMSr.log', DIRECTORY => 'EXP_DIR', FILETYPE => 3);
  DBMS_DATAPUMP.SET_PARAMETER(HANDLE => H1, NAME => 'FLASHBACK_SCN', VALUE => DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER);
  DBMS_DATAPUMP.SET_PARAMETER(HANDLE => H1, NAME => 'TABLE_EXISTS_ACTION', VALUE => 'append');
  DBMS_DATAPUMP.SET_PARAMETER(HANDLE => H1, NAME => 'INCLUDE_METADATA', VALUE => 0);
  DBMS_DATAPUMP.METADATA_FILTER(H1,'EXCLUDE_PATH_EXPR','in''INDEX','CONSTRAINT''');
--  dbms_datapump.metadata_filter(handle => H1, name => 'NAME_EXPR', value => '!=''RPT_WR0300''', object_path => 'TABLE'); 


--  DBMS_DATAPUMP.METADATA_FILTER (HANDLE => H1, NAME => 'NAME_EXPR', VALUE => '!=' 'RVIEW_CHARTCOM_CONV''', OBJECT_TYPE => 'TABLE');
--  DBMS_DATAPUMP.METADATA_FILTER(HANDLE => h1,name =>'NAME_EXPR',value =>'IN(''RVIEW_CHARTCOM_CONV'',''RVIEW_IT_MARKETSITE'')',object_type => 'VIEW');
--  DBMS_DATAPUMP.METADATA_TRANSFORM ( H1, 'STORAGE' , 0 , NULL ) ;

  DBMS_DATAPUMP.START_JOB(H1);
  DBMS_OUTPUT.PUT_LINE ('Started job ' || ' with handle: ' || H1);
  exception
      WHEN OTHERS THEN
       IF SQLCODE = DBMS_DATAPUMP.SUCCESS_WITH_INFO_NUM
       then 
          DBMS_OUTPUT.PUT_LINE('Data Pump job started with info available:');
          DBMS_DATAPUMP.GET_STATUS(H1, DBMS_DATAPUMP.KU$_STATUS_JOB_ERROR,0, JOB_STATE,STS);
          IF (BITAND(STS.MASK,DBMS_DATAPUMP.KU$_STATUS_JOB_ERROR) != 0)
          THEN
            LE := STS.ERROR;
            IF LE IS NOT NULL
            THEN
              IND := LE.FIRST;
              WHILE IND IS NOT NULL LOOP
                DBMS_OUTPUT.PUT_LINE(LE(IND).LOGTEXT);
                IND := LE.NEXT(IND);
              END LOOP;
            END IF;
          END IF;
        ELSE
          RAISE;
        END IF;
--  END; 

 PERCENT_DONE := 0;
  JOB_STATE := 'UNDEFINED';
  WHILE (JOB_STATE != 'COMPLETED') AND (JOB_STATE != 'STOPPED') LOOP
    DBMS_DATAPUMP.GET_STATUS(H1, DBMS_DATAPUMP.KU$_STATUS_JOB_ERROR + DBMS_DATAPUMP.KU$_STATUS_JOB_STATUS + DBMS_DATAPUMP.KU$_STATUS_WIP,-1,JOB_STATE,STS);
    JS := STS.JOB_STATUS;
-- If the percentage done has changed, display the new value.
     IF JS.PERCENT_DONE != PERCENT_DONE
    THEN
      DBMS_OUTPUT.PUT_LINE('*** Job percent done = ' || TO_CHAR(JS.PERCENT_DONE));
      PERCENT_DONE := JS.PERCENT_DONE;
    END IF;
-- Display any work-in-progress (WIP) or error messages that were received for the job.
      IF (BITAND(STS.MASK,DBMS_DATAPUMP.KU$_STATUS_WIP) != 0)
    THEN
      LE := STS.WIP;
    ELSE
      IF (BITAND(STS.MASK,DBMS_DATAPUMP.KU$_STATUS_JOB_ERROR) != 0)
      THEN
        LE := STS.ERROR;
      ELSE
        LE := NULL;
      END IF;
    END IF;
    IF LE IS NOT NULL
    THEN
      IND := LE.FIRST;
      WHILE IND IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(LE(IND).LOGTEXT);
        IND := LE.NEXT(IND);
      END LOOP;
    END IF;
  END LOOP;
-- Indicate that the job finished and detach from it.
  DBMS_OUTPUT.PUT_LINE('Job has completed');
  DBMS_OUTPUT.PUT_LINE('Final job state = ' || JOB_STATE);
  DBMS_DATAPUMP.DETACH(H1);
-- Change ROOT password to development password    
  EXECUTE IMMEDIATE 'alter user root identified by "GG287!40" account unlock';
  
--Need to execute these commands as the root user
--  connect root/GG287!40@test;
-- EXECUTE IMMEDIATE 'CREATE DATABASE LINK FMS.UMICH CONNECT TO ROOT IDENTIFIED BY HU6rEbRu USING 'FMS.UMICH'';
--  EXECUTE IMMEDIATE 'CREATE DATABASE LINK MARKETSITE.UMICH CONNECT TO RMTPLANT_FINQA911 IDENTIFIED BY asdfui45 USING 'FINQA91.WORLD'';
--  EXECUTE IMMEDIATE 'DROP DATABASE LINK M_PO_STAT.BF.UMICH.EDU';
--  EXECUTE IMMEDIATE 'CREATE DATABASE LINK M_PO_STAT.BF.UMICH.EDU CONNECT TO RMTPLANT_FINQA912 IDENTIFIED BY j64tyl51 USING 'finqa91.world'';
 
 END;
/