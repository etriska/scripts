-- Tables referring to order_type: ae_c_con_s,ae_p_prb_e,ae_s_sec_c
-- Tables referring to category: ae_c_con_s,ae_p_prb_e,ae_s_sec_c
-- Tables referring to oc_code: ae_i_whs_e,ae_s_sec_c
-- Tables referring to requestor: ae_s_sec_c

-- Notes: ae_h_emp_e had only one row and its shop_person was '1'
-- Any missing required values default to 'N' except for Active_yn.
-- ae_a_asset_type has more records in db4 than in Production.
-- ae_license_key has similar tranx_num but different licensekey.

insert into ae_h_job_e select * from ae_h_job_e@fms.umich;
insert into ae_l_lbr_c select * from ae_l_lbr_c@fms.umich;
insert into ae_h_pcc_e select * from ae_h_pcc_e@fms.umich;
insert into ae_h_pst_e select * from ae_h_pst_e@fms.umich;
insert into ae_h_pba_e select * from ae_h_pba_e@fms.umich;
insert into ae_h_csp_e select * from ae_h_csp_e@fms.umich;
insert into ae_h_edl_e select * from ae_h_edl_e@fms.umich;
insert into ae_h_emp_relation_c select * from ae_h_emp_relation_c@fms.umich;
insert into ae_h_rac_e select * from ae_h_rac_e@fms.umich;
insert into ae_h_exit_code select * from ae_h_exit_code@fms.umich;
insert into ae_h_hrc_e select * from ae_h_hrc_e@fms.umich;
insert into ae_h_sal_grade select * from ae_h_sal_grade@fms.umich;
insert into ae_h_emp_e select * from ae_h_emp_e@fms.umich;
insert into ae_h_emp_cont_data select * from ae_h_emp_cont_data@fms.umich;
insert into ae_h_emp_conf_demo_data select * from ae_h_emp_conf_demo_data@fms.umich;
insert into ae_h_emp_pos_data(SHOP_PERSON,JOB_FAM,JOB_CLASS,JOB_TITLE,
H_DATE,S_DATE,SEN_DATE,HIRE_C,STAT_R,LV_DATE,LV_RENEW,U_NUM,E_STAT,
C_STAT,W_STAT,P_CODE,PAY_B,BASE_WEEK_HR,BASE_DAY_HR,SUP_YN,DIST_CD,SHFT_PRE,
PRCNT_EFF,ANNUAL_SAL,B_SAL,SAL_GR,EXP_CLS,EDIT_DATE,EDIT_CLERK)
SELECT SHOP_PERSON,JOB_FAM,JOB_CLASS,JOB_TITLE,
H_DATE,S_DATE,SEN_DATE,HIRE_C,STAT_R,LV_DATE,LV_RENEW,U_NUM,E_STAT,
C_STAT,W_STAT,P_CODE,PAY_B,BASE_WEEK_HR,BASE_DAY_HR,SUP_YN,DIST_CD,SHFT_PRE,
PRCNT_EFF,ANNUAL_SAL,B_SAL,SAL_GR,EXP_CLS,EDIT_DATE,EDIT_CLERK
FROM ae_h_emp_pos_data@fms.umich;
insert into ae_h_act_e select * from ae_h_act_e@fms.umich;
insert into ae_h_lve_codes select * from ae_h_lve_codes@fms.umich;
insert into ae_l_man_d select * from ae_l_man_d@fms.umich;
insert into ae_h_sch_d select * from ae_h_sch_d@fms.umich;
insert into ae_h_emp_emergency select * from ae_h_emp_emergency@fms.umich;
insert into ae_h_trn_d select * from ae_h_trn_d@fms.umich;
insert into ae_h_emp_d select * from ae_h_emp_d@fms.umich;
insert into ae_h_emp_e_udf select * from ae_h_emp_e_udf@fms.umich;
truncate table ae_l_shp_e;
insert into ae_l_shp_e(SHOP,DESCRIPTION,NO_WORKERS,NO_DAYS_WK,
NO_DAYS_OFF,NO_HRS_DAY,CAPACITY_DAY,CONTACT,PH,REF,SUPERVISOR_ID,REGION_CODE,
FAC_ID,BLDG,LOCATION_CODE,LOC_ID,OVERH_FUNDING_CODE,OVERH_SUB_CODE,EDIT_DATE,
EDIT_CLERK,ACTIVE,MON_YN,TUE_YN,WED_YN,THU_YN,FRI_YN,SAT_YN,SUN_YN,
SHOP_START_TIME,SHOP_END_TIME,HOL_YN,LINK_TRANX_NUM,AF1,AF2,AF3,AF4,AF5,AF6,
AF7,AF8,AF9,AF10,AF11,AF12,motorpool_yn) 
select SHOP,DESCRIPTION,NO_WORKERS,NO_DAYS_WK,
NO_DAYS_OFF,NO_HRS_DAY,CAPACITY_DAY,CONTACT,PH,REF,SUPERVISOR_ID,REGION_CODE,
FAC_ID,BLDG,LOCATION_CODE,LOC_ID,OVERH_FUNDING_CODE,OVERH_SUB_CODE,EDIT_DATE,
EDIT_CLERK,ACTIVE,MON_YN,TUE_YN,WED_YN,THU_YN,FRI_YN,SAT_YN,SUN_YN,
SHOP_START_TIME,SHOP_END_TIME,HOL_YN,LINK_TRANX_NUM,AF1,AF2,AF3,AF4,AF5,AF6,
AF7,AF8,AF9,AF10,AF11,AF12,'N'
from ae_l_shp_e@fms.umich;
insert into ae_l_shp_accounts(shop,seq,sub_ledger,account_type,funding_code,
sub_code,start_date,end_date,locked_dist,edit_date,edit_clerk)
select shop,seq,sub_ledger,account_type,funding_code,
sub_code,start_date,end_date,'N',edit_date,edit_clerk
from ae_l_shp_accounts@fms.umich;
insert into ae_l_shp_c select * from ae_l_shp_c@fms.umich;
insert into ae_l_shp_l select * from ae_l_shp_l@fms.umich;
insert into ae_l_shp_eqp select * from ae_l_shp_eqp@fms.umich;
insert into ae_l_shp_m select * from ae_l_shp_m@fms.umich;
truncate table ae_l_shp_d;
insert into ae_l_shp_d select * from ae_l_shp_d@fms.umich;
truncate table ae_s_pri_c;
insert into ae_s_pri_c select * from ae_s_pri_c@fms.umich;
insert into ae_p_prb_e select * from ae_p_prb_e@fms.umich;
insert into ae_a_asset_type select * from ae_a_asset_type@fms.umich
where asset_type not in(select asset_type from ae_a_asset_type);
insert into ae_a_asset_status select * from ae_a_asset_status@fms.umich;
insert into ae_c_con_e select * from ae_c_con_e@fms.umich;
insert into ae_c_con_a select * from ae_c_con_a@fms.umich;
insert into ae_c_trm_e select * from ae_c_trm_e@fms.umich;
insert into ae_c_con_e_notes select * from ae_c_con_e_notes@fms.umich;
insert into ae_c_con_c select * from ae_c_con_c@fms.umich;
insert into ae_c_con_e_udf select * from ae_c_con_e_udf@fms.umich;
insert into ae_c_con_invoice_c select * from ae_c_con_invoice_c@fms.umich;
insert into ae_c_con_invoice_d select * from ae_c_con_invoice_d@fms.umich;
insert into ae_c_con_s select * from ae_c_con_s@fms.umich;
insert into ae_c_con_invoice_e(tranx_no,invoice_no,invoice_date,status_date,
login,status_code,description,edit_date,edit_clerk)
select tranx_no,invoice_no,invoice_date,status_date,
login,status_code,description,edit_date,edit_clerk
from ae_c_con_invoice_e@fms.umich;
truncate table ae_s_fnd_c;
insert into ae_s_fnd_c select * from ae_s_fnd_c@fms.umich;
insert into ae_s_fnd_c_notes select * from ae_s_fnd_c_notes@fms.umich;
insert into ae_s_fnd_d select * from ae_s_fnd_d@fms.umich;
insert into ae_s_fnd_a select * from ae_s_fnd_a@fms.umich;
insert into ae_i_whs_e(WAREHOUSE,DESCRIPTION,ADDR1,ADDR2,CONTACT,REGION_CODE,
FAC_ID,BLDG,LOCATION_CODE,LOC_ID,CITY,STATE,ZIP_CODE,PHONE,FAX,DISABLE_VALIDATE,
EDIT_DATE,EDIT_CLERK,COMPANY_ID,DEPT_ID,OC_CODE,MON_YN,TUE_YN,WED_YN,THU_YN,
FRI_YN,SAT_YN,SUN_YN,OFFSETFUNDING_CODE,OFFSETSUB_CODE,ACTIVE,LINK_TRANX_NUM,
AF1,AF2,AF3,AF4,AF5,AF6,AF7,AF8,AF9,AF10,AF11,AF12,VALIDATE_STAGE,
VALIDATE_STAGING_AREA_YN,validate_shop)
select WAREHOUSE,DESCRIPTION,ADDR1,ADDR2,CONTACT,REGION_CODE,
FAC_ID,BLDG,LOCATION_CODE,LOC_ID,CITY,STATE,ZIP_CODE,PHONE,FAX,DISABLE_VALIDATE,
EDIT_DATE,EDIT_CLERK,COMPANY_ID,DEPT_ID,OC_CODE,MON_YN,TUE_YN,WED_YN,THU_YN,
FRI_YN,SAT_YN,SUN_YN,OFFSETFUNDING_CODE,OFFSETSUB_CODE,ACTIVE,LINK_TRANX_NUM,
AF1,AF2,AF3,AF4,AF5,AF6,AF7,AF8,AF9,AF10,AF11,AF12,VALIDATE_STAGE,
VALIDATE_STAGING_AREA_YN,'N' from ae_i_whs_e@fms.umich;
insert into ae_i_whs_c(warehouse,seq,account_type,funding_code,sub_code,
start_date,end_date,edit_date,edit_clerk,sub_ledger)
select warehouse,seq,account_type,funding_code,sub_code,
start_date,end_date,edit_date,edit_clerk,sub_ledger
from ae_i_whs_c@fms.umich;
insert into ae_i_whs_security select * from ae_i_whs_security@fms.umich;
insert into ae_i_inv_w select * from ae_i_inv_w@fms.umich;
insert into ae_i_cls_e select * from ae_i_cls_e@fms.umich;
insert into ae_i_com_e select * from ae_i_com_e@fms.umich;
insert into ae_i_itm_e select * from ae_i_itm_e@fms.umich;
insert into ae_i_uom_d select * from ae_i_uom_d@fms.umich;
insert into ae_i_cyc_d select * from ae_i_cyc_d@fms.umich;
insert into ae_i_mak_e(manufacture_code,description,address1,address2,city,
state,zip_code,phone1,phone2,fax,contact_name,active_yn,edit_date,
edit_clerk)
select manufacture_code,description,address1,address2,city,
state,zip_code,phone1,phone2,fax,contact_name,'Y',edit_date,
edit_clerk
from ae_i_mak_e@fms.umich;
insert into ae_i_loc_e select * from ae_i_loc_e@fms.umich;
insert into ae_r_pms_e select * from ae_r_pms_e@fms.umich;
insert into ae_r_pms_d select * from ae_r_pms_d@fms.umich;
insert into ae_r_pms_e_notes select * from ae_r_pms_e_notes@fms.umich;
insert into ae_artifact select * from ae_artifact@fms.umich
where (artifact_tranx_num,version_tranx_num)
not in(select artifact_tranx_num,version_tranx_num from ae_artifact);
insert into ae_r_frq_e select * from ae_r_frq_e@fms.umich where
(schd_freq,occ_yr) not in(select schd_freq,occ_yr from ae_r_frq_e);
insert into ae_i_rte_d select * from ae_i_rte_d@fms.umich;
insert into ae_r_pms_uom select * from ae_r_pms_uom@fms.umich;
insert into ae_j_prj_type select * from ae_j_prj_type@fms.umich;
insert into ae_j_sta_c select * from ae_j_sta_c@fms.umich;
insert into ae_j_sta_d select * from ae_j_sta_d@fms.umich;
insert into ae_s_poe_t(po_type,description,default_type,use_3_way_match,
trans_at_invoice,edit_date,edit_clerk,active,require_ext_ref)
select po_type,description,default_type,use_3_way_match,
trans_at_invoice,edit_date,edit_clerk,active,'N'
from ae_s_poe_t@fms.umich;
insert into ae_i_poe_status_e(po_type,status_code,description,act_code,min_code,
max_code,no_days,complete_yn,edit_date,edit_clerk,active,seq)
select po_type,status_code,'MISSING DESCRIPTION',act_code,min_code,
max_code,no_days,complete_yn,edit_date,edit_clerk,active,seq
from ae_i_poe_status_e@fms.umich;
insert into ae_i_poe_status_d(status_code,role_id,dollar_amt,edit_date,
edit_clerk,po_type)
select status_code,role_id,dollar_amt,edit_date,
edit_clerk,po_type from ae_i_poe_status_d@fms.umich;
insert into ae_i_rec_t select * from ae_i_rec_t@fms.umich;
insert into ae_i_rej_e select * from ae_i_rej_e@fms.umich;
insert into ae_p_lat_c select * from ae_p_lat_c@fms.umich;
insert into ae_l_lbr_e select * from ae_l_lbr_e@fms.umich;
insert into ae_h_lvc_e select * from ae_h_lvc_e@fms.umich;
insert into ae_h_lve_e select * from ae_h_lve_e@fms.umich;
insert into ae_h_lev_c select * from ae_h_lev_c@fms.umich;
insert into ae_h_lve_job_fam select * from ae_h_lve_job_fam@fms.umich;
insert into ae_h_shf_c select * from ae_h_shf_c@fms.umich;
insert into ae_s_wks_h select * from ae_s_wks_h@fms.umich;
insert into ae_s_notes select * from ae_s_notes@fms.umich where
(notes_table,description) not in(select notes_table,description from
ae_s_notes);
insert into ae_trigger select * from ae_trigger@fms.umich;
insert into ae_s_udf_columns select * from ae_s_udf_columns@fms.umich
where (udf_table,udf_column) not in(select udf_table,udf_column 
from ae_s_udf_columns);
insert into ae_license_key select * from ae_license_key@fms.umich where
(tranx_num) not in(select tranx_num from
ae_license_key);
insert into ae_authz(role_id,description,edit_date,edit_clerk,active,
privileges_edit_date)
select role_id,description,edit_date,edit_clerk,active,edit_date
from ae_authz@fms.umich where role_id not in
(select role_id from ae_authz);
insert into ae_authz_privilege select * from ae_authz_privilege@fms.umich
where (role_id,privilegE_id) not in(select role_id,privilege_id from
ae_authz_privilege);
insert into ae_authz_security_filter select * 
from ae_authz_security_filter@fms.umich;
insert into ae_s_sec_c(LOGIN,ASSIGNED_BY,ASSIGN_DATE,DESCRIPTION,PASSWORD,
ORDER_TYPE,CATEGORY,REGION_CODE,FAC_ID,BLDG,LABOR_CLASS,SHOP,COMPANY_ID,
DEPT_ID,OC_CODE,REQUESTOR,PASSWD_EXP_DAYS,PASSWD_LAST_CHANGE,CONTRACTOR,
CRT_FLAG,WAREHOUSE,EMPLOYEE_ID,MFM_DOWNLOAD,EDIT_DATE,EDIT_CLERK,DEFAULT_ORG,
LOC_ID,LOCATION_CODE,ACTIVE,LINK_TRANX_NUM,LAST_LOGIN,ADMIN_ID,AUTHORIZER,
AUTHORIZER_EMAIL,EMAIL,login_attempt_count)
select LOGIN,ASSIGNED_BY,ASSIGN_DATE,DESCRIPTION,PASSWORD,
ORDER_TYPE,CATEGORY,REGION_CODE,FAC_ID,BLDG,LABOR_CLASS,SHOP,COMPANY_ID,
DEPT_ID,OC_CODE,REQUESTOR,PASSWD_EXP_DAYS,PASSWD_LAST_CHANGE,CONTRACTOR,
CRT_FLAG,WAREHOUSE,EMPLOYEE_ID,MFM_DOWNLOAD,EDIT_DATE,EDIT_CLERK,DEFAULT_ORG,
LOC_ID,LOCATION_CODE,ACTIVE,LINK_TRANX_NUM,LAST_LOGIN,ADMIN_ID,AUTHORIZER,
AUTHORIZER_EMAIL,EMAIL,0 from ae_s_sec_c@fms.umich where login
not in (select login from ae_s_sec_c);
insert into ae_security_filter select * from ae_security_filter@fms.umich;
insert into ae_s_sec_c_notes select * from ae_s_sec_c_notes@fms.umich;
insert into ae_authz_principal select * from ae_authz_principal@fms.umich 
where (role_id,login) not in(select role_id,login from ae_authz_principal);
insert into ae_s_currency_code select * from ae_s_currency_code where
curr_code not in(select curr_code from ae_s_currency_code);
insert into ae_s_currency_rate(seq,curr_code,start_date,end_date,
edit_clerk,curr_code_rate)
select seq,curr_code,start_date,end_date,
edit_clerk,curr_code_rate from ae_s_currency_rate@fms.umich;
insert into ae_artifact_flag select * from ae_artifact_flag@fms.umich where (flag,code)
not in (select flag,code from ae_artifact_flag);
commit;
/
