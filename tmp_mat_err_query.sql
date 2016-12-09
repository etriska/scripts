select a.voucher_number, a.voucher_line_no, a.work_request wo, a.phase_number phase, a.shop, a.invoice_num,a.vendor_id, a.vendor_name, a.invoice_date, a.payment_date, a.item_desc, a.num_amount
from um_mat_err_hist a
where a.status = 'UNPROCESSED'
and a.shop = 'M4900'