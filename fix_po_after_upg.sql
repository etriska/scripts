create table tmp_po_code as select * from ae_i_poe_status_hist@test.umich where edit_clerk = 'SYSTEM' and login = 'SYSTEM';

delete from ae_i_poe_status_hist where edit_clerk = 'SYSTEM';

update ae_i_poe_e 
set status_code = (select a.status_code from ae_i_poe_e@db3.umich a,tmp_po_code b
		where a.po_code=b.po_code
and a.po_code = ae_i_poe_e.po_Code)
where po_code in (select a.po_Code from ae_i_poe_e@db3.umich a,tmp_po_code b
where a.po_code=b.po_code);

insert into ae_s_fnd_a select * from ae_s_fnd_a@db3.umich where contract_no in (select po_code from tmp_po_code) and tranx_type = 'PO_E';

delete from pap_eproreqs_errors where po_num in (select po_code from tmp_po_code);

delete from pap_eproreqs_history where date_time >= TO_date('23-NOV-09 06:40:00', 'DD-MON-YY HH24:MI:SS')
AND date_time   < TO_date('23-NOV-09 7:00:00', 'DD-MON-YY HH24:MI:SS');

