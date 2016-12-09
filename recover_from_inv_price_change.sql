DELETE
FROM ae_i_trans_reg
WHERE SOURCE_TRANX_NO IN
  (

    SELECT trans_num
    FROM AE_I_AQR_R
    WHERE edit_clerk = 'ETRISKA'
    AND edit_date LIKE '11-AUG-16'
  )
AND SOURCE_SCREENNAME = 'INVENTORY EXTERNAL TRANS';

DELETE
FROM ae_i_aqr_r
WHERE edit_clerk = 'ETRISKA'
AND edit_date LIKE '11-AUG-16';

UPDATE ae_i_inv_w d
SET d.whse_cost = NVL(
  (
    SELECT
      CASE
        WHEN SUM(a.trans_qty) = 0
        THEN 0
        WHEN SUM(a.trans_qty) != 0
        THEN ROUND(SUM(a.inv_cost * a.trans_qty) / SUM(a.trans_qty), 2)
      END avg_value

    FROM AE_I_TRANS_REG a
    JOIN ae_i_inv_e b ON a.PART      = b.PART AND a.MULTITENANT_ID = b.MULTITENANT_ID
    JOIN ae_i_loc_e c ON A.warehouse = c.warehouse AND A.BIN_LOCATION = c.BIN_LOCATION
    WHERE A.warehouse                = d.warehouse
    AND A.PART                       = d.part

    GROUP BY a.warehouse, a.part, b.DESCRIPTION
  )
  , 0);

UPDATE ae_i_loc_e A
SET A.qty =
  (
    SELECT b.qty_on_hand
    FROM RVIEW_INV_QTY_VALUE b
    WHERE A.warehouse  = b.warehouse
    AND A.part         = b.part
    AND A.bin_location = b.bin_location
  )
WHERE A.part IN
  (
    SELECT inventory_part
    FROM TMP_INV_COST_ADJ
  )
AND A.warehouse IN ('A1050', 'M2250', 'M2350', 'M2450', 'M2550')
AND a.part      IS NOT NULL;