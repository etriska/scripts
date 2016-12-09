INSERT INTO AE_A_ASSET_E SELECT * FROM TMP_ASST_LOAD;
INSERT INTO AE_A_ASSET_E_UDF SELECT * FROM TMP_ASST_UDF_LOAD;
INSERT INTO AE_A_ASSET_STAT_HIST (ASSET_TAG, ASSET_TYPE, STATUS_DATE, STATUS_CODE, LOGIN, EDIT_DATE, EDIT_CLERK)
SELECT ASSET_TAG, ASSET_TYPE, SYSDATE, 'ACTIVE', EDIT_CLERK, EDIT_DATE, EDIT_CLERK FROM TMP_ASST_LOAD;
INSERT INTO AE_A_AST_TAG_HIST (ASSET_TAG, SEQ, TAG_NUMBER, EDIT_DATE, EDIT_CLERK)
SELECT ASSET_TAG, '1',ASSET_TAG, EDIT_DATE, EDIT_CLERK FROM TMP_ASST_LOAD;
INSERT INTO AE_I_MAK_E (MANUFACTURE_CODE) SELECT DISTINCT MANUFACTURE_CODE
FROM TMP_ASST_LOAD WHERE MANUFACTURE_CODE IS NOT NULL
AND MANUFACTURE_CODE NOT IN (SELECT MANUFACTURE_CODE FROM AE_I_MAK_E);
--update ae_s_ctl_c set tranx_num = 70445 where tranx_type = 'AST_HIST';
create sequence ast_tranx_num start with 70445 increment by 1 cache 20;
insert into ae_a_ast_loc_hist (trans_num, asset_tag, date_created, created_by, region_code, fac_id, bldg, edit_date, edit_clerk)
SELECT AST_TRANX_NUM.NEXTVAL, ASSET_TAG, NVL(EDIT_DATE,SYSDATE), NVL(EDIT_CLERK,'ETRISKA'), REGION_CODE, FAC_ID, BLDG, EDIT_DATE, EDIT_CLERK
FROM TMP_ASST_LOAD;
update ae_s_ctl_c set tranx_num = ast_tranx_num.nextval where tranx_type = 'AST_HIST';