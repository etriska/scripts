/*
This script will: 
A. delete assets from every table where asset_tag exists when asset tag does not exist in the 
   Master Asset Profile
B. delete all assets marked for deletion in the description of the asset
C. take a little while to run when it hits the ae_r_pmi_s table
D. will not touch ae_p_phs_e. This will need to be looked at on a case-by-case basis.
   Typically, you will not want to delete assets where there is a history of work.

Script created by Ed Triska on 13-AUG-10
*/
delete from AE_A_ASSET_E where description like '%DELETE%';
delete from AE_A_ASSET_ATTR where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_B where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_CHILD where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_DURABLE where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_E_NOTES where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_E_UDF where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_EQUIP where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_PARTS_LIST where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_PROC_ITEMS where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_ASSET_STAT_HIST where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_ACCOUNTS where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_DISP_E where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_FUND where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_LIFE_UPD_E where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_LOC_HIST where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_OFFSET where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_ORG where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_RC_HIST where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_TAG_HIST where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_VEHICLE where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_AST_WARRANTY where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_A_DEPR_SCHED where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_EHS_CONTAINER_LOC_HIST where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_GIS_ASSET where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_R_GEN_D where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_R_GEN_E where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_R_MTR_E where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_R_PMI_S where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_RM_ASSET_ATTR where asset_tag not in (select asset_tag from ae_a_asset_e);
delete from AE_RM_ASSET_D where asset_tag NOT IN (select asset_tag from ae_a_asset_e);
commit;