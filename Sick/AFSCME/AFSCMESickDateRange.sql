delete from um_afscme_sick;

insert into um_afscme_sick(shop_person, adj_date, lev_class, lev_code, lev_adj,
shop)
select shop_person, adj_date, lev_class, lev_code, lev_adj, shop from ae_h_lev_d
where lev_class != '3F'
and lev_code is not null
and    (lev_code = '00200PDENT' or 
	lev_code = '00200PMED' or 
	lev_code = '00200PDT' or 
	lev_code = '00200SCOMP' or 
	lev_code = '00200SHOSP' or 
	lev_code = '00200SICK'or 
	lev_code = '00200STWP' or
	lev_code = '00220PDENT' or 
	lev_code = '00220PMED' or 
	lev_code = '00220SCOMP' or 
	lev_code = '00220SHOSP' or 
	lev_code = '00220SICK'or 
	lev_code = '00220STWP')
and shop_person in (select shop_person from ae_h_emp_e where
job_fam = 'A')
and adj_date >= '01-JUL-00' and adj_date <= '30-JUN-01';

commit;

update um_afscme_sick set lev_adj = lev_adj * -1;
update um_afscme_sick set c_stat = (select c_stat from ae_h_emp_e where
um_afscme_sick.shop_person = ae_h_emp_e.shop_person);
update um_afscme_sick set shop = (select shop from ae_l_shp_h
where 
um_afscme_sick.shop_person = ae_l_shp_h.shop_person
and (adj_date >= date_from and (adj_date <= date_to or date_to is null)));
update um_afscme_sick set job_fam = (select job_fam from ae_h_emp_e
where um_afscme_sick.shop_person = ae_h_emp_e.shop_person);
commit;