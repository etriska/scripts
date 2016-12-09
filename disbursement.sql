INSERT INTO ae_i_disb_e (multitenant_id, doc_no, created_by, date_created,
description, edit_date, edit_clerk, long_desc, link_tranx_num) 
VALUES (1, 3745,
'ETRISKA', '2016-05-17 15:49:31', 'ALRO QUOTE: 068016666', '2016-05-17
15:49:34', 'ETRISKA', null, null);

INSERT INTO ae_i_disb_d (multitenant_id, doc_no, item_no, reversed_qty,
rev_item_no, proposal, sort_code, warehouse, bin_location, source_doc_type,
source_doc_num, source_doc_item, source_doc_sub_seq, vend_part, vend_qty,
unit_cost, po_code, po_item, po_sub_detail_line, part, edit_date, edit_clerk,
long_desc, ext_refcode, adj_tranx_no, curr_code, description, tax1_amt,
tax2_amt, tax1_rebate_amt, ship_amt, markup_amt, discount_amt, invoice_qty,
invoice_tranx_no, invoice_line_seq, invoice_seq, invoice_unit_cost,
capital_project, component_id, component, entry_date) 
VALUES (1, 3745, 1, 0,
null, '2404782-2016', '003', null, null, 'PR', 19922, 1, null, '18082000',
1.0000, 196.66, '116504', 1, 1, null, '2016-05-17 15:49:34', 'ETRISKA', null,
null, null, 'USD', null, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0, null, null, null,
0, null, null, null, '2016-05-17 15:49:31');

UPDATE ae_i_poe_d SET tot_dist_qty = 1.0000, edit_date = '2016-05-17 15:49:34',
edit_clerk = 'ETRISKA' 
WHERE ( (ae_i_poe_d.multitenant_id = 1) AND
(ae_i_poe_d.po_code = '116504') AND (ae_i_poe_d.po_item = 1) AND
(ae_i_poe_d.multitenant_id = 1) );

UPDATE ae_i_poe_p SET dist_qty = 1.0000, edit_date = '2016-05-17 15:49:34',
edit_clerk = 'ETRISKA' 
WHERE ( (ae_i_poe_p.multitenant_id = 1) AND
(ae_i_poe_p.po_code = '116504') AND (ae_i_poe_p.po_item = 1) AND (ae_i_poe_p.seq
= 1) AND (ae_i_poe_p.multitenant_id = 1) );

UPDATE ae_i_poe_f SET tot_dist_qty = 1.0000, edit_date = '2016-05-17 15:49:35',
edit_clerk = 'ETRISKA' 
WHERE ( (ae_i_poe_f.multitenant_id = 1) AND
(ae_i_poe_f.doc_num = 19922) AND (ae_i_poe_f.doc_item = 1) AND
(ae_i_poe_f.multitenant_id = 1) );

INSERT INTO ae_i_rec_status_hist (multitenant_id, doc_num, status_date,
status_code, login, reason_code, edit_date, edit_clerk) VALUES (1, 19922,
'2016-05-17 15:49:35', 'CLOSED', 'ETRISKA', null, '2016-05-17 15:49:35',
'ETRISKA');

UPDATE ae_i_rec_e SET edit_date = '2016-05-17 15:49:35', edit_clerk = 'ETRISKA',
status_code = 'CLOSED' WHERE ( (ae_i_rec_e.multitenant_id = 1) AND
(ae_i_rec_e.doc_num = 19922) AND (ae_i_rec_e.multitenant_id = 1) );

