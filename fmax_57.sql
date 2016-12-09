create or replace
PACKAGE fmax_57 AS
TYPE cr_cursor_lv0045 IS REF CURSOR RETURN rpt_lv0045%ROWTYPE;
PROCEDURE PROC_LV0045A(bdate DATE, edate DATE, jfam CHAR, esic BOOLEAN);
PROCEDURE proc_lv0045 (crystal_cursor0045 IN OUT cr_cursor_lv0045, Start_Date DATE, End_Date DATE, Job_Family CHAR, Extended_Sick BOOLEAN);

TYPE cr_cursor_wr0197 IS REF CURSOR RETURN rpt_wr0197%ROWTYPE;
PROCEDURE proc_wr0197(crystal_cursor0197 IN OUT cr_cursor_wr0197,req_proposal VARCHAR2,req_end_date DATE);
PROCEDURE proc_wr0197a (edate DATE);

TYPE cr_cursor_wr1291 IS REF CURSOR RETURN rpt_wr1291%ROWTYPE;
PROCEDURE proc_wr1291(crystal_cursor1291 IN OUT cr_cursor_wr1291,Work_Request VARCHAR2);
PROCEDURE proc_wr1291A(chrProposal_arg VARCHAR2);

TYPE cr_cursor_wr1312 IS REF CURSOR RETURN rpt_wr1312%ROWTYPE;
PROCEDURE proc_wr1312(crystal_cursor1312 IN OUT cr_cursor_wr1312,datBeg_date_arg DATE,datEnd_date_arg DATE);
PROCEDURE proc_wr1312A(datBeg_date_arg DATE,datEnd_date_arg DATE);

TYPE cr_cursor_wr0198 IS REF CURSOR RETURN rpt_wr0198%ROWTYPE;
PROCEDURE proc_wr0198(crystal_cursor0198 IN OUT cr_cursor_wr0198,datBeg_date_arg VARCHAR2,datEnd_date_arg VARCHAR2);
PROCEDURE proc_wr0198A(datBeg_date_arg DATE,datEnd_date_arg DATE);

TYPE cr_cursor_wr0941 IS REF CURSOR RETURN um_wrlabmat%ROWTYPE;
PROCEDURE proc_wrlabmat(crystal_cursor IN OUT cr_cursor_wr0941,chrProposal_arg varchar2);
PROCEDURE proc_wrlabmat2 (chrProposal_arg VARCHAR2);
TYPE cr_cursor_wr0070 IS REF CURSOR RETURN um_wrlabmat%ROWTYPE;
PROCEDURE proc_wrlabmatMulti(crystal_cursor IN OUT cr_cursor_wr0070,Work_Orders varchar2);

TYPE cr_cursor_wrPhas IS REF CURSOR RETURN um_phases_back_from_complete%ROWTYPE;
PROCEDURE proc_PhasesBackFromComplete(crystal_cursor IN OUT fmax_57.cr_cursor_wrPhas);
PROCEDURE proc_PhasesBackFromCompleteA;

TYPE cr_cursor_lv0600 IS REF CURSOR RETURN um_consecutive_absence%ROWTYPE;
PROCEDURE proc_Lv0600(crystal_cursor IN OUT fmax_57.cr_cursor_lv0600,chrBegin_date_arg VARCHAR2,chrEnd_date_arg VARCHAR2);
PROCEDURE proc_lv0600A(datBegin_date_arg DATE,datEnd_date_arg DATE);
FUNCTION func_GetNextWorkingDay(chrShop_person_arg VARCHAR2,datAdj_arg DATE) RETURN DATE;

-- change 01/14/2009: retrieve next proposal
FUNCTION func_RetrieveNextProposal(chrProposal_arg VARCHAR2,numIndex_arg NUMBER) RETURN VARCHAR2;

PROCEDURE proc_wrlabmatDt(crystal_cursor IN OUT cr_cursor_wr0941,chrProposal_arg varchar2,datFrom_date_arg DATE,datTo_date_arg DATE);
PROCEDURE proc_wrlabmatDt2 (chrProposal_arg VARCHAR2,datFrom_date_arg DATE,datTo_date_arg DATE);

TYPE cr_cursor_hr0310 IS REF CURSOR RETURN um_emp_lev_bal%ROWTYPE;
PROCEDURE proc_hr0310(crystal_cursor IN OUT fmax_57.cr_cursor_hr0310);
PROCEDURE proc_SeasonReimb;

TYPE cur_cursor_tc_entry IS REF CURSOR RETURN um_tc_entry_time%ROWTYPE;
PROCEDURE proc_TCEntryTime(crystal_cursor IN OUT fmax_57.cur_cursor_tc_entry,Entry_date DATE);
PROCEDURE proc_TCEntryTimeA(datEntry_arg DATE);

TYPE cur_cursor_wr9000 IS REF CURSOR RETURN um_wr9000_rpt%ROWTYPE;
PROCEDURE proc_Wr9000A;

TYPE cur_cursor_wr9002 IS REF CURSOR RETURN um_wr9002_rpt%ROWTYPE;
PROCEDURE proc_Wr9002A;

TYPE cur_cursor_wr9004 IS REF CURSOR RETURN um_wr9004_rpt%ROWTYPE;
PROCEDURE proc_Wr9004A;

TYPE cur_cursor_wr9005 IS REF CURSOR RETURN um_wr9005_rpt%ROWTYPE;
PROCEDURE proc_WR9005A;

TYPE cur_cursor_wr9006 IS REF CURSOR RETURN um_wr9006_rpt%ROWTYPE;
PROCEDURE proc_WR9006A;

TYPE cur_cursor_wr9007 IS REF CURSOR RETURN um_wr9007_rpt%ROWTYPE;
PROCEDURE proc_WR9007A;

PROCEDURE proc_HousingRpts;
END fmax_57;

create or replace
PACKAGE BODY fmax_57 AS

PROCEDURE proc_lv0045 (crystal_cursor0045 IN OUT cr_cursor_lv0045, Start_Date
DATE, End_Date DATE, Job_Family CHAR, Extended_Sick BOOLEAN) AS
BEGIN
  DELETE FROM rpt_lv0045;
  COMMIT;
  proc_lv0045a (Start_date, End_Date, Job_Family, Extended_Sick);
  OPEN crystal_cursor0045 FOR SELECT * FROM rpt_lv0045;
END proc_lv0045;

PROCEDURE PROC_LV0045A(bdate DATE, edate DATE, jfam CHAR, esic BOOLEAN) IS
  shop VARCHAR2(15);
  shopstr VARCHAR2(60);
  shopval NUMBER(10,3);
  shopper VARCHAR2(15);
  shoppers NUMBER(10);
  shoplev NUMBER(10,3);
  shoplevtot NUMBER(10,3);
  shoplevexc NUMBER(10,3);
  shoppertot NUMBER(10);
  shopperlev NUMBER(10,3);
  shopperlevexc NUMBER(10,3);

--ch1: single count of employee in a shop
CURSOR curRpt_lv0045 IS
	SELECT SUBSTR(shop,1,5),shophrs
		FROM rpt_lv0045;
-- variables for cursor
numShop_persons	NUMBER;
chrShop		VARCHAR2(5);
numShop_hrs	NUMBER(10,3);
-- end ch1
numCount	NUMBER;
BEGIN
-- Initialize variables
  shop := '     ';
  shopstr := ' ';
  shopval := 0;
  shopper := '    ';
  shoplev := 0;
  shoplevtot := 0;
  shoplevexc := 0;
  shoppers := 0;
  shoppertot := 0;
  shopperlev := 0;
  shopperlevexc := 0;

-- Main query
  FOR shop_shopperrec IN (
	SELECT AE_L_SHP_D.SHOP HSHOP,AE_L_SHP_D.SHOP_PERSON,
		AE_H_LEV_D.LEV_CODE,AE_H_LEV_D.LEV_ADJ,
		(CASE WHEN tc_trans_no IS NULL THEN AE_H_LEV_D.ADJ_DATE
		ELSE (SELECT sched_date FROM ae_p_wka_e a,ae_p_wka_d b
		WHERE b.trans_no=ae_h_lev_d.tc_trans_no AND item_no=ae_h_lev_d.tc_item_no
		AND a.trans_no=b.trans_no AND lev_code IS NOT NULL)
		END) ADJ_DATE,
--ae_h_lev_d.adj_date,
		AE_H_LEV_D.LEV_CLASS,
		AE_L_SHP_D.DATE_FROM,AE_L_SHP_D.DATE_TO,
		AE_L_SHP_E.SHOP THESHOP,AE_L_SHP_E.DESCRIPTION SHOP_DESC,
		AE_H_EMP_E.LNAME,AE_H_EMP_E.FNAME
		FROM	ROOT.AE_L_SHP_D AE_L_SHP_D,ROOT.AE_H_EMP_E AE_H_EMP_E,
			ROOT.AE_L_SHP_E AE_L_SHP_E,ROOT.AE_H_JOB_E AE_H_JOB_E,
			ROOT.AE_H_LEV_D AE_H_LEV_D,root.ae_h_emp_pos_data
		WHERE  AE_L_SHP_D.SHOP_PERSON=AE_H_EMP_E.SHOP_PERSON
		AND ae_h_emp_e.shop_person=ae_h_emp_pos_data.shop_person
		AND (AE_L_SHP_D.SHOP=AE_L_SHP_E.SHOP)
		AND (AE_H_EMP_POS_DATA.JOB_FAM=AE_H_JOB_E.JOB_FAM)
		AND (AE_H_EMP_E.SHOP_PERSON=AE_H_LEV_D.SHOP_PERSON (+))
		AND (AE_L_SHP_D.SHOP LIKE 'G%'
			OR AE_L_SHP_D.SHOP LIKE 'M%'
			OR AE_L_SHP_D.SHOP LIKE 'R%'
			OR AE_L_SHP_D.SHOP LIKE 'U%')
		AND (AE_L_SHP_D.DATE_TO IS  NULL
			AND AE_L_SHP_D.DATE_FROM< edate
			OR AE_L_SHP_D.DATE_FROM< edate
	       		AND AE_L_SHP_D.DATE_TO>=bdate)
		AND ((SUBSTR("AE_H_JOB_E"."JOB_FAM", INSTR("AE_H_JOB_E"."JOB_FAM", jfam), 1))=jfam)
		AND AE_H_LEV_D.LEV_CODE IN('00002','00002COMP','00002HOSP','00003','00003COMP',
			'00003HOSP','00003PDENT','00003PMED','00009COMP','00009EXSIC','00016','00016COMP',
			'00016FCARE','00016HOSP','00016OPST','00016PDENT','00016PMED','00016PRESC',
			'00018','00200PDENT','00200PDT','00200PMED','00200SCOMP','00200SHOSP','00200SICK',
			'00201COMP','00201FMCP','00201SWOP','00220PDENT','00220PMED','00220SCOMP',
			'00220SHOSP','00220SICK','00221ECOMP','00221FMCP','00221SWOP')
		ORDER BY AE_L_SHP_D.SHOP ASC, AE_L_SHP_D.SHOP_PERSON ASC,
			AE_L_SHP_D.DATE_FROM ASC, ADJ_DATE ASC)
-- adj_date may come from Time Card tables
--			AE_L_SHP_D.DATE_FROM ASC, AE_H_LEV_D.ADJ_DATE ASC)
	LOOP
-- Define totals of leave hours and exemptions
-- In the following lines ignore computing of shopval. Modification labeled ch1 corrects/overrides it.
		IF shop = '     ' THEN
			shop := shop_shopperrec.theshop;
			shopstr := ltrim(rtrim(shop)) || ' - ' || shop_shopperrec.shop_desc;
			shopval := 0;
			shoplev := 0;
			shoplevexc := 0;
			shoppers := 0;
			shopperlev := 0;
			shopperlevexc := 0;
		END IF;

		IF substr(shop,1,5) <> substr(shop_shopperrec.theshop,1,5) THEN
-- New shop under process
			IF shoppers <> 0 THEN
				shoplev := shoplev + shopperlev - shoplevexc;
				shoplevtot := shoplevtot + shoplev;
				shopval := shoplev / shoppers;
			ELSE
				shopval := 0;
			END IF;

-- insert into output table, which will be retrieved by Crystal Reports.
		        INSERT INTO RPT_LV0045 (SHOP, SHOPPERS, SHOPHRS, SHOPDAYS, SHOPVAL)
				VALUES (shopstr, shoppers, shoplev, shoplev/8, shopval);

			shop := shop_shopperrec.theshop;
			shopstr := ltrim(rtrim(shop)) || ' - ' || shop_shopperrec.shop_desc;
			shopval := 0;
			shoplev := 0;
			shoplevexc := 0;
			shopper := '    ';
			shoppers := 0;
			shopperlev := 0;
			shopperlevexc := 0;
		END IF;

		IF (substr(shop,1,5) = substr(shop_shopperrec.theshop,1,5))
		AND (substr(shopper,1,4) <> substr(shop_shopperrec.shop_person,1,4)) THEN
-- Same shop, but different shop_person under process
-- So increase counters, update totals and initialize variables for that employee
			shopper := shop_shopperrec.shop_person;
			shoppers := shoppers + 1;
			shoppertot := shoppertot + 1;
			shoplev := shoplev + shopperlev - shoplevexc;
			shopperlev := 0;
			shopperlevexc := 0;
			shoplevexc := 0;
		END IF;

		IF (substr(shop,1,5) = substr(shop_shopperrec.theshop,1,5))
		AND (substr(shopper,1,4) = substr(shop_shopperrec.shop_person,1,4))
		AND (shop_shopperrec.adj_date >= bdate AND shop_shopperrec.adj_date <= edate) THEN
-- Same shop and employee. Processing of row having adj_date within time frame
			IF shop_shopperrec.lev_code = '00016FCARE'
			and shop_shopperrec.lev_class = '1S' then
				shopperlev := shopperlev;
			ELSE
				IF shop_shopperrec.lev_code IS NULL
				OR shop_shopperrec.lev_code = '' THEN
					shopperlev := shopperlev;
				ELSE
					shopperlev := shopperlev + (shop_shopperrec.lev_adj * -1);
				END IF;
			END IF;

			IF NOT (esic) THEN
-- Boolean parameter specified by user
				IF (SUBSTR(shop_shopperrec.lev_code, 7, 4) = 'COMP'
				OR SUBSTR(shop_shopperrec.lev_code, 7, 4) = 'XSIC'
				OR SUBSTR(shop_shopperrec.lev_code, 6, 4) = 'COMP') THEN
					shopperlevexc := shopperlevexc + (shop_shopperrec.lev_adj * -1);
					IF shopperlevexc >= 20 THEN
						shoplevexc := shopperlevexc;
					END IF;
				ELSE
					shopperlevexc := 0;
				END IF;
			END IF;
		END IF;
	END LOOP;

-- Define shopval, which meaning is average leave time for each particular shop,
-- but ch1 overrides/corrects this, since there was multiple count of employees
	IF shoppers <> 0 THEN
		shoplev := shoplev + shopperlev - shoplevexc;
		shoplevtot := shoplevtot + shoplev;
		shopval := shoplev / shoppers;
 	ELSE
-- to prevent division by zero
		shopval := 0;
	END IF;
	INSERT INTO RPT_LV0045 (SHOP, SHOPPERS, SHOPHRS, SHOPDAYS, SHOPVAL)
		VALUES (shopstr, shoppers, shoplev, shoplev/8, shopval);
-- ch1: single count of employee in a shop
	OPEN curRpt_lv0045;
	LOOP
		FETCH curRpt_lv0045 INTO chrShop,numShop_hrs;
		EXIT WHEN curRpt_lv0045%NOTFOUND;
-- ch2 begins: match with ae_h_emp_pos_data now that count of employees per shop
--		should be affected by job_family
		SELECT COUNT(DISTINCT(A.shop_person)) INTO numShop_persons
			FROM ae_l_shp_d A,ae_h_emp_pos_data B
			WHERE A.shop_person=B.shop_person
			AND B.job_fam=jfam
-- ch2 ends
			AND RTRIM(shop)=chrShop
			AND NVL(date_to,SYSDATE)>=bdate
			AND date_from<=edate;

-- Compute average leave time for each shop inserted into output table
		IF(numShop_persons>0) THEN
			UPDATE rpt_lv0045
				SET shoppers=numShop_persons,
--				shopval=shoplev/numShop_persons
				shopval=numShop_hrs/numShop_persons
				WHERE SUBSTR(shop,1,5)=chrShop;
		END IF;
	END LOOP;
	CLOSE curRpt_lv0045;
--end ch1


	shopstr := 'xTOTALS*';
	IF shoppertot <> 0 THEN
		shopval := shoplevtot / shoppertot;
 	ELSE
		shopval := 0;
 	END IF;
 	INSERT INTO RPT_LV0045 (SHOP, SHOPPERS, SHOPHRS, SHOPDAYS, SHOPVAL)
		VALUES (shopstr, shoppertot, shoplevtot, shoplevtot/8, shopval);
	COMMIT;
END proc_lv0045a;


PROCEDURE proc_wr0197(crystal_cursor0197 IN OUT cr_cursor_wr0197,req_proposal VARCHAR2,req_end_date DATE) IS
-- "Header" program that calls proc_wr0197A
idx INTEGER(5);
wrkreqs VARCHAR2(255);
wrkreq VARCHAR2(15);
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE rpt_wr0197a';
	EXECUTE IMMEDIATE 'TRUNCATE TABLE rpt_wr0197';
	wrkreqs := RTRIM(SUBSTR(req_proposal,1,255));
	idx := 1;
	WHILE idx = 1
	LOOP
		IF INSTR(wrkreqs, ',')-1 > 0 THEN
			wrkreq := TRIM(SUBSTR(wrkreqs, 1, INSTR(wrkreqs, ',') - 1));
			wrkreqs := TRIM(SUBSTR(wrkreqs, INSTR(wrkreqs, ',') + 1, LENGTH(TRIM(wrkreqs))));
			INSERT INTO rpt_wr0197a (work_request) VALUES (UPPER(wrkreq));
		ELSE
			wrkreq := TRIM(SUBSTR(wrkreqs, 1, 15));
			INSERT INTO rpt_wr0197a (work_request) VALUES (UPPER(wrkreq));
			wrkreqs := '';
			idx := 0;
		END IF;
	END LOOP;
	COMMIT;
	SELECT COUNT(*) INTO idx FROM rpt_wr0197a;
	IF (idx > 0) THEN
		proc_wr0197a(req_end_date);
	END IF;
	OPEN crystal_cursor0197 FOR
		SELECT * FROM rpt_wr0197;
END proc_wr0197;


-- rep0197a
-- On 11/12/2010 Default cost to wka_d.act_cost. If null, compute it using Labor Rate.
-- ALTER TABLE um_wr0197_temp ADD cost NUMBER(12,4);
-- Pending: Once the command above is run, find all "re-enable" and do as appropriate.
PROCEDURE proc_wr0197a (edate DATE) IS
CURSOR curWr0197_temp IS
	SELECT shop_person,labor_class,time_type,work_code,proposal,sched_date,
		uom,sort_code,cost
		FROM um_wr0197_temp;
chrShop_person		VARCHAR2(15);
chrLabor_class		VARCHAR2(15);
chrTime_type		VARCHAR2(15);
chrWork_code		VARCHAR2(25);
chrProposal		VARCHAR2(15);
datSched_date		DATE;
numUom			NUMBER(12,4);
chrSort_code		VARCHAR2(15);
numCost			NUMBER(12,4);
numLabor_rate		NUMBER(12,2);
chrFound		VARCHAR2(1);
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wr0197_temp';
	INSERT INTO um_wr0197_temp
		SELECT a.shop_person,b.labor_class,time_type,
			b.craft_code, b.proposal, a.sched_date, b.act_hrs, b.sort_code,
			b.act_cost
			FROM ae_p_wka_e a,ae_p_wka_d b
			WHERE a.trans_no=b.trans_no
			AND b.proposal IN (SELECT work_request FROM rpt_wr0197a)
			AND a.sched_date <= edate;
	COMMIT;
	OPEN curWr0197_temp;
	LOOP
		FETCH curWr0197_temp INTO chrShop_person,chrLabor_class,chrTime_type,
			chrWork_code,chrProposal,datSched_date,numUom,chrSort_code,
			numCost;
		EXIT WHEN curWr0197_temp%NOTFOUND;

		chrFound:='Y';
		BEGIN
			SELECT DISTINCT labor_rate INTO numLabor_rate
				FROM ae_l_man_d
				WHERE shop_person=chrShop_person
				AND labor_class=chrLabor_class
				AND time_type=chrTime_type
				AND TRUNC(start_date)<=datSched_date
				AND (end_date IS NULL OR end_date>=TRUNC(datSched_date));
		EXCEPTION WHEN TOO_MANY_ROWS THEN
dbms_output.put_line(chrShop_person||' '||chrLabor_class||' '||chrTime_type||' '||datSched_date);
numLabor_rate:=1/0;
			WHEN NO_DATA_FOUND THEN
				numLabor_rate:=0;
				chrFound:='N';
		END;
		IF(numLabor_rate=0 AND chrFound='N') THEN
			BEGIN
				SELECT DISTINCT labor_rate INTO numLabor_rate
					FROM ae_l_shp_c A,ae_h_emp_pos_data B,
					ae_p_phs_e C
					WHERE shop_person=chrShop_person
					AND proposal=chrProposal
					AND sort_code=chrSort_code
--					AND u_num=shop
					AND a.shop=c.shop
					AND A.job_class=b.job_class
					AND labor_class=chrLabor_class
					AND time_type=chrTime_type
					AND TRUNC(start_date)<=datSched_date
					AND (end_date IS NULL OR end_date>=TRUNC(datSched_date));
			EXCEPTION WHEN NO_DATA_FOUND THEN
				numLabor_rate:=0;
			END;
		END IF;
		INSERT INTO rpt_wr0197(work_code, proposal, rec_date, uom, sort_code,cost)
			VALUES(chrWork_code,chrProposal,datSched_date,
			numUom,chrSort_code,NVL(numCost,numUom*numLabor_rate));
	END LOOP;
	CLOSE curWr0197_temp;
UPDATE rpt_wr0197 set rec_type = 'L' WHERE rec_type IS NULL;

-- On 05/06/2010 Retrieve craft_code description directly from ae_x_cft_e linking to phs_e
--UPDATE rpt_wr0197 set rec_desc = (select description from v_ae_x_cft_e where work_code = craft_code);
UPDATE rpt_wr0197 set rec_desc = (select a.description from ae_x_cft_e a,ae_p_phs_e b
				WHERE b.proposal=rpt_wr0197.proposal
				AND b.sort_code=rpt_wr0197.sort_code
				AND work_code=a.craft_code
				AND a.category=b.category
				AND a.order_type=b.order_type
				);

INSERT INTO rpt_wr0197(work_code, proposal, rec_date, cost, sort_code)
select craft_code, proposal, trans_date, amount, sort_code
	from ae_i_ext_e
	where ae_i_ext_e.proposal IN (SELECT work_request FROM rpt_wr0197a)
	and (ae_i_ext_e.trans_date <= edate);
update rpt_wr0197 set shop = (select shop
				from ae_p_phs_e
				WHERE rpt_wr0197.proposal = ae_p_phs_e.proposal
				and rpt_wr0197.sort_code = ae_p_phs_e.sort_code)
	WHERE rec_type IS NULL;
update rpt_wr0197 set rec_type = 'M' WHERE rec_type IS NULL;

-- On 05/06/2010 Retrieve craft_code description directly from ae_x_cft_e linking to phs_e
--update rpt_wr0197 set rec_desc = (select description from v_ae_x_cft_e where work_code = craft_code);
UPDATE rpt_wr0197 set rec_desc = (select a.description from ae_x_cft_e a,ae_p_phs_e b
				WHERE b.proposal=rpt_wr0197.proposal
				AND b.sort_code=rpt_wr0197.sort_code
				AND work_code=a.craft_code
				AND a.category=b.category
				AND a.order_type=b.order_type
				);

insert into rpt_wr0197(work_code, proposal, rec_date, cost, sort_code, uom,trans_type)
select b.craft_code, proposal, a.trans_date, inv_cost, sort_code, trans_qty,
	(case when trans_qty<0 then 'INV RETURN' else 'INV RELEASE' end)
from ae_i_release_e a,ae_i_release_d b
where a.trans_num=b.trans_num
and proposal IN (SELECT work_request FROM rpt_wr0197a)
and TRUNC(trans_date)<= edate;

-- On 05/06/2010 Retrieve craft_code description directly from ae_x_cft_e linking to phs_e
--update rpt_wr0197 set rec_desc = (select description
--			from v_ae_x_cft_e where work_code = craft_code);
UPDATE rpt_wr0197 set rec_desc = (select a.description from ae_x_cft_e a,ae_p_phs_e b
				WHERE b.proposal=rpt_wr0197.proposal
				AND b.sort_code=rpt_wr0197.sort_code
				AND work_code=a.craft_code
				AND a.category=b.category
				AND a.order_type=b.order_type
				);

update rpt_wr0197 set shop = (select shop
					from ae_p_phs_e WHERE rpt_wr0197.proposal = ae_p_phs_e.proposal and rpt_wr0197.sort_code = ae_p_phs_e.sort_code)
	WHERE rec_type IS NULL;
--UPDATE rpt_wr0197
--	SET trans_type='INV RELEASE';
--UPDATE rpt_wr0197
--	SET trans_type='INV RETURN'
--	WHERE uom<0;
update rpt_wr0197
	set cost=-cost
	WHERE trans_type='INV RETURN';

update rpt_wr0197 set rec_type = 'A' WHERE rec_type IS NULL;
update rpt_wr0197 set cost = cost * -1 WHERE trans_type = 'INV RETURN';
-- fix 03/03/2009
	UPDATE rpt_wr0197
		SET shop=(SELECT shop
				FROM ae_p_phs_e
				WHERE proposal=rpt_wr0197.proposal
				AND sort_code=rpt_wr0197.sort_code
			)
		WHERE (proposal,sort_code) IN(SELECT proposal,sort_code
						FROM ae_p_phs_e
					)
		AND RTRIM(shop) IS NULL;
	UPDATE rpt_wr0197
		SET cost=ROUND(cost,2);
-- Per Mona on 04/20/2012: If cost is zero, users don't want to see the record on the report.
--	DELETE FROM rpt_wr0197
--		WHERE cost=0;
	COMMIT;
END proc_wr0197a;

-- change: 01/14/2009 parse chrProposal_arg, which now may contain multiple proposals
PROCEDURE proc_wr1291A(chrProposal_arg VARCHAR2) IS
-- Called by proc_wr1291. Populates output table
CURSOR curWr1291(chrProposal_cur VARCHAR2) IS
	SELECT "AE_P_WKA_E"."SCHED_DATE", "AE_P_WKA_D"."PROPOSAL",
		"AE_P_WKA_D"."CRAFT_CODE", "AE_P_WKA_D"."TIME_TYPE",
		"AE_P_WKA_D"."LABOR_CLASS", "AE_P_WKA_E"."SHOP_PERSON",
		"AE_P_WKA_D"."SORT_CODE", "RVIEW_EMP_NAME"."NAME", "AE_P_WKA_D"."ACT_HRS"
		FROM AE_P_WKA_D,RVIEW_EMP_NAME,AE_P_WKA_E
		WHERE ae_p_wka_d.proposal=chrProposal_cur
		AND ae_p_wka_d.trans_no=ae_p_wka_e.trans_no
		AND ae_p_wka_e.shop_person=rview_emp_name.shop_person
		ORDER BY "AE_P_WKA_E"."SHOP_PERSON", "AE_P_WKA_D"."PROPOSAL",
			"AE_P_WKA_D"."SORT_CODE";
-- variables for cursor curWr1291
datWr1291_sched_date	DATE;
chrWr1291_proposal	VARCHAR2(15);
	chrWr1291_shop		VARCHAR2(25);
chrWr1291_craft_code	VARCHAR2(25);
chrWr1291_time_type	VARCHAR2(15);
chrWr1291_labor_class	VARCHAR2(15);
chrWr1291_shop_person	VARCHAR2(15);
chrWr1291_sort_code	VARCHAR2(15);
chrWr1291_name		VARCHAR2(78);
numWr1291_act_hrs	NUMBER(12,4);
chrWr1291_description	VARCHAR2(255);

datLatest_start_date	DATE;
datEnd_date		DATE;
numLabor_rate		NUMBER(12,2);
chrProposal		VARCHAR2(15);
numIndex		NUMBER;
chrFound		VARCHAR2(1);
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE rpt_wr1291';
	numIndex:=1;
	LOOP
		chrProposal:=func_RetrieveNextProposal(chrProposal_arg,numIndex);
		IF(chrProposal IS NULL) THEN
			EXIT;
		END IF;
		numIndex:=numIndex+LENGTH(chrProposal)+1;
dbms_output.put_line(chrProposal||' '||numIndex);
		OPEN curWr1291(RTRIM(chrProposal));
		LOOP
			FETCH curWr1291 INTO datWr1291_sched_date,chrWr1291_proposal,
				chrWr1291_craft_code,chrWr1291_time_type,
				chrWr1291_labor_class,chrWr1291_shop_person,
				chrWr1291_sort_code,chrWr1291_name,numWr1291_act_hrs;
			EXIT WHEN curWr1291%NOTFOUND;

			BEGIN
				SELECT shop,description INTO chrWr1291_shop,chrWr1291_description
					FROM ae_p_phs_e
					WHERE proposal=chrWr1291_proposal
					AND sort_code=chrWr1291_sort_code;
			EXCEPTION WHEN NO_DATA_FOUND THEN
				chrWr1291_shop:='FFFF';
			END;
			IF(chrWr1291_shop NOT LIKE 'F%') THEN
-- Query latest start_date, towards retrieval of current labor rate
--				SELECT MAX(start_date) INTO datLatest_start_date
--					FROM ae_l_man_d
--					WHERE shop_person=chrWr1291_shop_person
--					AND labor_class=chrWr1291_labor_class
--					AND time_type=chrWr1291_time_type
--					AND TRUNC(start_date)<=datWr1291_sched_date;
--
---- Query corresponding end_date, towards retrieval of current labor rate
--				BEGIN
--					SELECT end_date INTO datEnd_date
--						FROM ae_l_man_d
--						WHERE shop_person=chrWr1291_shop_person
--						AND labor_class=chrWr1291_labor_class
--						AND time_type=chrWr1291_time_type
--						AND start_date=datLatest_start_date
--						AND end_date is not null;
--					EXCEPTION WHEN NO_DATA_FOUND THEN
--						datEnd_date:=NULL;
--				END;
--
---- Retrieval of current labor rate, based on start_date and end_date
--				IF(datEnd_date IS NULL) then
--					SELECT labor_rate INTO numLabor_rate
--						FROM ae_l_man_d
--						WHERE shop_person=chrWr1291_shop_person
--						AND labor_class=chrWr1291_labor_class
--						AND time_type=chrWr1291_time_type
--						AND start_date=datLatest_start_date
--						AND end_date IS NULL;
--				ELSE
--					SELECT labor_rate INTO numLabor_rate
--						FROM ae_l_man_d
--						WHERE shop_person=chrWr1291_shop_person
--						AND labor_class=chrWr1291_labor_class
--						AND time_type=chrWr1291_time_type
--						AND start_date=datLatest_start_date
--						AND end_date IS NOT NULL;
--				END IF;
-- Retrieval of current (or most up-to-date) current rate
				chrFound:='Y';
				BEGIN
					SELECT labor_rate,start_date,NVL(end_date,SYSDATE+365)
						INTO numLabor_rate,datLatest_start_date,datEnd_date
						FROM (SELECT labor_rate,start_date,end_date
							FROM ae_l_man_d
							WHERE shop_person=chrWr1291_shop_person
							AND labor_class=chrWr1291_labor_class
							AND time_type=chrWr1291_time_type
							AND TRUNC(start_date)<=datWr1291_sched_date
							AND (end_date IS NULL OR end_date>=datWr1291_sched_date)
							ORDER BY start_date DESC,end_date
							)
						WHERE rownum<2;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					numLabor_rate:=0;
					chrFound:='N';
				END;
				IF(numLabor_rate=0 and chrFound='N') THEN
					BEGIN
						SELECT labor_rate,start_date,NVL(end_date,SYSDATE+365)
							INTO numLabor_rate,datLatest_start_date,datEnd_date
							FROM (SELECT labor_rate,start_date,end_date
								FROM ae_l_shp_c A,ae_h_emp_pos_data B,
								ae_p_phs_e C
								WHERE shop_person=chrWr1291_shop_person
								AND proposal=chrWr1291_proposal
								AND sort_code=chrWr1291_sort_code
--								AND u_num=shop
								AND a.shop=c.shop
								AND A.job_class=B.job_class
								AND labor_class=chrWr1291_labor_class
								AND time_type=chrWr1291_time_type
								AND TRUNC(start_date)<=datWr1291_sched_date
								AND (end_date IS NULL OR end_date>=datWr1291_sched_date)
								ORDER BY start_date DESC,end_date
								)
							WHERE rownum<2;
					EXCEPTION WHEN NO_DATA_FOUND THEN
						numLabor_rate:=0;
					END;
				END IF;

--datWr1291_sched_date:=NVL(datEnd_date,SYSDATE);
-- insert into output table
				INSERT INTO rpt_wr1291
					VALUES(chrWr1291_proposal,chrWr1291_sort_code,
					chrWr1291_shop,chrWr1291_craft_code,datWr1291_sched_date,
					chrWr1291_time_type,chrWr1291_labor_class,chrWr1291_shop_person,
					chrWr1291_name,numWr1291_act_hrs,numLabor_rate,
					chrWr1291_description);
			END IF;
		END LOOP;
		CLOSE curWr1291;
	END LOOP;
	COMMIT;
END proc_wr1291A;

PROCEDURE proc_wr1291(crystal_cursor1291 IN OUT cr_cursor_wr1291,Work_Request VARCHAR2) IS
-- caller to proc_wr1291A
BEGIN
	fmax_57.proc_wr1291A(Work_Request);
	OPEN crystal_cursor1291 FOR
		SELECT * FROM rpt_wr1291;

END proc_wr1291;


PROCEDURE proc_wr1312A(datBeg_date_arg DATE,datEnd_date_arg DATE) IS
-- Called by proc_wr1312. Ppopulates output table
CURSOR curWr1312(datBeg_date_cur DATE,datEnd_date_cur DATE) IS
	SELECT "AE_P_WKA_E"."SCHED_DATE", "AE_P_WKA_D"."PROPOSAL", "AE_P_PHS_E"."SHOP",
		"AE_P_WKA_D"."CRAFT_CODE", "AE_P_WKA_D"."TIME_TYPE",
		"AE_P_WKA_D"."LABOR_CLASS", "AE_P_WKA_E"."SHOP_PERSON",
		"AE_P_WKA_D"."SORT_CODE", "RVIEW_EMP_NAME"."NAME", "AE_P_WKA_D"."ACT_HRS",
		"AE_P_PHS_E"."DESCRIPTION"
		FROM AE_P_WKA_D,RVIEW_EMP_NAME,AE_P_WKA_E,AE_P_PHS_E
		WHERE ae_p_wka_e.sched_date>=TRUNC(datBeg_date_cur)
		AND ae_p_wka_e.sched_date<TRUNC(datEnd_date_cur)+1
		AND ae_p_wka_e.trans_no=ae_p_wka_d.trans_no
		AND ae_p_wka_d.proposal=ae_p_phs_e.proposal
		AND ae_p_wka_d.sort_code=ae_p_phs_e.sort_code
		AND ae_p_wka_e.shop_person=rview_emp_name.shop_person
		AND "AE_P_PHS_E"."SHOP" NOT  LIKE 'F%'
		ORDER BY "AE_P_WKA_E"."SHOP_PERSON", "AE_P_WKA_D"."PROPOSAL",
			"AE_P_WKA_D"."SORT_CODE";
-- variables for cursor curWr1312
datWr1312_sched_date	DATE;
chrWr1312_proposal	VARCHAR2(15);
chrWr1312_shop		VARCHAR2(25);
chrWr1312_craft_code	VARCHAR2(25);
chrWr1312_time_type	VARCHAR2(15);
chrWr1312_labor_class	VARCHAR2(15);
chrWr1312_shop_person	VARCHAR2(15);
chrWr1312_sort_code	VARCHAR2(15);
chrWr1312_name		VARCHAR2(78);
numWr1312_act_hrs	NUMBER(12,4);
chrWr1312_description	VARCHAR2(255);

datLatest_start_date	DATE;
datEnd_date		DATE;
numLabor_rate		NUMBER(12,2);
chrFound		VARCHAR2(1);
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE rpt_wr1312';
	OPEN curWr1312(datBeg_date_arg,datEnd_date_arg);
	LOOP
		FETCH curWr1312 INTO datWr1312_sched_date,chrWr1312_proposal,
			chrWr1312_shop,chrWr1312_craft_code,chrWr1312_time_type,
			chrWr1312_labor_class,chrWr1312_shop_person,
			chrWr1312_sort_code,chrWr1312_name,numWr1312_act_hrs,
			chrWr1312_description;
		EXIT WHEN curWr1312%NOTFOUND;

-- Retrieval of current (or most up-to-date) current rate
		chrFound:='Y';
		BEGIN
			SELECT labor_rate,start_date,NVL(end_date,SYSDATE+365)
				INTO numLabor_rate,datLatest_start_date,datEnd_date
				FROM (SELECT labor_rate,start_date,end_date
					FROM ae_l_man_d
					WHERE shop_person=chrWr1312_shop_person
					AND labor_class=chrWr1312_labor_class
					AND time_type=chrWr1312_time_type
					AND TRUNC(start_date)<=datWr1312_sched_date
					AND (end_date IS NULL OR end_date>=datWr1312_sched_date)
					ORDER BY start_date DESC,end_date
					)
				WHERE rownum<2;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			numLabor_rate:=0;
			chrFound:='N';
		END;
		IF(numLabor_rate=0 and chrFound='N') THEN
			BEGIN
				SELECT labor_rate,start_date,NVL(end_date,SYSDATE+365)
					INTO numLabor_rate,datLatest_start_date,datEnd_date
					FROM (SELECT labor_rate,start_date,end_date
						FROM ae_l_shp_c A,ae_h_emp_pos_data B,
						ae_p_phs_e C
						WHERE shop_person=chrWr1312_shop_person
						AND proposal=chrWr1312_proposal
						AND sort_code=chrWr1312_sort_code
--						AND u_num=shop
						AND a.shop=c.shop
						AND A.job_class=B.job_class
						AND labor_class=chrWr1312_labor_class
						AND time_type=chrWr1312_time_type
						AND TRUNC(start_date)<=datWr1312_sched_date
						AND (end_date IS NULL OR end_date>=datWr1312_sched_date)
						ORDER BY start_date DESC,end_date
						)
					WHERE rownum<2;
			EXCEPTION WHEN NO_DATA_FOUND THEN
				numLabor_rate:=0;
		END;
		END IF;

-- insertion into output table
		INSERT INTO rpt_wr1312
			VALUES(chrWr1312_proposal,chrWr1312_sort_code,
			chrWr1312_shop,chrWr1312_craft_code,datWr1312_sched_date,
			chrWr1312_time_type,chrWr1312_labor_class,chrWr1312_shop_person,
			chrWr1312_name,numWr1312_act_hrs,numLabor_rate,
			chrWr1312_description);
	END LOOP;
	CLOSE curWr1312;
	COMMIT;
END proc_wr1312A;

PROCEDURE proc_wr1312(crystal_cursor1312 IN OUT cr_cursor_wr1312,datBeg_date_arg DATE,datEnd_date_arg DATE) IS
-- Calls proc_wr1312a to populate output table
BEGIN
	fmax_57.proc_wr1312A(datBeg_date_arg,datEnd_date_arg);
	OPEN crystal_cursor1312 FOR
		SELECT * FROM rpt_wr1312;
END proc_wr1312;

PROCEDURE proc_wr0198(crystal_cursor0198 IN OUT cr_cursor_wr0198,datBeg_date_arg VARCHAR2,datEnd_date_arg VARCHAR2) IS
-- Calls proc_wr0198A, which will populate output table
BEGIN
	fmax_57.proc_wr0198A(TO_DATE(datBeg_date_arg,'MM/DD/YYYY'),TO_DATE(datEnd_date_arg,'MM/DD/YYYY'));
	OPEN crystal_cursor0198 FOR
		SELECT * FROM rpt_wr0198;
END proc_wr0198;

PROCEDURE proc_wr0198A(datBeg_date_arg DATE,datEnd_date_arg DATE) IS
-- Called by proc_wr0198. Populates output table
-- On 10/01/2010 references to v_ae_x_cft_e are replaced with ae_x_cft_e,
-- filtering by order_type and category to prevent repeated records.
CURSOR curWr0198(datBeg_date_cur DATE,datEnd_date_cur DATE) IS
	SELECT AE_P_WKA_D.CRAFT_CODE, AE_P_WKA_D.PROPOSAL,
			ae_p_wka_e.SCHED_DATE, ae_p_wka_e.SHOP_PERSON,
			ae_x_cft_e.description,
			AE_P_PRO_E.STATUS_CODE, AE_P_PRO_E.REQUESTOR,
			AE_P_WKA_D.ACT_HRS,--, AE_P_WKA_D.STATUS_CODE,
			ae_p_wka_d.time_type,ae_p_wka_d.labor_class,
			ae_p_pro_e.description AS title,sort_code
		FROM  ae_p_pro_e, ae_p_wka_d, ae_p_wka_e,ae_x_cft_e
		WHERE ae_p_wka_e.trans_no=ae_p_wka_d.trans_no
		AND ae_p_wka_e.sched_date>=datBeg_date_cur
		AND ae_p_wka_e.sched_date<=datEnd_date_cur
		AND ae_p_pro_e.proposal=ae_p_wka_d.proposal
		AND ae_x_cft_e.craft_code=ae_p_wka_d.craft_code
		AND ae_x_cft_e.order_type=ae_p_pro_e.order_type
		AND ae_x_cft_e.category=ae_p_pro_e.category;
-- variables for curWr0198
chrWr0198_craft_code	VARCHAR2(25);
chrWr0198_proposal	VARCHAR2(15);
datWr0198_sched_date	DATE;
chrWr0198_shop_person	VARCHAR2(15);
chrWr0198_description	VARCHAR2(255);
chrWr0198_status_code	VARCHAR2(20);
chrWr0198_requestor	VARCHAR2(25);
numWr0198_act_hrs	NUMBER(12,4);
chrWr0198_time_type	VARCHAR2(15);
chrWr0198_labor_class	VARCHAR2(15);
chrWr0198_title		VARCHAR2(255);
chrWr0198_sort_code	VARCHAR2(15);

numLabor_rate		NUMBER(12,2);
datLatest_start_date	DATE;
datEnd_date		DATE;
chrShop			VARCHAR2(25);
chrFound		VARCHAR2(1);
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE rpt_wr0198';
	OPEN curWr0198(datBeg_date_arg,datEnd_date_arg);
	LOOP
		FETCH curWr0198 INTO chrWr0198_craft_code,chrWr0198_proposal,
			datWr0198_sched_date,chrWr0198_shop_person,chrWr0198_description,
			chrWr0198_status_code,chrWr0198_requestor,numWr0198_act_hrs,
			chrWr0198_time_type,chrWr0198_labor_class,chrWr0198_title,
			chrWr0198_sort_code;
		EXIT WHEN curWr0198%NOTFOUND;

-- Retrieve shop for that employee corresponding to specified date range
		BEGIN
			SELECT shop INTO chrShop
				FROM (SELECT shop,date_from,NVL(date_to,SYSDATE)
					FROM ae_l_shp_d
					WHERE shop_person=chrWr0198_shop_person
					AND date_from<=datWr0198_sched_date
					AND (date_to>=datWr0198_sched_date
-- On 07/15/2010: due to advanced changes in shop, date_to is no longer reliable
-- indicator of somebody being at a shop.
--					OR date_to IS NULL;
					OR date_from<=SYSDATE
					AND NVL(datE_to,SYSDATE)>=TRUNC(SYSDATE)
						)
					ORDER BY date_from)
				WHERE rownum<2;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrShop:=NULL;
			WHEN TOO_MANY_ROWS THEN
				dbms_output.put_line(chrWr0198_shop_person);
				dbms_output.put_line(datWr0198_sched_date);
				rollback;
				return;
		END;

-- Retrieval of current (or most up-to-date) labor rate
		chrFound:='Y';
		BEGIN
			SELECT labor_rate,start_date,NVL(end_date,SYSDATE+365)
				INTO numLabor_rate,datLatest_start_date,datEnd_date
				FROM (SELECT labor_rate,start_date,end_date
					FROM ae_l_man_d
					WHERE shop_person=chrWr0198_shop_person
					AND labor_class=chrWr0198_labor_class
					AND time_type=chrWr0198_time_type
					AND TRUNC(start_date)<=datWr0198_sched_date
					AND (end_date IS NULL OR end_date>=datWr0198_sched_date)
					ORDER BY start_date DESC,end_date
					)
				WHERE rownum<2;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			numLabor_rate:=0;
			chrFound:='N';
		END;
		IF(numLabor_rate=0 AND chrFound='N') THEN
			BEGIN
				SELECT labor_rate,start_date,NVL(end_date,SYSDATE+365)
					INTO numLabor_rate,datLatest_start_date,datEnd_date
					FROM (SELECT labor_rate,start_date,end_date
						FROM ae_l_shp_c A,ae_h_emp_pos_data B,
						ae_p_phs_e C
						WHERE shop_person=chrWr0198_shop_person
						AND proposal=chrWr0198_proposal
						AND sort_code=chrWr0198_sort_code
--						AND u_num=shop
						AND a.shop=c.shop
						AND A.job_class=B.job_class
						AND labor_class=chrWr0198_labor_class
						AND time_type=chrWr0198_time_type
						AND TRUNC(start_date)<=datWr0198_sched_date
						AND (end_date IS NULL OR end_date>=datWr0198_sched_date)
						ORDER BY start_date DESC,end_date
						)
					WHERE rownum<2;
			EXCEPTION WHEN NO_DATA_FOUND THEN
				numLabor_rate:=0;
			END;
		END IF;

-- insertion into output table
		INSERT INTO rpt_wr0198
			VALUES(chrWr0198_craft_code,chrShop,chrWr0198_proposal,
			datWr0198_sched_date,chrWr0198_shop_person,chrWr0198_description,
			chrWr0198_status_code,chrWr0198_requestor,numWr0198_act_hrs,
			numLabor_rate,chrWr0198_title);

	END LOOP;
	CLOSE curWr0198;
	COMMIT;
END proc_wr0198A;


--CREATE OR REPLACE VIEW rh_sched_comp_v as select proposal,sort_code,status_code,description,shop
--from ae_p_phs_e where status_code ='COMPLETE' and shop in ('M8100','M8200')

PROCEDURE proc_wrlabmat(crystal_cursor IN OUT cr_cursor_wr0941,chrProposal_arg varchar2) AS
-- Calls proc_wrlabmat2, which populates output table
-- This relates to report WR0941
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wrlabmat';
	proc_wrlabmat2(chrProposal_arg);
	OPEN crystal_cursor FOR SELECT * FROM um_wrlabmat;
END proc_wrlabmat;

PROCEDURE proc_wrlabmat2 (chrProposal_arg VARCHAR2) IS
-- Called by proc_wrlabmat. Populates output table
-- This relates to report WR0941 (and also wr0945)
-- On 10/01/2010 references to v_ae_x_cft_e are replaced with ae_x_cft_e,
-- filtering by order_type and category to prevent repeated records.
-- On 11/04/2010 default cost to ae_p_wka_d.act_cost. When it's null, compute
-- cost from labor_rate
-- On 12/13/2011, INV Return or Release won't be based on returned_qty but on trans_qty being negative.
CURSOR curWka(chrProposal_cur VARCHAR2) IS
	SELECT a.proposal,a.sort_code,b.sched_date,b.shop_person,a.craft_code,
		a.act_hrs,a.time_type,a.labor_class,c.description,a.trans_no,
		a.act_cost
		FROM ae_p_wka_d a,ae_p_wka_e b,--v_ae_x_cft_e c
		ae_x_cft_e c,ae_p_phs_e d
		WHERE a.proposal=chrProposal_cur
		AND a.trans_no=b.trans_no
		AND a.proposal=d.proposal
		AND a.sort_code=d.sort_code
		AND a.craft_code=c.craft_code
		AND d.order_type=c.order_type
		AND d.category=c.category;
-- variables from curWka
chrWka_proposal		VARCHAR2(15);
chrWka_sort_code	VARCHAR2(15);
datWka_sched_date	DATE;
chrWka_shop_person	VARCHAR2(15);
chrWka_craft_code	VARCHAR2(25);
numWka_act_hrs		NUMBER(12,4);
chrWka_time_type	VARCHAR2(15);
chrWka_labor_class	VARCHAR2(15);
chrWka_craftdesc	VARCHAR2(255);
numWka_trans_no		NUMBER(8);
numWka_act_cost		NUMBER(12,4);
CURSOR curUm_wrlabmat IS
	SELECT proposal,sort_code,bldg,shop_person
		FROM um_wrlabmat;
--
chrUmWrLM_proposal	VARCHAR2(15);
chrUmWrLM_sort_code	VARCHAR2(15);
chrUmWrLM_bldg		VARCHAR2(15);
chrUmWrLM_shop_person	VARCHAR2(15);

datLatest_start_date	DATE;
numLabor_rate		NUMBER(12,4);
chrTime_type_desc	VARCHAR2(255);
chrShop			VARCHAR2(15);
chrPhsdsc		VARCHAR2(70);
datBeg_dt		DATE;
chrStatus_code		VARCHAR2(20);
chrBldg			VARCHAR2(15);
chrShop_person		VARCHAR2(15);
chrBldgdsc		VARCHAR2(255);
chrFname		VARCHAR2(15);
chrLname		VARCHAR2(15);
chrLead_person		VARCHAR2(15);
chrLead_lname		VARCHAR2(15);
chrLead_fname		VARCHAR2(15);
chrFound		VARCHAR2(1);
numCount		NUMBER;
BEGIN
-- On 12/16/2009 changed queries to retrieve the shop for past timecards,
-- as employees may have switched shops since then.
	OPEN curWka(chrProposal_arg);
	LOOP
		FETCH curWka INTO chrWka_proposal,chrWka_sort_code,datWka_sched_date,
			chrWka_shop_person,chrWka_craft_code,numWka_act_hrs,
			chrWka_time_type,chrWka_labor_class,chrWka_craftdesc,
			numWka_trans_no,numWka_act_cost;
		EXIT WHEN curWka%NOTFOUND;

-- Gather latest start_date, towards retrieval of labor rate
		chrFound:='Y';
		BEGIN
			SELECT MAX(start_date),COUNT(*) INTO datLatest_start_date,numCount
				FROM ae_l_man_d
				WHERE shop_person=chrWka_shop_person
					AND labor_class=chrWka_labor_class
					AND time_type=chrWka_time_type
					AND TRUNC(start_date)<=datWKa_sched_date
					AND (end_date>=datWKa_sched_date OR end_date IS NULL);
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrFound:='N';
		END;
		IF(numCount=0) THEN
			chrFound:='N';
		END IF;

		IF(chrFound='N') THEN
			SELECT MAX(start_date) INTO datLatest_start_date
				FROM ae_l_shp_c A,ae_h_emp_pos_data B,
				ae_p_phs_e C
				WHERE shop_person=chrWka_shop_person
				AND proposal=chrWka_proposal
				AND sort_code=chrWka_sort_code
				AND c.shop=a.shop
--				AND u_num=shop
				AND A.job_class=B.job_class
				AND labor_class=chrWka_labor_class
				AND time_type=chrWka_time_type
				AND TRUNC(start_date)<=datWKa_sched_date
				AND NVL(end_date,SYSDATE+365)>=datWKa_sched_date;
		END IF;
		datLatest_start_date:=datLatest_start_date;

-- Retrieval of labor rate
		IF(chrFound='Y') THEN
			BEGIN
				SELECT NVL(labor_rate,0) INTO numLabor_rate
					FROM ae_l_man_d
					WHERE shop_person=chrWka_shop_person
					AND labor_class=chrWka_labor_class
					AND time_type=chrWka_time_type
					AND start_date=datLatest_start_date
					AND end_date IS NOT NULL
					AND TRUNC(end_date)>=TRUNC(datWka_sched_date);
			EXCEPTION WHEN NO_DATA_FOUND THEN
				numLabor_rate:=0;
			END;
		ELSE
			BEGIN
				SELECT NVL(labor_rate,0) INTO numLabor_rate
					FROM ae_l_shp_c A,ae_h_emp_pos_data B,
					ae_p_phs_e C
					WHERE shop_person=chrWka_shop_person
					AND proposal=chrWka_proposal
					AND sort_code=chrWka_sort_code
					AND c.shop=a.shop
--					AND u_num=shop
					AND A.job_class=B.job_class
					AND labor_class=chrWka_labor_class
					AND time_type=chrWka_time_type
					AND start_date=datLatest_start_date
					AND end_date IS NOT NULL
					AND TRUNC(end_date)>=TRUNC(datWka_sched_date);
			EXCEPTION WHEN NO_DATA_FOUND THEN
				numLabor_rate:=0;
			END;
		END IF;

		IF(numLabor_rate=0) THEN
-- Second attempt to retrieve labor rate, but now with end_date NULL
			IF(chrFound='Y') THEN
				BEGIN
					SELECT NVL(labor_rate,0) INTO numLabor_rate
						FROM ae_l_man_d
						WHERE shop_person=chrWka_shop_person
						AND labor_class=chrWka_labor_class
						AND time_type=chrWka_time_type
						AND start_date=datLatest_start_date
						AND end_date IS NULL;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					numLabor_rate:=0;
				END;
			ELSE
				BEGIN
					SELECT NVL(labor_rate,0) INTO numLabor_rate
						FROM ae_l_shp_c A,ae_h_emp_pos_data B,
						ae_p_phs_e C
						WHERE shop_person=chrWka_shop_person
						AND proposal=chrWka_proposal
						AND sort_code=chrWka_sort_code
						AND c.shop=a.shop
--						AND u_num=shop
						AND A.job_class=B.job_class
						AND labor_class=chrWka_labor_class
						AND time_type=chrWka_time_type
						AND start_date=datLatest_start_date
						AND end_date IS NULL;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					numLabor_rate:=0;
				END;

			END IF;
		END IF;

-- Retrieve description of time type
		BEGIN
			SELECT description INTO chrTime_type_desc
				FROM ae_p_lat_c
				WHERE time_type=chrWka_time_type;
		EXCEPTION WHEN NO_DATA_FOUND THEN
				chrTime_type_desc:=NULL;
		END;
		INSERT INTO um_wrlabmat (proposal, sort_code, rec_date, shop_person,
				craft_code, hrs, cost, time_type,rec_type,timetypedesc,
				craftdesc,trans_no)
			VALUES(chrWka_proposal,chrWka_sort_code,datWka_sched_date,
				chrWka_shop_person,chrWka_craft_code,numWka_act_hrs,
				NVL(numWka_act_cost,numLabor_rate*numWka_act_hrs),
				chrWka_time_type,'L',
				SUBSTR(chrTime_type_desc,1,20),SUBSTR(chrWka_craftdesc,1,40),numWka_trans_no);
	END LOOP;
	CLOSE curWka;

	UPDATE um_wrlabmat
		SET inv_no = NULL,po_num = NULL;

-- Insert rows with trans_type='M'
	INSERT INTO um_wrlabmat(proposal, sort_code, rec_date, shop_person, craft_code,
		cost, rec_desc, inv_no,po_num, req_no,rec_type,craftdesc,trans_no)
		SELECT ae_i_ext_e.proposal,ae_i_ext_e.sort_code,ae_i_ext_e.trans_date,
			ae_i_ext_e.shop_person,ae_i_ext_e.craft_code,ae_i_ext_e.amount,
			SUBSTR(ae_i_ext_e.description,1,60),ae_i_ext_e.inv_no,
			ae_i_ext_e.po_code,ae_i_ext_e.req_no,'M',
			SUBSTR(ae_x_cft_e.description,1,40),
			ae_i_ext_e.trans_no
			FROM ae_i_ext_e,ae_p_pro_e,ae_x_cft_e
			WHERE ae_i_ext_e.proposal = chrProposal_arg
			AND ae_p_pro_e.proposal=chrProposal_arg
			AND ae_i_ext_e.craft_code=ae_x_cft_e.craft_code
			AND ae_x_cft_e.order_type=ae_p_pro_e.order_type
			AND ae_x_cft_e.category=ae_p_pro_e.category;

-- Insert rows with trans_type='A'
	INSERT INTO um_wrlabmat(proposal, sort_code, rec_date, shop_person, craft_code,
			qty, cost, rec_desc, trans_type,rec_type,craftdesc,trans_no)
		SELECT ae_i_release_d.proposal,ae_i_release_d.sort_code,ae_i_release_e.trans_date,
			ae_i_release_e.to_person,ae_i_release_d.craft_code,ae_i_release_d.trans_qty,
--			ae_i_release_d.trans_qty*ae_i_release_d.inv_cost,SUBSTR(ae_i_inv_e.description,1,60),
			ae_i_release_d.inv_cost,SUBSTR(ae_i_inv_e.description,1,60),
--			(CASE WHEN returned_qty>0 THEN 'INV RETURN' ELSE 'INV RELEASE' END),'A',
			(CASE WHEN trans_qty<0 THEN 'INV RETURN' ELSE 'INV RELEASE' END),'A',
			SUBSTR(ae_x_cft_e.description,1,40),ae_i_release_e.trans_num
			FROM ae_i_release_d,ae_i_release_e,ae_x_cft_e,ae_i_inv_e,
				ae_p_pro_e
			WHERE ae_i_release_d.trans_num=ae_i_release_e.trans_num
			AND ae_i_release_d.proposal = chrProposal_arg
			AND ae_p_pro_e.proposal=chrProposal_arg
			AND ae_i_release_d.craft_code=ae_x_cft_e.craft_code
			AND ae_x_cft_e.order_type=ae_p_pro_e.order_type
			AND ae_x_cft_e.category=ae_p_pro_e.category
			AND ae_i_release_d.part=ae_i_inv_e.part;
-- On 12/07/2011 trans_type is defined at insertion
--	UPDATE um_wrlabmat
--		SET cost = cost * -1
--		WHERE trans_type='INV RETURN'
--		AND rec_type='A';

-- This loop retrieves additional information from diverse tables to be displayed by report
	OPEN curUm_wrlabmat;
	LOOP
		FETCH curUm_wrlabmat INTO chrUmWrLM_proposal,chrUmWrLM_sort_code,
			chrUmWrLM_bldg,chrUmWrLM_shop_person;
		EXIT WHEN curUm_wrlabmat%NOTFOUND;
		BEGIN
			SELECT shop,SUBSTR(description,1,70),beg_dt,status_code
				INTO chrShop,chrPhsdsc,datBeg_dt,chrStatus_code
				FROM ae_p_phs_e
				WHERE proposal=chrUmWrLM_proposal
				AND sort_code=chrUmWrLM_sort_code;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrShop:=NULL;
			chrPhsdsc:=NULL;
			datBeg_dt:=NULL;
			chrStatus_code:=NULL;
		END;
		BEGIN
			SELECT bldg,shop_person	INTO chrBldg,chrLead_person
				FROM ae_p_pro_e
				WHERE proposal=chrUmWrLM_proposal;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrBldg:=NULL;
			chrLead_person:=NULL;
		END;
		BEGIN
			SELECT SUBSTR(description,1,40) INTO chrBldgdsc
				FROM ae_s_bld_c
				WHERE bldg=chrBldg;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrBldgdsc:=NULL;
		END;
		BEGIN
			SELECT SUBSTR( lname,1,15),fname INTO chrLname,chrFname
				FROM ae_h_emp_e
				WHERE shop_person=chrUmWrLM_shop_person;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrFname:=NULL;
			chrLname:=NULL;
		END;
		BEGIN
			SELECT SUBSTR(lname,1,15),fname INTO chrLead_lname,chrLead_fname
				FROM ae_h_emp_e
				WHERE shop_person=chrLead_person;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrLead_lname:=NULL;
			chrLead_fname:=NULL;
		END;

-- Perform update to complete data for the corresponding row
		UPDATE um_wrlabmat
			SET shop=chrShop,phsdsc=chrPhsdsc,beg_dt=datBeg_dt,
				status_code=chrStatus_code,bldg=chrBldg,
				shop_person=chrUmWrLM_shop_person,bldgdsc=chrBldgdsc,
				empfname=chrFname,emplname=chrLname,leadlname=chrLead_lname,
				leadfname=chrLead_fname
			WHERE proposal=chrUmWrLM_proposal
			AND sort_code=chrUmWrLM_sort_code
			AND shop_person=chrUmWrLm_shop_person;
	END LOOP;
	CLOSE curUm_wrlabmat;

-- Rounding issue surfacing when comparing to ae_s_fnd_a
	UPDATE um_wrlabmat
		SET cost=ROUND(cost,2);
	COMMIT;
END proc_wrlabmat2;

PROCEDURE proc_PhasesBackFromComplete(crystal_cursor IN OUT fmax_57.cr_cursor_wrPhas) AS
-- This procedure relates to report WR0750
-- Calls proc_PhasesBackFromCompleteA, which populates output table
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_phases_back_from_complete';
	fmax_57.proc_PhasesBackFromCompleteA;
	OPEN crystal_cursor FOR SELECT * FROM um_phases_back_from_complete;
END proc_PhasesBackFromComplete;

PROCEDURE proc_PhasesBackFromCompleteA IS
-- This procedure relates to report WR0750
chrCurr_sort_code	VARCHAR2(15);
numCount		NUMBER;
chrLogin		VARCHAR2(128);
datStatus_date		DATE;
CURSOR curUmPhases IS
	SELECT proposal,sort_code,status_code
		FROM um_phases_back_from_complete
		ORDER BY proposal,sort_code;
-- variables for curUm_phases
chrProposal		VARCHAR2(15);
chrSort_code		VARCHAR2(15);
chrStatus_code		VARCHAR2(20);

CURSOR curPhases IS
	SELECT a.proposal,a.sort_code,a.status_code
		FROM ae_p_phs_e A,ae_p_pro_e B
		WHERE a.proposal=b.proposal
-- to enable in FMS
--		AND b.status_code='80-CMPLETE'
		AND b.status_code='COMPLETE'
-- to enable in FMS
--		AND a.status_code<'80-CMPLETE'
-- 01/09/2009 <=80-CMPLETE
		AND a.status_code NOT IN('CANCELLED','CLOSED','NOTCOMPLETED');
-- variables for curPhases
chrPh_proposal		VARCHAR2(15);
chrPh_sort_code		VARCHAR2(15);
chrPh_status_code	VARCHAR2(20);

BEGIN
	chrLogin:=' ';
	OPEN curPhases;
	LOOP
		FETCH curPhases INTO chrPh_proposal,chrPh_sort_code,chrPh_status_code;
		EXIT WHEN curPhases%NOTFOUND;

		SELECT COUNT(*) INTO numCount
			FROM um_phases_back_from_complete
			WHERE proposal=chrPh_proposal
			AND sort_code=chrPh_sort_code;
		IF(numCount=0) THEN
			BEGIN
				SELECT MIN(status_date) INTO datStatus_date
					FROM ae_p_pst_e
					WHERE proposal=chrPh_proposal
					AND sort_code=chrPh_sort_code
					AND status_date>=(SELECT MAX(status_date)
								FROM ae_p_sta_e
								WHERE proposal=chrPh_proposal
--								AND status_code='80-CMPLETE'
								AND status_code='COMPLETE'
							)
--					AND status_code<'80-CMPLETE';
					AND status_code<>'COMPLETE';
			EXCEPTION WHEN NO_DATA_FOUND THEN
				chrLogin:='NOT IN AE_P_PST_E';
				datStatus_date:=SYSDATE;
			END;
			IF(chrLogin<>'NOT IN AE_P_PST_E') THEN
				numCount:=1;
				BEGIN
					SELECT login INTO chrLogin
						FROM ae_p_pst_e
						WHERE proposal=chrPh_proposal
						AND sort_code=chrPh_sort_code
						AND status_date=datStatus_date;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					numCount:=0;
				END;
			END IF;
			IF(numCount>0) THEN
				INSERT INTO um_phases_back_from_complete
					VALUES(chrPh_proposal,chrPh_sort_code,chrPh_status_code,
					datStatus_date,chrLogin);
			END IF;
		END IF;
	END LOOP;
	CLOSE curPhases;
	COMMIT;
END proc_PhasesBackFromCompleteA;

PROCEDURE proc_Lv0600(crystal_cursor IN OUT fmax_57.cr_cursor_lv0600,
	chrBegin_date_arg VARCHAR2,chrEnd_date_arg VARCHAR2) AS
datBegin_date	DATE;
datEnd_date		DATE;
BEGIN
	datBegin_date:=TO_DATE(chrBegin_date_arg,'yyyy-mm-dd');
	datEnd_date:=TO_DATE(chrEnd_date_arg,'yyyy-mm-dd');
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_consecutive_absence';
	fmax_57.proc_lv0600a(datBegin_date,datEnd_date);
	OPEN crystal_cursor FOR SELECT *
				FROM um_consecutive_absence
				ORDER BY name,start_date;
END proc_lv0600;

PROCEDURE proc_lv0600a(datBegin_date_arg DATE,datEnd_date_arg DATE) IS
-- pending: define parameters, cursor parms, func_GetNextWorkingDay
CURSOR curTs_lev_absences(datBegin_date_cur DATE,datEnd_date_cur DATE) Is
	SELECT shop_person,TRUNC(adj_date),NVL(sumlev,0)
		FROM ts_lev_absences_v
		WHERE TRUNC(adj_date)>=datBegin_date_cur
		AND TRUNC(adj_date)<=datEnd_date_cur
and sumLev<-7
                ORDER BY shop_person,adj_date;
-- variables for ts_lev_absences_v
chrLev_shop_person      VARCHAR2(15);
datLev_adj_date         DATE;
numLev_sumlev           NUMBER;
chrSave_shop_person     VARCHAR2(15);
datPrev_adj_date    	DATE;
datBegin_adj_date       DATE;
datNext_date            DATE;
numConsec_hrs_abs       NUMBER;
chrName                 VARCHAR2(50);
chrU_num                VARCHAR2(15);
datNext_working_day	DATE;
BEGIN
        chrSave_shop_person:=' ';
        datPrev_adj_date:=TO_DATE('19980101','YYYYMMDD');
-- lv0600 report
        EXECUTE IMMEDIATE 'TRUNCATE TABLE um_consecutive_absence';
        OPEN curTs_lev_absences(datBegin_date_arg,datEnd_date_arg);
        LOOP
                FETCH curTs_lev_absences INTO chrLev_shop_person,
                        datLev_adj_date,numlev_sumlev;
                EXIT WHEN curTs_lev_absences%NOTFOUND;
                IF(chrLev_shop_person=chrSave_shop_person) THEN
                        datNext_working_day:=func_GetNextWorkingDay(chrLev_shop_person,datPrev_adj_date);
if(chrSave_shop_person='1031') then
dbms_output.put_line('ok '||numConsec_hrs_abs||' '||datBegin_adj_date||' '||datNext_working_day||' '||datLev_adj_date);
end if;
                        IF(datNext_working_day<>datLev_adj_date) THEN
				IF(ABS(numConsec_hrs_abs)>31.9) THEN
					SELECT CONCAT(fname,CONCAT(' ',lname)),u_num
						INTO chrName,chrU_num
						FROM ae_h_emp_e a,ae_h_emp_pos_data b
						WHERE a.shop_person=chrLev_shop_person
						AND a.shop_person=b.shop_person;
					INSERT INTO um_consecutive_absence
						VALUES(chrLev_shop_person,chrName,chrU_num,
							TO_CHAR(datBegin_adj_date,'MM/DD/YYYY'),
							TO_CHAR(datPrev_adj_date,'MM/DD/YYYY'));
					chrSave_shop_person:=chrLev_shop_person;
				END IF;
                                numConsec_hrs_abs:=numLev_sumlev;
                                datBegin_adj_date:=datLev_adj_date;
                                datPrev_adj_date:=datLev_adj_date;
if(chrSave_shop_person='1031') then
dbms_output.put_line('New begin: '||datBegin_adj_date);
end if;
                        ELSE
                                numConsec_hrs_abs:=numConsec_hrs_abs+numLev_sumlev;
                                datPrev_adj_date:=datLev_adj_date;
                        END IF;
                ELSE
                        IF(ABS(numConsec_hrs_abs)>31.9 AND RTRIM(chrSave_shop_person) IS NOT NULL) THEN
                -- insert
				SELECT CONCAT(fname,CONCAT(' ',lname)),u_num
                                        INTO chrName,chrU_num
                                        FROM ae_h_emp_e a,ae_h_emp_pos_data b
                                        WHERE a.shop_person=chrSave_shop_person
                                        AND a.shop_person=b.shop_person;
                                INSERT INTO um_consecutive_absence
                                        VALUES(chrSave_shop_person,chrName,chrU_num,
                                        TO_CHAR(datBegin_adj_date,'MM/DD/YYYY'),
					TO_CHAR(datPrev_adj_date,'MM/DD/YYYY'));
                        END IF;
                        chrSave_shop_person:=chrLev_shop_person;
                        numConsec_hrs_abs:=numLev_sumlev;
                        datBegin_adj_date:=datLev_adj_date;
                        datPrev_adj_date:=datLev_adj_date;
                END IF;
        END LOOP;
        CLOSE curTs_lev_absences;
        IF(ABS(numConsec_hrs_abs)>31.9) THEN
        -- insert
                        SELECT CONCAT(fname,CONCAT(' ',lname)),u_num
                                INTO chrName,chrU_num
                                FROM ae_h_emp_e a,ae_h_emp_pos_data b
                                WHERE a.shop_person=chrLev_shop_person
                                AND a.shop_person=b.shop_person;
                        INSERT INTO um_consecutive_absence
                                VALUES(chrLev_shop_person,chrName,chrU_num,
                                TO_CHAR(datBegin_adj_date,'MM/DD/YYYY'),
				TO_CHAR(datPrev_adj_date,'MM/DD/YYYY'));
	END IF;
	COMMIT;
END proc_lv0600a;

FUNCTION func_GetNextWorkingDay(chrShop_person_arg VARCHAR2,datAdj_arg DATE) RETURN DATE IS
datNext_day	DATE;
chrFlag		VARCHAR2(1);
numDay		VARCHAR2(1);
numCount	NUMBER;
BEGIN
	datNext_day:=datAdj_arg+1;
	chrFlag:='Y';
	WHILE(chrFlag='Y')
	LOOP
		numDay:=TO_NUMBER(TO_CHAR(datNext_day,'D'),'9');
		SELECT COUNT(*) INTO numCount
			FROM ae_h_sch_d
			WHERE shop_person=chrShop_person_arg
			AND from_date IS NULL
			AND to_date IS NULL
			AND work_day=numDay;
		IF(numCount>0) THEN
			chrFlag:='N';
		ELSE
			datNext_day:=datNext_day+1;
		END IF;
	END LOOP;
	RETURN datNext_day;
END func_GetNextWorkingDay;

-- change 01/14/2009: retrieve next item
FUNCTION func_RetrieveNextProposal(chrProposal_arg VARCHAR2,numIndex_arg NUMBER) RETURN VARCHAR2 IS
chrResult	VARCHAR2(15);
numIndex	NUMBER;
BEGIN
	chrResult:=NULL;
	numIndex:=numIndex_arg;
	WHILE(SUBSTR(chrProposal_arg,numIndex) IS NOT NULL AND SUBSTR(chrProposal_arg,numIndex,1)=' ')
	LOOP
		numIndex:=numIndex+1;
	END LOOP;
	IF(SUBSTR(chrProposal_arg,numIndex) IS NULL) THEN
		RETURN chrResult;
	END IF;
	WHILE(SUBSTR(chrProposal_arg,numIndex) IS NOT NULL AND SUBSTR(chrProposal_arg,numIndex,1) NOT IN(',',' '))
	LOOP
		chrResult:=CONCAT(chrResult,SUBSTR(chrProposal_arg,numIndex,1));
		numIndex:=numIndex+1;
	END LOOP;
	RETURN chrResult;
END func_RetrieveNextProposal;

PROCEDURE proc_wrlabmatDt(crystal_cursor IN OUT cr_cursor_wr0941,chrProposal_arg varchar2,datFrom_date_arg DATE,datTo_date_arg DATE) AS
-- Calls proc_wrlabmatDt2, which populates output table
-- This relates to report WR____
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wrlabmat';
	proc_wrlabmatDt2(chrProposal_arg,datFrom_date_arg,datTo_date_arg);
	OPEN crystal_cursor FOR SELECT * FROM um_wrlabmat;
END proc_wrlabmatDt;

PROCEDURE proc_wrlabmatDt2 (chrProposal_arg VARCHAR2,datFrom_date_arg DATE,datTo_date_arg DATE) IS
-- Called by proc_wrlabmatDt. Populates output table
-- This relates to report WR____
-- On 10/01/2010 references to v_ae_x_cft_e are replaced with ae_x_cft_e,
-- filtering by order_type and category to prevent repeated records.
CURSOR curWka(chrProposal_cur VARCHAR2,datFrom_date_cur DATE,datTo_date_cur DATE) IS
	SELECT a.proposal,a.sort_code,b.sched_date,b.shop_person,a.craft_code,
		a.act_hrs,a.time_type,a.labor_class,c.description,a.trans_no
		FROM ae_p_wka_d a,ae_p_wka_e b,ae_x_cft_e c,ae_p_pro_e d
		WHERE a.proposal=chrProposal_arg
		AND d.proposal=chrProposal_arg
		AND a.trans_no=b.trans_no
		AND TRUNC(sched_date) BETWEEN datFrom_date_cur AND datTo_date_cur
		AND a.craft_code=c.craft_code
		AND c.order_type=d.order_type
		AND c.category=d.category;
-- variables from curWka
chrWka_proposal		VARCHAR2(15);
chrWka_sort_code	VARCHAR2(15);
datWka_sched_date	DATE;
chrWka_shop_person	VARCHAR2(15);
chrWka_craft_code	VARCHAR2(25);
numWka_act_hrs		NUMBER(12,4);
chrWka_time_type	VARCHAR2(15);
chrWka_labor_class	VARCHAR2(15);
chrWka_craftdesc	VARCHAR2(255);
numWka_trans_no		NUMBER(8);

CURSOR curUm_wrlabmat IS
	SELECT proposal,sort_code,bldg,shop_person
		FROM um_wrlabmat;
--
chrUmWrLM_proposal	VARCHAR2(15);
chrUmWrLM_sort_code	VARCHAR2(15);
chrUmWrLM_bldg		VARCHAR2(15);
chrUmWrLM_shop_person	VARCHAR2(15);

datLatest_start_date	DATE;
numLabor_rate		NUMBER(12,4);
chrTime_type_desc	VARCHAR2(255);
chrShop			VARCHAR2(15);
chrPhsdsc		VARCHAR2(70);
datBeg_dt		DATE;
chrStatus_code		VARCHAR2(20);
chrBldg			VARCHAR2(15);
chrShop_person		VARCHAR2(15);
chrBldgdsc		VARCHAR2(255);
chrFname		VARCHAR2(15);
chrLname		VARCHAR2(15);
chrLead_person		VARCHAR2(15);
chrLead_lname		VARCHAR2(15);
chrLead_fname		VARCHAR2(15);
chrFound		VARCHAR2(1);
numCount		NUMBER;
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wrlabmat';
	OPEN curWka(chrProposal_arg,datFrom_date_arg,datTo_date_arg);
	LOOP
		FETCH curWka INTO chrWka_proposal,chrWka_sort_code,datWka_sched_date,
			chrWka_shop_person,chrWka_craft_code,numWka_act_hrs,
			chrWka_time_type,chrWka_labor_class,chrWka_craftdesc,
			numWka_trans_no;
		EXIT WHEN curWka%NOTFOUND;

-- Gather latest start_date, towards retrieval of labor rate
		chrFound:='Y';
		BEGIN
			SELECT MAX(start_date),COUNT(*) INTO datLatest_start_date,numCount
				FROM ae_l_man_d
				WHERE shop_person=chrWka_shop_person
					AND labor_class=chrWka_labor_class
					AND time_type=chrWka_time_type
					AND TRUNC(start_date)<=datWKa_sched_date
					AND (end_date>=datWKa_sched_date OR end_date IS NULL);
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrFound:='N';
		END;
		IF(numCount=0) THEN
			chrFound:='N';
		END IF;

		IF(chrFound='N') THEN
			SELECT MAX(start_date) INTO datLatest_start_date
				FROM ae_l_shp_c A,ae_h_emp_pos_data B,
				ae_p_phs_e C
				WHERE shop_person=chrWka_shop_person
				AND proposal=chrWka_proposal
				AND sort_code=chrWka_sort_code
				AND a.shop=c.shop
--				AND u_num=shop
				AND A.job_class=B.job_class
				AND labor_class=chrWka_labor_class
				AND time_type=chrWka_time_type
				AND TRUNC(start_date)<=datWKa_sched_date
				AND NVL(end_date,SYSDATE+365)>=datWKa_sched_date;
		END IF;
		datLatest_start_date:=datLatest_start_date;

-- Retrieval of labor rate
		IF(chrFound='Y') THEN
			BEGIN
				SELECT NVL(labor_rate,0) INTO numLabor_rate
					FROM ae_l_man_d
					WHERE shop_person=chrWka_shop_person
					AND labor_class=chrWka_labor_class
					AND time_type=chrWka_time_type
					AND start_date=datLatest_start_date
					AND end_date IS NOT NULL
					AND TRUNC(end_date)>=TRUNC(datWka_sched_date);
			EXCEPTION WHEN NO_DATA_FOUND THEN
				numLabor_rate:=0;
			END;
		ELSE
			BEGIN
				SELECT NVL(labor_rate,0) INTO numLabor_rate
					FROM ae_l_shp_c A,ae_h_emp_pos_data B,
					ae_p_phs_e C
					WHERE shop_person=chrWka_shop_person
					AND proposal=chrWka_proposal
					AND sort_code=chrWka_sort_code
--					AND u_num=shop
					AND a.shop=c.shop
					AND A.job_class=B.job_class
					AND labor_class=chrWka_labor_class
					AND time_type=chrWka_time_type
					AND start_date=datLatest_start_date
					AND end_date IS NOT NULL
					AND TRUNC(end_date)>=TRUNC(datWka_sched_date);
			EXCEPTION WHEN NO_DATA_FOUND THEN
				numLabor_rate:=0;
			END;
		END IF;

		IF(numLabor_rate=0) THEN
-- Second attempt to retrieve labor rate, but now with end_date NULL
			IF(chrFound='Y') THEN
				BEGIN
					SELECT NVL(labor_rate,0) INTO numLabor_rate
						FROM ae_l_man_d
						WHERE shop_person=chrWka_shop_person
						AND labor_class=chrWka_labor_class
						AND time_type=chrWka_time_type
						AND start_date=datLatest_start_date
						AND end_date IS NULL;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					numLabor_rate:=0;
				END;
			ELSE
				BEGIN
					SELECT NVL(labor_rate,0) INTO numLabor_rate
						FROM ae_l_shp_c A,ae_h_emp_pos_data B,
						ae_p_phs_e C
						WHERE shop_person=chrWka_shop_person
						AND proposal=chrWka_proposal
						AND sort_code=chrWka_sort_code
--						AND u_num=shop
						AND a.shop=c.shop
						AND A.job_class=B.job_class
						AND labor_class=chrWka_labor_class
						AND time_type=chrWka_time_type
						AND start_date=datLatest_start_date
						AND end_date IS NULL;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					numLabor_rate:=0;
				END;

			END IF;
		END IF;

-- Retrieve description of time type
		BEGIN
			SELECT description INTO chrTime_type_desc
				FROM ae_p_lat_c
				WHERE time_type=chrWka_time_type;
		EXCEPTION WHEN NO_DATA_FOUND THEN
				chrTime_type_desc:=NULL;
		END;
		INSERT INTO um_wrlabmat (proposal, sort_code, rec_date, shop_person,
				craft_code, hrs, cost, time_type,rec_type,timetypedesc,
				craftdesc,trans_no)
			VALUES(chrWka_proposal,chrWka_sort_code,datWka_sched_date,
				chrWka_shop_person,chrWka_craft_code,numWka_act_hrs,
				numLabor_rate*numWka_act_hrs,chrWka_time_type,'L',
				SUBSTR(chrTime_type_desc,1,20),SUBSTR(chrWka_craftdesc,1,40),
				numWka_trans_no);
	END LOOP;
	CLOSE curWka;

	UPDATE um_wrlabmat
		SET inv_no = NULL,po_num = NULL;

-- Insert rows with trans_type='M'
	INSERT INTO um_wrlabmat(proposal, sort_code, rec_date, shop_person, craft_code,
		cost, rec_desc, inv_no,po_num, req_no,rec_type,craftdesc,trans_no)
		SELECT ae_i_ext_e.proposal,ae_i_ext_e.sort_code,ae_i_ext_e.trans_date,
			ae_i_ext_e.shop_person,ae_i_ext_e.craft_code,ae_i_ext_e.amount,
			SUBSTR(ae_i_ext_e.description,1,60),ae_i_ext_e.inv_no,
			ae_i_ext_e.po_code,ae_i_ext_e.req_no,'M',
			SUBSTR(ae_x_cft_e.description,1,40),
			ae_i_ext_e.trans_no
			FROM ae_i_ext_e,ae_x_cft_e,ae_p_pro_e
			WHERE ae_i_ext_e.proposal = chrProposal_arg
			AND ae_p_pro_e.proposal=chrProposal_arg
			AND TRUNC(trans_date) BETWEEN datFrom_date_arg AND datTo_date_arg
			AND ae_i_ext_e.craft_code=ae_x_cft_e.craft_code
			AND ae_p_pro_e.order_type=ae_x_cft_e.order_type
			AND ae_p_pro_e.category=ae_x_cft_e.category;

-- Insert rows with trans_type='A'
	INSERT INTO um_wrlabmat(proposal, sort_code, rec_date, shop_person, craft_code,
			qty, cost, rec_desc, trans_type,rec_type,craftdesc,trans_no)
		SELECT ae_i_release_d.proposal,ae_i_release_d.sort_code,ae_i_release_e.trans_date,
			ae_i_release_e.to_person,ae_i_release_d.craft_code,ae_i_release_d.trans_qty,
--			ae_i_release_d.trans_qty*ae_i_release_d.inv_cost,SUBSTR(ae_i_inv_e.description,1,60),'INV RELEASE','A'
			ae_i_release_d.inv_cost,SUBSTR(ae_i_inv_e.description,1,60),
--			(CASE WHEN returned_qty>0 THEN 'INV RETURN' ELSE 'INV RELEASE' END),'A',
			(CASE WHEN trans_qty<0 THEN 'INV RETURN' ELSE 'INV RELEASE' END),'A',
			SUBSTR(ae_x_cft_e.description,1,40),ae_i_release_e.trans_num
			FROM ae_i_release_d,ae_i_release_e,ae_x_cft_e,ae_i_inv_e,
				ae_p_pro_e
			WHERE ae_i_release_d.trans_num=ae_i_release_e.trans_num
			AND ae_i_release_d.proposal = chrProposal_arg
			AND ae_p_pro_e.proposal=chrProposal_arg
			AND TRUNC(trans_date) BETWEEN datFrom_date_arg AND datTo_date_arg
			AND ae_i_release_d.craft_code=ae_x_cft_e.craft_code
			AND ae_p_pro_e.order_type=ae_x_cft_e.order_type
			AND ae_p_pro_e.category=ae_x_cft_e.category
			AND ae_i_release_d.part=ae_i_inv_e.part;
-- On 12/07/2011 trans_type is defined at insertion
	UPDATE um_wrlabmat
		SET cost = cost * -1
		WHERE trans_type='INV RETURN'
		AND rec_type='A';

-- This loop retrieves additional information from diverse tables to be displayed by report
	OPEN curUm_wrlabmat;
	LOOP
		FETCH curUm_wrlabmat INTO chrUmWrLM_proposal,chrUmWrLM_sort_code,
			chrUmWrLM_bldg,chrUmWrLM_shop_person;
		EXIT WHEN curUm_wrlabmat%NOTFOUND;
		BEGIN
			SELECT shop,SUBSTR(description,1,70),beg_dt,status_code
				INTO chrShop,chrPhsdsc,datBeg_dt,chrStatus_code
				FROM ae_p_phs_e
				WHERE proposal=chrUmWrLM_proposal
				AND sort_code=chrUmWrLM_sort_code;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrShop:=NULL;
			chrPhsdsc:=NULL;
			datBeg_dt:=NULL;
			chrStatus_code:=NULL;
		END;
		BEGIN
			SELECT bldg,shop_person	INTO chrBldg,chrLead_person
				FROM ae_p_pro_e
				WHERE proposal=chrUmWrLM_proposal;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrBldg:=NULL;
			chrLead_person:=NULL;
		END;
		BEGIN
			SELECT SUBSTR(description,1,40) INTO chrBldgdsc
				FROM ae_s_bld_c
				WHERE bldg=chrBldg;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrBldgdsc:=NULL;
		END;
		BEGIN
			SELECT lname,fname INTO chrLname,chrFname
				FROM ae_h_emp_e
				WHERE shop_person=chrUmWrLM_shop_person;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrFname:=NULL;
			chrLname:=NULL;
		END;
		BEGIN
			SELECT lname,fname INTO chrLead_lname,chrLead_fname
				FROM ae_h_emp_e
				WHERE shop_person=chrLead_person;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrLead_lname:=NULL;
			chrLead_fname:=NULL;
		END;

-- Perform update to complete data for the corresponding row
		UPDATE um_wrlabmat
			SET shop=chrShop,phsdsc=chrPhsdsc,beg_dt=datBeg_dt,
				status_code=chrStatus_code,bldg=chrBldg,
				shop_person=chrUmWrLM_shop_person,bldgdsc=chrBldgdsc,
				empfname=chrFname,emplname=chrLname,leadlname=chrLead_lname,
				leadfname=chrLead_fname
			WHERE proposal=chrUmWrLM_proposal
			AND sort_code=chrUmWrLM_sort_code
			AND shop_person=chrUmWrLm_shop_person;
	END LOOP;
	CLOSE curUm_wrlabmat;
	COMMIT;
END proc_wrlabmatDt2;

-- Per Mona on 01/18/2009. Set as report
PROCEDURE proc_SeasonReimb IS
CURSOR curEmp IS
	SELECT a.shop_person,name,job_fam,TO_CHAR(sen_date,'YYYYMMDD'),
		u_num,prcnt_eff,w_stat
		FROM ae_h_emp_e a,ae_h_emp_pos_data b,rview_emp_name c
		WHERE a.shop_person=b.shop_person
		AND b.shop_person=c.shop_person
		AND active='Y'
		AND e_stat<>'B'
		AND w_stat IN('F','P');
chrShop_person		VARCHAR2(15);
chrName			VARCHAR2(80);
chrActive		VARCHAR2(1);
chrJob_fam		VARCHAR2(15);
chrSen_date		VARCHAR2(8);
chrU_num		VARCHAR2(15);
numPrcnt_eff		NUMBER(12,2);
chrW_stat		VARCHAR2(2);
--
numMonths_of_service	NUMBER(8,2);
numAccrued_hrs		NUMBER(14,2);
numCurr_balance		NUMBER(14,2);
numMax_accrual		NUMBER(14,2);
numCurr_plus_32	NUMBER(14,2);
numDeduct_allowed	NUMBER(14,2);
numDeduct_half		NUMBER(14,2);
numTot_deduct_allowed	NUMBER(14,2);
numTot_deduct_half	NUMBER(14,2);
datRun_date		DATE;
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_emp_lev_bal';
	datRun_date:=SYSDATE;
	OPEN curEmp;
	LOOP
		FETCH curEmp INTO chrShop_person,chrName,chrJob_fam,chrSen_date,chrU_num,
			numPrcnt_eff,chrW_stat;
-- 03/02/2010: For full-time employees, set Percentage to 100 when it is blank
		IF(chrW_stat='F' and numPrcnt_eff IS NULL) THEN
			numPrcnt_eff:=100;
		END IF;

		EXIT WHEN curEmp%NOTFOUND;
		SELECT MONTHS_BETWEEN (TO_DATE('20100101','YYYYMMDD'),
				TO_DATE(chrSen_date,'YYYYMMDD'))
			INTO numMonths_of_service
			FROM DUAL;
		IF(numMonths_of_service-trunc(numMonths_of_service)<>0)THEN
			numMonths_of_service:=TRUNC(numMonths_of_service+1);
		END IF;

		numCurr_balance:=NULL;
		IF(chrJob_fam='A') THEN -- 7P
			SELECT SUM(lev_adj) INTO numCurr_balance
				FROM ae_h_lev_d a,rview_tc_lv_adj_date b
				WHERE shop_person=chrShop_person
				AND  a.trans_num=b.trans_num
				AND b.adj_date<SYSDATE
				AND lev_class='7P';
			numCurr_balance:=NVL(numCurr_balance,0);
--------------
			IF(chrSen_date>'19890700' AND chrSen_date<'19910702') THEN
-- for this range of seniority dates set these fixed values
				numMonths_of_service:=125;
			ELSE
-- for any other seniority date compute number of months of service.
				SELECT MONTHS_BETWEEN(TO_DATE('20100101','YYYYMMDD'),
						TO_DATE(chrSen_date,'YYYYMMDD'))
					INTO numMonths_of_service
					FROM DUAL;
				IF(numMonths_of_service<>TRUNC(numMonths_of_service)) THEN
					numMonths_of_service:=TRUNC(numMonths_of_service+1);
				END IF;
-- compute lower and upper bounds based on number of months of service
--2400
				IF(numMonths_of_service<60) THEN
					numAccrued_hrs:=13.3;
					numMax_accrual:=240;
				ELSE
					IF(numMonths_of_service<120) THEN
						numAccrued_hrs:=17.3;
						numMax_accrual:=312;
					ELSE
						numAccrued_hrs:=21.3;
						numMax_accrual:=384;
					END IF;
				END IF;
				numDeduct_allowed:=56.1;
				numDeduct_half:=120;
-- adjust accrued hrs and bounds for part-time employees
				IF(chrW_stat='P') THEN
					IF(numPrcnt_eff<20) THEN
						numAccrued_hrs:=0;
						numMax_accrual:=0;
					ELSE
						numAccrued_hrs:=(numAccrued_hrs*numPrcnt_eff)/100;
						numMax_accrual:=(numMax_accrual*numPrcnt_eff)/100;
						numDeduct_allowed:=(numTot_deduct_allowed*numPrcnt_eff)/100;
						numDeduct_half:=(numTot_deduct_half*numPrcnt_eff)/100;
					END IF;
				END IF;
			END IF;
--------------
		ELSE --2V
			SELECT SUM(lev_adj) INTO numCurr_balance
				FROM ae_h_lev_d a,rview_tc_lv_adj_date b
				WHERE shop_person=chrShop_person
				AND  a.trans_num=b.trans_num
				AND b.adj_date<SYSDATE
				AND lev_class='2V';
			numCurr_balance:=NVL(numCurr_balance,0);

			IF(chrJob_fam='P') THEN
				-- SET PA_ACRRUALS
				numAccrued_hrs:=16;
				numMax_accrual:=384;

				IF(chrW_stat='P') THEN
					IF(numPrcnt_eff<20) THEN
						numAccrued_hrs:=0;
						numMax_accrual:=0;
					ELSE
						numAccrued_hrs:=numAccrued_hrs*numPrcnt_eff/100;
						numMax_accrual:=numAccrued_hrs*24;
					END IF;
				END IF;
			ELSE
				IF(chrShop_person IN('0565','0376','6684','0074','0897','0869',
							'0814','6532','6676','1619','6499',
							'6585','0947','6428')) THEN
					numAccrued_hrs:=16;
					numMax_accrual:=384;
				ELSE
					IF(numMonths_of_service<60) THEN
						numAccrued_hrs:=8;
						numMax_accrual:=192;
					ELSE
						IF(numMonths_of_service<96) THEN
							numAccrued_hrs:=12;
							numMax_accrual:=288;
						ELSE
							numAccrued_hrs:=16;
							numMax_accrual:=384;
						END IF;
					END IF;
				END IF;
				IF(chrW_stat='P') THEN
					IF(numPrcnt_eff<20) THEN
						numAccrued_hrs:=0;
						numMax_accrual:=0;
					ELSE
						numAccrued_hrs:=numAccrued_hrs*numPrcnt_eff/100;
						numMax_accrual:=numAccrued_hrs*24;
					END IF;
				END IF;
			END IF;
		END IF;
		INSERT INTO um_emp_lev_bal(shop,shop_person,name,hrs_accrued,curr_bal,
			max_accrual,curr_bal_plus_32,job_fam,w_stat,run_date)
			VALUES(chrU_num,chrShop_person,chrName,numAccrued_hrs,numCurr_balance,
			numMax_accrual,numCurr_balance+32,chrJob_fam,chrW_stat,datRun_date);
	END LOOP;
	COMMIT;
END proc_SeasonReimb;

PROCEDURE proc_hr0310(crystal_cursor IN OUT fmax_57.cr_cursor_hr0310) AS
-- Calls proc_SeasonReImb, which populates output table
-- This relates to report HR0310
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_emp_lev_bal';
	fmax_57.proc_SeasonReImb;
	OPEN crystal_cursor FOR SELECT * FROM um_emp_lev_bal;
END proc_Hr0310;

PROCEDURE proc_wrlabmatMulti(crystal_cursor IN OUT cr_cursor_wr0070,Work_Orders varchar2) AS
-- Calls proc_wrlabmat2, which populates output table
-- This relates to report WR0070
chrMulti_wr	VARCHAR2(500);
chrProposal	VARCHAR2(25);
numIdx		NUMBER;
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wrlabmat';
	chrMulti_wr:=TRIM(REPLACE(Work_Orders,' ',''));
	numIdx:=1;
	WHILE(LENGTH(chrMulti_wr)>0)
	LOOP
		IF(INSTR(chrMulti_wr,',',numIdx)>0) THEN
			chrProposal:=SUBSTR(chrMulti_wr,1,INSTR(chrMulti_wr,',')-1);
			chrMulti_wr:=SUBSTR(chrMulti_wr,INSTR(chrMulti_wr,',')+1);
		ELSE
			chrProposal:=chrMulti_wr;
			chrMulti_wr:=NULL;
		END IF;
		proc_wrlabmat2(chrProposal);
	END LOOP;
	OPEN crystal_cursor FOR SELECT * FROM um_wrlabmat;
END proc_wrlabmatMulti;

-- CREATE TABLE um_tc_entry_time(trans_no NUMBER(8),entry_time VARCHAR2(10),
-- entry_clerk VARCHAR2(20),beg_py DATE,end_py DATE);
PROCEDURE proc_TCEntryTime(crystal_cursor IN OUT fmax_57.cur_cursor_tc_entry,Entry_date DATE) IS
datEntry	DATE;
BEGIN
EXECUTE IMMEDIATE 'TRUNCATE TABLE iv_temp';
--insert into iv_temp values(Entry_date);
commit;
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_tc_entry_time';
	datEntry:=Entry_date;
	fmax_57.proc_TCEntryTimeA(Entry_date);
	OPEN crystal_cursor FOR SELECT * FROM um_tc_entry_time ORDER BY trans_no;
END proc_TCEntryTime;

PROCEDURE proc_TCEntryTimeA(datEntry_arg DATE) IS
datBeg_py	DATE;
datEnd_py	DATE;
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_tc_entry_time';

--Pending: code the scenario where it's run for non-Payroll Monday.
	IF(TRIM(TO_CHAR(datEntry_arg,'DAY'))='MONDAY') THEN
		SELECT TO_DATE(MAX(thru_date),'YYYYMMDD') INTO datEnd_py
			FROM um_p_wka_p
			WHERE TO_DATE(thru_date,'YYYYMMDD')<datEntry_arg;
		SELECT TO_DATE(MAX(from_date),'YYYYMMDD') INTO datBeg_py
			FROM um_p_wka_p
			WHERE TO_DATE(thru_date,'YYYYMMDD')=datEnd_py;
	ELSE
		SELECT TO_DATE(MAX(from_date),'YYYYMMDD') INTO datBeg_py
			FROM um_p_wka_p
			WHERE TO_DATE(from_date,'YYYYMMDD')<datEntry_arg;
		SELECT TO_DATE(MAX(thru_date),'YYYYMMDD') INTO datEnd_py
			FROM um_p_wka_p
			WHERE TO_DATE(from_date,'YYYYMMDD')=datBeg_py;
	END IF;
--dbms_output.put_line(datBeg_py||' '||datEnd_py);

	datEnd_py:=datEnd_py+1;
	INSERT INTO um_tc_entry_time
--		SELECT trans_no,TO_CHAR(a.entry_date,'hh24:mi:ss'),
		SELECT trans_no,a.entry_date,
			SUBSTR(a.entry_clerk,1,20),datBeg_py,datEnd_py,
			a.shop_person,
			(SELECT DISTINCT job_fam
				FROM um_p_wka_p
				WHERE shop_person=a.shop_person
				AND trans_date=TO_CHAR(a.sched_date,'YYYYMMDD')
			),
			a.sched_date
			FROM ae_p_wka_e a
			WHERE sched_date>=datBeg_py
			AND sched_date<datEnd_py
			AND TRUNC(entry_date)=datEntry_arg
			ORDER BY trans_no;
	UPDATE um_tc_entry_time
		SET job_fam=(SELECT job_fam FROM ae_h_emp_pos_data
				WHERE shop_person=um_tc_entry_time.shop_person
				)
		WHERE job_fam IS NULL;
	UPDATE um_tc_entry_time
		SET end_py=end_py-1;
	COMMIT;
END proc_TCEntryTimeA;

--CREATE TABLE um_wr9000_rpt(program_fy NUMBER(4),mth_yr VARCHAR2(10),Issued NUMBER,Closed NUMBER,
--one_day NUMBER,three_day NUMBER,over_three_day NUMBER,backlog NUMBER,
--ytd_issued NUMBER,ytd_closed NUMBER,ytd_one_day NUMBER,ytd_three_day NUMBER,
--ytd_over_three_day NUMBER,ytd_backlog NUMBER);
PROCEDURE proc_Wr9000A IS
CURSOR curPro IS
	SELECT b.proposal,b.sort_code,TRUNC(MIN(c.status_date)),b.status_code,a.program_fy
		FROM ae_p_pro_e a,ae_p_phs_e b,ae_p_pst_e c
		WHERE a.proposal=b.proposal
		AND b.shop='H1000'
-- Exclude PM and fetch only Priority Codes 01 through 03 (ticket 4948)
		AND a.category NOT IN('CAP','TO','PM')
		AND b.pri_code IN('01','02','03')
		AND b.proposal=c.proposal
		AND b.sort_code=c.sort_code
		AND a.ent_date>='01-MAY-2007'
		GROUP BY b.proposal,b.sort_code,b.status_code,a.program_fy
		ORDER BY TRUNC(MIN(c.status_date));
chrProposal		VARCHAR2(15);
chrSort_code		VARCHAR2(15);
datEnt_date		DATE;
chrStatus_code		VARCHAR2(30);
numProgram_fy		NUMBER(4);
chrPrev_period		VARCHAR2(10);
chrMth_yr		VARCHAR2(10);
numIssued		NUMBER;
numClosed		NUMBER;
numOne_day		NUMBER;
numThree_day		NUMBER;
numOver_three_day	NUMBER;
numBacklog		NUMBER;
datStatus_date		DATE;
datMin_status_date	DATE;
numPrev_fy		NUMBER(4);
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wr9000_rpt';
	numPrev_fy:=0;
	numIssued:=0;
	numClosed:=0;
	numOne_day:=0;
	numThree_day:=0;
	numOver_three_day:=0;
	numBacklog:=0;
	chrPrev_period:='04/2007';
	numPrev_fy:=2007;
	OPEN curPro;
	LOOP
		FETCH curPro INTO chrProposal,chrSort_code,datEnt_date,chrStatus_code,
			numProgram_fy;
		chrMth_yr:=TO_CHAR(datEnt_date,'MM/YYYY');
		IF(chrPrev_period<>chrMth_yr OR curPro%NOTFOUND) THEN
			INSERT INTO um_wr9000_rpt(program_fy,mth_yr,issued,closed,one_day,
				three_day,over_three_day,backlog,ytd_issued,ytd_closed,
				ytd_one_day,ytd_three_day,ytd_over_three_day,ytd_backlog)
				VALUES(numPrev_fy,chrPrev_period,
				numIssued,numClosed,numOne_day,numThree_day,
				numOver_three_day,numBacklog,0,0,0,0,0,0);
			UPDATE um_wr9000_rpt
				SET ytd_issued=(SELECT SUM(issued)
						FROM um_wr9000_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_closed=(SELECT SUM(closed)
						FROM um_wr9000_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_one_day=(SELECT SUM(one_day)
						FROM um_wr9000_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_three_day=(SELECT SUM(three_day)
						FROM um_wr9000_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_over_three_day=(SELECT SUM(over_three_day)
						FROM um_wr9000_rpt a
						WHERE a.program_fy=numPrev_fy
					)
				WHERE mth_yr=chrPrev_period;
			numPrev_fy:=numProgram_fy;
			chrPrev_period:=chrMth_yr;
			numIssued:=0;
			numClosed:=0;
			numOne_day:=0;
			numThree_day:=0;
			numOver_three_day:=0;
			numBacklog:=0;
		END IF;
		numIssued:=numIssued+1;
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			numClosed:=numClosed+1;
		END IF;
		datStatus_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datStatus_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='COMPLETE';
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CLOSED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE+1)) THEN
			datStatus_date:=datMin_status_date;
		END IF;
		datMin_status_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CANCELLED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE)+1) THEN
			datStatus_date:=datMin_status_date;
		END IF;


		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			CASE
				WHEN datStatus_date-datEnt_date<2 THEN numOne_day:=numOne_day+1;
				WHEN datStatus_date-datEnt_date<4 THEN numThree_day:=numThree_day+1;
				ELSE numOver_three_day:=numOver_three_day+1;
			END CASE;
			IF(MONTHS_BETWEEN(datStatus_date,datEnt_date)>1) THEN
				numBacklog:=numBacklog+1;
-- Per Diana M Caulkins on 09/13/2011, "Over 3 days" shouldn't include w.o.s in backlog of that period.
-- This reverts the original implementation, where Over 3 Days included Backlog.
-- See explanation from ticket 3336 on 09/06/2011.
				numOver_three_day:=numOver_three_day-1;
			END IF;
		ELSE
			numBacklog:=numBacklog+1;
		END IF;
		EXIT WHEN curPro%NOTFOUND;
	END LOOP;
	CLOSE curPro;
	DELETE FROM um_Wr9000_rpt WHERE mth_yr='04/2007';
	COMMIT;
END proc_Wr9000A;

--CREATE TABLE um_wr9002_rpt(program_fy NUMBER(4),mth_yr VARCHAR2(10),Issued NUMBER,Closed NUMBER,
--fifteen_day NUMBER,thirty_day NUMBER,over_a_month NUMBER,backlog NUMBER,
--ytd_issued NUMBER,ytd_closed NUMBER,ytd_fifteen_day NUMBER,ytd_thirty_day NUMBER,
--ytd_over_a_month NUMBER,ytd_backlog NUMBER);
PROCEDURE proc_Wr9002A IS
CURSOR curPro IS
	SELECT b.proposal,b.sort_code,TRUNC(MIN(c.status_date)),a.status_code,a.program_fy
		FROM ae_p_pro_e a,ae_p_phs_e b,ae_p_pst_e c
		WHERE a.proposal=b.proposal
		AND b.shop IN('H2000','H3000')
		AND a.category NOT IN('CAP','TO')
		AND a.ent_date>='01-MAY-2007'
		AND b.proposal=c.proposal
		AND b.sorT_code=c.sort_code
		GROUP BY b.proposal,b.sort_code,a.status_code,a.program_fy
		ORDER BY TRUNC(MIN(status_date));
chrProposal		VARCHAR2(15);
chrSort_code		VARCHAR2(15);
datEnt_date		DATE;
chrStatus_code		VARCHAR2(30);
numProgram_fy		NUMBER(4);
chrPrev_period		VARCHAR2(10);
chrMth_yr		VARCHAR2(10);
numIssued		NUMBER;
numClosed		NUMBER;
num15_day		NUMBER;
num30_31_day		NUMBER;
numOver_a_month		NUMBER;
numBacklog		NUMBER;
datStatus_date		DATE;
datMin_status_date	DATE;
numPrev_fy		NUMBER(4);
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wr9002_rpt';
	numPrev_fy:=0;
	numIssued:=0;
	numClosed:=0;
	num15_day:=0;
	num30_31_day:=0;
	numOver_a_month:=0;
	numBacklog:=0;
	chrPrev_period:='04/2007';
	numPrev_fy:=2007;
	OPEN curPro;
	LOOP
		FETCH curPro INTO chrProposal,chrSort_code,datEnt_date,chrStatus_code,
			numProgram_fy;
		chrMth_yr:=TO_CHAR(datEnt_date,'MM/YYYY');
		IF(chrPrev_period<>chrMth_yr OR curPro%NOTFOUND) THEN
if(chrPrev_period='01/2012') then
dbms_output.put_line(numIssued);
end if;
			INSERT INTO um_wr9002_rpt(program_fy,mth_yr,issued,closed,fifteen_day,
				thirty_day,over_a_month,backlog,ytd_issued,ytd_closed,
				ytd_fifteen_day,ytd_thirty_day,ytd_over_a_month,ytd_backlog)
				VALUES(numPrev_fy,chrPrev_period,
				numIssued,numClosed,num15_day,num30_31_day,
				numOver_a_month,numBacklog,0,0,0,0,0,0);
			UPDATE um_wr9002_rpt
				SET ytd_issued=(SELECT SUM(issued)
						FROM um_wr9002_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_closed=(SELECT SUM(closed)
						FROM um_wr9002_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_fifteen_day=(SELECT SUM(fifteen_day)
						FROM um_wr9002_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_thirty_day=(SELECT SUM(thirty_day)
						FROM um_wr9002_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_over_a_month=(SELECT SUM(over_a_month)
						FROM um_wr9002_rpt a
						WHERE a.program_fy=numPrev_fy
					)
				WHERE mth_yr=chrPrev_period;
			numPrev_fy:=numProgram_fy;
			chrPrev_period:=chrMth_yr;
			numIssued:=0;
			numClosed:=0;
			num15_day:=0;
			num30_31_day:=0;
			numOver_a_month:=0;
			numBacklog:=0;
		END IF;
		numIssued:=numIssued+1;
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			numClosed:=numClosed+1;
		END IF;
		datStatus_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datStatus_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='COMPLETE';
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CLOSED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE+1)) THEN
			datStatus_date:=datMin_status_date;
		END IF;
		datMin_status_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CANCELLED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE)+1) THEN
			datStatus_date:=datMin_status_date;
		END IF;


		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			CASE
				WHEN datStatus_date-datEnt_date<16 THEN num15_day:=num15_day+1;
				WHEN MONTHS_BETWEEN(datStatus_date,datEnt_date)<1 THEN num30_31_day:=num30_31_day+1;
				ELSE numOver_a_month:=numOver_a_month+1;
			END CASE;
			IF(MONTHS_BETWEEN(datStatus_date,datEnt_date)>1) THEN
				numBacklog:=numBacklog+1;
-- Comment came from proc_wr9000A
-- Per Diana M Caulkins on 09/13/2011, "Over 3 days" shouldn't include w.o.s in backlog of that period.
-- This reverts the original implementation, where Over 3 Days included Backlog.
-- See explanation from ticket 3336 on 09/06/2011.
				numOver_a_month:=numOver_a_month-1;
			END IF;
		ELSE
			numBacklog:=numBacklog+1;
		END IF;
		EXIT WHEN curPro%NOTFOUND;
	END LOOP;
	CLOSE curPro;
	DELETE FROM um_Wr9002_rpt WHERE mth_yr='04/2007';
	COMMIT;
END proc_Wr9002A;

--CREATE TABLE um_wr9004_rpt(program_fy NUMBER(4),mth_yr VARCHAR2(10),Issued NUMBER,Closed NUMBER,
--one_day NUMBER,three_day NUMBER,over_three_day NUMBER,backlog NUMBER,
--ytd_issued NUMBER,ytd_closed NUMBER,ytd_one_day NUMBER,ytd_three_day NUMBER,
--ytd_over_three_day NUMBER,ytd_backlog NUMBER,fac_id VARCHAR2(15),fac_id_desc VARCHAR2(80));
PROCEDURE proc_Wr9004A IS
CURSOR curPro IS
	SELECT b.proposal,b.sort_code,TRUNC(MIN(d.status_date)),a.status_code,a.program_fy,
-- Per Diane Caulkins on 05/30/2012 (ticket 7767), report shoud be set up by building,
-- not by campus. This is because of the recent Housing transition to the new structure.
--			a.fac_id,c.description
--		FROM ae_p_pro_e a,ae_p_phs_e b,ae_b_fac_e c,ae_p_pst_e d
-- Per Diana on 6/5/2012 (ticket 7767)
--			a.bldg,
		(CASE WHEN c.description LIKE 'BAITS %' THEN 'BAITS'
			WHEN c.description LIKE 'OXFORD %' THEN 'OXFORD'
			WHEN c.description LIKE 'NORTHWOOD 1%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 2%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 3%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD I %' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD II%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 4%' THEN 'NORTHWOOD 4-5'
			WHEN c.description LIKE 'NORTHWOOD 5%' THEN 'NORTHWOOD 4-5'
			ELSE a.bldg
		END) bldg,
		(CASE WHEN c.description LIKE 'BAITS %' THEN 'BAITS'
			WHEN c.description LIKE 'OXFORD %' THEN 'OXFORD'
			WHEN c.description LIKE 'NORTHWOOD 1%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 2%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 3%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD I %' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD II%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 4%' THEN 'NORTHWOOD 4-5'
			WHEN c.description LIKE 'NORTHWOOD 5%' THEN 'NORTHWOOD 4-5'
		ELSE c.description
		END) description
		FROM ae_p_pro_e a,ae_p_phs_e b,ae_s_bld_c c,ae_p_pst_e d
		WHERE a.proposal=b.proposal
		AND b.shop='H1000'
		AND a.category NOT IN('CAP','TO')
		AND b.pri_code IN('01','02','03')
		AND a.ent_date>='01-MAY-2007'
--		AND a.fac_id=c.fac_id
		AND a.bldg=c.bldg
		AND a.region_code=c.region_code
		AND b.proposal=d.proposal
		AND b.sort_code=d.sort_code
		GROUP BY b.proposal,b.sort_code,a.status_code,a.program_fy,
--			a.fac_id,c.description
--			a.bldg,
		(CASE WHEN c.description LIKE 'BAITS %' THEN 'BAITS'
			WHEN c.description LIKE 'OXFORD %' THEN 'OXFORD'
			WHEN c.description LIKE 'NORTHWOOD 1%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 2%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 3%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD I %' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD II%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 4%' THEN 'NORTHWOOD 4-5'
			WHEN c.description LIKE 'NORTHWOOD 5%' THEN 'NORTHWOOD 4-5'
			ELSE a.bldg
		END),
		(CASE WHEN c.description LIKE 'BAITS %' THEN 'BAITS'
			WHEN c.description LIKE 'OXFORD %' THEN 'OXFORD'
			WHEN c.description LIKE 'NORTHWOOD 1%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 2%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 3%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD I %' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD II%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 4%' THEN 'NORTHWOOD 4-5'
			WHEN c.description LIKE 'NORTHWOOD 5%' THEN 'NORTHWOOD 4-5'
		ELSE c.description
		END)
--		ORDER BY a.fac_id,TRUNC(MIN(d.status_date));
		ORDER BY (CASE WHEN c.description LIKE 'BAITS %' THEN 'BAITS'
			WHEN c.description LIKE 'OXFORD %' THEN 'OXFORD'
			WHEN c.description LIKE 'NORTHWOOD 1%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 2%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 3%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD I %' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD II%' THEN 'NORTHWOOD 1-3'
			WHEN c.description LIKE 'NORTHWOOD 4%' THEN 'NORTHWOOD 4-5'
			WHEN c.description LIKE 'NORTHWOOD 5%' THEN 'NORTHWOOD 4-5'
			ELSE a.bldg
		END),
		TRUNC(MIN(d.status_date));
chrProposal		VARCHAR2(15);
chrSort_code		VARCHAR2(15);
datEnt_date		DATE;
chrStatus_code		VARCHAR2(30);
numProgram_fy		NUMBER(4);
chrPrev_period		VARCHAR2(10);
chrMth_yr		VARCHAR2(10);
numIssued		NUMBER;
numClosed		NUMBER;
numOne_day		NUMBER;
numThree_day		NUMBER;
numOver_three_day	NUMBER;
numBacklog		NUMBER;
datStatus_date		DATE;
datMin_status_date	DATE;
numPrev_fy		NUMBER(4);
chrPrev_fac_id		VARCHAR2(15);
chrFac_id		VARCHAR2(15);
chrPrev_fac_id_desc	VARCHAR2(255);
chrFac_id_desc		VARCHAR2(255);
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wr9004_rpt';
	numPrev_fy:=0;
	numIssued:=0;
	numClosed:=0;
	numOne_day:=0;
	numThree_day:=0;
	numOver_three_day:=0;
	numBacklog:=0;
	chrPrev_period:='04/2007';
	numPrev_fy:=2007;
	chrPrev_fac_id:=' ';
	chrPrev_fac_id_desc:=' ';
	OPEN curPro;
	LOOP
		FETCH curPro INTO chrProposal,chrSort_code,datEnt_date,chrStatus_code,
			numProgram_fy,chrFac_id,chrFac_id_desc;
		chrMth_yr:=TO_CHAR(datEnt_date,'MM/YYYY');
		IF(chrPrev_period<>chrMth_yr OR chrPrev_fac_id<>chrFac_id OR curPro%NOTFOUND) THEN
			INSERT INTO um_wr9004_rpt(program_fy,mth_yr,issued,closed,one_day,
				three_day,over_three_day,backlog,ytd_issued,ytd_closed,
				ytd_one_day,ytd_three_day,ytd_over_three_day,ytd_backlog,
				fac_id,fac_id_desc)
				VALUES(numPrev_fy,chrPrev_period,
				numIssued,numClosed,numOne_day,numThree_day,
				numOver_three_day,numBacklog,0,0,0,0,0,0,chrPrev_fac_id,
				SUBSTR(chrPrev_fac_id_desc,1,80));
			UPDATE um_wr9004_rpt
				SET ytd_issued=(SELECT SUM(issued)
						FROM um_wr9004_rpt a
						WHERE a.program_fy=numPrev_fy
						AND a.fac_id=chrPrev_fac_id
					),
				ytd_closed=(SELECT SUM(closed)
						FROM um_wr9004_rpt a
						WHERE a.program_fy=numPrev_fy
						AND a.fac_id=chrPrev_fac_id
					),
				ytd_one_day=(SELECT SUM(one_day)
						FROM um_wr9004_rpt a
						WHERE a.program_fy=numPrev_fy
						AND a.fac_id=chrPrev_fac_id
					),
				ytd_three_day=(SELECT SUM(three_day)
						FROM um_wr9004_rpt a
						WHERE a.program_fy=numPrev_fy
						AND a.fac_id=chrPrev_fac_id
					),
				ytd_over_three_day=(SELECT SUM(over_three_day)
						FROM um_wr9004_rpt a
						WHERE a.program_fy=numPrev_fy
						AND a.fac_id=chrPrev_fac_id
					)
				WHERE mth_yr=chrPrev_period
				AND fac_id=chrPrev_fac_id;

			numPrev_fy:=numProgram_fy;
			chrPrev_fac_id:=chrFac_id;
			chrPrev_fac_id_desc:=chrFac_id_desc;
			chrPrev_period:=chrMth_yr;
			numIssued:=0;
			numClosed:=0;
			numOne_day:=0;
			numThree_day:=0;
			numOver_three_day:=0;
			numBacklog:=0;
		END IF;
		numIssued:=numIssued+1;
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			numClosed:=numClosed+1;
		END IF;
		datStatus_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datStatus_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='COMPLETE';
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CLOSED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE+1)) THEN
			datStatus_date:=datMin_status_date;
		END IF;
		datMin_status_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CANCELLED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE)+1) THEN
			datStatus_date:=datMin_status_date;
		END IF;


		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			CASE
				WHEN datStatus_date-datEnt_date<2 THEN numOne_day:=numOne_day+1;
				WHEN datStatus_date-datEnt_date<4 THEN numThree_day:=numThree_day+1;
				ELSE numOver_three_day:=numOver_three_day+1;
			END CASE;
			IF(MONTHS_BETWEEN(datStatus_date,datEnt_date)>1) THEN
				numBacklog:=numBacklog+1;
-- Per Diana M Caulkins on 09/13/2011, "Over 3 days" shouldn't include w.o.s in backlog of that period.
-- This reverts the original implementation, where Over 3 Days included Backlog.
-- See explanation from ticket 3336 on 09/06/2011.
				numOver_three_day:=numOver_three_day-1;
			END IF;
		ELSE
			numBacklog:=numBacklog+1;
		END IF;
		EXIT WHEN curPro%NOTFOUND;
	END LOOP;
	CLOSE curPro;
	DELETE FROM um_Wr9004_rpt WHERE mth_yr='04/2007' OR TRIM(fac_id) IS NULL;
	COMMIT;
END proc_Wr9004A;

PROCEDURE proc_WR9005A IS
CURSOR curPst(datInitial_cur DATE) IS
	SELECT proposal,sort_code,status_date,status_code
		FROM ae_p_pst_e
		WHERE (proposal,sort_code)
			IN(SELECT a.proposal,a.sort_code
				FROM ae_p_phs_e a,ae_p_pro_e b,ae_p_pst_e C
				WHERE a.shop='H1000'
				AND a.order_type='H'
				AND pri_code IN('01','02','03')
				AND a.proposal=b.proposal
				AND b.ent_date>=datInitial_cur --'01-MAY-2007'
				AND a.proposal=c.proposal
				AND a.sort_code=c.sort_code
				GROUP BY a.proposal,a.sort_code
			)
		ORDER BY proposal,sort_code,status_date;
-- Variables "coming" from WR9000
CURSOR curPro IS
	SELECT b.proposal,b.sort_code,TRUNC(MIN(c.status_date)),b.status_code,a.program_fy
		FROM ae_p_pro_e a,ae_p_phs_e b,ae_p_pst_e c
		WHERE a.proposal=b.proposal
		AND b.shop='H1000'
---- Exclude PM and fetch only Priority Codes 01 through 03 (ticket 4948)
--		AND a.category NOT IN('CAP','TO','PM')
		AND b.pri_code IN('01','02','03')
		AND b.proposal=c.proposal
		AND b.sort_code=c.sort_code
		AND a.ent_date>='01-MAY-2007'
		GROUP BY b.proposal,b.sort_code,b.status_code,a.program_fy
		ORDER BY TRUNC(MIN(c.status_date));
numPrev_fy		NUMBER;
numIssued		NUMBER;
numClosed		NUMBER;
numBacklog		NUMBER;
numOne_day		NUMBER;
numThree_day		NUMBER;
numOver_three_day	NUMBER;
chrPrev_period		VARCHAR2(7);
numProgram_fy		NUMBER;
chrMth_yr		VARCHAR2(7);
datMin_status_date	DATE;
datEnt_date		DATE;


chrProposal		VARCHAR2(25);
chrSort_code		VARCHAR2(5);
chrStatus_code		VARCHAR2(50);
datStatus_date		DATE;
chrPrv_proposal		VARCHAR2(25);
chrPrv_sort_code	VARCHAR2(5);
chrPrv_status_code	VARCHAR2(35);
chrMin_date		VARCHAR2(6);
chrMax_date		VARCHAR2(6);
CURSOR curPst_ii IS
	SELECT a.proposal,a.sort_code,TRUNC(MIN(status_date))
		FROM ae_p_phs_e a,ae_p_Pst_e b,ae_p_pro_e c
		WHERE a.shop IN('H2000','H3000')
		AND a.pri_code IN('01','02','03')
		AND a.order_type='H'
		AND a.proposal=c.proposal
		AND c.ent_date>='01-MAY-2007'
		AND a.proposal=b.proposal
		AND a.sort_code=b.sort_code
		AND b.status_code NOT IN('CLOSED','CANCELLED')
		GROUP BY a.proposal,a.sort_code
		ORDER BY a.proposal,a.sort_code;
numCount		NUMBER;
chrPrv_pre_trades_phs	VARCHAR2(5);
chrPre_trades_phs	VARCHAR2(5);
datPre_trade_status	DATE;
datInitial		DATE;
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wr9005_rpt';
	numPrev_fy:=0;
	numIssued:=0;
	numClosed:=0;
	numOne_day:=0;
	numThree_day:=0;
	numOver_three_day:=0;
	numBacklog:=0;
	chrPrev_period:='04/2007';
	numPrev_fy:=2007;
	OPEN curPro;
	LOOP
		FETCH curPro INTO chrProposal,chrSort_code,datEnt_date,chrStatus_code,
			numProgram_fy;
		chrMth_yr:=TO_CHAR(datEnt_date,'MM/YYYY');
		IF(chrPrev_period<>chrMth_yr OR curPro%NOTFOUND) THEN
-- initialize rcd and variables for new month
			INSERT INTO um_wr9005_rpt(program_fy,mth_yr,issued,closed,one_day,
				three_day,over_three_day,backlog,ytd_issued,ytd_closed,
				ytd_one_day,ytd_three_day,ytd_over_three_day,ytd_backlog,
				carry_over,ref_2_trades)
				VALUES(numPrev_fy,chrPrev_period,
				numIssued,numClosed,numOne_day,numThree_day,
				numOver_three_day,numBacklog,0,0,0,0,0,0,0,0);
			UPDATE um_wr9005_rpt
				SET ytd_issued=(SELECT SUM(issued)
						FROM um_wr9005_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_closed=(SELECT SUM(closed)
						FROM um_wr9005_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_one_day=(SELECT SUM(one_day)
						FROM um_wr9005_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_three_day=(SELECT SUM(three_day)
						FROM um_wr9005_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_over_three_day=(SELECT SUM(over_three_day)
						FROM um_wr9005_rpt a
						WHERE a.program_fy=numPrev_fy
					)
				WHERE mth_yr=chrPrev_period;
			numPrev_fy:=numProgram_fy;
			chrPrev_period:=chrMth_yr;
			numIssued:=0;
			numClosed:=0;
			numOne_day:=0;
			numThree_day:=0;
			numOver_three_day:=0;
			numBacklog:=0;
		END IF;
		numIssued:=numIssued+1;
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			numClosed:=numClosed+1;
		END IF;

-- retrieve earliest completion/closing status, given that w.o.s might reopen
		datStatus_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datStatus_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='COMPLETE';
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CLOSED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE+1)) THEN
			datStatus_date:=datMin_status_date;
		END IF;
		datMin_status_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CANCELLED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE)+1) THEN
			datStatus_date:=datMin_status_date;
		END IF;

-- classify completion timeframe
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			CASE
				WHEN datStatus_date-datEnt_date<2 THEN numOne_day:=numOne_day+1;
				WHEN datStatus_date-datEnt_date<4 THEN numThree_day:=numThree_day+1;
				ELSE numOver_three_day:=numOver_three_day+1;
			END CASE;
			IF(MONTHS_BETWEEN(datStatus_date,datEnt_date)>1) THEN
				numBacklog:=numBacklog+1;
-- Per Diana M Caulkins on 09/13/2011, "Over 3 days" shouldn't include w.o.s in backlog of that period.
-- This reverts the original implementation, where Over 3 Days included Backlog.
-- See explanation from ticket 3336 on 09/06/2011.
				numOver_three_day:=numOver_three_day-1;
			END IF;
		ELSE
			numBacklog:=numBacklog+1;
		END IF;
		EXIT WHEN curPro%NOTFOUND;
	END LOOP;
	CLOSE curPro;
	DELETE FROM um_Wr9005_rpt WHERE mth_yr='04/2007';

-- functionality additional to that of wr9000
	chrPrv_proposal:=' ';
	chrPrv_sort_code:=' ';


	datInitial:='01-MAY-2007';
	chrMin_date:='200705';
	chrMax_date:=chrMin_date;
	UPDATE um_wr9005_rpt
		SET yr_mth=SUBSTR(mth_yr,4)||SUBSTR(mth_yr,1,2);

	OPEN curPst(datInitial);
	LOOP
		FETCH curPst INTO chrProposal,chrSorT_code,datStatus_Date,chrStatus_Code;
		IF(chrPrv_proposal=' ') THEN
			chrPrv_proposal:=chrProposal;
			chrPrv_sort_code:=chrSort_code;
			chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
			chrPrv_status_code:=chrStatus_code;
		END IF;
		IF(chrPrv_proposal=chrProposal AND chrPrv_sort_code=chrSort_code) THEN
			chrMax_date:=TO_CHAR(datStatus_date,'YYYYMM');
			IF(chrStatus_code IN('COMPLETE','CLOSED','CANCELLED')) THEN
				chrMax_date:=TO_CHAR(datStatus_date,'YYYYMM');
				IF(chrPrv_status_code<>chrStatus_code) THEN
					UPDATE um_wr9005_rpt
						SET carry_over=carry_over+1
						WHERE yr_mth>chrMin_date
						AND yr_mth<=chrMax_date;
				END IF;
				chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
				chrPrv_status_code:=chrStatus_code;
			ELSE -- reopened. Might need to upd chrMin_date
				IF(chrPrv_status_code IN('COMPLETE','CLOSED','CANCELLED')) THEN
					chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
					chrMax_date:=chrMin_date;
					chrPrv_status_code:=chrStatus_code;
				END IF;
			END IF;
		ELSE
			IF(chrPrv_status_code NOT IN('COMPLETE','CLOSED','CANCELLED')) THEN
				UPDATE um_wr9005_rpt
					SET carry_over=carry_over+1
					WHERE yr_mth>chrMin_date;
			END IF;
			chrPrv_proposal:=chrProposal;
			chrPrv_sort_code:=chrSort_code;
			chrPrv_status_code:=chrStatus_code;
			chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
			chrMax_date:=chrMin_date;
		END IF;
		EXIT WHEN curPst%NOTFOUND;
	END LOOP;
	CLOSE curPst;


-- Referred-To-Trades portion
	chrPrv_pre_trades_phs:='000';
	chrPrv_proposal:=' ';
	OPEN curPst_ii;
	LOOP
		FETCH curPst_ii INTO chrProposal,chrSort_code,datStatus_date;
		EXIT WHEN curPst_ii%NOTFOUND;
		IF(chrPrv_proposal<>chrProposal) THEN
			chrPrv_pre_trades_phs:='000';
			chrPrv_proposal:=chrProposal;
		END IF;
		SELECT COUNT(*),MAX(sort_code) INTO numCount,chrPre_trades_phs
			FROM ae_p_phs_e
			WHERE proposal=chrProposal
			AND shop='H1000'
			AND order_type='H'
			AND sort_code<chrSort_code;
		IF(numCount>0) THEN
-- there's a phase that's probably a w.o. "transfer" to Trades
			SELECT TRUNC(MAX(status_date)) INTO datPre_trade_status
				FROM ae_p_pst_e
				WHERE proposal=chrProposal
				AND sort_code=chrPre_trades_phs;
			IF(datStatus_date-datPre_trade_status<2) THEN
				IF(chrPrv_pre_trades_phs<chrPre_trades_phs) THEN
					UPDATE um_wr9005_rpt
						SET ref_2_trades=ref_2_trades+1
						WHERE yr_mth=TO_CHAR(datStatus_date,'YYYYMM');
					chrPrv_pre_trades_phs:=chrPre_trades_phs;
				END IF;
			END IF;
		END IF;
	END LOOP;
	CLOSE curPst_ii;
	COMMIT;
END proc_WR9005A;

PROCEDURE proc_WR9006A IS
CURSOR curPst(datInitial_cur DATE) IS
	SELECT proposal,sort_code,status_date,status_code
		FROM ae_p_pst_e
		WHERE (proposal,sort_code)
			IN(SELECT a.proposal,a.sort_code
				FROM ae_p_phs_e a,ae_p_pro_e b,ae_p_pst_e C
				WHERE a.shop='H1000'
				AND a.order_type='H'
				AND pri_code IN('04','05','06')
				AND a.proposal=b.proposal
				AND b.ent_date>=datInitial_cur --'01-MAY-2007'
				AND a.proposal=c.proposal
				AND a.sort_code=c.sort_code
				GROUP BY a.proposal,a.sort_code
			)
		ORDER BY proposal,sort_code,status_date;
-- Variables "coming" from WR9000
CURSOR curPro IS
	SELECT b.proposal,b.sort_code,TRUNC(MIN(c.status_date)),b.status_code,a.program_fy
		FROM ae_p_pro_e a,ae_p_phs_e b,ae_p_pst_e c
		WHERE a.proposal=b.proposal
		AND b.shop='H1000'
---- Exclude PM and fetch only Priority Codes 01 through 03 (ticket 4948)
--		AND a.category NOT IN('CAP','TO','PM')
		AND b.pri_code IN('04','05','06')
		AND b.proposal=c.proposal
		AND b.sort_code=c.sort_code
		AND a.ent_date>='01-MAY-2007'
		GROUP BY b.proposal,b.sort_code,b.status_code,a.program_fy
		ORDER BY TRUNC(MIN(c.status_date));
numPrev_fy		NUMBER;
numIssued		NUMBER;
numClosed		NUMBER;
numBacklog		NUMBER;
numOne_day		NUMBER;
numThree_day		NUMBER;
numOver_three_day	NUMBER;
chrPrev_period		VARCHAR2(7);
numProgram_fy		NUMBER;
chrMth_yr		VARCHAR2(7);
datMin_status_date	DATE;
datEnt_date		DATE;


chrProposal		VARCHAR2(25);
chrSort_code		VARCHAR2(5);
chrStatus_code		VARCHAR2(50);
datStatus_date		DATE;
chrPrv_proposal		VARCHAR2(25);
chrPrv_sort_code	VARCHAR2(5);
chrPrv_status_code	VARCHAR2(35);
chrMin_date		VARCHAR2(6);
chrMax_date		VARCHAR2(6);
CURSOR curPst_ii IS
	SELECT a.proposal,a.sort_code,TRUNC(MIN(status_date))
		FROM ae_p_phs_e a,ae_p_Pst_e b,ae_p_pro_e c
		WHERE a.shop IN('H2000','H3000')
		AND a.pri_code IN('04','05','06')
		AND a.order_type='H'
		AND a.proposal=c.proposal
		AND c.ent_date>='01-MAY-2007'
		AND a.proposal=b.proposal
		AND a.sort_code=b.sort_code
		AND b.status_code NOT IN('CLOSED','CANCELLED')
		GROUP BY a.proposal,a.sort_code
		ORDER BY a.proposal,a.sort_code;
numCount		NUMBER;
chrPrv_pre_trades_phs	VARCHAR2(5);
chrPre_trades_phs	VARCHAR2(5);
datPre_trade_status	DATE;
datInitial		DATE;
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wr9006_rpt';
	numPrev_fy:=0;
	numIssued:=0;
	numClosed:=0;
	numOne_day:=0;
	numThree_day:=0;
	numOver_three_day:=0;
	numBacklog:=0;
	chrPrev_period:='04/2007';
	numPrev_fy:=2007;
	OPEN curPro;
	LOOP
		FETCH curPro INTO chrProposal,chrSort_code,datEnt_date,chrStatus_code,
			numProgram_fy;
		chrMth_yr:=TO_CHAR(datEnt_date,'MM/YYYY');
		IF(chrPrev_period<>chrMth_yr OR curPro%NOTFOUND) THEN
-- initialize rcd and variables for new month
			INSERT INTO um_wr9006_rpt(program_fy,mth_yr,issued,closed,one_day,
				three_day,over_three_day,backlog,ytd_issued,ytd_closed,
				ytd_one_day,ytd_three_day,ytd_over_three_day,ytd_backlog,
				carry_over,ref_2_trades)
				VALUES(numPrev_fy,chrPrev_period,
				numIssued,numClosed,numOne_day,numThree_day,
				numOver_three_day,numBacklog,0,0,0,0,0,0,0,0);
			UPDATE um_wr9006_rpt
				SET ytd_issued=(SELECT SUM(issued)
						FROM um_wr9006_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_closed=(SELECT SUM(closed)
						FROM um_wr9006_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_one_day=(SELECT SUM(one_day)
						FROM um_wr9006_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_three_day=(SELECT SUM(three_day)
						FROM um_wr9006_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_over_three_day=(SELECT SUM(over_three_day)
						FROM um_wr9006_rpt a
						WHERE a.program_fy=numPrev_fy
					)
				WHERE mth_yr=chrPrev_period;
			numPrev_fy:=numProgram_fy;
			chrPrev_period:=chrMth_yr;
			numIssued:=0;
			numClosed:=0;
			numOne_day:=0;
			numThree_day:=0;
			numOver_three_day:=0;
			numBacklog:=0;
		END IF;
		numIssued:=numIssued+1;
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			numClosed:=numClosed+1;
		END IF;

-- retrieve earliest completion/closing status, given that w.o.s might reopen
		datStatus_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datStatus_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='COMPLETE';
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CLOSED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE+1)) THEN
			datStatus_date:=datMin_status_date;
		END IF;
		datMin_status_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CANCELLED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE)+1) THEN
			datStatus_date:=datMin_status_date;
		END IF;

-- classify completion timeframe
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			CASE
				WHEN datStatus_date-datEnt_date<2 THEN numOne_day:=numOne_day+1;
				WHEN datStatus_date-datEnt_date<4 THEN numThree_day:=numThree_day+1;
				ELSE numOver_three_day:=numOver_three_day+1;
			END CASE;
			IF(MONTHS_BETWEEN(datStatus_date,datEnt_date)>1) THEN
				numBacklog:=numBacklog+1;
-- Per Diana M Caulkins on 09/13/2011, "Over 3 days" shouldn't include w.o.s in backlog of that period.
-- This reverts the original implementation, where Over 3 Days included Backlog.
-- See explanation from ticket 3336 on 09/06/2011.
				numOver_three_day:=numOver_three_day-1;
			END IF;
		ELSE
			numBacklog:=numBacklog+1;
		END IF;
		EXIT WHEN curPro%NOTFOUND;
	END LOOP;
	CLOSE curPro;
	DELETE FROM um_Wr9006_rpt WHERE mth_yr='04/2007';

-- functionality additional to that of wr9000
	chrPrv_proposal:=' ';
	chrPrv_sort_code:=' ';


	datInitial:='01-MAY-2007';
	chrMin_date:='200705';
	chrMax_date:=chrMin_date;
	UPDATE um_wr9006_rpt
		SET yr_mth=SUBSTR(mth_yr,4)||SUBSTR(mth_yr,1,2);

	OPEN curPst(datInitial);
	LOOP
		FETCH curPst INTO chrProposal,chrSorT_code,datStatus_Date,chrStatus_Code;
		IF(chrPrv_proposal=' ') THEN
			chrPrv_proposal:=chrProposal;
			chrPrv_sort_code:=chrSort_code;
			chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
			chrPrv_status_code:=chrStatus_code;
		END IF;
		IF(chrPrv_proposal=chrProposal AND chrPrv_sort_code=chrSort_code) THEN
			chrMax_date:=TO_CHAR(datStatus_date,'YYYYMM');
			IF(chrStatus_code IN('COMPLETE','CLOSED','CANCELLED')) THEN
				chrMax_date:=TO_CHAR(datStatus_date,'YYYYMM');
				IF(chrPrv_status_code<>chrStatus_code) THEN
					UPDATE um_wr9006_rpt
						SET carry_over=carry_over+1
						WHERE yr_mth>chrMin_date
						AND yr_mth<=chrMax_date;
				END IF;
				chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
				chrPrv_status_code:=chrStatus_code;
			ELSE -- reopened. Might need to upd chrMin_date
				IF(chrPrv_status_code IN('COMPLETE','CLOSED','CANCELLED')) THEN
					chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
					chrMax_date:=chrMin_date;
					chrPrv_status_code:=chrStatus_code;
				END IF;
			END IF;
		ELSE
			IF(chrPrv_status_code NOT IN('COMPLETE','CLOSED','CANCELLED')) THEN
				UPDATE um_wr9006_rpt
					SET carry_over=carry_over+1
					WHERE yr_mth>chrMin_date;
			END IF;
			chrPrv_proposal:=chrProposal;
			chrPrv_sort_code:=chrSort_code;
			chrPrv_status_code:=chrStatus_code;
			chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
			chrMax_date:=chrMin_date;
		END IF;
		EXIT WHEN curPst%NOTFOUND;
	END LOOP;
	CLOSE curPst;


-- Referred-To-Trades portion
	chrPrv_pre_trades_phs:='000';
	chrPrv_proposal:=' ';
	OPEN curPst_ii;
	LOOP
		FETCH curPst_ii INTO chrProposal,chrSort_code,datStatus_date;
		EXIT WHEN curPst_ii%NOTFOUND;
		IF(chrPrv_proposal<>chrProposal) THEN
			chrPrv_pre_trades_phs:='000';
			chrPrv_proposal:=chrProposal;
		END IF;
		SELECT COUNT(*),MAX(sort_code) INTO numCount,chrPre_trades_phs
			FROM ae_p_phs_e
			WHERE proposal=chrProposal
			AND shop='H1000'
			AND order_type='H'
			AND sort_code<chrSort_code;
		IF(numCount>0) THEN
-- there's a phase that's probably a w.o. "transfer" to Trades
			SELECT TRUNC(MAX(status_date)) INTO datPre_trade_status
				FROM ae_p_pst_e
				WHERE proposal=chrProposal
				AND sort_code=chrPre_trades_phs;
			IF(datStatus_date-datPre_trade_status<2) THEN
				IF(chrPrv_pre_trades_phs<chrPre_trades_phs) THEN
					UPDATE um_wr9006_rpt
						SET ref_2_trades=ref_2_trades+1
						WHERE yr_mth=TO_CHAR(datStatus_date,'YYYYMM');
					chrPrv_pre_trades_phs:=chrPre_trades_phs;
				END IF;
			END IF;
		END IF;
	END LOOP;
	CLOSE curPst_ii;
	COMMIT;
END proc_WR9006A;

PROCEDURE proc_WR9007A IS
CURSOR curPst(datInitial_cur DATE) IS
	SELECT proposal,sort_code,status_date,status_code
		FROM ae_p_pst_e
		WHERE (proposal,sort_code)
			IN(SELECT a.proposal,a.sort_code
				FROM ae_p_phs_e a,ae_p_pro_e b,ae_p_pst_e C
				WHERE a.shop IN('H2000','H3000')
				AND a.order_type='H'
				AND pri_code IN('01','02','03','04','05','06')
				AND a.proposal=b.proposal
				AND b.ent_date>=datInitial_cur --'01-MAY-2007'
				AND a.proposal=c.proposal
				AND a.sort_code=c.sort_code
				GROUP BY a.proposal,a.sort_code
			)
		ORDER BY proposal,sort_code,status_date;
-- Variables "coming" from WR9000
CURSOR curPro IS
	SELECT b.proposal,b.sort_code,TRUNC(MIN(c.status_date)),b.status_code,a.program_fy
		FROM ae_p_pro_e a,ae_p_phs_e b,ae_p_pst_e c
		WHERE a.proposal=b.proposal
		AND b.shop IN('H2000','H3000')
---- Exclude PM and fetch only Priority Codes 01 through 03 (ticket 4948)
--		AND a.category NOT IN('CAP','TO','PM')
		AND b.pri_code IN('01','02','03','04','05','06')
		AND b.proposal=c.proposal
		AND b.sort_code=c.sort_code
		AND a.ent_date>='01-MAY-2007'
		GROUP BY b.proposal,b.sort_code,b.status_code,a.program_fy
		ORDER BY TRUNC(MIN(c.status_date));
numPrev_fy		NUMBER;
numIssued		NUMBER;
numClosed		NUMBER;
numBacklog		NUMBER;
numOne_day		NUMBER;
numThree_day		NUMBER;
numOver_three_day	NUMBER;
chrPrev_period		VARCHAR2(7);
numProgram_fy		NUMBER;
chrMth_yr		VARCHAR2(7);
datMin_status_date	DATE;
datEnt_date		DATE;


chrProposal		VARCHAR2(25);
chrSort_code		VARCHAR2(5);
chrStatus_code		VARCHAR2(50);
datStatus_date		DATE;
chrPrv_proposal		VARCHAR2(25);
chrPrv_sort_code	VARCHAR2(5);
chrPrv_status_code	VARCHAR2(35);
chrMin_date		VARCHAR2(6);
chrMax_date		VARCHAR2(6);
CURSOR curPst_ii IS
	SELECT a.proposal,a.sort_code,TRUNC(MIN(status_date))
		FROM ae_p_phs_e a,ae_p_Pst_e b,ae_p_pro_e c
		WHERE a.shop IN('H2000','H3000')
		AND a.pri_code IN('01','02','03','04','05','06')
		AND a.order_type='H'
		AND a.proposal=c.proposal
		AND c.ent_date>='01-MAY-2007'
		AND a.proposal=b.proposal
		AND a.sort_code=b.sort_code
		AND b.status_code NOT IN('CLOSED','CANCELLED')
		GROUP BY a.proposal,a.sort_code
		ORDER BY a.proposal,a.sort_code;
numCount		NUMBER;
chrPrv_pre_trades_phs	VARCHAR2(5);
chrPre_trades_phs	VARCHAR2(5);
datPre_trade_status	DATE;
datInitial		DATE;
BEGIN
	EXECUTE IMMEDIATE 'TRUNCATE TABLE um_wr9007_rpt';
	numPrev_fy:=0;
	numIssued:=0;
	numClosed:=0;
	numOne_day:=0;
	numThree_day:=0;
	numOver_three_day:=0;
	numBacklog:=0;
	chrPrev_period:='04/2007';
	numPrev_fy:=2007;
	OPEN curPro;
	LOOP
		FETCH curPro INTO chrProposal,chrSort_code,datEnt_date,chrStatus_code,
			numProgram_fy;
		chrMth_yr:=TO_CHAR(datEnt_date,'MM/YYYY');
		IF(chrPrev_period<>chrMth_yr OR curPro%NOTFOUND) THEN
-- initialize rcd and variables for new month
			INSERT INTO um_wr9007_rpt(program_fy,mth_yr,issued,closed,one_day,
				three_day,over_three_day,backlog,ytd_issued,ytd_closed,
				ytd_one_day,ytd_three_day,ytd_over_three_day,ytd_backlog,
				carry_over,ref_2_trades)
				VALUES(numPrev_fy,chrPrev_period,
				numIssued,numClosed,numOne_day,numThree_day,
				numOver_three_day,numBacklog,0,0,0,0,0,0,0,0);
			UPDATE um_wr9007_rpt
				SET ytd_issued=(SELECT SUM(issued)
						FROM um_wr9007_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_closed=(SELECT SUM(closed)
						FROM um_wr9007_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_one_day=(SELECT SUM(one_day)
						FROM um_wr9007_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_three_day=(SELECT SUM(three_day)
						FROM um_wr9007_rpt a
						WHERE a.program_fy=numPrev_fy
					),
				ytd_over_three_day=(SELECT SUM(over_three_day)
						FROM um_wr9007_rpt a
						WHERE a.program_fy=numPrev_fy
					)
				WHERE mth_yr=chrPrev_period;
			numPrev_fy:=numProgram_fy;
			chrPrev_period:=chrMth_yr;
			numIssued:=0;
			numClosed:=0;
			numOne_day:=0;
			numThree_day:=0;
			numOver_three_day:=0;
			numBacklog:=0;
		END IF;
		numIssued:=numIssued+1;
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			numClosed:=numClosed+1;
		END IF;

-- retrieve earliest completion/closing status, given that w.o.s might reopen
		datStatus_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datStatus_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='COMPLETE';
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CLOSED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE+1)) THEN
			datStatus_date:=datMin_status_date;
		END IF;
		datMin_status_date:=NULL;
		SELECT TRUNC(MAX(status_date)) INTO datMin_status_date
			FROM ae_p_pst_e
			WHERE proposal=chrProposal
			AND sort_code=chrSort_code
			AND status_code='CANCELLED';
		IF(NVL(datStatus_date,SYSDATE)>NVL(datMin_status_date,SYSDATE)+1) THEN
			datStatus_date:=datMin_status_date;
		END IF;

-- classify completion timeframe
		IF(chrStatus_code IN('CLOSED','COMPLETE','CANCELLED')) THEN
			CASE
				WHEN datStatus_date-datEnt_date<2 THEN numOne_day:=numOne_day+1;
				WHEN datStatus_date-datEnt_date<4 THEN numThree_day:=numThree_day+1;
				ELSE numOver_three_day:=numOver_three_day+1;
			END CASE;
			IF(MONTHS_BETWEEN(datStatus_date,datEnt_date)>1) THEN
				numBacklog:=numBacklog+1;
-- Per Diana M Caulkins on 09/13/2011, "Over 3 days" shouldn't include w.o.s in backlog of that period.
-- This reverts the original implementation, where Over 3 Days included Backlog.
-- See explanation from ticket 3336 on 09/06/2011.
				numOver_three_day:=numOver_three_day-1;
			END IF;
		ELSE
			numBacklog:=numBacklog+1;
		END IF;
		EXIT WHEN curPro%NOTFOUND;
	END LOOP;
	CLOSE curPro;
	DELETE FROM um_Wr9007_rpt WHERE mth_yr='04/2007';

-- functionality additional to that of wr9000. Carry Over portion
	chrPrv_proposal:=' ';
	chrPrv_sort_code:=' ';


	datInitial:='01-MAY-2007';
	chrMin_date:='200705';
	chrMax_date:=chrMin_date;
	UPDATE um_wr9007_rpt
		SET yr_mth=SUBSTR(mth_yr,4)||SUBSTR(mth_yr,1,2);

	OPEN curPst(datInitial);
	LOOP
		FETCH curPst INTO chrProposal,chrSorT_code,datStatus_Date,chrStatus_Code;
		IF(chrPrv_proposal=' ') THEN -- initial case?
			chrPrv_proposal:=chrProposal;
			chrPrv_sort_code:=chrSort_code;
			chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
			chrPrv_status_code:=chrStatus_code;
		END IF;
		IF(chrPrv_proposal=chrProposal AND chrPrv_sort_code=chrSort_code) THEN
			chrMax_date:=TO_CHAR(datStatus_date,'YYYYMM');
			IF(chrStatus_code IN('COMPLETE','CLOSED','CANCELLED')) THEN
				chrMax_date:=TO_CHAR(datStatus_date,'YYYYMM');
				IF(chrPrv_status_code<>chrStatus_code) THEN
					UPDATE um_wr9007_rpt
						SET carry_over=carry_over+1
						WHERE yr_mth>chrMin_date
						AND yr_mth<=chrMax_date;
				END IF;
				chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
				chrPrv_status_code:=chrStatus_code;
			ELSE -- reopened. Might need to upd chrMin_date
				IF(chrPrv_status_code IN('COMPLETE','CLOSED','CANCELLED')) THEN
					chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
					chrMax_date:=chrMin_date;
					chrPrv_status_code:=chrStatus_code;
				END IF;
			END IF;
		ELSE -- different w.o. or phase. Upd if previous phase was still open
			IF(chrPrv_status_code NOT IN('COMPLETE','CLOSED','CANCELLED')) THEN
				UPDATE um_wr9007_rpt
					SET carry_over=carry_over+1
					WHERE yr_mth>chrMin_date;
			END IF;
			-- upd variables for previous phase
			chrPrv_proposal:=chrProposal;
			chrPrv_sort_code:=chrSort_code;
			chrPrv_status_code:=chrStatus_code;
			chrMin_date:=TO_CHAR(datStatus_date,'YYYYMM');
			chrMax_date:=chrMin_date;
		END IF;
		EXIT WHEN curPst%NOTFOUND;
	END LOOP;
	CLOSE curPst;


-- Referred-To-Trades portion
	chrPrv_pre_trades_phs:='000';
	chrPrv_proposal:=' ';
	OPEN curPst_ii;
	LOOP
		FETCH curPst_ii INTO chrProposal,chrSort_code,datStatus_date;
		EXIT WHEN curPst_ii%NOTFOUND;
		IF(chrPrv_proposal<>chrProposal) THEN
			chrPrv_pre_trades_phs:='000';
			chrPrv_proposal:=chrProposal;
		END IF;
		SELECT COUNT(*),MAX(sort_code) INTO numCount,chrPre_trades_phs
			FROM ae_p_phs_e
			WHERE proposal=chrProposal
			AND shop='H1000'
			AND order_type='H'
			AND sort_code<chrSort_code;
		IF(numCount>0) THEN
-- there's a phase that's probably a w.o. "transfer" to Trades
			SELECT TRUNC(MAX(status_date)) INTO datPre_trade_status
				FROM ae_p_pst_e
				WHERE proposal=chrProposal
				AND sort_code=chrPre_trades_phs;
			IF(datStatus_date-datPre_trade_status<2) THEN
				IF(chrPrv_pre_trades_phs<chrPre_trades_phs) THEN
					UPDATE um_wr9007_rpt
						SET ref_2_trades=ref_2_trades+1
						WHERE yr_mth=TO_CHAR(datStatus_date,'YYYYMM');
					chrPrv_pre_trades_phs:=chrPre_trades_phs;
				END IF;
			END IF;
		END IF;
	END LOOP;
	CLOSE curPst_ii;
	COMMIT;
END proc_WR9007A;

PROCEDURE proc_HousingRpts IS
BEGIN
	fmax_57.proc_Wr9000A;
	fmax_57.proc_Wr9002A;
	fmax_57.proc_Wr9004A;
	fmax_57.proc_WR9005A;
	fmax_57.proc_WR9006A;
	fmax_57.proc_WR9007A;
END proc_HousingRpts;
END fmax_57;