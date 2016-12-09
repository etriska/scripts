create or replace
PACKAGE fmaxC_18 AS
-- Extract data from Plants AEC system to transmit them to DSC for the purpose of Service Unit Billing.
-- Plantzero file lists the work request with charges and having the sum of offsetting debit and credit
-- be zero.
-- The program simulates it runs three days prior the last day of month.
-- The output of this program is a file which will be sent to DSC
-- The output file contains two types of records.
-- Records of output file must comply with a fixed-length layout. Therefore some numeric values (e.g. charges)
-- need to be right-adjusted before adding to file.
PROCEDURE proc_Sub100(chrBegin_date VARCHAR2,chrEnd_date VARCHAR2);

-- Define variables to verify whether next fetched row concerns the same proposal, sort_code, funding_code and oofsetfunding_code.
-- Whenever there's a difference in any of these values, the record will be added to file/table.
PROCEDURE proc_SaveCurrentInfo(chrProposal_arg VARCHAR2,chrSort_code_arg VARCHAR2,chrFunding_code_arg VARCHAR2,chrOffsetfunding_code_arg VARCHAR2, chrSourceTranx_no_arg number);

-- Define error variables for current proposal, sort_code, subledger_type, etc. should any error in data be detected
PROCEDURE proc_MoveMbErrFields(chrProposal_arg VARCHAR2,chrSort_code_arg VARCHAR2,numAmount_arg NUMBER,
		chrSubledger_type_arg VARCHAR2,chrFunding_code_arg VARCHAR2,chrOffsetfunding_code_arg VARCHAR2);

-- Update totals for current shop by adding labor/material amounts.
-- Build record for plantsub table, which will be later written to file
PROCEDURE proc_WriteOutCurrentRecord;

-- add proposal to list of plants with sum of credit and debit equal to 0.
PROCEDURE proc_WriteOutZeroRecs;

-- Parse Chart field to retrieve fund code, org_code, subclass, program code, project grant and account
PROCEDURE proc_BreakUpChartField;

-- Returns index to first numeric byte from argument or 0 if each byte is alphabetic
FUNCTION func_IndexToNumeric(chrString_arg VARCHAR2) RETURN NUMBER;

-- Return a right-adjusted string representing a number with decimals
FUNCTION func_RightAdjust(numNumeric_arg NUMBER,numLength_arg NUMBER,numDecimals_arg NUMBER) RETURN CHAR;

PROCEDURE proc_AddAmounts;
PROCEDURE proc_AddToTotals;

PROCEDURE proc_TestChartField(chrArg VARCHAR2);

-- added on 04/01/2009 because of New Line chars in item_desc
PROCEDURE proc_FixPlantSub;
--PROCEDURE proc_TestSub100;
END fmaxC_18;

create or replace
PACKAGE BODY fmaxC_18 AS
-- Global variables
--Saved record
chrSaved_proposal		VARCHAR2(15);
chrSaved_sort_code		VARCHAR2(15);
chrSaved_funding_code		VARCHAR2(50);
chrSaved_offsetfunding_code	VARCHAR2(50);
numSaved_amount			NUMBER(14,2);
chrSaveD_shop			VARCHAR2(25);
chrSaved_source_tranx_no number(18);
--CF-err record
chrCf_err_proposal		VARCHAR2(15);
chrCf_err_phase			VARCHAR2(15);
chrCf_err_chart_field		VARCHAR2(50);
numCf_err_amt			NUMBER(7,2);
--S_err record
chrS_err_proposal		VARCHAR2(15);
chrS_err_sort_code		VARCHAR2(15);
numS_err_amount			NUMBER(14,2);
chrS_err_subledger_type		VARCHAR2(1);
chrS_err_fund			VARCHAR2(50);
chrS_err_offsetfund		VARCHAR2(50);
-- Tti record
chrTti_shop			VARCHAR2(25);
numTti_matr			NUMBER(14,2);
numTti_labr			NUMBER(14,2);
numTti_totl			NUMBER(14,2);
-- Ae record
chrAe_proposal			VARCHAR2(15);
chrAe_sort_code			VARCHAR2(15);
chrAe_shop			VARCHAR2(25);
chrAe_description		VARCHAR2(255);
chrAe_reference_no		VARCHAR2(15);
--
numExists			NUMBER;
chrC_sub			NUMBER; --used as pointer in a substring (for chrCf_chart_field)
chrCf_chart_field		VARCHAR2(51);
numShop_lab_tot			NUMBER(14,2);
numChg_acct_lab			NUMBER(14,2);
numChg_acct_labr		NUMBER(14,2);
numShop_mat_tot			NUMBER(14,2);
numChg_acct_mat			NUMBER(14,2);
numChg_acct_matr		NUMBER(14,2);
numBilling_amount_rnd		NUMBER(14,2);
CHRMY_TRANX_TYPE		VARCHAR2(40);
--numSourceTranx_no number(16);
numUpdate_cnt			NUMBER;
numRental_tot_rnd		NUMBER(14,2);
numProc_tot_rnd			NUMBER(14,2);
chrAe_custom002			VARCHAR2(30);
chrTodays_date			VARCHAR2(10);
-- Tr record (record for PlantSub)
chrTr_card_code			CHAR(1);
chrTr_short_code		CHAR(6);
chrTr_account			CHAR(6);
chrTr_fund_code			CHAR(5);
chrTr_org_code			CHAR(6);
chrTr_program_code		CHAR(5);
chrTr_subclass			CHAR(5);
chrTr_project_grant		CHAR(15);
chrTr_vendor_id			CHAR(10);
chrTr_invoice_date		CHAR(10);
chrTr_invoice_id		CHAR(30);
chrTr_uniqname		CHAR(8);
chrTr_location_code		CHAR(10);
chrTr_deliver_to		CHAR(30);
chrTr_vendor_order_num		CHAR(20);
chrTr_dept_ref_no		CHAR(30);
chrTr_trip_no			CHAR(6);
chrTr_item_id			CHAR(18);
chrTr_item_desc			CHAR(30);
chrTr_vendor_item_id		CHAR(20);
chrTr_manufacturer_name		CHAR(30);
chrTr_model_num			CHAR(30);
chrTr_serial_num		CHAR(25);
chrTr_um_tag_num		CHAR(12);
numTr_qty_vouchered		NUMBER;--not actually part of record
chrTr_qty_vouchered		CHAR(16);
chrTr_unit_of_measure		CHAR(3);
numTr_unit_price		NUMBER;--not actually part of record
chrTr_unit_price		CHAR(17);
numTr_merchandise_amount	NUMBER;--not actually part of record
chrTr_merchandise_amount	CHAR(17);
chrTr_voucher_comment		CHAR(30);
-- Ac record
chrAc_card_code			CHAR(1);
numAc_total_amount		NUMBER(16,2);
chrAc_total_amount		CHAR(16);
numAc_total_voucher		NUMBER(7);
chrAc_total_voucher		CHAR(7);
--
chrHold_chart			CHAR(30);
numTot_voucher_amount		NUMBER(11,2);
numTot_voucher_count		NUMBER(10);
numAec_rec_cnt			NUMBER;
numPlt_rec_cnt			NUMBER;
numIndex			NUMBER;
numOseh_rec_cnt			NUMBER;
numPlt_ext_rnd			NUMBER(16,2);
numOseh_tot_rnd			NUMBER(16,2);
numNumeric			NUMBER;
filOutput_file			UTL_FILE.FILE_TYPE;
chrFile_buffer			VARCHAR2(600);
numErr_count			NUMBER;
numCust_err_count		NUMBER;

-- record for sub_grand_totals
numLabor			NUMBER(16,2);
numMaterial			NUMBER(16,2);
numPlant_ext			NUMBER(16,2);
numPlant_ext_rec_cnt		NUMBER(16);
--End of global variables
-- Extract data from Plants AEC system to transmit them to DSC for the purpose of Service Unit Billing.
-- The program simulates it runs three days prior the last day of month.
-- The output of this program is a file which will be sent to DSC
-- The output file contains tw otypes of records.
-- Plantzero file lists the work request with charges and having the sum of offsetting debit and credit
-- be zero
chrDate_flag		VARCHAR2(1);
datBegin_date		DATE;
datEnd_date		DATE;
chrGood_fund_flag	VARCHAR2(1);
chrGood_offset_flag	VARCHAR2(1);
numCf_error_cnt		NUMBER;

CURSOR curMb(chrMb_thru_date_cur VARCHAR2) IS
	SELECT proposal,TO_CHAR(tranx_date,'FXYYYYMMDD'),funding_code,
		AMOUNT,NVL(SUBLEDGER_TYPE,'M'),NVL(POST_FLAG,'N'),OFFSETFUNDING_CODE,
		offsetsub_code,sort_code,tranx_no,tranx_type, source_tranx_no
		FROM ae_s_fnd_a
		WHERE (funding_code<> offsetfunding_code)
		AND (post_flag='N' OR post_flag IS NULL)
		AND TRUNC(TRANX_DATE)<=TO_DATE(CHRMB_THRU_DATE_CUR,'YYYY/MM/DD')
-- Per Meenal, effective February 2012, WO_JRNL is processed in variant fmaxC_88, not here.
		AND tranx_type IN('TW','CW','AJ','WX','CJ','TP','OC','PO_INV_OC','WO_JRNL')--'MARKUP')
		AND proposal IN(
				SELECT proposal
					FROM ae_p_pro_e
					WHERE order_type IN('C','P','U','E')
					-- 04/29/2011
--					AND oc_code<>'601220'
				)
AND LENGTH(TRIM(sort_code))<6
		ORDER BY proposal,sort_code,funding_code,offsetfunding_code,
			subledger_type;
--Variables used for curMb
chrMb_proposal			VARCHAR2(15);
chrMb_tranx_date		VARCHAR2(8);
chrMb_funding_code		VARCHAR2(50);
numMb_amount			NUMBER(14,2);
chrMb_subledger_type		VARCHAR2(1);
chrMb_post_flag			VARCHAR2(1);
chrMb_offsetfunding_code	VARCHAR2(50);
chrMb_offsetsub_code		VARCHAR2(15);
chrMb_sort_code			VARCHAR2(15);
numMb_tranx_no			NUMBER(16);
CHRMB_TRANX_TYPE		VARCHAR2(40);
chrMB_Source_tranx_no number(16);
chrHold_fund_code		VARCHAR2(50);
CURSOR curPlantsub Is
	SELECT card_code,short_code,account,fund_code,org_code,
			program_code,subclass,projecT_grant,vendor_id,
			invoice_date,invoice_id,uniqname,location_code,
			deliver_to,vendor_order_num,dept_ref_no,trip_no,
--			item_id,item_desc,
-- regular expression
			item_id,
REGEXP_SUBSTR(item_desc,'([['||CHR(32)||'-'||chr(127)||']]*)*'),
			vendor_item_id,manufacturer_name,
			model_num,serial_num,um_tag_num,qty_vouchered,
			unit_of_measure,unit_price,merchandise_amount,
			voucher_coment
		FROM plantsub;
PROCEDURE proc_Sub100(chrBegin_date VARCHAR2,chrEnd_date VARCHAR2) IS
BEGIN
--Initialize variables
	numCf_error_cnt:=0;
	numCf_err_amt:=0;
	numS_err_amount:=0;
	numShop_lab_tot:=0;
	numShop_mat_tot:=0;
	numChg_acct_lab:=0;
	numChg_acct_mat:=0;
	numUpdate_cnt:=0;
	numRental_tot_rnd:=0;
	numProc_tot_rnd:=0;
	numPlt_ext_rnd:=0;
	numOseh_tot_rnd:=0;
	numTti_matr:=0;
	numTti_labr:=0;
	numTti_totl:=0;
	numTot_voucher_count:=0;
	numTot_voucher_amount:=0;
	numAec_rec_cnt:=0;
	numOseh_rec_cnt:=0;
	numPlt_rec_cnt:=0;
	chrTr_short_code:=' ';
	chrTr_account:=' ';
	chrTr_fund_code:=' ';
	chrTr_org_code:=' ';
	chrTr_program_code:=' ';
	chrTr_subclass:=' ';
	chrTr_project_grant:=' ';
	chrTr_vendor_id:=' ';
	chrTr_invoice_date:=' ';
	chrTr_invoice_id:=' ';
	chrTr_uniqname:=' ';
	chrTr_location_code:=' ';
	chrTr_deliver_to:=' ';
	chrTr_vendor_order_num:=' ';
	chrTr_dept_ref_no:=' ';
	chrTr_trip_no:=' ';
	chrTr_item_id:=' ';
	chrTr_item_desc:=' ';
	chrTr_vendor_id:=' ';
	chrTr_vendor_item_id:=' ';
	chrTr_manufacturer_name:=' ';
	chrTr_model_num:=' ';
	chrTr_serial_num:=' ';
	chrTr_um_tag_num:=' ';
	chrTr_qty_vouchered:=' ';
	chrTr_unit_of_measure:=' ';
	chrTr_unit_price:=' ';
	chrTr_merchandise_amount:=' ';
	chrTr_voucher_comment:=' ';

-- record in sub_grand_totals
	numLabor:=0;
	numMaterial:=0;
--	numProcurement:=0;
--	numRental:=0;
--	numPlant_rec_cnt:=0;
	numPlant_ext:=0;
	numPlant_ext_rec_cnt:=0;

	EXECUTE IMMEDIATE 'TRUNCATE TABLE plantsub';
	EXECUTE IMMEDIATE 'TRUNCATE TABLE plant_zero';
	EXECUTE IMMEDIATE 'TRUNCATE TABLE audit_control';
	EXECUTE IMMEDIATE 'TRUNCATE TABLE sub_cust_est_errors';
	EXECUTE IMMEDIATE 'TRUNCATE TABLE sub_vendorid_errors';
	INSERT INTO sub_grand_totals_hist(labor,material,procurement,rental,
		plant_rec_cnt,plant_ext,plant_ext_rec_cnt,run_date)
		SELECT labor,material,procurement,rental,plant_rec_cnt,plant_ext,
			plant_ext_rec_cnt,TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MON-YY')
			FROM sub_grand_totals;
	EXECUTE IMMEDIATE 'TRUNCATE TABLE sub_grand_totals';
-- reset totals
	INSERT INTO sub_shop_bill_totals_hist(shop,labor,material,total,run_date)
		SELECT shop,labor,material,total,TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MON-YY')
			FROM sub_shop_bill_totals;
	UPDATE sub_shop_bill_totals
		SET material=0,labor=0,total=0;
	COMMIT;

-- Check whether begin and end dates are defined by user or should be by program
	chrDate_flag:='Y';
	IF((chrBegin_date IS NOT NULL) AND (chrEnd_date IS NOT NULL)) THEN
		chrDate_flag:='N';
		BEGIN
		datBegin_date:=TRUNC(TO_DATE(chrBegin_date,'YYYYMMDD'));
		EXCEPTION WHEN VALUE_ERROR THEN
			chrDate_flag:='Y';
		END;
		BEGIN
			datEnd_date:=TRUNC(TO_DATE(chrEnd_date,'YYYYMMDD'));
		EXCEPTION WHEN VALUE_ERROR THEN
			chrDate_flag:='Y';
		END;
	END IF;

	IF(chrDate_flag='Y') THEN
--set dates, since user didn't specify date values or they were invalid
		datEnd_date:=TRUNC(SYSDATE);
		datBegin_date:=last_day(ADD_MONTHS(TRUNC(SYSDATE),-1))+1;
	END IF;

	chrTodays_date:=TO_CHAR(datEnd_date,'YYYY/MM/DD');
	filOutput_file:=UTL_FILE.FOPEN('PROC_DIR','PLANTSUB_BAD','W');
	OPEN curMb(chrTodays_date);--'2007/12/07'
	FETCH curMb INTO chrMb_proposal,chrMb_tranx_date,chrMb_funding_code,
		numMb_amount,chrMb_subledger_type,
		chrMb_post_flag,chrMb_offsetfunding_code,
		CHRMB_OFFSETSUB_CODE,CHRMB_SORT_CODE,NUMMB_TRANX_NO,
		chrMb_tranx_type, chrMB_Source_tranx_no;

	proc_SaveCurrentInfo(chrMb_proposal,chrMb_sort_code,chrMb_funding_code,chrMb_offsetfunding_code, chrMB_Source_tranx_no);

	chrTr_card_code:='1';
	chrAc_card_code:='2';
	LOOP
--2100
-- Per Meenal 05/01/2009, disable swapping and reversing of TP transactions.
--		IF(chrMb_tranx_type='TP') THEN
--			numMb_amount:=-numMb_amount;
--			chrHold_fund_code:=chrMb_funding_code;
--			chrMb_funding_code:=chrMb_offsetfunding_code;
--			chrMb_offsetfunding_code:=chrHold_fund_code;
--		END IF;
		chrGood_fund_flag:='Y';
		chrGood_offset_flag:='Y';
-- check existence of funding_code fetched from ae_s_fnd_a
		SELECT COUNT(*) INTO numExists
			FROM pap_bill_vendor_id
			WHERE offsetfunding_code=chrMb_offsetfunding_code;
		IF(numExists=0) THEN
-- change2
--			--8610 Insert-cf-error
--			chrGood_offset_flag:='N';
--			numCf_error_cnt:=numCf_error_cnt+1;
--			numSaved_amount:=numMb_amount;
--			IF(chrMb_proposal=chrCf_err_proposal AND chrMb_sort_code=chrCf_err_phase) THEN
--				numCf_err_amt:=numCf_err_amt+numSaved_amount;
--			ELSE
--				chrCf_err_proposal:=chrMb_proposal;
--				chrCf_err_phase:=chrMb_sort_code;
--				numCf_err_amt:=numSaved_amount;
--				chrCf_err_chart_field:=chrMb_offsetfunding_code;
--			END IF;
			chrGood_offset_flag:='N';
-- fetched funding_code doesn't exist, so insert into error table
			SELECT COUNT(*) INTO numErr_count
				FROM sub_vendorid_errors
				WHERE proposal=chrMb_proposal
				AND sort_code=chrMb_sort_code
				AND offsetfunding_code=chrMb_offsetfunding_code;
			IF(numErr_count=0) THEN
				INSERT INTO sub_vendorid_errors
					VALUES(chrMb_proposal,chrMb_sort_code,numMb_amount,
						chrMb_offsetfunding_code);
			ELSE
				UPDATE sub_vendorid_errors
					SET amount=amount+numMb_amount
					WHERE proposal=chrMb_proposal
					AND sort_code=chrMb_sort_code
					AND offsetfunding_code=chrMb_offsetfunding_code;
			END IF;
-- end of change2
		END IF;--numExists=0

		chrCf_chart_field:=chrMb_funding_code;
		chrC_sub:=6;
		IF(SUBSTR(chrCf_chart_field,6,1)<>'-') THEN
-- a valid chart field should have a separator at 6th byte
			--8200 Error-report
			chrGood_fund_flag:='N';
			IF(chrS_err_proposal IS NULL) THEN
-- Prepare error variables if error variable for proposal  is null ...
				--8210 move-mb-err-fields
				proc_MoveMbErrFields(chrMb_proposal,chrMb_sort_code,numMb_amount,chrMb_subledger_type,
					chrMb_funding_code,chrMb_offsetfunding_code);
			ELSE
				IF(chrMb_proposal<> chrS_err_proposal
					OR chrMb_sort_code<>chrS_err_sort_code
					OR chrMb_subledger_type<>chrS_err_subledger_type
					OR chrMb_funding_code<>chrS_err_fund
					OR chrMb_offsetfunding_code<>chrS_err_offsetfund
				) THEN
-- or if any of relevant values of fetched row has changed
					--8210 move-mb-err-fields
					proc_MoveMbErrFields(chrMb_proposal,chrMb_sort_code,numMb_amount,chrMb_subledger_type,
						chrMb_funding_code,chrMb_offsetfunding_code);
				ELSE
-- Otherwise just add to the errors amount
					numS_err_amount:=numS_err_amount+numMb_amount;
				END IF;
			END IF;
		END IF;--substr(chrCf_chart_field,6,1)<>'-'
-- fix: disable change1
---- change1
--		IF(chrMb_Funding_code IN('CUST_ACCT','EST_ACCT','HOUSING')
--		OR SUBSTR(chrMb_Offsetfunding_code,7,1)='-') THEN
--			chrGood_fund_flag:='N';
--			chrGood_offset_flag:='N';
--		END IF;
---- end of change1
-- end fix
		IF(chrGood_fund_flag='Y' AND chrGood_offset_flag='Y') THEN
			--2105 Check-if-same
			IF(chrMb_proposal<> chrSaved_proposal
				OR chrMb_sort_code<>chrSaved_sort_code
				OR chrMb_funding_code<>chrSaved_funding_code
				OR chrMb_offsetfunding_code<>chrSaved_offsetfunding_code
--OR chrTr_vendor_id<>chrSaved_vendor_id
			) THEN
-- at least one field of most recently fetched row has changed, so it's time to
-- write the record before processing the current one
				IF(numChg_acct_lab<>0 OR numChg_acct_mat<>0) THEN
-- add record to plantsub table
					--5000 Write-out-current-record
					proc_WriteOutCurrentRecord;
				ELSE
-- sum of debit and credit for those charges is zero
					--5005 Write-out-zero-recs
					proc_WriteOutZeroRecs;
				END IF;
-- Define the new "current" info to process the new set of charges
				--6000 Save-current-info
				proc_SaveCurrentInfo(chrMb_proposal,chrMb_sort_code,chrMb_funding_code,chrMb_offsetfunding_code, chrMB_Source_tranx_no);
			END IF;--If current Mb rcd is <> to Saved rcd

			--2110 It-is-the-same
			IF(chrMb_subledger_type='L') THEN
-- add amount to either labor or material amounts
				numLabor:=numLabor+numMb_amount;
				numShop_lab_tot:=numShop_lab_tot+numMb_amount;
				numChg_acct_lab:=numChg_acct_lab+numMb_amount;
			ELSE
				numMaterial:=numMaterial+numMb_amount;
				numShop_mat_tot:=numShop_mat_tot+numMb_amount;
				numChg_acct_mat:=numChg_acct_mat+numMb_amount;
			END IF;

-- Now mark the transaction as posted
			-- 4020 Update_fnda_table
			chrMy_tranx_type:=chrMb_tranx_type;
			numUpdate_cnt:=numUpdate_cnt+1;
-- Per Meenal on 12/03/2009 set bill_amount to numMb_amount (just like amount).
			UPDATE ae_s_fnd_a
				SET post_flag='Y',bill_date=datEnd_date,
					amount=numMb_amount,bill_amount=numMb_amount,
					funding_code=chrMb_funding_code,
					offsetfunding_code=chrMb_offsetfunding_code
				WHERE tranx_no=numMb_tranx_no
				AND tranx_type=chrMy_tranx_type;
--end of 2110-it-is-the-same (makesure this is NOT the 'else' of mb<>saved)
		ELSE
--IF(chrMb_Funding_code IN('CUST_ACCT','EST_ACCT','HOUSING')
--OR SUBSTR(chrMb_Offsetfunding_code,7,1)='-') THEN
			SELECT COUNT(*) INTO numCust_err_count
				FROM sub_cust_est_errors
				WHERE proposal=chrMb_proposal
				AND sort_code=chrMb_sort_code
				AND subledger_type=chrMb_subledger_type
				AND funding_code=chrMb_funding_code
				AND offsetfunding_code=chrMb_offsetfunding_code
				AND rownum=1;
			IF(numCust_err_count=0) THEN
				INSERT INTO sub_cust_est_errors
					VALUES(chrMb_proposal,chrMb_sort_code,
					chrMb_subledger_type,numMb_amount,
					chrMb_funding_code,chrMb_offsetfunding_code);
			ELSE
				UPDATE sub_cust_est_errors
					SET amount=amount+numMb_amount
					WHERE proposal=chrMb_proposal
					AND sort_code=chrMb_sort_code
					AND subledger_type=chrMb_subledger_type
					AND funding_code=chrMb_funding_code
					AND offsetfunding_code=chrMb_offsetfunding_code;
			END IF;
--END IF;

		END IF;
--End of processing when both Good_fund and Good_offset flags are 'Y'



		FETCH curMb INTO chrMb_proposal,chrMb_tranx_date,chrMb_funding_code,
			numMb_amount,chrMb_subledger_type,
			chrMb_post_flag,chrMb_offsetfunding_code,
			CHRMB_OFFSETSUB_CODE,CHRMB_SORT_CODE,NUMMB_TRANX_NO,
			chrMb_tranx_type, chrMB_Source_tranx_no;
		EXIT WHEN curMb%NOTFOUND;
	END LOOP;
	CLOSE curMb;

-- last row
	IF(chrMb_tranx_type='TP') THEN
		numMb_amount:=-numMb_amount;
		chrHold_fund_code:=chrMb_funding_code;
		chrMb_funding_code:=chrMb_offsetfunding_code;
		chrMb_offsetfunding_code:=chrHold_fund_code;
	END IF;
	chrGood_fund_flag:='Y';
	chrGood_offset_flag:='Y';
-- check existence of funding_code fetched from ae_s_fnd_a
	SELECT COUNT(*) INTO numExists
		FROM pap_bill_vendor_id
		WHERE offsetfunding_code=chrMb_offsetfunding_code;
	IF(numExists=0) THEN
		chrGood_offset_flag:='N';
-- fetched funding_code doesn't exist, so insert into error table

		INSERT INTO sub_vendorid_errors
			VALUES(chrMb_proposal,chrMb_sort_code,numMb_amount,
				chrMb_offsetfunding_code);
	END IF;--numExists=0

	chrCf_chart_field:=chrMb_funding_code;
	chrC_sub:=6;
	IF(SUBSTR(chrCf_chart_field,6,1)<>'-') THEN
-- a valid chart field should have a separator at 6th byte
		--8200 Error-report
		chrGood_fund_flag:='N';
		IF(chrS_err_proposal IS NULL) THEN
-- Prepare error variables if error variable for proposal  is null ...
			--8210 move-mb-err-fields
			proc_MoveMbErrFields(chrMb_proposal,chrMb_sort_code,numMb_amount,chrMb_subledger_type,
				chrMb_funding_code,chrMb_offsetfunding_code);
		ELSE
			IF(chrMb_proposal<> chrS_err_proposal
				OR chrMb_sort_code<>chrS_err_sort_code
				OR chrMb_subledger_type<>chrS_err_subledger_type
				OR chrMb_funding_code<>chrS_err_fund
				OR chrMb_offsetfunding_code<>chrS_err_offsetfund
			) THEN
-- or if any of relevant values of fetched row has changed
				--8210 move-mb-err-fields
				proc_MoveMbErrFields(chrMb_proposal,chrMb_sort_code,numMb_amount,chrMb_subledger_type,
					chrMb_funding_code,chrMb_offsetfunding_code);
			ELSE
-- Otherwise just add to the errors amount
				numS_err_amount:=numS_err_amount+numMb_amount;
			END IF;
		END IF;
	END IF;--substr(chrCf_chart_field,6,1)<>'-'
	IF(chrGood_fund_flag='Y' AND chrGood_offset_flag='Y') THEN
		--2105 Check-if-same
-- at least one field of most recently fetched row has changed, so it's time to
-- write the record before processing the current one
		IF(numChg_acct_lab<>0 OR numChg_acct_mat<>0) THEN
-- add record to plantsub table
			--5000 Write-out-current-record
			proc_WriteOutCurrentRecord;
		ELSE
-- sum of debit and credit for those charges is zero
			--5005 Write-out-zero-recs
			proc_WriteOutZeroRecs;
		END IF;

-- Now mark the transaction as posted
		-- 4020 Update_fnda_table
		chrMy_tranx_type:=chrMb_tranx_type;
		numUpdate_cnt:=numUpdate_cnt+1;
-- Per Meenal on 12/03/2009 set bill_amount to numMb_amount (just like amount).
		UPDATE ae_s_fnd_a
			SET post_flag='Y',bill_date=datEnd_date,
				amount=numMb_amount,bill_amount=numMb_amount,
				funding_code=chrMb_funding_code,
				offsetfunding_code=chrMb_offsetfunding_code
			WHERE tranx_no=numMb_tranx_no
			AND tranx_type=chrMy_tranx_type;
--end of 2110-it-is-the-same (makesure this is NOT the 'else' of mb<>saved)
	END IF;
--End of processing when both Good_fund and Good_offset flags are 'Y'
--end of last row

-- Prepare record for Audit Control
	numAc_total_amount:=numTot_voucher_amount;
	chrAc_total_amount:=func_RightAdjust(numAc_total_amount,16,2);
	numAc_total_voucher:=numTot_voucher_count;
	chrAc_total_voucher:=func_RightAdjust(numAc_total_voucher,7,0);
	INSERT INTO audit_control
		VALUES(chrAc_card_code,chrAc_total_voucher,chrAc_total_amount);

-- Copy rows of Plantsub to output file
	OPEN curPlantsub;
	LOOP
		FETCH curPlantsub INTO chrTr_card_code,chrTr_short_code,
			chrTr_account,chrTr_fund_code,chrTr_org_code,
			chrTr_program_code,chrTr_subclass,chrTr_project_grant,
			chrTr_vendor_id,chrTr_invoice_date,chrTr_invoice_id,
			chrTr_uniqname,chrTr_location_code,chrTr_deliver_to,
			chrTr_vendor_order_num,chrTr_dept_ref_no,chrTr_trip_no,
			chrTr_item_id,chrTr_item_desc,chrTr_vendor_item_id,
			chrTr_manufacturer_name,chrTr_model_num,chrTr_serial_num,
			chrTr_um_tag_num,chrTr_qty_vouchered,chrTr_unit_of_measure,
			chrTr_unit_price,chrTr_merchandise_amount,chrTr_voucher_comment;
		EXIT WHEN curPlantsub%NOTFOUND;
-- Append contents for file buffer
		chrFile_buffer:=CONCAT(chrTr_card_code,chrTr_short_code);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_account);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_fund_code);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_org_code);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_program_code);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_subclass);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_project_grant);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_vendor_id);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_invoice_date);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_invoice_id);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_uniqname);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_location_code);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_deliver_to);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_vendor_order_num);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_dept_ref_no);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_trip_no);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_item_id);
chrTr_item_desc:=REPLACE(chrTr_item_desc,CHR(13)||CHR(10),' ');
chrTr_item_desc:=REPLACE(chrTr_item_desc,CHR(9),' ');
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_item_desc);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_vendor_item_id);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_manufacturer_name);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_model_num);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_serial_num);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_um_tag_num);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_qty_vouchered);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_unit_of_measure);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_unit_price);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_merchandise_amount);
		chrFile_buffer:=CONCAT(chrFile_buffer,chrTr_voucher_comment);
-- Add record to file
		utl_file.put_line(filOutput_file,chrFile_buffer);
	END LOOP;
	CLOSE curPlantsub;

-- Write totals record to file
chrFile_buffer:=chrAc_card_code||chrAc_total_voucher||chrAc_total_amount;
utl_file.put_line(filOutput_file,chrFile_buffer);
utl_file.fclose(filOutput_file);

-- Insert totals of Service Unit Billing
	INSERT INTO sub_grand_totals
		VALUES(numLabor,numMaterial,numProc_tot_rnd,numRental_tot_rnd,
			numPlt_rec_cnt,numPlt_ext_rnd,numAec_rec_cnt);
	COMMIT;
	proc_FixPlantSub;
END proc_Sub100;

-- Define error variables for current proposal, sort_code, subledger_type, etc. should any error in data be detected
PROCEDURE proc_MoveMbErrFields(chrProposal_arg VARCHAR2,chrSort_code_arg VARCHAR2,numAmount_arg NUMBER,
		chrSubledger_type_arg VARCHAR2,chrFunding_code_arg VARCHAR2,chrOffsetfunding_code_arg VARCHAR2) IS
BEGIN
	chrS_err_proposal:=chrProposal_arg;
	chrS_err_sort_code:=chrSort_code_arg;
	numS_err_amount:=numAmount_arg;
	chrS_err_subledger_type:=chrSubledger_type_arg;
	chrS_err_fund:=chrFunding_code_arg;
	chrS_err_offsetfund:=chrOffsetfunding_code_arg;
END proc_MoveMbErrFields;

-- Define variables to verify whether next fetched row concerns the same proposal, sort_code, funding_code and oofsetfunding_code.
-- Whenever there's a difference in any of these values, the record will be added to file/table.
PROCEDURE proc_SaveCurrentInfo(chrProposal_arg VARCHAR2,chrSort_code_arg VARCHAR2,chrFunding_code_arg VARCHAR2,chrOffsetfunding_code_arg VARCHAR2, chrSourceTranx_no_arg number) IS
BEGIN
	chrSaved_proposal:=chrProposal_arg;
	chrSaved_sort_code:=chrSort_code_arg;
	chrSaved_funding_code:=chrFunding_code_arg;
	chrSaved_offsetfunding_code:=chrOffsetfunding_code_arg;
  chrSaved_source_tranx_no := chrSourceTranx_no_arg;
END proc_SaveCurrentInfo;

-- Update totals for current shop by adding labor/material amounts.
-- Build record for plantsub table, which will be later written to file
PROCEDURE proc_WriteOutCurrentRecord IS
BEGIN
	numChg_acct_labr:=numChg_acct_lab;
	numChg_acct_matr:=numChg_acct_mat;
	numBilling_amount_rnd:=numChg_acct_labr+numChg_acct_matr;
	--2500 add-to-totals
	proc_AddToTotals;

-- Retrieve additional fields, like item description, reference number, vendor id
-- and set others like invoice date (todays date) and default unit price.
	--5010 Find-title-cust-dec

	SELECT description,reference_no INTO chrAe_description,chrAe_reference_no
		FROM ae_p_pro_e
		WHERE proposal=chrAe_proposal;
	BEGIN
	SELECT CUSTOM002 INTO CHRAE_CUSTOM002
		FROM AE_I_EXT_E_UDF
--		WHERE trans_no=chrMB_Source_tranx_no;
    WHERE trans_no=chrSaved_source_tranx_no;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		chrAe_custom002:='                              ';
	END;
	-- End of 5010
	IF(chrAe_custom002 IS NULL) THEN
		chrAe_custom002:='                              ';
	END IF;

	chrTr_dept_ref_no:=chrAe_custom002;
	CHRTR_ITEM_DESC:=SUBSTR(CHRAE_DESCRIPTION,1,30);
	chrTr_vendor_order_num:=chrSaved_proposal;

	BEGIN
		SELECT DISTINCT vendor_id INTO chrTr_vendor_id
			FROM pap_bill_vendor_id
			WHERE offsetfunding_code=chrSaved_offsetfunding_code;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		chrTr_vendor_id:='          ';
	END;
	numTr_unit_price:=0;
	chrTr_unit_price:=' ';-- Warning: this line would change if Tr_unit_price is given another value
	numTr_qty_vouchered:=0;
	chrTr_qty_vouchered:=' ';-- Warning: this line would change if Tr_qty_vouchered is given another value

	numTr_merchandise_amount:=numBilling_amount_rnd;
-- Right adjust previous numeric variable when putting into an alphabetic field (for file insertion).
	chrTr_merchandise_amount:=func_RightAdjust(numTr_merchandise_amount,17,2);
	chrTr_invoice_date:=chrTodays_date;
	chrCf_chart_field:=chrSaved_funding_code;

-- Parse Chart field to retrieve fund code, org_code, subclass, program code, project grant and account
	chrCf_chart_field:=REPLACE(chrCf_chart_field,' ','');
	--5100
	proc_BreakUpChartField;

	IF(RTRIM(chrAe_reference_no) IS NULL) THEN
		chrTr_voucher_comment:=' ';
	ELSE
		chrTr_voucher_comment:=chrAe_reference_no;
	END IF;

-- insert row into plantsub table ...
	INSERT INTO plantsub
		VALUES(chrTr_card_code,chrTr_short_code,chrTr_account,
		chrTr_fund_code,chrTr_org_code,chrTr_program_code,chrTr_subclass,
		chrTr_project_grant,chrTr_vendor_id,chrTr_invoice_date,chrTr_invoice_id,
		chrTr_uniqname,chrTr_location_code,chrTr_deliver_to,
		chrTr_vendor_order_num,chrTr_dept_ref_no,chrTr_trip_no,chrTr_item_id,
		chrTr_item_desc,chrTr_vendor_item_id,chrTr_manufacturer_name,
		chrTr_model_num,chrTr_serial_num,chrTr_um_tag_num,chrTr_qty_vouchered,
		chrTr_unit_of_measure,chrTr_unit_price,chrTr_merchandise_amount,
		chrTr_voucher_comment);
chrFile_buffer:=null;
chrFile_buffer:=chrTr_card_code||chrTr_short_code||chrTr_account||chrTr_fund_code||chrTr_org_code;
chrFile_buffer:=chrFile_buffer||chrTr_program_code||chrTr_subclass||chrTr_project_grant||chrTr_vendor_id;
chrFile_buffer:=chrFile_buffer||chrTr_invoice_date||chrTr_invoice_id||chrTr_uniqname||chrTr_location_code;
chrFile_buffer:=chrFile_buffer||chrTr_deliver_to||chrTr_vendor_order_num||chrTr_dept_ref_no||chrTr_trip_no;
chrFile_buffer:=chrFile_buffer||chrTr_item_id||chrTr_item_desc||chrTr_vendor_item_id||chrTr_manufacturer_name;
chrFile_buffer:=chrFile_buffer||chrTr_model_num||chrTr_serial_num||chrTr_um_tag_num||chrTr_qty_vouchered;
chrFile_buffer:=chrFile_buffer||chrTr_unit_of_measure||chrTr_unit_price||chrTr_merchandise_amount||chrTr_voucher_comment;

-- update totals and counters
	numTot_voucher_count:=numTot_voucher_count+1;
	numTot_voucher_amount:=numTot_voucher_amount+numBilling_amount_rnd;
	numBilling_amount_rnd:=0;
	numChg_acct_lab:=0;
	numChg_acct_mat:=0;

	IF(chrSaved_offsetfunding_code='52000-678400-92320-ADMIN'
		OR chrSaved_offsetfunding_code='52000-678200-92320-ADMIN') THEN
		numAec_rec_cnt:=numAec_rec_cnt+1;
	ELSE
		IF(chrSaved_offsetfunding_code='10000-679605-71000-OPERA') THEN
			numOseh_rec_cnt:=numOseh_rec_cnt+1;
		ELSE
			numPlt_rec_cnt:=numPlt_rec_cnt+1;
		END IF;
	END IF;
END proc_WriteOutCurrentRecord;

-- add proposal to list of plants with sum of credit and debit equal to 0.
PROCEDURE proc_WriteOutZeroRecs IS
BEGIN
	INSERT INTO plant_zero
		VALUES(chrSaved_proposal);
END proc_WriteOutZeroRecs;

-- Parse Chart field to retrieve fund code, org_code, subclass, program code, project grant and account
PROCEDURE proc_BreakUpChartField IS
numBuff_pointerS	NUMBER;--pointer to SPACE
numBuff_pointerD	NUMBER;--pointer to DASH
numBuff_pointer		NUMBER;--min of pointers to SPACE and DASH
numBuff_prev_pointer	NUMBER;
numBuff_length		NUMBER;
numTr_account		NUMBER;
chrAccount_numeric	VARCHAR2(1);
BEGIN
	numBuff_length:=LENGTH(RTRIM(chrCf_chart_field));
	numBuff_prev_pointer:=1;
	numBuff_pointerS:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),' ',numBuff_prev_pointer);
	numBuff_pointerD:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),'-',numBuff_prev_pointer);
	IF(numBuff_pointerS<numBuff_pointerD AND numBuff_pointerS>0) THEN
		numBuff_pointer:=numBuff_pointerS;
	ELSE
		IF(numBuff_pointerD>0) THEN
			numBuff_pointer:=numBuff_pointerD;
		ELSE
			numBuff_pointer:=LENGTH(RTRIM(chrCf_chart_field))+1;
		END IF;
-- fix
		IF(numBuff_pointerS=0 AND numBuff_pointerD=0) THEN
			numBuff_pointer:=LENGTH(SUBSTR(RTRIM(chrCf_chart_field),numBuff_prev_pointer))+1;
		END IF;
-- end fix
	END IF;

	chrTr_fund_code:=SUBSTR(chrCf_chart_field,numBuff_Prev_pointer,numBuff_pointer-1);
	IF(chrTr_fund_code IS NULL) THEN
		chrTr_fund_code:=' ';
	END IF;

--Get Tr_org_code
	numBuff_prev_pointer:=7;
	numBuff_pointerS:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),' ',numBuff_prev_pointer);
	numBuff_pointerD:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),'-',numBuff_prev_pointer);
	IF(numBuff_pointerS<numBuff_pointerD AND numBuff_pointerS>0) THEN
		numBuff_pointer:=numBuff_pointerS;
	ELSE
		IF(numBuff_pointerD>0) THEN
			numBuff_pointer:=numBuff_pointerD;
		ELSE
			numBuff_pointer:=LENGTH(RTRIM(chrCf_chart_field))+1;
		END IF;
-- fix
		IF(numBuff_pointerS=0 AND numBuff_pointerD=0) THEN
			numBuff_pointer:=LENGTH(SUBSTR(RTRIM(chrCf_chart_field),numBuff_prev_pointer))+1;
		END IF;
-- end fix
	END IF;
	chrTr_org_code:=SUBSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_pointer-1),1,6);
	IF(chrTr_org_code IS NULL) THEN
		chrTr_org_code:=' ';
	END IF;

--Get Tr_subclass
	chrCf_chart_field:=substr(chrCf_chart_field,14,numBuff_length);
	numBuff_prev_pointer:=1;
	IF(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,1)=';') THEN
		chrTr_subclass:=' ';
		numBuff_prev_pointer:=numBuff_prev_pointer+2;
		numBuff_pointer:=0;
	ELSE
		numBuff_pointerS:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),' ',numBuff_prev_pointer);
		numBuff_pointerD:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),'-',numBuff_prev_pointer);
		IF(numBuff_pointerS<numBuff_pointerD AND numBuff_pointerS>0) THEN
			numBuff_pointer:=numBuff_pointerS;
		ELSE
			IF(numBuff_pointerD>0) THEN
				numBuff_pointer:=numBuff_pointerD;
			ELSE
				numBuff_pointer:=LENGTH(RTRIM(chrCf_chart_field))+1;
			END IF;
		END IF;
-- fix
		IF(numBuff_pointerS=0 AND numBuff_pointerD=0) THEN
			numBuff_pointer:=LENGTH(SUBSTR(RTRIM(chrCf_chart_field),numBuff_prev_pointer))+1;
		END IF;
-- end fix
		chrTr_subclass:=SUBSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_pointer-1),1,5);
		IF(chrTr_subclass IS NULL) THEN
			chrTr_subclass:=' ';
		END IF;
	END IF;

--Get Tr_program_code
	numBuff_prev_pointer:=numBuff_prev_pointer+numBuff_pointer;
	chrCf_chart_field:=substr(chrCf_chart_field,numBuff_prev_pointer,numBuff_length);
	numBuff_prev_pointer:=1;
	IF(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,1)=';' OR SUBSTR(chrCf_chart_field,numBuff_prev_pointer,1)=' ') THEN
		chrTr_program_code:=' ';
		numBuff_prev_pointer:=numBuff_prev_pointer+2;
		numBuff_pointer:=0;
	ELSE
		numBuff_pointerS:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),' ',numBuff_prev_pointer);
		numBuff_pointerD:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),'-',numBuff_prev_pointer);
		IF(numBuff_pointerS<numBuff_pointerD AND numBuff_pointerS>0) THEN
			numBuff_pointer:=numBuff_pointerS;
		ELSE
			IF(numBuff_pointerD>0) THEN
				numBuff_pointer:=numBuff_pointerD;
			ELSE
				numBuff_pointer:=LENGTH(RTRIM(chrCf_chart_field))+1;
			END IF;
		END IF;
-- fix
		IF(numBuff_pointerS=0 AND numBuff_pointerD=0) THEN
			numBuff_pointer:=LENGTH(SUBSTR(RTRIM(chrCf_chart_field),numBuff_prev_pointer))+1;
		END IF;
-- end fix
		chrTr_program_code:=SUBSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_pointer-1),1,5);
		IF(chrTr_program_code IS NULL) THEN
			chrTr_program_code:=' ';
		END IF;
	END IF;

--Get Tr_project_grant
	numBuff_prev_pointer:=numBuff_prev_pointer+numBuff_pointer;
	chrCf_chart_field:=substr(chrCf_chart_field,numBuff_prev_pointer,numBuff_length);
	numBuff_prev_pointer:=1;
	IF(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,1)=';' OR SUBSTR(chrCf_chart_field,numBuff_prev_pointer,1)=' ') THEN
		chrTr_project_grant:=' ';
		numBuff_prev_pointer:=numBuff_prev_pointer+2;
		numBuff_pointer:=0;
	ELSE
		numBuff_pointerS:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),' ',numBuff_prev_pointer);
		numBuff_pointerD:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),'-',numBuff_prev_pointer);
		IF(numBuff_pointerS<numBuff_pointerD AND numBuff_pointerS>0) THEN
			numBuff_pointer:=numBuff_pointerS;
		ELSE
			IF(numBuff_pointerD>0) THEN
				numBuff_pointer:=numBuff_pointerD;
			ELSE
				numBuff_pointer:=LENGTH(RTRIM(chrCf_chart_field))+1;
			END IF;
		END IF;
-- fix
		IF(numBuff_pointerS=0 AND numBuff_pointerD=0) THEN
			numBuff_pointer:=LENGTH(SUBSTR(RTRIM(chrCf_chart_field),numBuff_prev_pointer))+1;
		END IF;
-- end fix
		chrTr_project_grant:=SUBSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_pointer-1),1,15);
		IF(chrTr_project_grant IS NULL) THEN
			chrTr_project_grant:=' ';
		END IF;
	END IF;

--Get Tr_account
	numBuff_prev_pointer:=numBuff_prev_pointer+numBuff_pointer;
	numBuff_pointerS:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),' ',numBuff_prev_pointer);
	numBuff_pointerD:=INSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_length-numBuff_prev_pointer+1),'-',numBuff_prev_pointer);
	IF(numBuff_pointerS<numBuff_pointerD AND numBuff_pointerS>0) THEN
		numBuff_pointer:=numBuff_pointerS;
	ELSE
		IF(numBuff_pointerD>0) THEN
			numBuff_pointer:=numBuff_pointerD;
		ELSE
			numBuff_pointer:=LENGTH(RTRIM(chrCf_chart_field))+1;
		END IF;
	END IF;

	IF(numBuff_pointer>0) THEN
		chrTr_account:=SUBSTR(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,numBuff_pointer-1),1,6);
	ELSE
		chrTr_account:=RTRIM(SUBSTR(chrCf_chart_field,numBuff_prev_pointer,6));
	END IF;
	chrAccount_numeric:='Y';
-- Find out whether account is numeric
	BEGIN
		numTr_account:=TO_NUMBER(chrTr_account);
	EXCEPTION WHEN VALUE_ERROR THEN
		chrAccount_numeric:='N';
	END;
--dbms_output.put_line(chrCf_chart_field);
--dbms_output.put_line('prj grant '||chrTr_project_grant);
--dbms_output.put_line('bf accnt  '||chrTr_account);

	IF(RTRIM(chrTr_account) IS NULL OR LENGTH(RTRIM(chrTr_account))<>6) THEN
		chrAccount_numeric:='N';
	END IF;

	IF(chrAccount_numeric='N') THEN
-- Account is not numeric, so attempt to gather it from pap_bill_dept_acct
-- depending on what range the shop belongs to.
		BEGIN
			SELECT dept_acct INTO chrTr_account
				FROM pap_bill_dept_acct
				WHERE RTRIM(chrAe_shop) BETWEEN RTRIM(dept_low) AND RTRIM(dept_high);
		EXCEPTION WHEN NO_DATA_FOUND THEN
			chrTr_account:=' ';
		END;
	END IF;
--	IF(chrTr_account IS NULL OR TO_NUMBER(chrTr_account)=0) THEN
	IF(RTRIM(chrTr_account) IS NULL) THEN
		chrTr_account:=' ';
	END IF;
--dbms_output.put_line('af accnt  '||chrTr_account||'  with shop '||chrAe_shop);
END proc_BreakUpChartField;

-- Returns index to first numeric byte from argument or 0 if each byte is alphabetic
FUNCTION func_IndexToNumeric(chrString_arg VARCHAR2) RETURN NUMBER IS
numIndex	NUMBER;
chrFunc_flag	VARCHAR2(1);
numNumeric	NUMBER;
BEGIN
		chrFunc_flag:='Y';
		numIndex:=0;
		WHILE(chrFunc_flag='Y')-- AND numIndex<5)
		LOOP
			numIndex:=numIndex+1;
			chrFunc_flag:='N';
			BEGIN
			numNumeric:=TO_NUMBER(SUBSTR(chrString_arg,numIndex,1));
			EXCEPTION WHEN VALUE_ERROR THEN
				chrFunc_flag:='Y';
			END;
		END LOOP;
		IF(chrFunc_flag='N') THEN
			numIndex:=0;
		END IF;
		RETURN numIndex;
END func_IndexToNumeric;

-- Return a right-adjusted string representing a number with decimals
FUNCTION func_RightAdjust(numNumeric_arg NUMBER,numLength_arg NUMBER,numDecimals_arg NUMBER) RETURN CHAR IS
chrBuffer	VARCHAR2(20);
numIndex	NUMBER;
numDecimal_part	NUMBER(10,9);
chrDecimal_part	VARCHAR2(20);
numSpace_pad	NUMBER;
chrNumber	VARCHAR2(20);
numCount	NUMBER;
BEGIN
	chrNumber:=TO_CHAR(numNumeric_arg);

	IF(numDecimals_arg>0) THEN
		numIndex:=INSTR(chrNumber,'.',1);

		IF(numIndex>0) THEN
			chrNumber:=SUBSTR(chrNumber,1,numIndex+numDecimals_arg);
		ELSE
			numIndex:=LENGTH(chrNumber)+1;
			chrNumber:=CONCAT(chrNumber,'.0');
		END IF;

		WHILE(LENGTH(SUBSTR(chrNumber,numIndex+1,numDecimals_arg))<numDecimals_arg)
		LOOP
			chrNumber:=CONCAT(chrNumber,'0');
		END LOOP;
	ELSE
		chrNumber:=TO_CHAR(TRUNC(numNumeric_arg));
	END IF;

	IF(numNumeric_arg=0) THEN
		chrNumber:=SUBSTR(chrNumber,2,numDecimals_arg+1);
	END IF;

	numIndex:=numLength_arg-LENGTH(chrNumber)+1;
	numCount:=1;
	WHILE(numCount<numIndex)
	LOOP
		chrBuffer:=CONCAT(chrBuffer,' ');
		numCount:=numCount+1;
	END LOOP;
	chrBuffer:=CONCAT(chrBuffer,chrNumber);
	RETURN chrBuffer;
END func_RightAdjust;

PROCEDURE proc_AddAmounts IS
BEGIN
	IF(chrSaved_offsetfunding_code='52000-685100-92320-12133') THEN
		numRental_tot_rnd:=numRental_tot_rnd+numChg_acct_matr;
		numMaterial:=numMaterial-numChg_acct_matr;
	ELSE
		IF(chrSaved_offsetfunding_code='50000-680000-92320-A1050') THEN
			numProc_tot_rnd:=numProc_tot_rnd+numChg_acct_matr;
			numMaterial:=numMaterial-numChg_acct_matr;
		ELSE
-- Since it's not about a special offsetfunding_code, update biling totals for that shop.
			numTti_matr:=numTti_matr+numChg_acct_matr;
			numTti_labr:=numTti_labr+numChg_acct_labr;
			numTti_totl:=numTti_labr+numTti_matr;
			UPDATE sub_shop_bill_totals
				SET material=material+numTti_matr, labor=labor+numTti_labr,
					total=total+numTti_totl
				WHERE shop=chrTti_shop;
			IF(chrTti_shop IN('E1000','E1001','E1002','E2000',
				'E2001','E2002','E2003')) THEN
				numPlt_ext_rnd:=numPlt_ext_rnd+numTti_totl;
				numMaterial:=numMaterial-numTti_totl;
			ELSE
				IF(chrTti_shop='O1000') THEN
					numOseh_tot_rnd:=numOseh_tot_rnd+numTti_totl;
				END IF;
			END IF;
-- reset variables for next update of totals.
			numTti_labr:=0;
			numTti_matr:=0;
		END IF;
	END IF;
END proc_AddAmounts;

PROCEDURE proc_AddToTotals IS
BEGIN
	BEGIN
		SELECT shop INTO chrAe_shop
			FROM ae_p_phs_e
			WHERE proposal=chrSaved_proposal
			AND sort_code=chrSaved_sort_code;
	EXCEPTION WHEN NO_DATA_FOUND THEN
-- display on screen if proposal or sort_code is missing in ae_p_phs_e,
-- but this should never happen
		dbms_output.put_line(chrSaved_proposal);
		dbms_output.put_line(chrSaved_sort_code);
	END;
	SELECT shop INTO chrAe_shop
		FROM ae_p_phs_e
		WHERE proposal=chrSaved_proposal
		AND sort_code=chrSaved_sort_code;
	chrAe_proposal:=chrSaved_proposal;
	chrAe_sort_code:=chrSaved_sort_code;
	chrSaved_shop:=chrAe_shop;

--look for rcd in TOTAL-ITEM and perform 2510 (add amounts according to offsetfunding_code)
	SELECT COUNT(*) INTO numExists
		FROM sub_shop_bill_totals
		WHERE shop=chrSaved_shop;

	chrTti_shop:=chrSaved_shop;
-- Insert shop if new to sub_shop_bill_totals
	IF(numExists=0) THEN
		INSERT INTO sub_shop_bill_totals(shop,material,labor,total)
			VALUES(chrTti_shop,0,0,0);
	END IF;
	-- 2510 Add-amounts
	proc_AddAmounts;
END proc_AddToTotals;

---------------will disable change3
---- change3
--			IF(chrMb_offsetfunding_code='50000-680000-92320-A1050') THEN
---- add amount to procurement for that offsetfunding_code
--				numProcurement:=numProcurement+numMb_amount;
--			ELSE
--				IF(chrMb_offsetfunding_code='52000-685100-92320-12133') THEN
---- add amount to rental for that offsetfunding_code
--					numRental:=numRental+numMb_amount;
--				ELSE
--					SELECT shop INTO chrAe_shop
--						FROM ae_p_phs_e
--						WHERE proposal=chrMb_proposal
--						AND sort_code=chrMb_sort_code;
--
--					IF(chrMb_offsetfunding_code IN('52000-678400-92320-ADMIN',
--						'52000-678200-92320-ADMIN')
--					OR chrAe_shop IN('E1000','E1001','E1002','E2000',
--						'E2001','E2002','E2003')) THEN
--						numPlant_ext_rec_cnt:=numPlant_ext_rec_cnt+1;
--						numPlant_ext:=numPlant_ext+numMb_amount;
---- reverse addition to be performed some lines below
--						numPlt_rec_cnt:=numPlt_rec_cnt-1;
--					ELSE
--						--2110 It-is-the-same
--						IF(chrMb_subledger_type='L') THEN
---- add amount to either labor or material amounts
--							numLabor:=numLabor+numMb_amount;
--							numShop_lab_tot:=numShop_lab_tot+numMb_amount;
--							numChg_acct_lab:=numChg_acct_lab+numMb_amount;
--						ELSE
--							numMaterial:=numMaterial+numMb_amount;
--							numShop_mat_tot:=numShop_mat_tot+numMb_amount;
--							numChg_acct_mat:=numChg_acct_mat+numMb_amount;
--						END IF;
--					END IF;
--				END IF;
--			END IF;
--			numPlt_rec_cnt:=numPlt_rec_cnt+1;
---- end of change3

PROCEDURE proc_TestChartField(chrArg VARCHAR2) IS
begin
chrCf_chart_field:=chrArg;
	proc_BreakupChartField;
dbms_output.put_line('fund code '||chrTr_fund_code);
dbms_output.put_line('org code  '||chrTr_org_code);
dbms_output.put_line('sub class '||chrTr_subclass);
dbms_output.put_line('pgm code  '||chrTr_program_code);
dbms_output.put_line('prj grant '||chrTr_project_grant);
dbms_output.put_line('tr accnt  '||chrTr_account);
END proc_TestChartField;

-- added on 04/01/2009 because of New Line chars in item_desc
PROCEDURE proc_FixPlantSub IS
-- Remove CRLF
filInp		UTL_FILE.FILE_TYPE;
filOut		UTL_FILE.FILE_TYPE;
chrSav_buff	VARCHAR2(600);
chrBuff		VARCHAR2(600);
chrWr_flag	VARCHAR2(1);
numLength	NUMBER;
BEGIN
	chrWr_flag:='N';
	filInp:=UTL_FILE.FOPEN('PROC_DIR','PLANTSUB_BAD','R');
	filOut:=UTL_FILE.FOPEN('PROC_DIR','PLANTSUB','W');
	chrSav_buff:=' ';
	LOOP
		BEGIN
			UTL_FILE.GET_LINE(filInp,chrBuff);
		EXCEPTION WHEN NO_DATA_FOUND THEN
			EXIT;
		END;
chrBuff:=REPLACE(chrBuff,CHR(13)||CHR(10),' ');
chrBuff:=REPLACE(chrBuff,CHR(10),' ');
chrBuff:=REPLACE(chrBuff,CHR(13),' ');
chrBuff:=REPLACE(chrBuff,CHR(9),' ');
		IF(chrBuff LIKE '1 %') THEN
			IF(RTRIM(chrSav_buff) IS NOT NULL) THEN
				UTL_FILE.PUT_LINE(filOut,chrSav_buff);
			END IF;
			chrSav_buff:=chrBuff;
		ELSE
			IF(chrBuff LIKE '2 %') THEN
	UTL_FILE.PUT_LINE(filOut,chrSav_buff);
	UTL_FILE.PUT_LINE(filOut,chrBuff);
				EXIT;
			ELSE
				numLength:=LENGTH(chrSav_buff)-2;
				chrSav_buff:=CONCAT(SUBSTR(chrSav_buff,1,numLength),'   ');
				chrSav_buff:=CONCAT(chrSav_buff,chrBuff);
			END IF;
		END IF;
	END LOOP;
	UTL_FILE.FCLOSE(filInp);
	UTL_FILE.FCLOSE(filOut);
END proc_FixPlantSub;

---- create table iv_fmax_extra/iv_fms_extra/iv_plant_fmax/iv_plant_fms(content varchar2(600));
--PROCEDURE proc_TestSub100 IS
--filFms		UTL_FILE.FILE_TYPE;
--filFmax		UTL_FILE.FILE_TYPE;
--chrBuffer		varchar2(600);
--BEGIN
--	EXECUTE IMMEDIATE 'TRUNCATE TABLE iv_plant_fms';
--	EXECUTE IMMEDIATE 'TRUNCATE TABLE iv_plant_fmax';
--	EXECUTE IMMEDIATE 'TRUNCATE TABLE iv_fmax_extra';
--	EXECUTE IMMEDIATE 'TRUNCATE TABLE iv_fms_extra';
--
--	filFms:=UTL_FILE.FOPEN('PROC_DIR','PLANT_FMS','R');
--	LOOP
--	BEGIN
--			UTL_FILE.GET_LINE(filFms,chrBuffer);
--		EXCEPTION WHEN NO_DATA_FOUND THEN
--			EXIT;
--		END;
--		INSERT INTO iv_plant_fms VALUES(chrBuffer);
--	END LOOP;
--	UTL_FILE.FCLOSE(filFms);
--	DELETE FROM iv_plant_fms WHERE content like '2  12%';
--	filFmax:=UTL_FILE.FOPEN('PROC_DIR','PLANTSUB','R');
--	LOOP
--		BEGIN
--		UTL_FILE.GET_LINE(filFmax,chrBuffer);
--		EXCEPTION WHEN NO_DATA_FOUND THEN
--			EXIT;
--		END;
--		INSERT INTO iv_plant_fmax VALUES(chrBuffer);
--	END LOOP;
--	UTL_FILE.FCLOSE(filFmax);
--	DELETE FROM iv_plant_fmax WHERE content like '2  12%';
--	INSERT INTO iv_fmax_extra
--		SELECT rtrim(content) FROM iv_plant_fmax
--			WHERE RTRIM(content) not in (select rtrim(content) from iv_plant_fms);
--	INSERT INTO iv_fms_extra
--		SELECT rtrim(content) FROM iv_plant_fms
--			WHERE RTRIM(content) not in (select rtrim(content) from iv_plant_fmax);
--	COMMIT;
--END proc_TestSub100;
END fmaxC_18;