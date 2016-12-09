--Rebuild ROOT schema over network link
--Must run job as system user
--Must create database link to FMS as system user
--EXECUTE IMMEDIATE 'CREATE DATABASE LINK FMS.UMICH CONNECT TO ROOT IDENTIFIED BY ******** USING 'FMS.UMICH'';

declare
  H1 NUMBER;
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
  EXECUTE IMMEDIATE 'drop user root cascade';
  h1 := dbms_datapump.open(operation=>'IMPORT', JOB_MODE=>'SCHEMA', REMOTE_LINK=>'FMS.UMICH', job_name => 'Test_Ref', VERSION=>'COMPATIBLE');
  dbms_datapump.metadata_filter(handle=>h1, NAME=>'SCHEMA_LIST', VALUE=>'''ROOT''');
  DBMS_DATAPUMP.SET_PARALLEL(HANDLE => H1, DEGREE => 12);
  DBMS_DATAPUMP.ADD_FILE(HANDLE => H1, FILENAME => 'impFMSr.log', DIRECTORY => 'EXP_DIR', FILETYPE => 3);
  DBMS_DATAPUMP.SET_PARAMETER(HANDLE => H1, NAME => 'FLASHBACK_SCN', VALUE => DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER);
  
--  DBMS_DATAPUMP.SET_PARAMETER(HANDLE => H1, NAME => 'TABLE_EXISTS_ACTION', VALUE => 'truncate');
--  DBMS_DATAPUMP.METADATA_FILTER (HANDLE => H1, NAME => 'NAME_EXPR', VALUE => '!=' 'RVIEW_CHARTCOM_CONV''', OBJECT_TYPE => 'TABLE');
--  DBMS_DATAPUMP.METADATA_FILTER(HANDLE => h1,name =>'NAME_EXPR',value =>'IN(''RVIEW_CHARTCOM_CONV'',''RVIEW_IT_MARKETSITE'')',object_type => 'VIEW');
-- DBMS_DATAPUMP.METADATA_TRANSFORM ( H1, 'STORAGE' , 0 , NULL ) ;

  DBMS_DATAPUMP.START_JOB(H1);
  dbms_output.put_line ('Started job ' || ' with handle: ' || H1);
  exception
      WHEN OTHERS THEN
       IF SQLCODE = DBMS_DATAPUMP.SUCCESS_WITH_INFO_NUM
       then 
          DBMS_OUTPUT.PUT_LINE('Data Pump job started with info available:');
          dbms_datapump.get_status(h1,
                                   dbms_datapump.ku$_status_job_error,0,
                                   job_state,sts);
          if (bitand(sts.mask,dbms_datapump.ku$_status_job_error) != 0)
          then
            le := sts.error;
            if le is not null
            then
              ind := le.FIRST;
              while ind is not null loop
                dbms_output.put_line(le(ind).LogText);
                ind := le.NEXT(ind);
              end loop;
            end if;
          end if;
        else
          raise;
        END IF;
--  END; 

 percent_done := 0;
  job_state := 'UNDEFINED';
  while (job_state != 'COMPLETED') and (job_state != 'STOPPED') loop
    dbms_datapump.get_status(h1,
           dbms_datapump.ku$_status_job_error +
           dbms_datapump.ku$_status_job_status +
           dbms_datapump.ku$_status_wip,-1,job_state,sts);
    JS := STS.JOB_STATUS;
-- If the percentage done has changed, display the new value.
     if js.percent_done != percent_done
    then
      dbms_output.put_line('*** Job percent done = ' ||
                           to_char(js.percent_done));
      percent_done := js.percent_done;
    end if;
-- Display any work-in-progress (WIP) or error messages that were received for
-- the job.
      if (bitand(sts.mask,dbms_datapump.ku$_status_wip) != 0)
    then
      le := sts.wip;
    else
      if (bitand(sts.mask,dbms_datapump.ku$_status_job_error) != 0)
      then
        le := sts.error;
      else
        le := null;
      end if;
    end if;
    if le is not null
    then
      ind := le.FIRST;
      while ind is not null loop
        dbms_output.put_line(le(ind).LogText);
        ind := le.NEXT(ind);
      end loop;
    end if;
  end loop;
-- Indicate that the job finished and detach from it.
  dbms_output.put_line('Job has completed');
  DBMS_OUTPUT.PUT_LINE('Final job state = ' || JOB_STATE);
  DBMS_DATAPUMP.DETACH(H1);  
  
  EXECUTE IMMEDIATE 'alter user root identified by "GG287!40" account unlock';
  EXECUTE IMMEDIATE 'CREATE DATABASE LINK FMS.UMICH CONNECT TO ROOT IDENTIFIED BY HU6rEbRu USING 'FMS.UMICH'';
  EXECUTE IMMEDIATE 'CREATE DATABASE LINK MARKETSITE.UMICH CONNECT TO RMTPLANT_FINQA911 IDENTIFIED BY asdfui45 USING 'FINQA91.WORLD'';
  EXECUTE IMMEDIATE 'DROP DATABASE LINK M_PO_STAT.BF.UMICH.EDU';
  EXECUTE IMMEDIATE 'CREATE DATABASE LINK M_PO_STAT.BF.UMICH.EDU CONNECT TO RMTPLANT_FINQA912 IDENTIFIED BY j64tyl51 USING 'finqa91.world'';
 
 END;
/