--copy rates to M6050
DELETE FROM ae_l_shp_c
where shop = 'M6050';
CREATE SEQUENCE bill_rate_seq
  start with 1
  INCREMENT BY 1
  NOCACHE
  nocycle;

INSERT INTO ae_l_shp_c (shop, seq, labor_class, time_type, job_class, labor_rate, edit_date, start_date, locked_yn, multitenant_id, edit_clerk)
SELECT shop, bill_rate_seq.nextval, labor_class, time_type, job_class, labor_rate, edit_date, start_date, locked_yn, multitenant_id, edit_clerk
FROM (
      (SELECT 'M6050' shop, labor_class, time_type, job_class, MAX(labor_rate) labor_rate, sysdate edit_date, '01-DEC-16' start_date, 'N' locked_yn, '1' multitenant_id, 'ETRISKA' edit_clerk
FROM (
  SELECT labor_class, time_type, job_class, labor_rate, multitenant_id
      FROM ae_l_shp_c
      WHERE shop IN ('M2001','M2050','M6400','M6500','M6600') AND end_date IS NULL
      GROUP BY labor_class, time_type, job_class, labor_rate, multitenant_id
    )
  GROUP BY 1, labor_class, time_type, job_class, sysdate, '01-DEC-16', 'N', Multitenant_id)
      );

DROP SEQUENCE bill_rate_seq;

--copy rates to M5050
DELETE FROM ae_l_shp_c
where shop = 'M5050';
CREATE SEQUENCE bill_rate_seq
  start with 1
  INCREMENT BY 1
  NOCACHE
  nocycle;

INSERT INTO ae_l_shp_c (shop, seq, labor_class, time_type, job_class, labor_rate, edit_date, start_date, locked_yn, multitenant_id, edit_clerk)
SELECT shop, bill_rate_seq.nextval, labor_class, time_type, job_class, labor_rate, edit_date, start_date, locked_yn, multitenant_id, edit_clerk
FROM (
      (SELECT 'M5050' shop, labor_class, time_type, job_class, MAX(labor_rate) labor_rate, sysdate edit_date, '01-DEC-16' start_date, 'N' locked_yn, '1' multitenant_id, 'ETRISKA' edit_clerk
FROM (
  SELECT labor_class, time_type, job_class, labor_rate, multitenant_id
      FROM ae_l_shp_c
      WHERE shop IN ('M5100','M5200') AND end_date IS NULL
      GROUP BY labor_class, time_type, job_class, labor_rate, multitenant_id
    )
  GROUP BY 1, labor_class, time_type, job_class, sysdate, '01-DEC-16', 'N', Multitenant_id)
      );

DROP SEQUENCE bill_rate_seq;

--copy rates to M3050
DELETE FROM ae_l_shp_c
where shop = 'M3050';
CREATE SEQUENCE bill_rate_seq
  start with 1
  INCREMENT BY 1
  NOCACHE
  nocycle;

INSERT INTO ae_l_shp_c (shop, seq, labor_class, time_type, job_class, labor_rate, edit_date, start_date, locked_yn, multitenant_id, edit_clerk)
SELECT shop, bill_rate_seq.nextval, labor_class, time_type, job_class, labor_rate, edit_date, start_date, locked_yn, multitenant_id, edit_clerk
FROM (
      (SELECT 'M3050' shop, labor_class, time_type, job_class, MAX(labor_rate) labor_rate, sysdate edit_date, '01-DEC-16' start_date, 'N' locked_yn, '1' multitenant_id, 'ETRISKA' edit_clerk
FROM (
  SELECT labor_class, time_type, job_class, labor_rate, multitenant_id
      FROM ae_l_shp_c
      WHERE shop IN ('M3100','M3200','M3300','M3500') AND end_date IS NULL
      GROUP BY labor_class, time_type, job_class, labor_rate, multitenant_id
    )
  GROUP BY 1, labor_class, time_type, job_class, sysdate, '01-DEC-16', 'N', Multitenant_id)
      );

DROP SEQUENCE bill_rate_seq;