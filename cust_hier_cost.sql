select b.company_id, b.top_level_desc, b.dept_id, b.mid_level_desc, b.bottom_level_desc, substr(a.funding_code,7,6) oc_code, sum(a.amount) amount
from ae_s_fnd_a a
join rview_cust_hierarchy b on substr(a.funding_code,7,6) = b.oc_code
and a.tranx_date >= '01-JUL-12'
and a.tranx_type in ('TW','CW','AJ','WX','CJ','TP','OC','PO_INV_OC','WO_JRNL')
group by b.company_id, b.top_level_desc, b.dept_id, b.mid_level_desc, b.bottom_level_desc, substr(a.funding_code,7,6)
order by b.company_id, b.dept_id