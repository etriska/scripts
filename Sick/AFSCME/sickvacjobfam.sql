delete from um_sick_vac_jobfam;

insert into um_sick_vac_jobfam(shop_person, adj_date, lev_class, lev_code, lev_adj,
shop)
select shop_person, adj_date, lev_class, lev_code, lev_adj, shop from ae_h_lev_d
where lev_class != '3F'
and lev_code is not null;

commit;

update um_sick_vac_jobfam set lev_adj = lev_adj * -1;
commit;
update um_sick_vac_jobfam set shop = (select shop from ae_l_shp_h
where 
um_sick_vac_jobfam.shop_person = ae_l_shp_h.shop_person
and (adj_date >= date_from and (adj_date <= date_to or date_to is null)));
commit;
update um_sick_vac_jobfam set job_fam = (select job_fam from ae_h_emp_e
where um_sick_vac_jobfam.shop_person = ae_h_emp_e.shop_person);
commit;