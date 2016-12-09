/*--create view for adjustment calculation
create or replace view rview_inv_partsqtytotal as
SELECT
  WAREHOUSE.WAREHOUSE,
  LOCATION.BIN_LOCATION,
  LOCATION.PART,
  SUM(LOCATION.QTY) AS ONHAND_QUANITY,
  AVG(WAREHOUSE.WHSE_COST) AS ONHAND_UNIT_COST,
  SUM(LOCATION.QTY) * AVG(WAREHOUSE.WHSE_COST) AS ONHAND_VALUE
FROM
  AE_I_LOC_E LOCATION
  JOIN AE_I_INV_W WAREHOUSE ON LOCATION.WAREHOUSE = WAREHOUSE.WAREHOUSE
    AND LOCATION.PART = WAREHOUSE.PART
    AND LOCATION.MULTITENANT_ID = WAREHOUSE.MULTITENANT_ID
GROUP BY
  WAREHOUSE.WAREHOUSE,
  LOCATION.BIN_LOCATION,
  LOCATION.PART
ORDER BY WAREHOUSE.WAREHOUSE,
  LOCATION.BIN_LOCATION,
  LOCATION.PART;

--View for cost and qty
CREATE OR REPLACE VIEW rview_inv_qty_value AS
SELECT
  b.WAREHOUSE,
  A.BIN_LOCATION,
  A.PART,
  c.DESCRIPTION,
  SUM(a.QTY) AS qty_on_hand, 
  SUM(A.QTY) * AVG(b.WHSE_COST) AS ON_HAND_VALUE,
  AVG(b.WHSE_COST) AS avg_value
FROM
  AE_I_LOC_E A
  JOIN AE_I_INV_W b ON A.WAREHOUSE = b.WAREHOUSE AND A.PART = b.PART AND A.MULTITENANT_ID = b.MULTITENANT_ID
  JOIN ae_i_inv_e c ON A.part = c.part and A.MULTITENANT_ID = b.MULTITENANT_ID

GROUP BY
  b.WAREHOUSE,
  A.BIN_LOCATION,
  A.PART,
  c.DESCRIPTION;
*/
--create adjustment record
INSERT INTO ae_i_adj_e (multitenant_id, trans_num, adjustment_type, description, warehouse, bin_location, part, inv_cost, adj_qty, edit_clerk,edit_date)
SELECT '1', FUNC_TRANXGEN(1,'INV_ADJ'), 'C', 'INCREASE INVENTORY COST TO FAIR MARKET VALUE', A.warehouse, A.bin_location, A.part, b.unit_cost, NULL, 'ETRISKA', SYSDATE
FROM AE_I_LOC_E A
JOIN TMP_INV_COST_ADJ b ON A.part = b.INVENTORY_PART
JOIN ae_i_inv_e c ON A.part = c.part
JOIN ae_i_inv_w d on a.warehouse = d.warehouse and A.PART = d.PART
WHERE a.part IN (SELECT inventory_part FROM TMP_INV_COST_ADJ)
AND A.qty > 0
AND A.ACTIVE = 'Y'
AND c.ACTIVE = 'Y'
AND b.UNIT_COST <> d.WHSE_COST
AND A.warehouse IN ('A1050','M2250','M2350','M2450','M2550', 'M2650','M8100')
ORDER BY A.part, A.warehouse;

--create dollar_adj to fix the cost difference between new and old prices
INSERT INTO ae_i_trans_reg(TRANS_NUM, SOURCE_SCREENNAME, source_tranx_no, source_tranx_item, warehouse, part, trans_qty, inv_Cost, dollar_adj, entry_clerk, entry_date, edit_clerk, edit_date, description, sub_line_seq, multitenant_id)
select FUNC_TRANXGEN(1,'INV_TRANS'), 'INVENTORY ADJUSTMENT', 0, 0, warehouse, part, 0, 0, adj_amount, 'ETRISKA', sysdate, 'ETRISKA', sysdate, 'CORRECT COST AND ADJUST PRICE', 0, 1
FROM (
SELECT A.WAREHOUSE, A.PART, SUM(A.TRANS_QTY * A.INV_COST + A.DOLLAR_ADJ)oh_value, SUM(A.TRANS_QTY) QTY, nvl(ROUND(SUM(A.TRANS_QTY * A.INV_COST + A.DOLLAR_ADJ) / NULLIF(SUM(A.TRANS_QTY),0),4),0) avg_cost,
  SUM(a.TRANS_QTY * b.whse_cost + a.DOLLAR_ADJ) - sum(A.TRANS_QTY * A.INV_COST + a.dollar_adj) adj_amount, sum(a.dollar_adj) dollar_adj_amount
FROM AE_I_TRANS_REG A
JOIN AE_I_INV_W B ON A.WAREHOUSE = B.WAREHOUSE AND A.PART = B.PART
WHERE --A.PART = '100288' AND A.WAREHOUSE = 'M2250'
A.WAREHOUSE IN ('A1050','M2250','M2350','M2450','M2550', 'M2650','M8100')
AND A.PART IN (SELECT INVENTORY_PART FROM TMP_INV_COST_ADJ)
GROUP BY A.WAREHOUSE, A.PART) A
JOIN TMP_INV_COST_ADJ b ON A.part = b.INVENTORY_PART
WHERE adj_amount <> 0 
AND A.avg_cost <> b.UNIT_COST
AND A.qty > 0
and round(a.adj_amount,2) <> round(a.dollar_adj_amount,2);

--add adjustment to trans_reg to match the adjustment record
INSERT INTO ae_i_trans_reg
  (multitenant_id, trans_num, source_screenname, source_tranx_no, source_tranx_item, warehouse, bin_location, part,
    inv_cost, trans_qty, bin_qty, dollar_adj, entry_clerk, entry_date, edit_clerk, edit_date, description, vend_cost,
    issue_factor, eqp_tag_id, asset_tag, sub_line_seq)
SELECT '1',FUNC_TRANXGEN(1,'INV_TRANS'), 'INVENTORY ADJUSTMENT', A.trans_num, 0, A.warehouse, A.bin_location, A.part, b.ONHAND_UNIT_COST, b.ONHAND_QUANITY * -1, null, 0, 'ETRISKA', SYSDATE, 
  'ETRISKA', SYSDATE, 'INVENTORY PRICE ADJUSTEMENT', NULL, NULL, NULL, NULL, 0
from AE_I_ADJ_E a
JOIN RVIEW_INV_PARTSQTYTOTAL b ON A.WAREHOUSE = b.WAREHOUSE and A.BIN_LOCATION = b.BIN_LOCATION AND A.PART = b.PART
WHERE A.edit_clerk = 'ETRISKA'
and A.EDIT_DATE like sysdate;

--insert the adjusted record
INSERT INTO ae_i_trans_reg
  (multitenant_id, trans_num, source_screenname, source_tranx_no, source_tranx_item, warehouse, bin_location, part,
    inv_cost, trans_qty, bin_qty, dollar_adj, entry_clerk, entry_date, edit_clerk, edit_date, description, vend_cost,
    issue_factor, eqp_tag_id, asset_tag, sub_line_seq)
SELECT '1',FUNC_TRANXGEN(1,'INV_TRANS'), 'INVENTORY ADJUSTMENT', A.trans_num, 0, A.warehouse, A.bin_location, A.part, A.inv_cost, b.QTY, null, 0, 'ETRISKA', SYSDATE, 'ETRISKA', 
	SYSDATE, 'INVENTORY PRICE ADJUSTEMENT', NULL, NULL, NULL, NULL, 0
FROM ae_i_adj_e A
JOIN ae_i_loc_e b ON A.WAREHOUSE = b.WAREHOUSE and A.BIN_LOCATION = b.BIN_LOCATION and a.part = b.part
WHERE a.edit_clerk = 'ETRISKA'
AND A.EDIT_DATE LIKE SYSDATE
AND b.ACTIVE = 'Y';

--Set the warehouse cost
UPDATE ae_i_inv_w A
SET A.whse_cost = (
    SELECT max(b.inv_cost)
    FROM ae_i_adj_e b 
    WHERE A.warehouse = b.warehouse  
    AND A.part = b.part 
    AND b.edit_clerk = 'ETRISKA' 
    AND b.edit_date LIKE SYSDATE
    GROUP BY b.warehouse, b.part),
    A.edit_date = SYSDATE,
    A.edit_clerk = 'ETRISKA'
WHERE (A.WAREHOUSE, A.part) IN (SELECT b.warehouse, b.part FROM ae_i_adj_e b WHERE b.edit_clerk = 'ETRISKA' AND b.edit_date LIKE SYSDATE)
AND A.warehouse IN ('A1050','M2250','M2350','M2450','M2550', 'M2650','M8100');

--Set edit date and clerk in Part Profile
UPDATE ae_i_inv_e A SET A.edit_date = SYSDATE, A.edit_clerk = 'ETRISKA'
WHERE EXISTS (SELECT DISTINCT part FROM TMP_INV_COST_ADJ b WHERE A.part = b.inventory_part);
