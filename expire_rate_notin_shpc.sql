--Expire labor rates in ae_l_man_d where the rate will now be picked up from ae_l_shp_c
CREATE TABLE tmp_expire AS
SELECT a.seq,
  a.shop_person,
  a.labor_class,
  a.time_type
FROM ae_l_man_d a
JOIN ae_h_emp_pos_data b
ON a.shop_person = b.shop_person
JOIN ae_h_emp_e c
ON a.shop_person = c.shop_person
JOIN ae_l_lbr_c d
ON b.job_class = d.job_class
JOIN ae_h_pst_e e
ON b.e_stat        = e.e_stat
WHERE b.job_class IN
  (SELECT DISTINCT job_class FROM um_rates_tmp
  )
AND a.time_type NOT LIKE 'N%'
AND e.complete_yn = 'Y'
AND a.shop_person NOT LIKE '9%'
AND a.end_date IS NULL;

UPDATE ae_l_man_d
SET end_date                                      = '18-JUL-09'
WHERE (seq, shop_person, labor_class, time_type) IN
  ( SELECT seq, shop_person, labor_class, time_type FROM tmp_expire
  );
--DROP TABLE tmp_expire;