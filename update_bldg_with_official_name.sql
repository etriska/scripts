UPDATE ae_s_bld_c A
SET A.bldg_directions =
  (
    SELECT b.BLD_DESCR50
    FROM RVIEW_ITS_SPC_BLD_TBL b
    WHERE b.fiscal_year = '2017'
    AND A.bldg          = SUBSTR(b.bldrecnbr, 3)
  )
WHERE A.bldg IN
  (
    SELECT SUBSTR(b.bldrecnbr, 3)
    FROM RVIEW_ITS_SPC_BLD_TBL b
    WHERE b.fiscal_year = '2017'
  );

UPDATE ae_s_bld_c A
SET A.bldg_directions =
  (
    SELECT b.strname
    FROM RVIEW_ITS_SPC_STR_TBL b
    WHERE b.fiscal_year = '2017'
    AND A.bldg          = SUBSTR(b.strrecnbr, 3)
  )
WHERE A.bldg IN
  (
    SELECT SUBSTR(b.strrecnbr, 3)
    FROM RVIEW_ITS_SPC_STR_TBL b
    WHERE b.fiscal_year = '2017'
  );