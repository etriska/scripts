update ae_i_ext_e e set SUBLEDGER_TYPE = (select d.subledger_type
 from ae_i_ext_e a
join AE_I_EXT_E_UDF b on a.trans_no = b.trans_no
join ae_i_poe_e c on a.po_code = c.PURCHASE_ORDER or a.po_code = c.po_code
join ae_i_poe_d d on c.po_code = d.po_code and substr(b.custom003, (instr(b.custom003,'-' )+1)) = d.PO_ITEM
where A.DESCRIPTION not like '%ACQUISITION CHARGE'
and A.SUBLEDGER_TYPE <> d.SUBLEDGER_TYPE
AND A.TRANS_DATE >= '01-JUL-16'
AND e.trans_no = A.trans_no)
Where e.trans_no in (SELECT a.trans_no
FROM ae_i_ext_e a
JOIN AE_I_EXT_E_UDF b ON a.trans_no = b.trans_no
JOIN ae_i_poe_e c     ON a.po_code  = c.PURCHASE_ORDER OR a.po_code = c.po_code
JOIN ae_i_poe_d d     ON c.po_code  = d.po_code AND SUBSTR(b.custom003, (instr(b.custom003, '-' ) + 1)) = d.PO_ITEM
WHERE A.DESCRIPTION NOT LIKE '%ACQUISITION CHARGE'
AND A.SUBLEDGER_TYPE <> d.SUBLEDGER_TYPE
AND A.TRANS_DATE     >= '01-JUL-16');

update ae_s_fnd_a a set A.SUBLEDGER_TYPE = (select b.subledger_type from ae_i_ext_e b where A.SOURCE_TRANX_NO = b.trans_no and A.TRANX_TYPE = 'WX')
where a.tranx_no in (select A.TRANX_NO
from ae_s_fnd_a a
join ae_i_ext_e b on A.SOURCE_TRANX_NO = b.trans_no and A.TRANX_TYPE = 'WX'
WHERE A.subledger_type <> b.subledger_type
and A.TRANX_DATE >=  '01-JUL-16');