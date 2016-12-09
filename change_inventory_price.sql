--change inventory price
INSERT INTO ae_i_adj_e (multitenant_id, trans_num, adjustment_type, description, warehouse, bin_location, part, inv_cost, adj_qty, edit_clerk,edit_date)
SELECT '1', FUNC_TRANXGEN(1,'INV_ADJ'), 'C', 'INCREASE INVENTORY COST TO FAIR MARKET VALUE', A.warehouse, A.bin_location, A.part, b.unit_cost, NULL, 'ETRISKA', SYSDATE
FROM AE_I_LOC_E A
JOIN TMP_INV_COST_ADJ b ON A.part = b.INVENTORY_PART
JOIN ae_i_inv_e c ON A.part = c.part
WHERE a.part IN (SELECT inventory_part FROM TMP_INV_COST_ADJ)
AND A.qty > 0
AND A.ACTIVE = 'Y'
AND c.ACTIVE = 'Y'
AND A.warehouse IN ('A1050','M2250','M2350','M2450','M2550', 'M2650','M8100')
ORDER BY A.part, A.warehouse;

INSERT INTO ae_i_trans_reg
  (multitenant_id, trans_num, source_screenname, source_tranx_no, source_tranx_item, warehouse, bin_location, part,
    inv_cost, trans_qty, bin_qty, dollar_adj, entry_clerk, entry_date, edit_clerk, edit_date, description, vend_cost,
    issue_factor, eqp_tag_id, asset_tag, sub_line_seq)
SELECT '1',FUNC_TRANXGEN(1,'INV_TRANS'), 'INVENTORY ADJUSTMENT', A.trans_num, 0, A.warehouse, A.bin_location, A.part, b.avg_value, b.qty_on_hand * -1, null, 0, 'ETRISKA', SYSDATE, 
  'ETRISKA', SYSDATE, 'INVENTORY PRICE ADJUSTEMENT', NULL, NULL, NULL, NULL, 0
FROM ae_i_adj_e A
JOIN rview_inv_qty_value b ON A.WAREHOUSE = b.WAREHOUSE AND A.BIN_LOCATION = b.BIN_LOCATION AND A.PART = b.PART
WHERE A.edit_clerk = 'ETRISKA'
and A.EDIT_DATE like sysdate;

INSERT INTO ae_i_trans_reg
  (multitenant_id, trans_num, source_screenname, source_tranx_no, source_tranx_item, warehouse, bin_location, part,
    inv_cost, trans_qty, bin_qty, dollar_adj, entry_clerk, entry_date, edit_clerk, edit_date, description, vend_cost,
    issue_factor, eqp_tag_id, asset_tag, sub_line_seq)
SELECT '1',FUNC_TRANXGEN(1,'INV_TRANS'), 'INVENTORY ADJUSTMENT', A.trans_num, 0, A.warehouse, A.bin_location, A.part, A.inv_cost, b.QTY, null, 0, 'ETRISKA', SYSDATE, 'ETRISKA', 
	SYSDATE, 'INVENTORY PRICE ADJUSTEMENT', NULL, NULL, NULL, NULL, 0
FROM ae_i_adj_e A
JOIN ae_i_loc_e b ON A.WAREHOUSE = b.WAREHOUSE and A.BIN_LOCATION = b.BIN_LOCATION and a.part = b.part
WHERE a.edit_clerk = 'ETRISKA'
AND A.EDIT_DATE LIKE SYSDATE;

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
and a.warehouse in ('A1050','M2250','M2350','M2450','M2550', 'M2650','M8100');

--Code below presumed accurate code above obsolete.
--change inventory price

--create adjustment record
INSERT INTO ae_i_adj_e (multitenant_id, trans_num, adjustment_type, description, warehouse, bin_location, part, inv_cost, adj_qty, edit_clerk,edit_date)
SELECT '1', FUNC_TRANXGEN(1,'INV_ADJ'), 'C', 'INCREASE INVENTORY COST TO FAIR MARKET VALUE', A.warehouse, A.bin_location, A.part, b.unit_cost, NULL, 'ETRISKA', SYSDATE
FROM AE_I_LOC_E A
JOIN TMP_INV_COST_ADJ b ON A.part = b.INVENTORY_PART
JOIN ae_i_inv_e c ON A.part = c.part
WHERE a.part IN (SELECT inventory_part FROM TMP_INV_COST_ADJ)
AND A.qty > 0
AND A.ACTIVE = 'Y'
AND c.ACTIVE = 'Y'
AND A.warehouse IN ('A1050','M2250','M2350','M2450','M2550', 'M2650','M8100')
ORDER BY A.part, A.warehouse;

--add adjustment to trans_reg to match the adjustment record
INSERT INTO ae_i_trans_reg
  (multitenant_id, trans_num, source_screenname, source_tranx_no, source_tranx_item, warehouse, bin_location, part,
    inv_cost, trans_qty, bin_qty, dollar_adj, entry_clerk, entry_date, edit_clerk, edit_date, description, vend_cost,
    issue_factor, eqp_tag_id, asset_tag, sub_line_seq)
SELECT '1',FUNC_TRANXGEN(1,'INV_TRANS'), 'INVENTORY ADJUSTMENT', A.trans_num, 0, A.warehouse, A.bin_location, A.part, b.ONHAND_UNIT_COST, b.ONHAND_QUANITY * -1, null, 0, 'ETRISKA', SYSDATE, 
  'ETRISKA', SYSDATE, 'INVENTORY PRICE ADJUSTEMENT', NULL, NULL, NULL, NULL, 0
FROM ae_i_adj_e A
JOIN TMP_PT_ITEM_PARTSQTYTOTAL b ON A.WAREHOUSE = b.WAREHOUSE AND A.PART = b.PART
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
AND A.EDIT_DATE LIKE SYSDATE;

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
where exists (select distinct part from TMP_INV_COST_ADJ b where a.part = b.inventory_part);

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
  c.DESCRIPTION
;