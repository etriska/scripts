--recover from invalid ae_i_aqr_r entries made to update inventory cost
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

--Get warehouse stock info
SELECT A.warehouse, A.bin_location, A.part, b.QTY_ON_HAND
FROM ae_i_loc_e A
left outer join RVIEW_INV_QTY_VALUE_all b on a.warehouse = b.WAREHOUSE and A.BIN_LOCATION = b.BIN_LOCATION and a.part = b.part
WHERE A.QTY IS NULL
AND A.ACTIVE = 'Y'
AND A.part IS NOT NULL
and b.QTY_ON_HAND is not null
order by a.warehouse, a.part

--update inventory costs
update ae_i_inv_w a set A.WHSE_COST = ( 
SELECT b.avg_value 
FROM RVIEW_INV_QTY_VALUE b
join ae_i_inv_w c on b.warehouse = c.warehouse and b.part = c.part
WHERE b.warehouse IN ('A1050','M2250','M2350','M2450','M2550')
AND A.warehouse = b.warehouse AND A.part = b.part)
where (A.WAREHOUSE, a.part) in (SELECT b.warehouse, b.part
FROM RVIEW_INV_QTY_VALUE b
join ae_i_inv_w c on b.warehouse = c.warehouse and b.part = c.part
WHERE b.warehouse IN ('A1050','M2250','M2350','M2450','M2550')
HAVING count(*) < 2
group by b.warehouse, b.part);

SELECT a.warehouse, a.part, A.AVG_VALUE
FROM RVIEW_INV_QTY_VALUE A
WHERE A.warehouse IN ('A1050','M2250','M2350','M2450','M2550')
and (a.warehouse, a.part) not in (select warehouse, part from ae_i_inv_w);

--update qty, cost in inventory tables
SELECT b.warehouse, b.part
FROM RVIEW_INV_QTY_VALUE b
join ae_i_inv_w c on b.warehouse = c.warehouse and b.part = c.part
WHERE b.warehouse IN ('A1050','M2250','M2350','M2450','M2550')
HAVING count(*) < 2
group by b.warehouse, b.part;


UPDATE ae_i_loc_e A
SET A.qty =
  (
    SELECT b.qty_on_hand
    FROM RVIEW_INV_QTY_VALUE b
    WHERE A.warehouse  = b.warehouse
    AND A.part         = b.part
    AND A.bin_location = b.bin_location
    AND A.warehouse IN ('A1050', 'M2250', 'M2350', 'M2450', 'M2550')
  )
WHERE (A.warehouse, a.bin_location, a.part)
IN
  (
    SELECT b.warehouse, b.bin_location, b.part
    FROM RVIEW_INV_QTY_VALUE b
    WHERE A.warehouse  = b.warehouse
    AND A.part         = b.part
    AND A.bin_location = b.bin_location
    AND A.warehouse IN ('A1050', 'M2250', 'M2350', 'M2450', 'M2550')
  )
AND A.warehouse IN ('A1050', 'M2250', 'M2350', 'M2450', 'M2550')
AND a.part      IS NOT NULL;

--displaced work order for Camie
WITH phase_craft_notes AS
  (
    SELECT proposal, sort_code, notes, edit_date
    FROM ae_p_phs_e_notes
    WHERE
      (
        proposal, sort_code, edit_date
      )
      IN
      (
        SELECT AE_P_PHS_E_NOTES.proposal, AE_P_PHS_E_NOTES.sort_code, MAX(AE_P_PHS_E_NOTES.edit_date)
        FROM AE_P_PHS_E_NOTES
        WHERE NVL(AE_P_PHS_E_NOTES.NOTES_TYPE, 'GENERAL') = 'CRAFT_NOTES'
        AND ae_p_phs_e_notes.MULTITENANT_ID               = AE_P_PHS_E_NOTES.MULTITENANT_ID
        GROUP BY AE_P_PHS_E_NOTES.proposal, AE_P_PHS_E_NOTES.SORT_CODE
      )
  )

SELECT a.proposal, a.sort_code, b.status_code phase_status, a.login, c.notes, a.status_Date hist_date, b.status_code current_status
FROM ae_p_pst_e a
JOIN ae_p_phs_e b        ON a.proposal = b.proposal AND a.sort_code = b.sort_code
JOIN phase_craft_notes c ON a.proposal = c.proposal AND a.sort_code = b.sort_code
WHERE A.status_code                    = 'DISPLACED'
AND b.status_code                               IN ('MASTERSCHED', 'FOLLOWUPREQ', 'COMPLETE', 'DISPLACED')
AND A.status_date                     >= SYSDATE - 7
AND b.shop                             = 'M2450';

--Update OH rates
exec fmax_85.proc_LoadUtlRates(1);

SELECT LENGTH(labor)
FROM UM_UTL_RATES_UPLD
order by labor asc