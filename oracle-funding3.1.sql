/****** Object:  View sccoun views    Script Date: 08/11/2008 17:28:02 ******/
CREATE OR REPLACE VIEW Shop_accounts
AS
SELECT     phase.proposal as proposal, phase.sort_code as sort_code, phase.default_dist as Dist_type, charge.sub_ledger as sub_ledger, charge.funding_code as charge_account, charge.sub_code as charge_subcode,
					  CASE WHEN offset.sub_ledger IS NULL then All_offset.sub_ledger else
					  offset.sub_ledger end as offset_sub_ledger,
					  CASE WHEN offset.funding_code IS NULL then All_offset.funding_code else 
					  offset.funding_code end as offset_account, 
					  CASE WHEN offset.funding_code IS NULL then All_offset.sub_code else 
					  offset.sub_code end as offset_subcode
FROM        ae_p_phs_e   phase join  ae_l_shp_accounts  charge ON phase.shop = charge.shop LEFT OUTER JOIN
                      ae_l_shp_accounts  offset ON charge.shop = offset.shop AND (charge.sub_ledger = offset.sub_ledger OR charge.sub_ledger = 'A' OR offset.sub_ledger = 'A') LEFT OUTER JOIN
					  ae_l_shp_accounts  All_offset ON charge.shop = All_offset.shop AND  All_offset.sub_ledger = 'A'
WHERE     ((charge.start_date IS NULL) OR (charge.start_date < SYSDATE and charge.end_date IS NULL) OR (SYSDATE  Between Charge.start_date and charge.end_date)) AND (offset.account_type = 'O') 
					  AND (charge.account_type = 'C') AND ((offset.start_date IS NULL) OR (offset.start_date < SYSDATE and offset.end_date IS NULL) OR (SYSDATE  Between offset.start_date and offset.end_date))
					  AND (All_offset.account_type = 'O' OR All_offset.account_type IS NULL) AND ((All_offset.start_date IS NULL) OR (All_offset.start_date < SYSDATE and All_Offset.end_date IS NULL) OR (SYSDATE  Between All_offset.start_date and All_offset.end_date)) 
					  AND PHASE.DEFAULT_DIST = 'S';
COMMIT;

CREATE OR REPLACE VIEW Custom_and_Org_accounts
AS
SELECT     charge.proposal, charge.sort_code,phase.default_dist as Dist_type, charge.fixed_actual, charge.precedence, charge.sub_percent AS precent, charge.sub_amount AS amount, 
                      charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, CASE WHEN offset.sub_ledger IS NULL 
                      THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_p_phs_c charge ON phase.proposal = charge.proposal AND phase.sort_code = charge.sort_code LEFT OUTER JOIN
                      ae_p_phs_offset offset ON charge.proposal = offset.proposal AND charge.sort_code = offset.sort_code AND 
                      (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_p_phs_offset All_offset ON charge.proposal = All_offset.proposal AND charge.sort_code = All_offset.sort_code AND 
                      All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.expire_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.expire_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date) AND
		      (PHASE.DEFAULT_DIST = 'O' OR PHASE.DEFAULT_DIST = 'C') ;
COMMIT;
CREATE OR REPLACE VIEW project_accounts
AS
SELECT     phase.proposal, phase.sort_code, phase.default_dist as Dist_type, charge.fixed_actual, charge.precedence, charge.sub_percent AS precent, charge.sub_amount AS amount, 
                      charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, CASE WHEN offset.sub_ledger IS NULL 
                      THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_pro_e prop INNER JOIN
                      ae_p_phs_e phase ON phase.proposal = prop.proposal AND phase.default_dist = 'J' INNER JOIN
                      ae_j_prj_c charge ON prop.project = charge.project LEFT OUTER JOIN
                      ae_j_prj_offset offset ON charge.project = offset.project AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_j_prj_offset All_offset ON charge.project = All_offset.project AND All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.expire_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.expire_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date)
		      AND PHASE.DEFAULT_DIST = 'J';
COMMIT;
CREATE OR REPLACE VIEW equipment_accounts
AS
SELECT     phase.proposal, phase.sort_code, charge.sub_ledger,phase.default_dist as Dist_type, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, 
                      CASE WHEN offset.sub_ledger IS NULL THEN All_offset.sub_ledger ELSE offset.sub_ledger END AS offset_sub_ledger, 
                      CASE WHEN offset.funding_code IS NULL THEN All_offset.funding_code ELSE offset.funding_code END AS offset_account, 
                      CASE WHEN offset.funding_code IS NULL THEN All_offset.sub_code ELSE offset.sub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_r_eqm_accounts charge ON phase.eqp_tag_id = charge.eqp_tag_id LEFT OUTER JOIN
                      ae_l_shp_accounts offset ON phase.shop = offset.shop AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_offset ON phase.shop = All_offset.shop AND All_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.end_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.end_date) AND (offset.account_type = 'O') AND (charge.account_type = 'C') AND 
                      (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.account_type = 'O' OR
                      All_offset.account_type IS NULL) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date)
		      AND PHASE.DEFAULT_DIST = 'E' ;  		      
COMMIT;
CREATE OR REPLACE VIEW asset_accounts
AS
SELECT     phase.proposal, phase.sort_code,phase.default_dist as Dist_type, charge.sub_percent AS precent,  
                      charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, CASE WHEN offset.sub_ledger IS NULL 
                      THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_a_ast_accounts charge ON phase.asset_tag = charge.asset_tag  LEFT OUTER JOIN
                      ae_a_ast_offset offset ON charge.asset_tag = offset.asset_tag AND 
                      (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_a_ast_offset All_offset ON charge.asset_tag = All_offset.asset_tag AND  
                      All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.end_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.end_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date) 
                 AND (PHASE.DEFAULT_DIST = 'A' ) ;
COMMIT;
CREATE OR REPLACE VIEW Property_accounts
AS
SELECT     phase.proposal, phase.sort_code,phase.default_dist as Dist_type, charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, 
                      CASE WHEN offset.sub_ledger IS NULL THEN All_offset.sub_ledger ELSE offset.sub_ledger END AS offset_sub_ledger, 
                      CASE WHEN offset.funding_code IS NULL THEN All_offset.funding_code ELSE offset.funding_code END AS offset_account, 
                      CASE WHEN offset.funding_code IS NULL THEN All_offset.sub_code ELSE offset.sub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_s_bld_accounts charge ON phase.region_code = charge.region_code AND phase.fac_id = charge.fac_id AND 
                      phase.bldg = charge.bldg LEFT OUTER JOIN
                      ae_l_shp_accounts offset ON phase.shop = offset.shop AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_offset ON phase.shop = All_offset.shop AND All_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.end_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.end_date) AND (offset.account_type = 'O') AND (charge.account_type = 'C') AND 
                      (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.account_type = 'O' OR
                      All_offset.account_type IS NULL) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date)
		      AND PHASE.DEFAULT_DIST = 'P';
COMMIT;
CREATE OR REPLACE VIEW Workorder_accounts
AS
SELECT     phase.proposal, phase.sort_code, phase.default_dist AS Dist_type, charge.fixed_actual, charge.precedence, charge.sub_percent AS precent, 
                      charge.sub_amount AS amount, charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, 
                      CASE WHEN offset.sub_ledger IS NULL THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_p_pro_c charge ON phase.proposal = charge.proposal LEFT OUTER JOIN
                      ae_p_pro_offset offset ON charge.proposal = offset.proposal AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_p_pro_offset All_offset ON charge.proposal = All_offset.proposal AND All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND shop_offset.account_type = 'O' AND 
                      (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.account_type = 'O' AND 
                      All_shop_offset.sub_ledger = 'A'
WHERE     (phase.default_dist = 'W') AND (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.expire_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.expire_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date);
COMMIT;

CREATE OR REPLACE VIEW Workcode_accounts
AS
SELECT     phase.proposal, phase.sort_code, phase.default_dist AS Dist_type, charge.sub_percent AS precent, charge.sub_ledger, 
                      charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, CASE WHEN offset.sub_ledger IS NULL 
                      THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_p_workcode_accounts charge ON phase.order_type = charge.order_type AND phase.category = charge.category AND 
                      phase.craft_code = charge.craft_code LEFT OUTER JOIN
                      ae_p_workcode_offset offset ON charge.order_type = offset.order_type AND phase.category = offset.category AND 
                      phase.craft_code = offset.craft_code AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_p_workcode_offset All_offset ON charge.order_type = All_offset.order_type AND phase.category = All_offset.category AND 
                      phase.craft_code = All_offset.craft_code AND All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND shop_offset.account_type = 'O' AND 
                      (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.account_type = 'O' AND 
                      All_shop_offset.sub_ledger = 'A'
WHERE     (phase.default_dist = 'K') AND (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.end_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.end_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date);
COMMIT;

CREATE OR REPLACE VIEW total_accounts
AS
SELECT     proposal, sort_code, Dist_type, fixed_actual, precedence, precent, amount, sub_ledger, charge_account, charge_subcode, offset_sub_ledger, 
                      offset_account, offset_subcode
FROM         Custom_and_Org_accounts
UNION
SELECT     proposal, sort_code, Dist_type, NULL AS fixed_actual, NULL AS precedence, NULL AS precent, NULL AS amount, sub_ledger, charge_account, 
                      charge_subcode, offset_sub_ledger, offset_account, offset_subcode
FROM         equipment_accounts
UNION
SELECT     proposal, sort_code, Dist_type, 'P' AS fixed_actual, NULL AS precedence, precent, NULL AS amount, sub_ledger, charge_account, charge_subcode, offset_sub_ledger, 
                      offset_account, offset_subcode
FROM         asset_accounts
UNION
SELECT     proposal, sort_code, Dist_type, fixed_actual, precedence, precent, amount, sub_ledger, charge_account, charge_subcode, offset_sub_ledger, 
                      offset_account, offset_subcode
FROM         project_accounts
UNION
SELECT     proposal, sort_code, Dist_type, NULL AS fixed_actual, NULL AS precedence, NULL AS precent, NULL AS amount, sub_ledger, charge_account, 
                      charge_subcode, offset_sub_ledger, offset_account, offset_subcode
FROM         Property_accounts
UNION
SELECT     proposal, sort_code, Dist_type, NULL AS fixed_actual, NULL AS precedence, NULL AS precent, NULL AS amount, sub_ledger, charge_account, 
                      charge_subcode, offset_sub_ledger, offset_account, offset_subcode
FROM         Shop_accounts
UNION
SELECT     proposal, sort_code, Dist_type, fixed_actual, precedence, precent, amount, sub_ledger, charge_account, charge_subcode, offset_sub_ledger, 
                      offset_account, offset_subcode
FROM         Workorder_accounts
UNION
SELECT     proposal, sort_code, Dist_type, NULL AS fixed_actual, NULL AS precedence, precent, NULL AS amount, sub_ledger, charge_account, charge_subcode, offset_sub_ledger, 
                      offset_account, offset_subcode
FROM         Workcode_accounts;

COMMIT;

CREATE OR REPLACE VIEW total_accounts2
AS

SELECT     charge.proposal, charge.sort_code,phase.default_dist as Dist_type, charge.fixed_actual, charge.precedence, charge.sub_percent AS precent, charge.sub_amount AS amount, 
                      charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, CASE WHEN offset.sub_ledger IS NULL 
                      THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_p_phs_c charge ON phase.proposal = charge.proposal AND phase.sort_code = charge.sort_code LEFT OUTER JOIN
                      ae_p_phs_offset offset ON charge.proposal = offset.proposal AND charge.sort_code = offset.sort_code AND 
                      (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_p_phs_offset All_offset ON charge.proposal = All_offset.proposal AND charge.sort_code = All_offset.sort_code AND 
                      All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts  shop_offset ON phase.shop = shop_offset.shop AND (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts  All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.expire_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.expire_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date) AND
		      (PHASE.DEFAULT_DIST = 'O' OR PHASE.DEFAULT_DIST = 'C') 
UNION
SELECT     phase.proposal, phase.sort_code, phase.default_dist as Dist_type,NULL AS fixed_actual, NULL AS precedence, NULL AS precent, NULL AS amount,
					  charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, 
                      CASE WHEN offset.sub_ledger IS NULL THEN All_offset.sub_ledger ELSE offset.sub_ledger END AS offset_sub_ledger, 
                      CASE WHEN offset.funding_code IS NULL THEN All_offset.funding_code ELSE offset.funding_code END AS offset_account, 
                      CASE WHEN offset.funding_code IS NULL THEN All_offset.sub_code ELSE offset.sub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_r_eqm_accounts charge ON phase.eqp_tag_id = charge.eqp_tag_id LEFT OUTER JOIN
                      ae_l_shp_accounts offset ON phase.shop = offset.shop AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_offset ON phase.shop = All_offset.shop AND All_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.end_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.end_date) AND (offset.account_type = 'O') AND (charge.account_type = 'C') AND 
                      (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.account_type = 'O' OR
                      All_offset.account_type IS NULL) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date)
		      AND PHASE.DEFAULT_DIST = 'E'   		      
UNION
SELECT     phase.proposal, phase.sort_code,phase.default_dist as Dist_type, 'P' AS fixed_actual, NULL AS precedence, charge.sub_percent AS precent, NULL AS amount,  
                      charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, CASE WHEN offset.sub_ledger IS NULL 
                      THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_a_ast_accounts charge ON phase.asset_tag = charge.asset_tag  LEFT OUTER JOIN
                      ae_a_ast_offset offset ON charge.asset_tag = offset.asset_tag AND 
                      (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_a_ast_offset All_offset ON charge.asset_tag = All_offset.asset_tag AND  
                      All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.end_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.end_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date) 
                 AND (PHASE.DEFAULT_DIST = 'A' )              
UNION
SELECT     phase.proposal, phase.sort_code, phase.default_dist as Dist_type, charge.fixed_actual, charge.precedence, charge.sub_percent AS precent, charge.sub_amount AS amount, 
                      charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, CASE WHEN offset.sub_ledger IS NULL 
                      THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_pro_e prop INNER JOIN
                      ae_p_phs_e phase ON phase.proposal = prop.proposal AND phase.default_dist = 'J' INNER JOIN
                      ae_j_prj_c charge ON prop.project = charge.project LEFT OUTER JOIN
                      ae_j_prj_offset offset ON charge.project = offset.project AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_j_prj_offset All_offset ON charge.project = All_offset.project AND All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.expire_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.expire_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date)
		      AND PHASE.DEFAULT_DIST = 'J'
UNION

SELECT     phase.proposal, phase.sort_code,phase.default_dist as Dist_type, NULL AS fixed_actual, NULL AS precedence, NULL AS precent, NULL AS amount,
					  charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, 
                      CASE WHEN offset.sub_ledger IS NULL THEN All_offset.sub_ledger ELSE offset.sub_ledger END AS offset_sub_ledger, 
                      CASE WHEN offset.funding_code IS NULL THEN All_offset.funding_code ELSE offset.funding_code END AS offset_account, 
                      CASE WHEN offset.funding_code IS NULL THEN All_offset.sub_code ELSE offset.sub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_s_bld_accounts charge ON phase.region_code = charge.region_code AND phase.fac_id = charge.fac_id AND 
                      phase.bldg = charge.bldg LEFT OUTER JOIN
                      ae_l_shp_accounts offset ON phase.shop = offset.shop AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_offset ON phase.shop = All_offset.shop AND All_offset.sub_ledger = 'A'
WHERE     (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.end_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.end_date) AND (offset.account_type = 'O') AND (charge.account_type = 'C') AND 
                      (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.account_type = 'O' OR
                      All_offset.account_type IS NULL) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date)
		      AND PHASE.DEFAULT_DIST = 'P'
UNION
SELECT     phase.proposal as proposal, phase.sort_code as sort_code, phase.default_dist as Dist_type, NULL AS fixed_actual, NULL AS precedence, NULL AS precent, NULL AS amount,
					  charge.sub_ledger as sub_ledger, charge.funding_code as charge_account, charge.sub_code as charge_subcode,
					  CASE WHEN offset.sub_ledger IS NULL then All_offset.sub_ledger else
					  offset.sub_ledger end as offset_sub_ledger,
					  CASE WHEN offset.funding_code IS NULL then All_offset.funding_code else 
					  offset.funding_code end as offset_account, 
					  CASE WHEN offset.funding_code IS NULL then All_offset.sub_code else 
					  offset.sub_code end as offset_subcode
FROM        ae_p_phs_e  phase join  ae_l_shp_accounts charge ON phase.shop = charge.shop LEFT OUTER JOIN
                      ae_l_shp_accounts offset ON charge.shop = offset.shop AND (charge.sub_ledger = offset.sub_ledger OR charge.sub_ledger = 'A' OR offset.sub_ledger = 'A') LEFT OUTER JOIN
					  ae_l_shp_accounts All_offset ON charge.shop = All_offset.shop AND  All_offset.sub_ledger = 'A'
WHERE     ((charge.start_date IS NULL) OR (charge.start_date < SYSDATE and charge.end_date IS NULL) OR (SYSDATE  Between Charge.start_date and charge.end_date)) AND (offset.account_type = 'O') 
					  AND (charge.account_type = 'C') AND ((offset.start_date IS NULL) OR (offset.start_date < SYSDATE and offset.end_date IS NULL) OR (SYSDATE  Between offset.start_date and offset.end_date))
					  AND (All_offset.account_type = 'O' OR All_offset.account_type IS NULL) AND ((All_offset.start_date IS NULL) OR (All_offset.start_date < SYSDATE and All_Offset.end_date IS NULL) OR (SYSDATE  Between All_offset.start_date and All_offset.end_date)) 
					  AND PHASE.DEFAULT_DIST = 'S'
UNION
SELECT     phase.proposal, phase.sort_code, phase.default_dist AS Dist_type, NULL AS fixed_actual, NULL AS precedence,
					  charge.sub_percent AS precent, NULL AS amount,charge.sub_ledger, charge.funding_code AS charge_account, 
					  charge.sub_code AS charge_subcode, CASE WHEN offset.sub_ledger IS NULL 
                      THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_p_workcode_accounts charge ON phase.order_type = charge.order_type AND phase.category = charge.category AND 
                      phase.craft_code = charge.craft_code LEFT OUTER JOIN
                      ae_p_workcode_offset offset ON charge.order_type = offset.order_type AND phase.category = offset.category AND 
                      phase.craft_code = offset.craft_code AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_p_workcode_offset All_offset ON charge.order_type = All_offset.order_type AND phase.category = All_offset.category AND 
                      phase.craft_code = All_offset.craft_code AND All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND shop_offset.account_type = 'O' AND 
                      (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.account_type = 'O' AND 
                      All_shop_offset.sub_ledger = 'A'
WHERE     (phase.default_dist = 'K') AND (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.end_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.end_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date)	 
Union
SELECT     phase.proposal, phase.sort_code, phase.default_dist AS Dist_type, charge.fixed_actual, charge.precedence, charge.sub_percent AS precent, 
                      charge.sub_amount AS amount, charge.sub_ledger, charge.funding_code AS charge_account, charge.sub_code AS charge_subcode, 
                      CASE WHEN offset.sub_ledger IS NULL THEN CASE WHEN All_offset.sub_ledger IS NULL THEN CASE WHEN shop_offset.sub_ledger IS NULL 
                      THEN All_shop_offset.sub_ledger ELSE shop_offset.sub_ledger END ELSE All_offset.sub_ledger END ELSE offset.sub_ledger END AS offset_sub_ledger,
                       CASE WHEN offset.offsetfunding_code IS NULL THEN CASE WHEN All_offset.offsetfunding_code IS NULL 
                      THEN CASE WHEN shop_offset.funding_code IS NULL 
                      THEN All_shop_offset.funding_code ELSE shop_offset.funding_code END ELSE All_offset.offsetfunding_code END ELSE offset.offsetfunding_code END AS
                       offset_account, CASE WHEN offset.offsetsub_code IS NULL THEN CASE WHEN All_offset.offsetsub_code IS NULL 
                      THEN CASE WHEN shop_offset.sub_code IS NULL 
                      THEN All_shop_offset.sub_code ELSE shop_offset.sub_code END ELSE All_offset.offsetsub_code END ELSE offset.offsetsub_code END AS offset_subcode
FROM         ae_p_phs_e phase INNER JOIN
                      ae_p_pro_c charge ON phase.proposal = charge.proposal LEFT OUTER JOIN
                      ae_p_pro_offset offset ON charge.proposal = offset.proposal AND (charge.sub_ledger = offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_p_pro_offset All_offset ON charge.proposal = All_offset.proposal AND All_offset.sub_ledger = 'A' LEFT OUTER JOIN
                      ae_l_shp_accounts shop_offset ON phase.shop = shop_offset.shop AND shop_offset.account_type = 'O' AND 
                      (charge.sub_ledger = shop_offset.sub_ledger OR
                      charge.sub_ledger = 'A') LEFT OUTER JOIN
                      ae_l_shp_accounts All_shop_offset ON phase.shop = All_shop_offset.shop AND All_shop_offset.account_type = 'O' AND 
                      All_shop_offset.sub_ledger = 'A'
WHERE     (phase.default_dist = 'W') AND (charge.start_date IS NULL OR
                      charge.start_date < SYSDATE AND charge.expire_date IS NULL OR
                      SYSDATE BETWEEN charge.start_date AND charge.expire_date) AND (offset.start_date IS NULL OR
                      offset.start_date < SYSDATE AND offset.end_date IS NULL OR
                      SYSDATE BETWEEN offset.start_date AND offset.end_date) AND (All_offset.start_date IS NULL OR
                      All_offset.start_date < SYSDATE AND All_offset.end_date IS NULL OR
                      SYSDATE BETWEEN All_offset.start_date AND All_offset.end_date);
COMMIT;