INSERT INTO AE_A_ASSET_E(DESCRIPTION, MANUFACTURE_CODE, MANU_PART_NUMBER, REGION_CODE, FAC_ID, BLDG, SHOP, SHOP_PERSON, STATUS_CODE, ROUTE_NO, ROUTE_SEQ, RENTABLE_YN, LOCKOUT, EDIT_DATE, EDIT_CLERK, ASSET_TAG, ASSET_GROUP, LONG_DESC, LINK_TRANX_NUM, VERSION_TRANX_NUM, ASSET_TYPE) 
SELECT DESCRIPTION, MANUFACTURE_CODE, MANU_PART_NUMBER, REGION_CODE, FAC_ID, BLDG, SHOP, SHOP_PERSON, eqm_STATUS, ROUTE_NO, ROUTE_SEQ, RENTABLE_YN, LOCKOUT, EDIT_DATE, EDIT_CLERK, eqp_TAG_id, eqm_GROUP, LONG_DESC, LINK_TRANX_NUM, VERSION_TRANX_NUM, 'E'
from ae_r_eqm_e@fms.umich;