truncate table tmp_strategic_po_enc_rel;
drop table tmp_strategic_po_enc_rel;
CREATE GLOBAL TEMPORARY TABLE tmp_strategic_po_enc_rel
ON COMMIT PRESERVE ROWS AS
SELECT distinct A.po_code, c.po_item, A.purchase_order, A.status_code, c.proposal, c.sort_code, e.merchandise_amt enc_tot
FROM ae_i_poe_e A
JOIN ae_i_poe_d b ON A.po_code = b.po_code
JOIN ae_i_poe_p c ON b.po_code = c.po_code AND b.po_item = c.po_item
JOIN rview_phs_totals d ON c.proposal = d.proposal AND c.sort_code = d.sort_code
JOIN um_proc_voucher_line e on a.po_code = e.useref and b.po_item = e.voucher_line_num and b.vend_qty = e.VOUCHER_LINE_QTY
WHERE A.po_type = 'STRATEGIC'
AND A.status_code NOT IN ('CLOSED','CANCELLED')
AND d.enc_tot > 0
ORDER BY A.po_code, c.proposal, c.sort_code;

--close po lines
UPDATE ae_i_poe_d SET po_line_status = 'C'
WHERE (po_code, po_item) IN (SELECT po_code, po_item
    FROM tmp_strategic_po_enc_rel)
AND po_line_status <> 'C';

INSERT INTO ae_i_poe_status_hist(status_date, status_code, login, edit_date, edit_clerk, po_code, multitenant_id)
SELECT DISTINCT SYSDATE, 'CLOSED','ETRISKA', SYSDATE, 'ETRISKA', po_code, 1
FROM tmp_strategic_po_enc_rel;

INSERT INTO ae_s_fnd_a(tranx_no, tranx_date, tranx_type, subledger_type, description, funding_code, offsetfunding_code, proposal, sort_code, post_flag, 
    bill_seq, amount, contractor, distrib_seq, fin_type, contract_no, source_screenname, edit_date, edit_clerk, contract_item, distribution_source, curr_rate, 
    sub_code, address_code, version_no, multitenant_id)
SELECT func_tranxgen(1,'F'), SYSDATE, 'PO_DE', subledger_type, 'PURCHASE ORDER DEENCUMBRANCE', funding_code, offsetfunding_code, proposal, sort_code, post_flag, 
    bill_seq, amount * -1, contractor, distrib_seq, fin_type, contract_no, source_screenname, SYSDATE, 'ETRISKA', contract_item, distribution_source, curr_rate, 
    sub_code, address_code, version_no, multitenant_id
FROM ae_s_fnd_a
WHERE (contract_no, contract_item) IN (SELECT po_code, po_item FROM tmp_strategic_po_enc_rel);

UPDATE ae_i_poe_e SET status_code = 'CLOSED'
WHERE po_code IN (SELECT po_code FROM tmp_strategic_po_enc_rel);

exec FMAX_85.PROC_AIMWOPHASECOST();
