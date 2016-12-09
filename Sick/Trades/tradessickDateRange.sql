delete from um_trades_sick;
insert into um_trades_sick(shop_person, adj_date, lev_class, lev_code, lev_adj,
shop)
select shop_person, adj_date, lev_class, lev_code, lev_adj, shop from ae_h_lev_d
where lev_class != '3F'
and lev_code is not null
and (lev_code = '00010FCMP' or lev_code = '00010FMLA'
or lev_code = '00010PENT' or lev_code = '00010SWOP'
or lev_code = '00016' or lev_code = '00016HOSP'
or lev_code = '00016OPST' or lev_code = '00016TRANS'
or lev_code = '00018' or lev_code = '00016FCARE'
or lev_code = '00016PDENT' or lev_code = '00016PMED'
or lev_code = '00010COMP' or lev_code = '00016COMP'
or lev_code = '00001' or lev_code = '00010'
or lev_code = '00016PRESC')
and shop_person in (select shop_person from ae_h_emp_e where
job_fam = 'W')
and adj_date >= '01-AUG-06' and adj_date <= '31-JUL-07';
commit;
update um_trades_sick set lev_adj = lev_adj * -1;
update um_trades_sick set c_stat = (select c_stat from ae_h_emp_e where
um_trades_sick.shop_person = ae_h_emp_e.shop_person);
update um_trades_sick set shop = (select shop from ae_l_shp_h
where 
um_trades_sick.shop_person = ae_l_shp_h.shop_person
and ((adj_date >= date_from and adj_date <= date_to)));
update um_trades_sick set job_fam = (select job_fam from ae_h_emp_e
where um_trades_sick.shop_person = ae_h_emp_e.shop_person);
update um_trades_sick set bdate = (select b_date from ae_h_emp_e
where um_trades_sick.shop_person = ae_h_emp_e.shop_person);
update um_trades_sick set hire_date = (select h_date from ae_h_emp_e
where um_trades_sick.shop_person = ae_h_emp_e.shop_person);
update um_trades_sick set vacation = (select sum(ae_h_lev_d.lev_adj)*-1 from ae_h_lev_d
where um_trades_sick.shop_person = ae_h_lev_d.shop_person and
ae_h_lev_d.adj_date >= '01-AUG-05' and ae_h_lev_d.adj_date <= '31-JUL-06' and
ae_h_lev_d.lev_code is not null and ae_h_lev_d.lev_class = '2V');
commit;


