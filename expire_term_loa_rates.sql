--Expire rates for terminated and loa employees as term_date -1
CREATE TABLE tmp_expire2 AS
SELECT a.shop_person,
  c.time_type,
  c.seq,
  c.labor_class,
  CASE
  WHEN b.e_stat = 'L' THEN b.lv_date -1
  ELSE e.term_date -1 
  END AS term_date
FROM ae_h_emp_e a
JOIN ae_h_emp_pos_data b ON a.shop_person = b.shop_person
JOIN ae_l_man_d c ON a.shop_person = c.shop_person
JOIN ae_h_pst_e d ON b.e_stat = d.e_stat
JOIN ae_h_emp_conf_demo_data e ON a.shop_person  = e.shop_person
WHERE c.end_date IS NULL
AND d.complete_yn = 'N'
AND term_date is not null;

UPDATE ae_l_man_d a
SET end_date =
  (SELECT term_date
  FROM tmp_expire2 b
  WHERE a.shop_person = b.shop_person
  AND a.time_type     = b.time_type
  AND a.seq           = b.seq
  AND a.labor_class   = b.labor_class
  AND a.end_date     IS NULL
  )
WHERE a.end_date  IS NULL
AND a.shop_person IN
  (SELECT shop_person FROM tmp_expire2
  );
DROP TABLE tmp_expire2;