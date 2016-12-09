UPDATE ae_i_ext_e e SET subledger_type = (SELECT d.subledger_type
 FROM ae_i_ext_e A
JOIN ae_i_ext_e_udf b ON A.trans_no = b.trans_no
JOIN ae_i_poe_e c ON A.po_code = c.purchase_order OR A.po_code = c.po_code
JOIN ae_i_poe_d d ON c.po_code = d.po_code AND substr(b.custom003, (instr(b.custom003,'-' )+1)) = d.po_item
WHERE A.description NOT LIKE '%ACQUISITION CHARGE'
AND A.subledger_type <> d.subledger_type
AND A.trans_date >= '01-JUL-16'
AND e.trans_no = A.trans_no)
WHERE e.trans_no IN (SELECT A.trans_no
FROM ae_i_ext_e A
JOIN ae_i_ext_e_udf b ON A.trans_no = b.trans_no
JOIN ae_i_poe_e c     ON A.po_code  = c.purchase_order OR A.po_code = c.po_code
JOIN ae_i_poe_d d     ON c.po_code  = d.po_code AND substr(b.custom003, (instr(b.custom003, '-' ) + 1)) = d.po_item
WHERE A.description NOT LIKE '%ACQUISITION CHARGE'
AND A.subledger_type <> d.subledger_type
AND A.trans_date     >= '01-JUL-16');

UPDATE ae_s_fnd_a A SET A.subledger_type = (SELECT b.subledger_type FROM ae_i_ext_e b WHERE A.source_tranx_no = b.trans_no AND A.tranx_type = 'WX')
WHERE A.tranx_no IN (SELECT A.tranx_no
FROM ae_s_fnd_a A
JOIN ae_i_ext_e b ON A.source_tranx_no = b.trans_no AND A.tranx_type = 'WX'
WHERE A.subledger_type <> b.subledger_type
AND A.tranx_date >=  '01-JUL-16');