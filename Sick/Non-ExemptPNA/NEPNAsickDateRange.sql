delete from um_nepna_sick;
insert into um_nepna_sick(shop_person, adj_date, lev_class, lev_code, lev_adj,
shop)
select shop_person, adj_date, lev_class, lev_code, lev_adj, shop from ae_h_lev_d
where lev_class != '3F'
and lev_code is not null
and (lev_code = '00016' or lev_code = '00016HOSP'
or lev_code = '00016TRANS' or lev_code = '00016FCARE'
or lev_code = '00016PDENT' or lev_code = '00016PMED'
or lev_code = '00016COMP')
and shop_person in (select shop_person from ae_h_emp_e where
job_fam = 'N')
and adj_date >= '01-JUL-99' and adj_date <= '30-JUN-06';
commit;
update um_nepna_sick set lev_adj = lev_adj * -1;
update um_nepna_sick set c_stat = (select c_stat from ae_h_emp_e where
um_nepna_sick.shop_person = ae_h_emp_e.shop_person);
update um_nepna_sick set shop = (select shop from ae_l_shp_h
where 
um_nepna_sick.shop_person = ae_l_shp_h.shop_person
and ((adj_date >= date_from and adj_date <= date_to)));
update um_nepna_sick set job_fam = (select job_fam from ae_h_emp_e
where um_nepna_sick.shop_person = ae_h_emp_e.shop_person);
commit;


