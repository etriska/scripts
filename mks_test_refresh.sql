--create database link FMS.UMICH connect to ROOT identified by ******* using 'FMS.UMICH';
DROP TABLE PAP_EPROREQS_FINPROD;
CREATE TABLE PAP_EPROREQS_FINPROD ( 
BUSINESS_UNIT VARCHAR2(5) NOT NULL, 
PO_ID VARCHAR2(10)NOT NULL, 
BUDGET_HDR_STATUS VARCHAR2(1)NOT NULL, 
REQ_ID VARCHAR2(10)NOT NULL, 
BUDGET_STATUS VARCHAR2(1)NOT NULL, 
PO_STATUS VARCHAR2(2)NOT NULL, 
REQ_DT DATE NOT NULL, 
PO_DT DATE NOT NULL, 
DATETIME_DISPATCH TIMESTAMP(6), 
VENDOR_ID VARCHAR2(10) NOT NULL, 
ORIGIN VARCHAR2(3) NOT NULL, 
LINE_NBR NUMBER NOT NULL, 
ITM_ID_VNDR VARCHAR2(50) NOT NULL,
UNIT_OF_MEASURE VARCHAR2(3) NOT NULL, 
CATEGORY_CD VARCHAR2(18) NOT NULL, 
M_PR_USEREF VARCHAR2(30) NOT NULL, 
ADDRESS_SEQ_NUM NUMBER NOT NULL, 
DESCR254_MIXED VARCHAR2(254) NOT NULL, 
SHIPTO_ID VARCHAR2(10) NOT NULL, 
SUT_BASE_ID VARCHAR2(10) NOT NULL, 
QTY_PO NUMBER(15,4) NOT NULL, 
MERCHANDISE_AMT NUMBER(26,3) NOT NULL, 
REQUESTOR_ID VARCHAR2(30) NOT NULL, 
OPRID_ENTERED_BY VARCHAR2(30) NOT NULL,
ACCOUNT VARCHAR2(10) NOT NULL, 
FUND_CODE VARCHAR2(5) NOT NULL, 
DEPTID VARCHAR2(10) NOT NULL, 
PROGRAM_CODE VARCHAR2(5) NOT NULL, 
CLASS_FLD VARCHAR2(5) NOT NULL, 
PROJECT_ID VARCHAR2(15) NOT NULL,
COMMENTS_2000 VARCHAR2(4000));

DECLARE
CURSOR C IS
SELECT BUSINESS_UNIT, PO_ID, BUDGET_HDR_STATUS, REQ_ID, BUDGET_STATUS, PO_STATUS, REQ_DT, PO_DT, DATETIME_DISPATCH, 
  VENDOR_ID, ORIGIN, LINE_NBR, ITM_ID_VNDR, UNIT_OF_MEASURE, CATEGORY_CD, M_PR_USEREF, ADDRESS_SEQ_NUM, DESCR254_MIXED, 
  SHIPTO_ID, SUT_BASE_ID, QTY_PO, MERCHANDISE_AMT, REQUESTOR_ID, OPRID_ENTERED_BY, ACCOUNT, FUND_CODE, DEPTID, PROGRAM_CODE, 
  CLASS_FLD, PROJECT_ID, COMMENTS_2000
from RVIEW_IT_MARKETSITE@FMS.UMICH
WHERE PO_DT >= '01-JAN-11';
RC C%ROWTYPE;

BEGIN

IF NOT C%ISOPEN THEN OPEN C;
END IF;
LOOP
FETCH C INTO RC;
EXIT WHEN C%NOTFOUND;
INSERT INTO PAP_EPROREQS_FINPROD
(BUSINESS_UNIT, PO_ID, BUDGET_HDR_STATUS, REQ_ID, BUDGET_STATUS, PO_STATUS, REQ_DT, PO_DT, DATETIME_DISPATCH,
  VENDOR_ID, ORIGIN, LINE_NBR, ITM_ID_VNDR, UNIT_OF_MEASURE, CATEGORY_CD, M_PR_USEREF, ADDRESS_SEQ_NUM, DESCR254_MIXED, 
  SHIPTO_ID, SUT_BASE_ID, QTY_PO, MERCHANDISE_AMT, REQUESTOR_ID, OPRID_ENTERED_BY, ACCOUNT, FUND_CODE, DEPTID, 
  PROGRAM_CODE, CLASS_FLD, PROJECT_ID, COMMENTS_2000)
VALUES
(RC.BUSINESS_UNIT, RC.PO_ID, RC.BUDGET_HDR_STATUS, RC.REQ_ID, RC.BUDGET_STATUS, RC.PO_STATUS, RC.REQ_DT, RC.PO_DT, 
  RC.DATETIME_DISPATCH, RC.VENDOR_ID, RC.ORIGIN, RC.LINE_NBR, RC.ITM_ID_VNDR, RC.UNIT_OF_MEASURE, RC.CATEGORY_CD, RC.M_PR_USEREF,
  RC.ADDRESS_SEQ_NUM, RC.DESCR254_MIXED, RC.SHIPTO_ID, RC.SUT_BASE_ID, RC.QTY_PO, RC.MERCHANDISE_AMT, RC.REQUESTOR_ID,
  RC.OPRID_ENTERED_BY, RC.account, RC.FUND_CODE, RC.DEPTID, RC.PROGRAM_CODE, RC.CLASS_FLD, RC.PROJECT_ID, RC.COMMENTS_2000);
END LOOP;
CLOSE C;
COMMIT;
END;
