--CLOSE Material Request where work order is closed or CANCELLED

--create tmp table to store records for transformation
/*
create global temporary table tmp_mr_close
on commit preserve rows as
select a.pr_code, a.pr_Status, a.pr_Date
from ae_i_pre_e a
join ae_p_pro_e b on a.proposal = b.proposal
join ae_i_pre_status c on A.PR_STATUS = c.PR_STATUS
where b.status_code in ('CLOSED','CANCELLED') --work order header is in a closed status
and c.complete_yn not in ('C','L')  --locate material requests that are still open
order by a.pr_Date, A.PR_CODE;
*/
--update material request line items to closed
update ae_i_pre_d set itm_status = 'C'
where pr_code in (select pr_code from tmp_mr_close);

--insert status history for closing on material request
insert into ae_i_pre_status_hist (pr_code, pr_status, status_date, login, edit_date, edit_clerk, multitenant_id)
select pr_code, 'CLOSED', sysdate, 'CLARKDA', sysdate, 'CLARKDA',  1
from TMP_MR_CLOSE;

update ae_i_pre_e set pr_status = 'CLOSED'
where pr_code in (select pr_code from tmp_mr_close);

commit;
truncate table tmp_mr_close;
drop table tmp_mr_close;

--Close material request where pr_status is 'POCOMPLETE' and work order is closed or cancelled.
--create tmp table to store records for transformation

create global temporary table tmp_mr_close
on commit preserve rows as
select a.pr_code, a.pr_Status, a.pr_Date
from ae_i_pre_e a
join ae_p_phs_e b on a.proposal = b.proposal and a.sort_code = b.sort_code
where b.status_code in ('CLOSED','CANCELLED','COMPLETE', 'NOTCOMPLETED') --work order header is in a closed status
and a.pr_status = 'NONPOMATORDRCOMPLETE'
order by a.pr_Date, A.PR_CODE;

--update material request line items to closed
update ae_i_pre_d set itm_status = 'C'
where pr_code in (select pr_code from tmp_mr_close);

--insert status history for closing on material request
insert into ae_i_pre_status_hist (pr_code, pr_status, status_date, login, edit_date, edit_clerk, multitenant_id)
select pr_code, 'CLOSED', sysdate, 'CLARKDA', sysdate, 'CLARKDA',  1
from TMP_MR_CLOSE;

update ae_i_pre_e set pr_status = 'CLOSED'
where pr_code in (select pr_code from tmp_mr_close);

--commit;
truncate table tmp_mr_close;
drop table tmp_mr_close;