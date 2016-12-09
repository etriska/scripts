with timecard as (
select b.trans_no, b.item_no, b.act_hrs, b.act_cost, b.current_rate
from ae_p_wka_e a
join ae_p_wka_d b on a.trans_no = b.trans_no)
select '1'card_type, c.dept_acct, e.VENDOR_ID, to_char(sysdate, 'YYYY/MM/DD') invoice_date,
    case when a.subledger_type = 'M' then 'MATERIALS'||';'||a.sort_code
              when a.subledger_type = 'L' then 'LABOR'||';'||a.sort_code
              else 'MATERIALS'||';'||a.sort_code end as invoice_id, a.proposal vendor_order_num, substr(b.DESCRIPTION,1,30) item_description,
    case when a.subledger_type = 'M' then round(1,4)
              when a.subledger_type = 'L' then round(f.act_hrs,4)
              else 1 end as qty_vouchered,
    case when a.subledger_type = 'M' then a.amount
              when a.subledger_type = 'L' then f.current_rate
              else a.amount end as unit_price,
    case when a.subledger_type = 'M' then a.amount
               when a.subledger_type = 'L' then f.act_cost
               else a.amount end as merchandise_amt,
    a.tranx_no, f.trans_no, a.funding_Code, a.offsetfunding_code
from ae_s_fnd_a a
join ae_p_phs_e b on a.proposal = b.proposal and a.sort_code = b.sort_code
join pap_bill_dept_acct c on b.shop between c.dept_low and c.dept_high
--join RVIEW_CHARTCOM_CONV d on a.funding_code = d.FUNDING_CODE
join PAP_BILL_VENDOR_ID e on b.shop = e.SHOP
left outer join timecard f on a.source_tranx_no = f.trans_no and a.source_tranx_item = f.item_no and a.tranx_type = 'CW'
where --a.bill_date like '29-APR-16%'
--and A.POST_FLAG = 'Y'
--and
a.tranx_type IN('TW','CW','AJ','WX','CJ','TP','OC','PO_INV_OC','WO_JRNL','SS')
and b.order_type in ('C','P','U','E')
--and a.funding_code <> a.offsetfunding_code
--and e.active_flag = 'Y'
--and b.status_code <> 'CANCELLED'
and a.tranx_no in ('87992689','87992691')
--and d.status <> 'T'
order by a.tranx_no