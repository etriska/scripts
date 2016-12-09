SELECT *
FROM
  (SELECT A.shop_person,
    lname,
    fname,
    shop
  FROM root.ae_h_emp_e A,
    root.ae_l_shp_d B,
    root.ae_h_emp_pos_data C
  WHERE A.shop_person = B.shop_person
  AND A.shop_person   = C.shop_person
  AND active          = 'Y'
  AND C.e_stat       IN
    (SELECT e_stat FROM root.ae_h_pst_e WHERE active = 'Y' AND complete_yn = 'Y'
    )
  AND (to_date(TO_CHAR(B.date_from,'MM/DD/YYYY'),'MM/DD/YYYY') <= to_date('5/28/2009', 'MM/DD/YY'))
  AND (to_date('5/28/2009', 'MM/DD/YY')                        <= DECODE(to_date(TO_CHAR(B.date_to,'MM/DD/YYYY'),'MM/DD/YYYY'),NULL,to_date('5/15/2010', 'MM/DD/YY'),to_date(TO_CHAR(B.date_to,'MM/DD/YYYY'),'MM/DD/YYYY')))
  ORDER BY A.shop_person
  )
WHERE ROWNUM <= 75