update ae_s_fnd_a a set A.SUBLEDGER_TYPE = (select b.subledger_type from ae_i_ext_e b where A.SOURCE_TRANX_NO = b.trans_no and A.TRANX_TYPE = 'WX')
where a.tranx_no in (select A.TRANX_NO
from ae_s_fnd_a a
join ae_i_ext_e b on A.SOURCE_TRANX_NO = b.trans_no and A.TRANX_TYPE = 'WX'
where A.SUBLEDGER_TYPE <> b.subledger_type
and A.TRANX_DATE >=  '01-JUL-16');  