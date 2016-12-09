--To reset work day in temp table
UPDATE um_h_sch_d SET work_day = (
  CASE WHEN to_char(to_date(from_date),'day') LIKE 'sunday%' THEN '1'
              WHEN to_char(to_date(from_date),'day') LIKE 'monday%' THEN '2'
              WHEN to_char(to_date(from_date),'day') like 'tuesday%' THEN '3'
              WHEN to_char(to_date(from_date),'day') LIKE 'wednesday%' THEN '4'
              WHEN to_char(to_date(from_date),'day') LIKE 'thursday%' THEN '5'
              WHEN to_char(to_date(from_date),'day') LIKE 'friday%' THEN '6'
              WHEN to_char(to_date(from_date),'day') LIKE 'saturday%' THEN '7'
              end);
