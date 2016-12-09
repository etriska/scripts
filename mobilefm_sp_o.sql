/*==============================================================*/
/* DBMS name:      ORACLE Version 9i2                           */
/* Created on:     12/23/2009 9:52:08 AM                        */
/*==============================================================*/



create or replace procedure BEG_UL_AE_I_EXT_E(v_ml_user    varchar,
    v_table      varchar)
as
        v_shop_person    ae_h_emp_e.shop_person%type;
        v_pda_id         varchar(128);
        v_download_type  varchar(15);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_ae_i_ext_e_delete
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);
end;
/


create or replace procedure BEG_UL_AE_I_POE_E(v_ml_user    varchar,
    v_table      varchar)
as
        v_shop_person    varchar(15);
        v_pda_id         varchar(128);
        v_download_type  varchar(15);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_ae_i_rec_c_trans_no
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);


end;
/


create or replace procedure BEG_UL_AE_I_PTN_E(v_ml_user    varchar,
    v_table      varchar)
as
        v_shop_person    varchar(15);
        v_pda_id         varchar(128);
        v_download_type  varchar(15);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_ae_i_ptn_e_trans_no
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);

end;
/


create or replace procedure BEG_UL_AE_P_PRO_E(v_ml_user    varchar,
    v_table      varchar)
as
        v_shop_person    varchar(15);
        v_pda_id         varchar(128);
        v_download_type  varchar(15);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_proposal_xref
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);
end;
/


create or replace procedure BEG_UL_AE_P_PST_E(v_ml_user    varchar,
    v_table      varchar)
as
        v_pda_id         varchar(128);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_ae_p_pst_e_delete
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);
end;
/


create or replace procedure BEG_UL_AE_P_REQ_E(v_ml_user    varchar,
    v_table      varchar)
as
        v_pda_id         varchar(128);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_ae_p_req_e_delete
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);
end;
/


create or replace procedure BEG_UL_AE_P_STA_E(v_ml_user    varchar,
    v_table      varchar)
as
        v_pda_id         varchar(128);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_ae_p_sta_e_delete
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);
end;
/


create or replace procedure BEG_UL_AE_P_WKA_D(v_ml_user    varchar,
    v_table      varchar)
as
        v_shop_person    ae_h_emp_e.shop_person%type;
        v_pda_id         varchar(128);
        v_download_type  varchar(15);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_ae_p_wka_d_delete
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);
end;
/


create or replace procedure BEG_UL_AE_R_EQM_NOTES(v_ml_user    varchar,
    v_table      varchar)
as
        v_pda_id         varchar(128);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_ae_r_eqm_notes
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);
end;
/


create or replace procedure BEG_UL_MFM_CYCLE_COUNT_TO_DL(v_ml_user    varchar,
    v_table      varchar)
as
        v_shop_person    varchar(15);
        v_pda_id         varchar(128);
        v_download_type  varchar(15);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_cycle_count_to_download
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);

end;
/


create or replace procedure BEG_UL_MFM_ROUTES_DL(v_ml_user    varchar,
    v_table      varchar)
as
        v_shop_person    varchar(15);
        v_pda_id         varchar(128);
        v_download_type  varchar(15);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_routes_download
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);

end;
/


create or replace procedure BEG_UL_MFM_WAREHOUSE_FOR_PO_DL(v_ml_user    varchar,
    v_table      varchar)
as
        v_shop_person    varchar(15);
        v_pda_id         varchar(128);
        v_download_type  varchar(15);
begin
    v_pda_id := 'PDA_ID';

    delete from mfm_warehouse_for_po_download
    where trim(upper(login)) = trim(upper(v_ml_user))
      and trim(pda_id) = trim(v_pda_id);

end;
/


create or replace function BITOR(p_dec1 number, p_dec2 number)
return number is
begin
  return p_dec1-bitand(p_dec1,p_dec2)+p_dec2;
end;
/


create or replace function BITXOR(p_dec1 number, p_dec2 number)
return number is
begin
  return bitor(p_dec1,p_dec2)-bitand(p_dec1,p_dec2);
end;
/


create or replace procedure MFM_AUTHENTIC_USER(v_auth_status in out integer,
    v_in_ml_username varchar,
    v_in_user_password varchar,
    v_in_user_new_password varchar)
as
     v_shov_person varchar2(10);
     v_encrypt_pass varchar2(10);
     v_pass_key varchar2(10);
     v_pass_pos int;
     v_charpos  int;
     v_count  int;
     v_pos int;
     v_exor_pass int ;
     v_exor_val varchar(1);
     v_valid varchar2(10);
    v_ml_username varchar(128);
    v_user_password varchar(128);
    v_user_new_password varchar(128);
begin

v_ml_username := v_in_ml_username;
v_user_password := v_in_user_password;
v_user_new_password := v_in_user_new_password;

if v_ml_username is null then
   v_ml_username := '';
end if;

if v_user_password is null then
   v_user_password := '';
end if;

if v_user_new_password is null then
   v_user_new_password := '';
end if;

if length(rtrim(v_ml_username)) = 0 or length(rtrim(v_user_password)) = 0 then
   v_auth_status := 4000;
   return;
end if;

v_pass_key := 'AECAECAECA';
v_encrypt_pass :='';
v_pos := 1;
while v_pos <= length(v_user_password)
loop
    v_charpos := ascii(substr(v_user_password,v_pos,1) );
    v_charpos := bitor(v_charpos , 128);
    v_pass_pos := ascii(substr(v_pass_key,v_pos,1) );
    v_exor_pass := bitxor(v_charpos , v_pass_pos);
    v_exor_val := chr(v_exor_pass);
    v_encrypt_pass := v_encrypt_pass || v_exor_val;
    v_pos := v_pos + 1;
end loop;

select count(*)
  into  v_count
  from ae_s_sec_c
 where upper(trim(login)) = upper(trim(v_ml_username))
   and trim(password) = v_encrypt_pass;

if v_count > 0 then
    v_auth_status := 1000;
else
    v_auth_status := 4000;
end if;

end;
/


create or replace procedure MFM_BO_AE_P_PHS_C(v_proposal             varchar,
    v_sort_code            varchar,
    v_insertrow            varchar,
    v_old_phase_default_dist in out varchar)
as
/*
        v_edit_date date;
        v_default_dist varchar(1);
	    v_seq numeric(5,0);
        v_dist_count int;
        v_reload_dist_flag  ae_s_sys_f.parameter%type;
        v_con_ref      ae_p_pro_e.ref%type;
    	v_con_enforce_dist_yn varchar(1);
        v_dist_loaded    varchar(1);
        v_dist_craft_code varchar(15);
    	v_dist_sub_ledger varchar(1);
    	v_dist_funding_code varchar(50);
    	v_dist_sub_code varchar(5);
    	v_dist_offsetfunding_code varchar(50);
    	v_dist_offsetsub_code varchar(5);
    	v_dist_company_c varchar(25);
    	v_dist_dept_c varchar(9);
    	v_dist_oc_c varchar(15);
    	v_dist_sub_percent numeric(16,4);
    	v_dist_sub_amount numeric(12,4);
    	v_dist_enc_amount numeric(12,4);
    	v_dist_region_code varchar(6);
    	v_dist_fac_id varchar(15);
    	v_dist_bldg varchar(15);
    	v_dist_precedence numeric(4,0);
    	v_dist_fixed_actual varchar(1);
    	v_dist_charged_amount numeric(18,4);
    	v_dist_expire_date date;
    	v_dist_start_date date;
    	v_dist_locked_dist varchar(1);
    	v_dist_af1 varchar(30);
    	v_dist_af2 varchar(30);
    	v_dist_af3 varchar(30);
    	v_dist_af4 varchar(30);
    	v_dist_af5 varchar(30);
    	v_dist_af6 varchar(30);
    	v_dist_af7 varchar(30);
    	v_dist_af8 varchar(30);
    	v_dist_af9 varchar(30);
    	v_dist_af10 varchar(30);
    	v_dist_af11 varchar(30);
    	v_dist_af12 varchar(30);
    	v_dist_seq numeric(5,0);
    	v_dist_sub_tranx_type varchar(10);
        v_count int;
        v_current_date   date;
    	v_company_o	varchar(25);
    	v_dept_o		varchar(9);
    	v_oc_o		varchar(15);
    	v_region_code	varchar(6);
    	v_fac_id		varchar(15);
    	v_bldg		varchar(15);
        v_shop       varchar(15);
        v_part       varchar(25);
        v_serial_no  varchar(50);
        v_flag_128   varchar(1);
        cursor c_reload_dist_flag is
            select parameter
              from ae_s_sys_f
             where flag_id = 106;
        cursor c_proposal_project(v_proposal ae_p_pro_e.proposal%type) is
        select ref
           from ae_p_pro_e
          where proposal = v_proposal;
        cursor c_enforce_dist(v_con_ref ae_j_prj_e.enforce_dist_yn%type) is
            select enforce_dist_yn
              from ae_j_prj_e
             where project = v_con_ref;
        cursor c_default_dist(v_proposal ae_p_phs_e.proposal%type,
                                v_sort_code ae_p_phs_e.sort_code%type) is
            select default_dist
              from ae_p_phs_e
             where v_proposal = proposal
               and v_sort_code = sort_code;
        cursor c_phase_dist_count(v_proposal ae_p_phs_e.proposal%type,
                                v_sort_code ae_p_phs_e.sort_code%type) is
            select count(*),
                   max(seq)
              from ae_p_phs_c
             where v_proposal = proposal
               and v_sort_code = sort_code;
        cursor c_customer_org(v_proposal ae_p_phs_e.proposal%type,
                                    v_sort_code ae_p_phs_e.sort_code%type) is
            select company_o,
                   dept_o,
                   oc_o
              from ae_p_phs_e
             where proposal = v_proposal
               and sort_code = v_sort_code;
    cursor c_cust_dist(v_company_o ae_s_dep_c.company_id%type,
                        v_dept_o ae_s_dep_c.dept_id%type) is
            select craft_code,
                    sub_ledger,
                    funding_code,
                    sub_code,
                    offsetfunding_code,
                    offsetsub_code,
                    company_c,
                    dept_c,
                    oc_c,
                    sub_percent,
                    sub_amount,
                    enc_amount,
                    region_code,
                    fac_id,
                    bldg,
                    precedence,
                    fixed_actual,
                    varcharged_amount,
                    expire_date,
                    start_date,
                    locked_dist,
                    af1, af2, af3, af4, af5, af6, af7, af8, af9, af10, af11, af12,
                    seq
               from ae_s_dep_c
              where company_id = v_company_o
                and dept_id = v_dept_o
                and (expire_date > sysdate or expire_date is null)
              order by seq;
    cursor c_pro_bldg(v_proposal ae_p_pro_e.proposal%type) is
       select region_code,
              fac_id,
              bldg
         from ae_p_pro_e
        where proposal = v_proposal;
    cursor c_bldg_dist(v_region_code ae_s_bld_b.region_code%type,
                        v_fac_id ae_s_bld_b.fac_id%type,
                        v_bldg ae_s_bld_b.bldg%type) is
        select craft_code,
                sub_ledger,
                funding_code,
                sub_code,
                offsetfunding_code,
                offsetsub_code,
                company_c,
                dept_c,
                oc_c,
                sub_percent,
                sub_amount,
                enc_amount,
                region_code,
                fac_id,
                bldg,
                precedence,
                fixed_actual,
                varcharged_amount,
                expire_date,
                start_date,
                locked_dist,
                af1, af2, af3, af4, af5, af6, af7, af8, af9, af10, af11, af12,
                seq
           from ae_s_bld_b
          where region_code = v_region_code
            and fac_id = v_fac_id
            and bldg = v_bldg
            and (expire_date > sysdate or expire_date is null)
          order by seq;
    cursor c_phase_shop(v_proposal ae_p_phs_e.proposal%type,
                        v_sort_code ae_p_phs_e.sort_code%type) is
       select shop
         from ae_p_phs_e
        where proposal = v_proposal
          and sort_code = v_sort_code;
    cursor c_shop_dist(v_shop ae_p_phs_e.shop%type) is
        select craft_code,
                sub_ledger,
                funding_code,
                sub_code,
                offsetfunding_code,
                offsetsub_code,
                company_c,
                dept_c,
                oc_c,
                sub_percent,
                sub_amount,
                enc_amount,
                region_code,
                fac_id,
                bldg,
                precedence,
                fixed_actual,
                varcharged_amount,
                expire_date,
                start_date,
                locked_dist,
                af1, af2, af3, af4, af5, af6, af7, af8, af9, af10, af11, af12,
                seq
           from ae_l_shp_b
          where shop = v_shop
           and (expire_date > sysdate or expire_date is null)
          order by seq;
    cursor c_phase_equipment(v_proposal ae_p_phs_e.proposal%type,
                            v_serial_no ae_p_phs_e.sort_code%type) is
       select part,
              serial_no
         from ae_p_phs_e
        where proposal = v_proposal
          and sort_code = v_sort_code;
    cursor c_equipment_dist(v_part  ae_p_phs_e.part%type,
                            v_serial_no ae_p_phs_e.serial_no%type) is
        select craft_code,
                sub_ledger,
                funding_code,
                sub_code,
                offsetfunding_code,
                offsetsub_code,
                company_c,
                dept_c,
                oc_c,
                sub_percent,
                sub_amount,
                enc_amount,
                region_code,
                fac_id,
                bldg,
                precedence,
                fixed_actual,
                varcharged_amount,
                expire_date,
                start_date,
                locked_dist,
                af1, af2, af3, af4, af5, af6, af7, af8, af9, af10, af11, af12,
                seq
           from ae_r_eqm_c
          where part = v_part
            and serial_no = v_serial_no
            and (expire_date > sysdate or expire_date is null)
          order by seq;
        cursor c_flag_128 is
            select rtrim(parameter)
              from ae_s_sys_f
             where flag_id = 128;
      cursor c_shop_acct( v_shop ae_l_shp_e.shop%type) is
      select funding_code, offsetsub_code
        from ae_l_shp_e
       where shop = v_shop
         and active = 'Y';
         */
begin
/*
open c_reload_dist_flag;
fetch c_reload_dist_flag into v_reload_dist_flag;
close c_reload_dist_flag;
if rtrim(v_reload_dist_flag) <> 'Y' and v_insertrow = 'N' then
    return;
end if;
open c_proposal_project(v_proposal);
fetch c_proposal_project into v_con_ref;
close c_proposal_project;
if rtrim(v_con_ref) = '' then
    v_con_ref := null;
end if;
if v_con_ref is not null then
    open c_enforce_dist(v_con_ref);
    fetch c_enforce_dist into v_con_enforce_dist_yn;
    close c_enforce_dist;
    if rtrim(v_con_enforce_dist_yn) = 'Y' then
        return;
    end if;
end if;
v_edit_date := sysdate;
v_dist_sub_tranx_type := 'MAIN';
open c_default_dist(v_proposal, v_sort_code);
fetch c_default_dist into v_default_dist;
close c_default_dist;
if v_insertrow = 'Y' then
    v_old_phase_default_dist := '';
end if;
v_dist_loaded := 'N';
if rtrim(v_default_dist) = rtrim(v_old_phase_default_dist) then
    return;
end if;
open c_phase_dist_count(v_proposal, v_sort_code);
fetch c_phase_dist_count into v_dist_count, v_seq;
close c_phase_dist_count;
if v_dist_count > 0 then
   v_current_date := sysdate;
   update ae_p_phs_c
      set expire_date = v_current_date
    where v_proposal = proposal
      and v_sort_code = sort_code
      and (expire_date is null
       or  expire_date > v_current_date);
   update ae_p_phs_c
      set locked_dist = 'Y'
    where v_proposal = proposal
      and v_sort_code = sort_code
      and (locked_dist is null or rtrim(locked_dist) <> 'Y');
else
    v_seq := 0;
end if;
*/

/*
   select v_dist_count=count(*)
     from ae_s_prop_wc_dist
    where region_code = ~'' + ax_region + '~' and fac_id = ~'' + ax_facility + '~' and bldg = ~'' + ax_property + '~' and wr_type = ~'' + ax_type + '~' and category = ~'' + ax_category + '~' and work_code = ~'' + ax_work_code + '~''
lx_sql = 'select work_code, sub_ledger, funding_code, sub_code, offsetfunding_code, offsetsub_code, company_c, dept_c, oc_c, sub_percent, sub_amount, enc_amout, region_code, fac_id, bldg, precedence, fixed_actual, varcharged_amount, expire_date, start_date, locked_dist, af1, af2, af3, af4, af5, af6, af7, af8, af9, af10, af11, af12, seq from'
choose case parent.classname()
	case 'w_i_wra_p', 'w_plan_wra_p', 'w_i_prj_e', 'w_i_wra_p_limited'
		lx_sql = lx_sql + ' ae_s_prop_wc_dist where region_code = ~'' + ax_region + '~' and fac_id = ~'' + ax_facility + '~' and bldg = ~'' + ax_property + '~' and wr_type = ~'' + ax_type + '~' and category = ~'' + ax_category + '~' and work_code = ~'' + ax_work_code + '~''
*/

/*
if v_default_dist = 'C' and v_dist_loaded <> 'Y' then
    open c_customer_org(v_proposal, v_sort_code);
    fetch c_customer_org into v_company_o, v_dept_o, v_oc_o;
    close c_customer_org;
    open c_cust_dist(v_company_o, v_dept_o);
    loop
        fetch c_cust_dist into v_dist_craft_code,
    		v_dist_sub_ledger,
    		v_dist_funding_code,
    		v_dist_sub_code,
    		v_dist_offsetfunding_code,
    		v_dist_offsetsub_code,
    		v_dist_company_c,
    		v_dist_dept_c,
    		v_dist_oc_c,
    		v_dist_sub_percent,
    		v_dist_sub_amount,
    		v_dist_enc_amount,
    		v_dist_region_code,
    		v_dist_fac_id,
    		v_dist_bldg,
    		v_dist_precedence,
    		v_dist_fixed_actual,
    		v_dist_charged_amount,
    		v_dist_expire_date,
    		v_dist_start_date,
    		v_dist_locked_dist,
    		v_dist_af1,
    		v_dist_af2,
    		v_dist_af3,
    		v_dist_af4,
    		v_dist_af5,
    		v_dist_af6,
    		v_dist_af7,
    		v_dist_af8,
    		v_dist_af9,
    		v_dist_af10,
    		v_dist_af11,
    		v_dist_af12,
    		v_dist_seq;
    		exit when c_cust_dist%notfound;
        	v_reload_dist_flag := 'Y';
    	    v_seq := v_seq + 1;
    	    insert into ae_p_phs_c(proposal,
    	    			sort_code,
    				craft_code,
    				sub_ledger,
    				funding_code,
    				sub_code,
    				offsetfunding_code,
    				offsetsub_code,
    				company_c,
    				dept_c,
    				oc_c,
    				sub_percent,
    				sub_amount,
    				enc_amount,
    				region_code,
    				fac_id,
    				bldg,
    				precedence,
    				fixed_actual,
    				charged_amount,
    				expire_date,
    				start_date,
    				locked_dist,
    				af1,
    				af2,
    				af3,
    				af4,
    				af5,
    				af6,
    				af7,
    				af8,
    				af9,
    				af10,
    				af11,
    				af12,
    				seq,
    			sub_tranx_type
    	    ) values (rtrim(v_proposal),
    	    		rtrim(v_sort_code),
    			rtrim(v_dist_craft_code),
    			rtrim(v_dist_sub_ledger),
    			rtrim(v_dist_funding_code),
    			rtrim(v_dist_sub_code),
    			rtrim(v_dist_offsetfunding_code),
    			rtrim(v_dist_offsetsub_code),
    			rtrim(v_dist_company_c),
    			rtrim(v_dist_dept_c),
    			rtrim(v_dist_oc_c),
    			v_dist_sub_percent,
    			v_dist_sub_amount,
    			v_dist_enc_amount,
    			rtrim(v_dist_region_code),
    			rtrim(v_dist_fac_id),
    			rtrim(v_dist_bldg),
    			v_dist_precedence,
    			v_dist_fixed_actual,
    			v_dist_charged_amount,
    			v_dist_expire_date,
    			v_dist_start_date,
    			rtrim(v_dist_locked_dist),
    			rtrim(v_dist_af1),
    			rtrim(v_dist_af2),
    			rtrim(v_dist_af3),
    			rtrim(v_dist_af4),
    			rtrim(v_dist_af5),
    			rtrim(v_dist_af6),
    			rtrim(v_dist_af7),
    			rtrim(v_dist_af8),
    			rtrim(v_dist_af9),
    			rtrim(v_dist_af10),
    			rtrim(v_dist_af11),
    			rtrim(v_dist_af12),
    			v_seq,
        		v_dist_sub_tranx_type
    		    );
    end loop;
    close c_cust_dist;
end if;
if v_default_dist = 'P' and v_dist_loaded <> 'Y' then
    open c_pro_bldg(v_proposal);
    fetch c_pro_bldg into v_region_code, v_fac_id, v_bldg;
    close c_pro_bldg;
    open c_bldg_dist(v_region_code, v_fac_id, v_bldg);
    loop
        fetch c_bldg_dist into v_dist_craft_code,
    		v_dist_sub_ledger,
    		v_dist_funding_code,
    		v_dist_sub_code,
    		v_dist_offsetfunding_code,
    		v_dist_offsetsub_code,
    		v_dist_company_c,
    		v_dist_dept_c,
    		v_dist_oc_c,
    		v_dist_sub_percent,
    		v_dist_sub_amount,
    		v_dist_enc_amount,
    		v_dist_region_code,
    		v_dist_fac_id,
    		v_dist_bldg,
    		v_dist_precedence,
    		v_dist_fixed_actual,
    		v_dist_charged_amount,
    		v_dist_expire_date,
    		v_dist_start_date,
    		v_dist_locked_dist,
    		v_dist_af1,
    		v_dist_af2,
    		v_dist_af3,
    		v_dist_af4,
    		v_dist_af5,
    		v_dist_af6,
    		v_dist_af7,
    		v_dist_af8,
    		v_dist_af9,
    		v_dist_af10,
    		v_dist_af11,
    		v_dist_af12,
    		v_dist_seq;
        exit when c_bldg_dist%notfound;
        v_reload_dist_flag := 'Y';
    	v_seq := v_seq + 1;
	    insert into ae_p_phs_c(proposal,
	    			sort_code,
				craft_code,
				sub_ledger,
				funding_code,
				sub_code,
				offsetfunding_code,
				offsetsub_code,
				company_c,
				dept_c,
				oc_c,
				sub_percent,
				sub_amount,
				enc_amount,
				region_code,
				fac_id,
				bldg,
				precedence,
				fixed_actual,
				charged_amount,
				expire_date,
				start_date,
				locked_dist,
				af1,
				af2,
				af3,
				af4,
				af5,
				af6,
				af7,
				af8,
				af9,
				af10,
				af11,
				af12,
				seq,
			sub_tranx_type
	    ) values (rtrim(v_proposal),
	    		rtrim(v_sort_code),
			rtrim(v_dist_craft_code),
			rtrim(v_dist_sub_ledger),
			rtrim(v_dist_funding_code),
			rtrim(v_dist_sub_code),
			rtrim(v_dist_offsetfunding_code),
			rtrim(v_dist_offsetsub_code),
			rtrim(v_dist_company_c),
			rtrim(v_dist_dept_c),
			rtrim(v_dist_oc_c),
			v_dist_sub_percent,
			v_dist_sub_amount,
			v_dist_enc_amount,
			rtrim(v_dist_region_code),
			rtrim(v_dist_fac_id),
			rtrim(v_dist_bldg),
			v_dist_precedence,
			rtrim(v_dist_fixed_actual),
			v_dist_charged_amount,
			v_dist_expire_date,
			v_dist_start_date,
			rtrim(v_dist_locked_dist),
			rtrim(v_dist_af1),
			rtrim(v_dist_af2),
			rtrim(v_dist_af3),
			rtrim(v_dist_af4),
			rtrim(v_dist_af5),
			rtrim(v_dist_af6),
			rtrim(v_dist_af7),
			rtrim(v_dist_af8),
			rtrim(v_dist_af9),
			rtrim(v_dist_af10),
			rtrim(v_dist_af11),
			rtrim(v_dist_af12),
			v_seq,
		v_dist_sub_tranx_type
		    );
    end loop;
    close c_bldg_dist;
end if;
if v_default_dist = 'S' and v_dist_loaded <> 'Y' then
    open c_phase_shop(v_proposal, v_sort_code);
    fetch c_phase_shop into v_shop;
    close c_phase_shop;
    open c_shop_dist(v_shop);
    loop
        fetch c_shop_dist into v_dist_craft_code,
			v_dist_sub_ledger,
			v_dist_funding_code,
			v_dist_sub_code,
			v_dist_offsetfunding_code,
			v_dist_offsetsub_code,
			v_dist_company_c,
			v_dist_dept_c,
			v_dist_oc_c,
			v_dist_sub_percent,
			v_dist_sub_amount,
			v_dist_enc_amount,
			v_dist_region_code,
			v_dist_fac_id,
			v_dist_bldg,
			v_dist_precedence,
			v_dist_fixed_actual,
			v_dist_charged_amount,
			v_dist_expire_date,
			v_dist_start_date,
			v_dist_locked_dist,
			v_dist_af1,
			v_dist_af2,
			v_dist_af3,
			v_dist_af4,
			v_dist_af5,
			v_dist_af6,
			v_dist_af7,
			v_dist_af8,
			v_dist_af9,
			v_dist_af10,
			v_dist_af11,
			v_dist_af12,
			v_dist_seq;
		exit when c_shop_dist%notfound;
    	v_reload_dist_flag := 'Y';
	    v_seq := v_seq + 1;
	    insert into ae_p_phs_c(proposal,
	    			sort_code,
				craft_code,
				sub_ledger,
				funding_code,
				sub_code,
				offsetfunding_code,
				offsetsub_code,
				company_c,
				dept_c,
				oc_c,
				sub_percent,
				sub_amount,
				enc_amount,
				region_code,
				fac_id,
				bldg,
				precedence,
				fixed_actual,
				charged_amount,
				expire_date,
				start_date,
				locked_dist,
				af1,
				af2,
				af3,
				af4,
				af5,
				af6,
				af7,
				af8,
				af9,
				af10,
				af11,
				af12,
				seq,
			sub_tranx_type
	    ) values (rtrim(v_proposal),
	    		rtrim(v_sort_code),
			rtrim(v_dist_craft_code),
			rtrim(v_dist_sub_ledger),
			rtrim(v_dist_funding_code),
			rtrim(v_dist_sub_code),
			rtrim(v_dist_offsetfunding_code),
			rtrim(v_dist_offsetsub_code),
			rtrim(v_dist_company_c),
			rtrim(v_dist_dept_c),
			rtrim(v_dist_oc_c),
			v_dist_sub_percent,
			v_dist_sub_amount,
			v_dist_enc_amount,
			rtrim(v_dist_region_code),
			rtrim(v_dist_fac_id),
			rtrim(v_dist_bldg),
			v_dist_precedence,
			rtrim(v_dist_fixed_actual),
			v_dist_charged_amount,
			v_dist_expire_date,
			v_dist_start_date,
			rtrim(v_dist_locked_dist),
			rtrim(v_dist_af1),
			rtrim(v_dist_af2),
			rtrim(v_dist_af3),
			rtrim(v_dist_af4),
			rtrim(v_dist_af5),
			rtrim(v_dist_af6),
			rtrim(v_dist_af7),
			rtrim(v_dist_af8),
			rtrim(v_dist_af9),
			rtrim(v_dist_af10),
			rtrim(v_dist_af11),
			rtrim(v_dist_af12),
			v_seq,
		v_dist_sub_tranx_type
		    );
    end loop;
    close c_shop_dist;
end if;
if v_default_dist = 'E' and v_dist_loaded <> 'Y' then
    open c_phase_equipment(v_proposal, v_serial_no);
    fetch c_phase_equipment into v_part, v_serial_no;
    close c_phase_equipment;
    open c_equipment_dist( v_part, v_serial_no);
    loop
        fetch c_equipment_dist into v_dist_craft_code,
			v_dist_sub_ledger,
			v_dist_funding_code,
			v_dist_sub_code,
			v_dist_offsetfunding_code,
			v_dist_offsetsub_code,
			v_dist_company_c,
			v_dist_dept_c,
			v_dist_oc_c,
			v_dist_sub_percent,
			v_dist_sub_amount,
			v_dist_enc_amount,
			v_dist_region_code,
			v_dist_fac_id,
			v_dist_bldg,
			v_dist_precedence,
			v_dist_fixed_actual,
			v_dist_charged_amount,
			v_dist_expire_date,
			v_dist_start_date,
			v_dist_locked_dist,
			v_dist_af1,
			v_dist_af2,
			v_dist_af3,
			v_dist_af4,
			v_dist_af5,
			v_dist_af6,
			v_dist_af7,
			v_dist_af8,
			v_dist_af9,
			v_dist_af10,
			v_dist_af11,
			v_dist_af12,
			v_dist_seq;
	    exit when c_equipment_dist%notfound;
    	v_reload_dist_flag := 'Y';
	    v_seq := v_seq + 1;
	    insert into ae_p_phs_c(proposal,
	    			sort_code,
				craft_code,
				sub_ledger,
				funding_code,
				sub_code,
				offsetfunding_code,
				offsetsub_code,
				company_c,
				dept_c,
				oc_c,
				sub_percent,
				sub_amount,
				enc_amount,
				region_code,
				fac_id,
				bldg,
				precedence,
				fixed_actual,
				charged_amount,
				expire_date,
				start_date,
				locked_dist,
				af1,
				af2,
				af3,
				af4,
				af5,
				af6,
				af7,
				af8,
				af9,
				af10,
				af11,
				af12,
				seq,
			sub_tranx_type
	    ) values (rtrim(v_proposal),
	    		rtrim(v_sort_code),
			rtrim(v_dist_craft_code),
			rtrim(v_dist_sub_ledger),
			rtrim(v_dist_funding_code),
			rtrim(v_dist_sub_code),
			rtrim(v_dist_offsetfunding_code),
			rtrim(v_dist_offsetsub_code),
			rtrim(v_dist_company_c),
			rtrim(v_dist_dept_c),
			rtrim(v_dist_oc_c),
			v_dist_sub_percent,
			v_dist_sub_amount,
			v_dist_enc_amount,
			rtrim(v_dist_region_code),
			rtrim(v_dist_fac_id),
			rtrim(v_dist_bldg),
			v_dist_precedence,
			rtrim(v_dist_fixed_actual),
			v_dist_charged_amount,
			v_dist_expire_date,
			v_dist_start_date,
			rtrim(v_dist_locked_dist),
			rtrim(v_dist_af1),
			rtrim(v_dist_af2),
			rtrim(v_dist_af3),
			rtrim(v_dist_af4),
			rtrim(v_dist_af5),
			rtrim(v_dist_af6),
			rtrim(v_dist_af7),
			rtrim(v_dist_af8),
			rtrim(v_dist_af9),
			rtrim(v_dist_af10),
			rtrim(v_dist_af11),
			rtrim(v_dist_af12),
			v_seq,
		v_dist_sub_tranx_type
		    );
    end loop;
    close c_equipment_dist;
end if;
open c_flag_128;
fetch c_flag_128 into v_flag_128;
close c_flag_128;
if rtrim(v_flag_128) = '' then
    v_flag_128 := null;
end if;
if rtrim(v_flag_128) = 'Y' then
       open c_phase_shop(v_proposal, v_sort_code);
       fetch c_phase_shop into v_shop;
       close c_phase_shop;
      open c_shop_acct( v_shop );
      fetch c_shop_acct into v_dist_offsetfunding_code,  v_dist_offsetsub_code;
      close c_shop_acct;
       if rtrim(v_dist_offsetsub_code) = '' then
            v_dist_offsetsub_code := null;
       end if;
       if v_dist_offsetsub_code is not null then
            update ae_p_phs_c
               set offsetfunding_code = v_dist_offsetfunding_code,
                   offsetsub_code = v_dist_offsetsub_code
             where proposal = v_proposal
               and sort_code = v_sort_code
               and (locked_dist <> 'Y'
                or  locked_dist is null);
       else
            update ae_p_phs_c
               set offsetfunding_code = v_dist_offsetfunding_code
             where proposal = v_proposal
               and sort_code = v_sort_code
               and (locked_dist <> 'Y'
                or  locked_dist is null);
   end if;
end if;
*/
null;
end;
/


create or replace procedure MFM_BO_AE_P_PHS_E(v_proposal             varchar,
    v_sort_code            varchar,
    v_login                varchar,
    v_insertrow            varchar,
    v_wr_ref                    varchar,
    v_wr_requestor              varchar,
    v_wr_region_code            varchar,
    v_wr_fac_id                 varchar,
    v_wr_bldg                   varchar,
    v_wr_edit_date           date,
    v_wr_order_type                varchar,
    v_in_wr_category            varchar,
    v_in_old_phase_shop         varchar,
    v_in_old_phase_status_code       varchar,
    v_in_old_phase_pri_code     varchar,
    v_in_old_phase_default_dist varchar,
    v_pda_edit_date             date)
as
    v_wr_category            ae_p_pro_e.category%type;
    v_old_phase_shop         ae_p_phs_e.shop%type;
    v_old_phase_status_code       ae_p_phs_e.status_code%type;
    v_old_phase_pri_code     ae_p_phs_e.pri_code%type;
    v_old_phase_default_dist ae_p_phs_e.default_dist%type;
        v_edit_date date;
        v_tot_hrs ae_p_phs_e.tot_hrs%type;
        v_tot_lab ae_p_phs_e.tot_lab%type;
        v_tot_mat ae_p_phs_e.tot_mat%type;
        v_tot_eqp ae_p_phs_e.tot_eqp%type;
        v_tot_oth ae_p_phs_e.tot_oth%type;
        v_tot_ext ae_p_phs_e.tot_oth%type;
        v_requestor ae_p_pro_e.requestor%type;
        v_company_o ae_p_pro_e.company_id%type;
        v_dept_o ae_p_pro_e.dept_id%type;
        v_oc_o ae_p_pro_e.oc_code%type;
        v_status_code ae_p_pro_e.status_code%type;
        v_default_dist varchar(1);
	    v_seq numeric(5,0);
        v_dist_count int;
        v_default_dist_flag  varchar(1);
        v_con_status_code      ae_p_pro_e.status_code%type;
        v_con_default_dist     varchar(1);
        v_con_ref              ae_p_pro_e.project%type;
	    v_con_enforce_dist_yn varchar(1);
        v_rowcount           int;
        v_category           ae_p_pro_e.category%type;
        v_message            varchar(1000);
        v_con_wr_status_code ae_p_pro_e.status_code%type;
        v_con_complete_yn    varchar(1);
        v_end_dt             date;
        cursor c_proposal(v_proposal ae_p_pro_e.proposal%type) is
            select requestor,
                    category,
                    status_code
               from ae_p_pro_e
              where proposal = v_proposal;
        cursor c_proposal_status(v_order_type ae_p_sta_e.order_type%type,
                                 v_category ae_p_sta_c.category%type,
                                 v_status_code ae_p_sta_c.status_code%type) is
            select complete_yn
              from ae_p_sta_c
             where order_type = v_order_type
               and category = v_category
               and status_code = v_status_code;
        cursor c_company(v_requestor ae_s_usr_d.requestor%type) is
             select company_id,
                    dept_id,
                    oc_code
               from ae_s_usr_d
              where requestor = v_requestor;
    cursor c_phase(v_proposal ae_p_phs_e.proposal%type,
                    v_sort_code ae_p_phs_e.sort_code%type) is
         select status_code,
                default_dist
           from ae_p_phs_e
          where proposal = v_proposal
            and sort_code = v_sort_code;

    cursor c_phase_status(v_order_type ae_p_pro_e.order_type%type,
                            v_category ae_p_pro_e.category%type,
                            v_phase_status ae_p_phs_e.status_code%type) is
        select complete_yn
          from ae_p_pst_c
         where order_type = v_order_type
           and category = v_category
           and status_code = v_phase_status;
        cursor c_end_dt_not_null(v_proposal ae_p_phs_e.proposal%type) is
            select max(end_dt)
              from ae_p_phs_e
             where proposal = v_proposal;
begin
    v_wr_category := v_in_wr_category;
    v_old_phase_shop := v_in_old_phase_shop;
    v_old_phase_status_code := v_in_old_phase_status_code;
    v_old_phase_pri_code := v_in_old_phase_pri_code;
    v_old_phase_default_dist := v_in_old_phase_default_dist;
    v_edit_date := sysdate;
    open c_proposal(v_proposal);
    fetch c_proposal into v_requestor, v_category, v_con_wr_status_code;
    close c_proposal;
    open c_proposal_status(v_wr_order_type, v_category, v_con_wr_status_code);
    fetch c_proposal_status into v_con_complete_yn;
    close c_proposal_status;
    if v_con_complete_yn = 'Y' then
        raise_application_error(-20000, 'WR is closed, Skipping Record');
    end if;
    open c_end_dt_not_null(v_proposal);
    fetch c_end_dt_not_null into v_end_dt;
    close c_end_dt_not_null;
    open c_phase(v_proposal, v_sort_code);
    fetch c_phase into v_status_code, v_default_dist;
    close c_phase;
    if v_insertrow <> 'Y' then
        open c_phase_status(v_wr_order_type, v_category, v_old_phase_status_code);
        fetch c_phase_status into v_con_complete_yn;
        close c_phase_status;
        if v_con_complete_yn = 'Y' then
            raise_application_error(-20000, 'Phase is closed, Skipping Record');
        end if;
    end if;
end;
/


create or replace procedure MFM_BO_AE_P_PHS_E_STATUS(v_proposal             varchar,
    v_sort_code             varchar,
    v_login                varchar,
    v_order_type                varchar,
    v_category            varchar,
    v_status_code       varchar,
    v_result                out integer)
as
    v_old_status_code       ae_p_phs_e.status_code%type;
    v_min_code              int;
    v_max_code              int;
        v_rowcount           int;
        v_message            varchar(1000);
        cursor c_count(v_proposal ae_p_pro_e.proposal%type,
                        v_sort_code ae_p_phs_e.sort_code%type) is
            select count(*)
               from ae_p_phs_e
              where proposal = v_proposal
                and sort_code = v_sort_code;
        cursor c_old_status(v_proposal ae_p_pro_e.proposal%type,
                        v_sort_code ae_p_phs_e.sort_code%type) is
            select status_code
               from ae_p_phs_e
              where proposal = v_proposal
                and sort_code = v_sort_code;
        cursor c_status_security_count(v_order_type ae_p_pro_e.order_type%type,
                                            v_category ae_p_pro_e.category%type,
                                            v_status ae_p_phs_e.status_code%type) is
                select count(*)
                  from ae_p_pst_d
                 where status_code = v_status
                   and category = v_category
                   and order_type = v_order_type;
        cursor c_status_security_user(v_order_type ae_p_pro_e.order_type%type,
                                            v_category ae_p_pro_e.category%type,
                                            v_status ae_p_phs_e.status_code%type,
                                            v_login ae_authz_principal.login%type) is
                select count(*)
                  from ae_p_pst_d, ae_authz_principal, ae_authz
                 where ae_p_pst_d.status_code = v_status
                   and ae_p_pst_d.category = v_category
                   and ae_p_pst_d.order_type = v_order_type
                   and upper(ae_authz_principal.login) = upper(v_login)
                   and ae_authz_principal.role_id = ae_p_pst_d.role_id
                   and ae_authz.role_id = ae_authz_principal.role_id
                   and ae_authz.active = 'Y'
                   ;
        cursor c_status_active_flag(v_order_type ae_p_pro_e.order_type%type,
                                            v_category ae_p_pro_e.category%type,
                                            v_status ae_p_phs_e.status_code%type) is
                select active, min_code, max_code
                  from ae_p_pst_c
                 where status_code = v_status
                   and category = v_category
                   and order_type = v_order_type;
        cursor c_status_seq(v_order_type ae_p_pro_e.order_type%type,
                                            v_category ae_p_pro_e.category%type,
                                            v_status ae_p_phs_e.status_code%type) is
                select seq
                  from ae_p_pst_c
                 where status_code = v_status
                   and category = v_category
                   and order_type = v_order_type;
       v_active     ae_p_sta_c.active%type;
       v_new_seq    int;
       v_min_seq    int;
       v_max_seq    int;
       v_old_min_status_code       ae_p_phs_e.status_code%type;
       v_old_max_status_code       ae_p_phs_e.status_code%type;

begin
    v_result := 1;

    open c_count(v_proposal, v_sort_code);
    fetch c_count into v_rowcount;
    close c_count;

    if v_rowcount = 1 then

        open c_old_status(v_proposal, v_sort_code);
        fetch c_old_status into v_old_status_code;
        close c_old_status;
    else
        v_old_status_code := null;
    end if;

    open c_status_active_flag(v_order_type, v_category, v_status_code);
    fetch c_status_active_flag into v_active, v_old_min_status_code, v_old_max_status_code;
    close c_status_active_flag;

    if v_active <> 'Y' then
        v_message := rtrim(v_status_code) || ' is not active for WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code) || ', Skipping Record';
        raise_application_error(-20000, v_message);
    end if;


    if (rtrim(v_status_code) <> rtrim(v_old_status_code)) or (v_old_status_code is null) then


        open c_status_security_count(v_order_type, v_category, v_status_code);
        fetch c_status_security_count into v_rowcount;
        close c_status_security_count;
        if v_rowcount > 0 then
            open c_status_security_user(v_order_type, v_category, v_status_code, v_login);
            fetch c_status_security_user into v_rowcount;
            close c_status_security_user;
            if v_rowcount = 0 then
                v_message := rtrim(v_login) || ' do not have access to change to status ' || rtrim(v_status_code) || ' for WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code) || ', Skipping Record';
                raise_application_error(-20000, v_message);
            end if;
        end if;
    end if;

    if (rtrim(v_status_code) <> rtrim(v_old_status_code)) or (v_old_status_code is not null) then

        open c_status_active_flag(v_order_type, v_category, v_old_status_code);
        fetch c_status_active_flag into v_active, v_old_min_status_code, v_old_max_status_code;
        close c_status_active_flag;

        open c_status_seq(v_order_type, v_category, v_status_code);
        fetch c_status_seq into v_new_seq;
        close c_status_seq;

        if v_old_min_status_code is null or v_old_min_status_code = '' then
            v_min_seq := null;
        else
            open c_status_seq(v_order_type, v_category, v_old_min_status_code);
            fetch c_status_seq into v_min_seq;
            close c_status_seq;
        end if;

        if v_old_max_status_code is null or v_old_max_status_code = '' then
            v_max_seq := null;
        else
            open c_status_seq(v_order_type, v_category, v_old_max_status_code);
            fetch c_status_seq into v_max_seq;
            close c_status_seq;
        end if;


        if v_min_seq is not null then
            if v_new_seq < v_min_seq then
                v_message := rtrim(v_status_code) || ' is not valid for min/max status range of ' || v_old_status_code || ' for WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code) || ', Skipping Record';
                raise_application_error(-20000, v_message);
            end if;
        end if;
        if v_max_seq is not null then
            if v_new_seq > v_max_seq then
                v_message := rtrim(v_status_code) || ' is not valid for min/max status range of ' || v_old_status_code || ' for WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code) || ', Skipping Record';
                raise_application_error(-20000, v_message);
            end if;
        end if;
    end if;


end;
/


create or replace procedure MFM_BO_AE_P_PRO_E_STATUS(v_proposal             varchar,
    v_login                varchar,
    v_order_type                varchar,
    v_category            varchar,
    v_status_code       varchar,
    v_result                out integer)
as
    v_old_status_code       ae_p_phs_e.status_code%type;
        v_rowcount           int;
        v_message            varchar(1000);
        cursor c_count(v_proposal ae_p_pro_e.proposal%type) is
            select count(*)
               from ae_p_pro_e
              where proposal = v_proposal;
        cursor c_old_status(v_proposal ae_p_pro_e.proposal%type) is
            select status_code
               from ae_p_pro_e
              where proposal = v_proposal;
        cursor c_status_security_count(v_order_type ae_p_pro_e.order_type%type,
                                            v_category ae_p_pro_e.category%type,
                                            v_status ae_p_phs_e.status_code%type) is
                select count(*)
                  from ae_p_sta_d
                 where status_code = v_status
                   and order_type = v_order_type
                   and category = v_category;
        cursor c_status_security_user(v_order_type ae_p_pro_e.order_type%type,
                                            v_category ae_p_pro_e.category%type,
                                            v_status ae_p_phs_e.status_code%type,
                                            v_role_id ae_s_sec_c.login%type) is
                select count(*)
                  from ae_p_sta_d, ae_authz_principal, ae_authz
                 where ae_p_sta_d.status_code = v_status
                   and ae_p_sta_d.order_type = v_order_type
                   and ae_p_sta_d.category = v_category
                   and ae_p_sta_d.role_id = ae_authz_principal.role_id
                   and ae_authz_principal.role_id = ae_authz.role_id
                   and ae_authz.active = 'Y'
                   and upper(ae_authz_principal.login) = upper(v_login);
        cursor c_status_active_flag(v_order_type ae_p_pro_e.order_type%type,
                                            v_category ae_p_pro_e.category%type,
                                            v_status ae_p_phs_e.status_code%type) is
                select active, min_code, max_code
                  from ae_p_sta_c
                 where status_code = v_status
                   and order_type = v_order_type
                   and category = v_category;
        cursor c_status_seq(v_order_type ae_p_pro_e.order_type%type,
                                            v_category ae_p_pro_e.category%type,
                                            v_status ae_p_pro_e.status_code%type) is
                select seq
                  from ae_p_sta_c
                 where status_code = v_status
                   and category = v_category
                   and order_type = v_order_type;
       v_active     ae_p_sta_c.active%type;
       v_new_seq    int;
       v_min_seq    int;
       v_max_seq    int;
       v_old_min_status_code       ae_p_phs_e.status_code%type;
       v_old_max_status_code       ae_p_phs_e.status_code%type;

begin

    open c_count(v_proposal);
    fetch c_count into v_rowcount;
    close c_count;

    if v_rowcount = 1 then

        open c_old_status(v_proposal);
        fetch c_old_status into v_old_status_code;
        close c_old_status;
    else
        v_old_status_code := null;
    end if;

    open c_status_active_flag(v_order_type, v_category, v_status_code);
    fetch c_status_active_flag into v_active, v_old_min_status_code, v_old_max_status_code;
    close c_status_active_flag;

    if v_active <> 'Y' then
        v_message := rtrim(v_status_code) || ' is not active for WR ' || rtrim(v_proposal) || ', Skipping Record';
        raise_application_error(-20000, v_message);
    end if;

    if (rtrim(v_status_code) <> rtrim(v_old_status_code)) or (v_old_status_code is null) then

        if (v_old_status_code is not null) then
            open c_status_active_flag(v_order_type, v_category, v_old_status_code);
            fetch c_status_active_flag into v_active, v_old_min_status_code, v_old_max_status_code;
            close c_status_active_flag;

            open c_status_seq(v_order_type, v_category, v_status_code);
            fetch c_status_seq into v_new_seq;
            close c_status_seq;

            if v_old_min_status_code is null or v_old_min_status_code = '' then
                v_min_seq := null;
            else
                open c_status_seq(v_order_type, v_category, v_old_min_status_code);
                fetch c_status_seq into v_min_seq;
                close c_status_seq;
            end if;

            if v_old_max_status_code is null or v_old_max_status_code = '' then
                v_max_seq := null;
            else
                open c_status_seq(v_order_type, v_category, v_old_max_status_code);
                fetch c_status_seq into v_max_seq;
                close c_status_seq;
            end if;


            if v_min_seq is not null then
                if v_new_seq < v_min_seq then
                    v_message := rtrim(v_status_code) || ' is not valid for min/max status range of ' || v_old_status_code || ' for WR ' || rtrim(v_proposal) || ', Skipping Record';
                    raise_application_error(-20000, v_message);
                end if;
            end if;
            if v_max_seq is not null then
                if v_new_seq > v_max_seq then
                    v_message := rtrim(v_status_code) || ' is not valid for min/max status range of ' || v_old_status_code || ' for WR ' || rtrim(v_proposal) || ', Skipping Record';
                    raise_application_error(-20000, v_message);
                end if;
            end if;
        end if;

        open c_status_security_count(v_order_type, v_category, v_status_code);
        fetch c_status_security_count into v_rowcount;
        close c_status_security_count;
        if v_rowcount > 0 then
            open c_status_security_user(v_order_type, v_category, v_status_code, v_login);
            fetch c_status_security_user into v_rowcount;
            close c_status_security_user;
            if v_rowcount = 0 then
                v_message := rtrim(v_login) || ' do not have access to change to status ' || rtrim(v_status_code) || ' for WR ' || rtrim(v_proposal) || ', Skipping Record';
                raise_application_error(-20000, v_message);
            end if;
        end if;
    end if;

end;
/


create or replace procedure MFM_BO_WR_PHASE_OPEN(v_source_message        varchar,
    v_proposal             varchar,
    v_sort_code            varchar,
    v_return_code           out integer)
as
    v_mesg  varchar(1000);
    v_old_phase_status_code       ae_p_phs_e.status_code%type;
        v_con_complete_yn    varchar(1);
        v_wr_count  integer;
        cursor c_proposal_count(v_proposal ae_p_pro_e.proposal%type) is
            select count(*)
      from ae_p_pro_e
     where ae_p_pro_e.proposal = v_proposal;
        cursor c_proposal_status(v_proposal ae_p_pro_e.proposal%type) is
            select complete_yn
      from ae_p_sta_c, ae_p_pro_e
     where ae_p_sta_c.category = ae_p_pro_e.category
       and ae_p_sta_c.order_type = ae_p_pro_e.order_type
       and ae_p_sta_c.status_code = ae_p_pro_e.status_code
       and ae_p_pro_e.proposal = v_proposal;
    cursor c_phase_status(v_proposal ae_p_pro_e.proposal%type,
                            v_sort_code ae_p_phs_e.sort_code%type) is
             select complete_yn
              from ae_p_pst_c, ae_p_pro_e, ae_p_phs_e
                 where ae_p_pst_c.category = ae_p_pro_e.category
                   and ae_p_pst_c.order_type = ae_p_pro_e.order_type
                   and ae_p_pst_c.status_code = ae_p_phs_e.status_code
                   and ae_p_pro_e.proposal = ae_p_phs_e.proposal
                   and ae_p_pro_e.proposal = v_proposal
                   and ae_p_phs_e.sort_code = v_sort_code;

begin

    v_return_code := 1;

    v_wr_count := null;
    open c_proposal_count(v_proposal);
    fetch c_proposal_count into v_wr_count;
    close c_proposal_count;

    if v_wr_count is null or v_wr_count = 0 then
        v_mesg := 'WR ' || rtrim(v_proposal) || ' does not exist, Skipping Record ' || v_source_message;
        raise_application_error(-20000, v_mesg);
        v_return_code := -1;
        return;
    end if;

    open c_proposal_status(v_proposal);
    fetch c_proposal_status into v_con_complete_yn;
    close c_proposal_status;

    if v_con_complete_yn = 'Y' then
        v_mesg := 'WR ' || rtrim(v_proposal) || ' is closed, Skipping Record ' || v_source_message;
        raise_application_error(-20000, v_mesg);
        v_return_code := -1;
        return;
    end if;

    open c_phase_status(v_proposal, v_sort_code);
    fetch c_phase_status into v_con_complete_yn;
    close c_phase_status;

    if v_con_complete_yn = 'Y' then
        v_mesg := 'WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code) || ' is closed, Skipping Record ' || v_source_message;
        raise_application_error(-20000, v_mesg);
        v_return_code := -1;
        return;
    end if;

end;
/


create or replace procedure MFM_CHECK_PROPOSAL_XREF(v_login varchar,
    v_pda_id varchar,
    v_mfm_proposal ae_p_pro_e.proposal%TYPE,
    v_con_proposal in out ae_p_pro_e.proposal%TYPE)
as
        v_message            varchar(80);
        v_error_bak          int;
        v_rowcount_bak       int;
        v_xref_count         int;
        cursor c_xref_count(v_login mfm_proposal_xref.login%type,
                            v_pda_id mfm_proposal_xref.pda_id%type,
                            v_mfm_proposal mfm_proposal_xref.mfm_proposal%type) is
           select count(*)
             from mfm_proposal_xref
             where upper(login) = upper(v_login)
               and rtrim(pda_id) = rtrim(v_pda_id)
               and mfm_proposal = v_mfm_proposal;
        cursor c_xref(v_login mfm_proposal_xref.login%type,
                            v_pda_id mfm_proposal_xref.pda_id%type,
                            v_mfm_proposal mfm_proposal_xref.mfm_proposal%type) is
           select proposal
             from mfm_proposal_xref
             where upper(login) = upper(v_login)
               and rtrim(pda_id) = rtrim(v_pda_id)
               and mfm_proposal = v_mfm_proposal;
begin

    open c_xref_count( v_login, v_pda_id, v_mfm_proposal);
    fetch c_xref_count into v_xref_count;
    close c_xref_count;

    if v_xref_count = 0 then
        v_con_proposal := rtrim(v_mfm_proposal);
    else
        open c_xref( v_login, v_pda_id, v_mfm_proposal);
        fetch c_xref into v_con_proposal;
        close c_xref;
    end if;

end;
/


create or replace procedure MFM_CHECK_SHOP(v_security_status in out integer,
    v_in_shop varchar)
as
	    v_shop_active 		ae_l_shp_e.active%type;

		cursor c_shop_active(v_shop ae_l_shp_e.shop%type) is
			select active
			  from ae_l_shp_e
			 where upper(shop) = upper(v_shop);
        v_message       varchar(1000);
begin

v_security_status := 0;

if v_in_shop is null or rtrim(v_in_shop) = '' then
    v_security_status := 1;
	return;
end if;

open c_shop_active(v_in_shop);
fetch c_shop_active into v_shop_active;
if c_shop_active%notfound then
    v_message := 'MFM_CHECK_SHOP, Shop ' || rtrim(v_in_shop) || ' is not found in ae_l_shp_e.';
	raise_application_error(-20000, v_message);
	return;
end if;
close c_shop_active;

if upper(rtrim(v_shop_active)) = 'Y' then
    v_security_status := 1;
	return;
end if;

v_message := 'Shop ' || rtrim(v_in_shop) || ' is not not active, Skipping Record.';
raise_application_error(-20000, v_message);
v_security_status := 0;

return;

end;
/


create or replace procedure MFM_CHECK_SHOP_BY_WR_PHASE(v_security_status in out integer,
    v_in_wr varchar,
    v_in_phase varchar)
as
	    v_shop 		ae_l_shp_e.shop%type;

		cursor c_phase_shop(v_wr ae_p_phs_e.proposal%type,
                            v_phase ae_p_phs_e.sort_code%type) is
			select shop
			  from ae_p_phs_e
			 where proposal = v_wr
               and sort_code = v_phase;
        v_message       varchar(1000);
begin

v_security_status := 0;

if v_in_phase is null or rtrim(v_in_phase) = '' then
    v_message := 'MFM_CHECK_SHOP_BY_WR_PHASE, Phase field is empty';
    raise_application_error(-20000, v_message);
	return;
end if;

open c_phase_shop(v_in_wr, v_in_phase);
fetch c_phase_shop into v_shop;
if c_phase_shop%notfound then
    v_message := 'MFM_CHECK_SHOP_BY_WR_PHASE, WR ' || rtrim(v_in_wr) || ' Phase ' || rtrim(v_in_phase) ||' is not found, Skipping Record';
	raise_application_error(-20000, v_message);
	return;
end if;
close c_phase_shop;


mfm_check_shop( v_security_status, v_shop);

return;

end;
/


create or replace procedure MFM_GEN_TRANSACTION_NUMBER(v_tranx_type ae_s_ctl_c.tranx_type%type,
    v_tranx_num in out ae_s_ctl_c.tranx_num%type)
as
    pragma autonomous_transaction;
    v_message	varchar(80);
	v_rowcount numeric(8,0);
  cursor c_trans_gen_count(v_tranx_type ae_s_ctl_c.tranx_type%type) is
        select count(*)
          from ae_s_ctl_c
         where tranx_type = v_tranx_type;
  cursor c_trans_gen(v_tranx_type ae_s_ctl_c.tranx_type%type) is
        select tranx_num
          from ae_s_ctl_c
         where tranx_type = v_tranx_type
         for update of tranx_num;
begin

v_tranx_num := 0;

open c_trans_gen_count(v_tranx_type);
fetch c_trans_gen_count into v_rowcount;
close c_trans_gen_count;

if v_rowcount = 0 then
	insert into ae_s_ctl_c (tranx_type, tranx_num) values (v_tranx_type, v_tranx_num);
end if;

open c_trans_gen (v_tranx_type);

fetch c_trans_gen into v_tranx_num;
v_tranx_num := v_tranx_num + 1;
update ae_s_ctl_c
   set tranx_num = v_tranx_num
 where current of c_trans_gen;

close c_trans_gen;
commit work;

end;
/


create or replace procedure MFM_GEN_TRANSACTION_STRING(v_tranx_type varchar,
    v_tranx_string in out varchar,
    v_region_code varchar,
    v_fac_id     varchar,
    v_order_type varchar,
    v_program_fy varchar,
    v_ent_date   date)
as
    v_message	varchar(80);
	v_rowcount_backup numeric(8,0);
    v_tranx_num numeric(8,0);
    v_format_count numeric(8,0);
    v_tranx_seq  int;
    v_tranx_column varchar(40);
    v_tranx_length int;
    v_tranx_format varchar(20);
    v_temp_tranx_string varchar(15);
    v_scratch    varchar(50);
    v_space		varchar(15);
    v_pos     int;
	cursor c_format_count(v_tranx_type ae_s_ctl_d.tranx_type%type) is
		select count(*)
		  from ae_s_ctl_d
		 where tranx_type = v_tranx_type;
	cursor c_tranx_format(v_tranx_type ae_s_ctl_d.tranx_type%type) is
	 select tranx_seq, tranx_column, tranx_length, tranx_format
	   from ae_s_ctl_d
	  where tranx_type = v_tranx_type
	  order by tranx_seq;
begin
v_space := '               ';

mfm_gen_transaction_number(v_tranx_type, v_tranx_num);

open c_format_count(v_tranx_type);
fetch c_format_count into v_format_count;
close c_format_count;

if v_format_count > 0 and (v_tranx_type = 'R' or v_tranx_type = 'PROJECT') then

    open c_tranx_format(v_tranx_type);

    v_temp_tranx_string := '';
    loop
	    fetch c_tranx_format into v_tranx_seq, v_tranx_column, v_tranx_length, v_tranx_format;
	    exit when c_tranx_format%notfound;
        if rtrim(v_tranx_column) = '-' then
        	v_temp_tranx_string := v_temp_tranx_string || '-';
        end if;
        if rtrim(v_tranx_column) = 'ae_p_pro_e.ent_date' then
        	v_scratch := to_char(v_ent_date, 'YYMMDDHH24MISS');
            v_scratch := substr(v_scratch || v_space, 1, v_tranx_length);
            v_temp_tranx_string := v_temp_tranx_string || v_scratch;
        end if;
        if rtrim(v_tranx_column) = 'ae_p_pro_e.fac_id' then
        	v_scratch := substr(v_fac_id || v_space, 1, v_tranx_length);
            v_temp_tranx_string := v_temp_tranx_string || v_scratch;
        end if;
        if rtrim(v_tranx_column) = 'ae_p_pro_e.order_type' then
        	v_scratch := substr(v_order_type || v_space, 1, v_tranx_length);
            v_temp_tranx_string := v_temp_tranx_string || v_scratch;
        end if;
        if rtrim(v_tranx_column) = 'ae_p_pro_e.program_fy' then
        	v_scratch := substr(v_program_fy || v_space, 1, v_tranx_length);
            v_temp_tranx_string := v_temp_tranx_string || v_scratch;
        end if;
        if rtrim(v_tranx_column) = 'ae_p_pro_e.region_code' then
        	v_scratch := substr(v_region_code || v_space, 1, v_tranx_length);
            v_temp_tranx_string := v_temp_tranx_string || v_scratch;
        end if;
        if rtrim(v_tranx_column) = 'ae_s_ctl_c.tranx_num' then
        	v_scratch := to_char(v_tranx_num);
        	v_scratch := '000000000000000' || rtrim(ltrim(v_scratch));
        	v_pos := length(v_scratch) - v_tranx_length + 1;
          v_scratch := substr(v_scratch, v_pos, v_tranx_length);
          v_temp_tranx_string := v_temp_tranx_string || v_scratch;
        end if;
    end loop;
    close c_tranx_format;
	v_tranx_string := v_temp_tranx_string;
else
	 v_tranx_string := substr(('00000000' || ltrim(rtrim(to_char(v_tranx_num)) )), -1, 8);
end if;

end;
/


create or replace procedure MFM_GET_FLAG_147(v_flag out ae_s_sys_f.parameter%type)
as
		cursor c_get_flag is
			select parameter
			  from ae_s_sys_f
			 where flag_id = 147;
        v_message       varchar(1000);
begin

open c_get_flag;
fetch c_get_flag into v_flag;
if c_get_flag%notfound then
    v_flag := 0;
end if;
close c_get_flag;

if v_flag is null then
    v_flag := 0;
end if;

return;

end;
/


create or replace procedure MFM_GET_PDA_MEMORY(v_login in mfm_user_pda.login%type,
    v_memory out mfm_user_pda.memory%type)
as
		cursor c_pda_memory(v_login mfm_user_pda.login%type) is
			select memory
			  from mfm_user_pda
			 where upper(login) = upper(v_login)
			 order by memory;
        v_message       varchar(1000);
begin


if v_login is null or rtrim(v_login) = '' then
    v_message := 'MFM_GET_PDA_MEMORY, Login field is empty';
    raise_application_error(-20000, v_message);
	return;
end if;

open c_pda_memory(v_login);
fetch c_pda_memory into v_memory;
if c_pda_memory%notfound then
    v_memory := 0;
end if;
close c_pda_memory;

if v_memory is null then
    v_memory := 0;
end if;

return;

end;
/


create or replace procedure MFM_HANDLE_ERROR(v_action in out integer,
                       v_error_code integer,
                       v_error_message varchar,
                       v_user_name    varchar,
                       v_table_name   varchar)
as
                v_error_date  date;
                       v_skip_record_code    int;
begin
    v_action := 3000;
    v_skip_record_code := instr(v_error_message, 'Skipping Record');
    if v_skip_record_code > 0 then
        v_action := 1000;
     end if;
end;
/


create or replace procedure MFM_HANDLE_ODBC_ERROR(v_action in out integer,
                       v_odbc_state varchar,
                       v_error_message varchar,
                       v_user_name    varchar,
                       v_table_name   varchar)
as
                v_error_date  date;
                       v_skip_record_code    int;
begin
    v_action := 3000;
    v_skip_record_code := instr(v_error_message, 'Skipping Record');
    if v_skip_record_code > 0 then
        v_action := 1000;
     end if;
end;
/


create or replace procedure MFM_REPORT_ERROR(v_action integer,
                       v_error_code integer,
                       v_error_message varchar,
                       v_user_name    varchar,
                       v_table_name   varchar)
as
               v_error_date  date;
               v_pda_id varchar(128);
               v_error_no integer;
begin
    v_error_date := sysdate;
    v_pda_id := 'PDA_ID';
    mfm_gen_transaction_number( 'MFM_ERROR', v_error_no );
    insert into mfm_error_log(error_no, error_type, error_code, odbc_state, error_message, user_name, table_name, error_date, pda_id, action)
    values( v_error_no, 'MFM', v_error_code, null, v_error_message, v_user_name, v_table_name, v_error_date, v_pda_id, v_action);
end;
/


create or replace procedure MFM_REPORT_ODBC_ERROR(v_action in out integer,
                       v_odbc_state varchar,
                       v_error_message varchar,
                       v_user_name    varchar,
                       v_table_name   varchar)
as
                v_error_date  date;
               v_pda_id varchar(128);
               v_error_no integer;
begin
    v_error_date := sysdate;
    v_pda_id := 'PDA_ID';
    mfm_gen_transaction_number( 'MFM_ERROR', v_error_no );
    insert into mfm_error_log (error_no, error_type, error_code, odbc_state, error_message, user_name, table_name, error_date, pda_id, action)
    values( v_error_no, 'ODBC', null, v_odbc_state, v_error_message, v_user_name, v_table_name, v_error_date, v_pda_id, v_action);
end;
/


create or replace procedure MFM_SCREEN_SECURITY(v_security_status in out integer,
    v_in_login varchar,
    v_in_prompt varchar)
as
--        v_role_id           varchar(15);
--        v_error_bak          integer;
--        v_rowcount_bak       integer;
--        v_sec_logic          varchar;
        v_sec_logic_count          integer;
        v_message            varchar(100);
	    v_login 		ae_s_sec_c.login%type;
	    v_prompt 		ae_authz_privilege.privilege_id%type;

/*
		cursor c_role(v_login ae_s_sec_c.login%type) is
			select role_id
			  from ae_s_sec_c
			 where upper(login) = upper(v_login);
             */
        cursor c_security(v_login ae_s_sec_c.login%type,
                          v_privilege ae_authz_privilege.privilege_id%type) is
            select count(*)
              from ae_s_sec_c, ae_authz_principal, ae_authz_privilege, ae_authz
             where upper(ae_s_sec_c.login) = upper(v_login)
               and ae_authz_principal.login = ae_s_sec_c.login
               and ae_authz_principal.role_id = ae_authz.role_id
               and ae_authz_principal.role_id = ae_authz_privilege.role_id
               and ae_authz.active = 'Y'
               and ae_authz_privilege.privilege_id = v_privilege;
begin

v_login := v_in_login;
v_prompt := v_in_prompt;

v_security_status := 0;

if v_login is null then
   v_login := '';
end if;

if v_prompt is null then
   v_prompt := '';
end if;

if length(rtrim(v_login)) = 0 or length(rtrim(v_prompt)) = 0 then
    v_message := 'User/Pasword are invalid';
    raise_application_error(-20000, v_message);
	return;
end if;

if v_login is null or rtrim(v_login) = '' then
    v_message := 'Login field is empty, permission denied';
    raise_application_error(-20000, v_message);
	return;
end if;
/*
open c_role(v_login);
fetch c_role into v_role_id;
if c_role%notfound then
    if rtrim(v_login) = '' then
        v_login := '<blank>';
    end if;
    if v_login is null then
        v_login := '<null>';
    end if;
    v_message := 'User ' || rtrim(v_login) || ' is not known to the system.';
	raise_application_error(-20000, v_message);
	return;
end if;
close c_role;
*/
/*
if upper(rtrim(v_role_id)) = 'SUPERUSER' then
    v_security_status := 1;
	return;
end if;
*/

if rtrim(v_prompt) = '' then
    raise_application_error(-20000, 'Privilege is empty.');
	return;
end if;

open c_security(v_login, v_prompt);
fetch c_security into v_sec_logic_count;
close c_security;
if v_sec_logic_count > 0 then
    v_security_status := 1;
    return;
else
    v_message := 'User ' || rtrim(v_login) || ' do not have permissions for ' || rtrim(v_prompt) || ', Skipping Record.';
    v_security_status := 0;
    raise_application_error(-20000, v_message);
	return;
end if;

v_security_status := 0;

return;

end;
/


create or replace procedure MFM_VERSION_SECURITY(v_version_status in out integer)
as
        v_version_no           ae_s_sys_c.version_no%type;
        v_blank_pos             int;
        v_message                varchar(1000);
        v_software_version_no    varchar(15);
		cursor c_version is
			select version_no
			  from ae_s_sys_c;
begin

v_version_status := 0;
v_software_version_no := '4.0';

open c_version;
fetch c_version into v_version_no;
close c_version;

v_blank_pos := instr(v_version_no, ' ' );

if v_blank_pos > 0 then
    v_version_no := substr(v_version_no, 1, v_blank_pos);
end if;

if rtrim(v_version_no) = rtrim(v_software_version_no) then
    v_version_status := 1;
else
    v_message := 'There is a mismatch between your software and database versions.~r~nContact your system administrator~r~nDatabase Version : ' || rtrim(v_version_no) || '~r~nSoftware Version : ' || rtrim(v_software_version_no);
    raise_application_error(-20000,  v_message);
end if;

end;
/


--create or replace procedure ML_EVENTS(<arg> in out <type>) as
declare ml_script_start  varchar2(100);
        ml_script_end    varchar2(100);
        nl               varchar2(6);
        ml_script     varchar2(5000);
        ml_script_from varchar2(50);
        ml_script_where varchar2(50);
        ml_script_table varchar2(50);
        ml_script_parms varchar2(200);
        ml_script_where_active varchar2(100);
        ml_script_and_active varchar2(100);
begin
nl := ' ';
ml_script_where_active := ' where active = ''Y''';
ml_script_and_active  := ' and active = ''Y''';

ml_script := '{ call  mfm.beg_dl_wr( ?, ? ) }';
ml_add_connection_script('wr', 'begin_download', ml_script );

ml_script := '{ call  mfm.beg_dl_inv( ?, ?) }';
ml_add_connection_script('inv', 'begin_download', ml_script );

ml_script := '{ call  mfm.end_dl_wr( ?, ? ) }';
ml_add_connection_script('wr', 'end_download', ml_script );

ml_script := '{ call  mfm.end_dl_inv( ?, ? ) }';
ml_add_connection_script('inv', 'end_download', ml_script );

ml_script := '{ call  mfm.beg_dl_ae_p_pro_e_wr( ?, ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_p_pro_e', 'begin_download', ml_script );

ml_script := '{ call  mfm.beg_dl_ae_p_pro_e_inv( ?, ?, ? ) }';
ml_script := null;
ml_add_table_script('inv', 'ae_p_pro_e', 'begin_download', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_phs_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_phs_e', 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_p_phs_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_pro_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_pro_e', 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_p_pro_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_phs_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_phs_e', 'download_delete_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_p_phs_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_pro_s( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_pro_s', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_dsc_e( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_p_dsc_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_dsc_h( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_p_dsc_h', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_dsc_e( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_p_dsc_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_dsc_h( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_p_dsc_h', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_wka_e( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_p_wka_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_wka_d( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_p_wka_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_wka_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_wka_d', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_req_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_req_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_i_ptn_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_i_ptn_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_i_ptn_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_i_ptn_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_mfm_meter_reading( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'mfm_meter_reading', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_l_stock_use( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_l_stock_use', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_l_stock_use( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_l_stock_use', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_i_ext_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_i_ext_e', 'download_delete_cursor', ml_script );


ml_script := '{ call  mfm.dl_cur_ae_i_poe_e( ?, ? ) }';
ml_add_table_script('inv', 'ae_i_poe_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_i_poe_d( ?, ? ) }';
ml_add_table_script('inv', 'ae_i_poe_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_mfm_cycle_count( ?, ? ) }';
ml_add_table_script('inv', 'mfm_cycle_count', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_s_usr_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_s_usr_e', 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_s_usr_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_r_eqm_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_r_eqm_e', 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_r_eqm_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_r_eqm_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_r_eqm_e', 'download_delete_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_r_eqm_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_a_asset_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_a_asset_e', 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_a_asset_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_a_asset_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_a_asset_e', 'download_delete_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_a_asset_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.DL_CUR_AE_R_EQM_E_VIRTUAL_EQM( ?, ? ) }';
ml_add_table_script('wr', 'ae_r_eqm_e_virtual_eqm', 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_r_eqm_e_virtual_eqm', 'download_cursor', ml_script );

ml_script := '{ call  mfm.DL_DEL_CUR_AE_R_EQM_E_VIRT_EQM( ?, ? ) }';
ml_add_table_script('wr', 'ae_r_eqm_e_virtual_eqm', 'download_delete_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_r_eqm_e_virtual_eqm', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_mfm_eqp_meter_read( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'mfm_equipment_meter_reading', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_mfm_eqp_meter_read( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'mfm_equipment_meter_reading', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_r_pms_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_r_pms_d', 'download_cursor', ml_script );

--ml_script := '{ call  mfm.dl_cur_ae_r_sds_d( ?, ? ) }';
--ml_add_table_script('wr', 'ae_r_sds_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_pro_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_pro_e', 'download_delete_cursor', ml_script );
ml_script := null;
ml_add_table_script('inv', 'ae_p_pro_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_r_eqm_notes( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_r_eqm_notes', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_r_eqm_notes( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_r_eqm_notes', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_mfm_error_log( ?, ? ) }';
ml_add_table_script('wr', 'mfm_error_log', 'download_cursor', ml_script );
ml_add_table_script('inv', 'mfm_error_log', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_s_bld_c( ?, ? ) }';
ml_add_table_script('wr', 'ae_s_bld_c', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_s_bld_c( ?, ? ) }';
ml_add_table_script('wr', 'ae_s_bld_c', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_b_loc_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_b_loc_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_b_loc_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_b_loc_d', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_sta_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_sta_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_pst_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_pst_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_mfm_time_card_sum( ?, ? ) }';
ml_add_table_script('wr', 'mfm_time_card_summary', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_sta_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_sta_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_pst_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_pst_e', 'download_delete_cursor', ml_script );

ml_script_table := 'ae_i_inv_e';
ml_script := '{ call  mfm.dl_cur_ae_i_inv_e( ?, ? ) }';
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_i_inv_e';
ml_script := '{ call  mfm.dl_del_cur_ae_i_inv_e( ?, ? ) }';
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_delete_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'wr', ml_script_table, 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_p_pst_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_pst_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_i_whs_e_inv( ?, ? ) }';
ml_add_table_script('inv', 'ae_i_whs_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_i_whs_e_inv( ?, ? ) }';
ml_add_table_script('inv', 'ae_i_whs_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_i_whs_e_wr( ?, ? ) }';
ml_add_table_script('wr', 'ae_i_whs_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_i_whs_e_wr( ?, ? ) }';
ml_add_table_script('wr', 'ae_i_whs_e', 'download_delete_cursor', ml_script );

--ml_script := '{ call  mfm.dl_cur_ae_i_whs_d( ?, ? ) }';
--ml_add_table_script('inv', 'ae_i_whs_d', 'download_cursor', ml_script );

--ml_script := '{ call  mfm.dl_del_cur_ae_i_whs_d( ?, ? ) }';
--ml_add_table_script('inv', 'ae_i_whs_d', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_i_loc_e_inv( ?, ? ) }';
ml_script := null;
ml_add_table_script('inv', 'ae_i_loc_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_i_loc_e_inv( ?, ? ) }';
ml_script := null;
ml_add_table_script('inv', 'ae_i_loc_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_i_loc_e_wr( ?, ? ) }';
ml_add_table_script('wr', 'ae_i_loc_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_i_loc_e_wr( ?, ? ) }';
ml_add_table_script('wr', 'ae_i_loc_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_l_shp_e( ?, ? ) }';
ml_script := null;
ml_add_table_script('inv', 'ae_l_shp_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_l_shp_e( ?, ? ) }';
ml_script := null;
ml_add_table_script('inv', 'ae_l_shp_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_l_shp_d( ?, ? ) }';
ml_script := null;
ml_add_table_script('inv', 'ae_l_shp_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_l_shp_d( ?, ? ) }';
ml_script := null;
ml_add_table_script('inv', 'ae_l_shp_d', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_l_shp_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_l_shp_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_l_shp_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_l_shp_e', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_l_shp_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_l_shp_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_del_cur_ae_l_shp_d( ?, ? ) }';
ml_script := null;
ml_add_table_script('wr', 'ae_l_shp_d', 'download_delete_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_l_man_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_l_man_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_l_man_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_l_man_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_x_cft_e( ?, ? ) }';
ml_add_table_script('wr', 'ae_x_cft_e', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_x_cft_e_only( ?, ? ) }';
ml_add_table_script('wr', 'ae_x_cft_e_only', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_sta_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_sta_d', 'download_cursor', ml_script );

ml_script := '{ call  mfm.dl_cur_ae_p_pst_d( ?, ? ) }';
ml_add_table_script('wr', 'ae_p_pst_d', 'download_cursor', ml_script );

/* Download by SQL */

ml_script_from := nl || 'from ';
ml_script_where := nl || 'where edit_date >= ?';

ml_script_table := 'ae_p_def_e';
ml_script := 'select order_type, description ' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_s_cat_c';
ml_script := 'select category, description, order_type, move_yn ' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_p_sta_c';
ml_script := 'select status_code, description, act_code, min_code, max_code, category, no_days, complete_yn, parent_message, edit_budget_yn, seq, order_type ' || ml_script_from || ml_script_table || ml_script_where || ' and active = ''Y'' and complete_yn <> ''Y''';
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script := 'select status_code, category, order_type' || ml_script_from || ml_script_table || ml_script_where || ' and active <> ''Y'' or active is null';
ml_add_table_script( 'wr', ml_script_table, 'download_delete_cursor', ml_script );

ml_script_table := 'ae_s_usr_d';
ml_script := 'select company_id, dept_id, oc_code, requestor, requestor_ph, requestor_mc, contact, contact_ph, contact_mc, trim(requestor_name), employee_yn, address1, address2, city, state, zip, region_code, fac_id, bldg, location_code, loc_id' || ml_script_from || ml_script_table || ml_script_where || ' and active = ''Y''';
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script := 'select requestor ' || ml_script_from || ml_script_table || ml_script_where || ' and active <> ''Y'' or active is null';
ml_add_table_script( 'wr', ml_script_table, 'download_delete_cursor', ml_script );

ml_script_table := 'ae_s_com_e';
ml_script := 'select company_id, description, active' || ml_script_from || ml_script_table || ml_script_where ;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_s_dep_e';
ml_script := 'select company_id, dept_id, description, active' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_s_oci_e';
ml_script := 'select oc_code, company_id, dept_id, description, active' || ml_script_from || ml_script_table || ml_script_where ;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_p_prb_e';
ml_script := 'select problem_code, description, hazardous, shop, craft_code, pri_code, shop_person, tot_hrs, tot_lab, tot_mat, tot_eqp, tot_ext, tot_con, order_type, category, edit_date' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_p_pst_c';
ml_script := 'select status_code, description, act_code, min_code, max_code, category, no_days, complete_yn, ap_ready_yn, escalate_text, parent_message, page, fax, email, lock_phs_est_yn, edit_budget_yn, seq, order_type ' || ml_script_from || ml_script_table || ml_script_where || ' and active = ''Y'' and complete_yn <> ''Y''';
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script := 'select status_code, category, order_type' || ml_script_from || ml_script_table || ml_script_where || ' and active <> ''Y'' or active is null';
ml_add_table_script( 'wr', ml_script_table, 'download_delete_cursor', ml_script );

ml_script_table := 'ae_l_lbr_e';
ml_script := 'select labor_class, description' || ml_script_from || ml_script_table || ml_script_where || ml_script_and_active;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_s_pri_c';
ml_script := 'select pri_code, description' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_p_rep_e';
ml_script := 'select repair_code, description' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_p_lat_c';
ml_script := 'select time_type, description, ss_flag, val_hrs, post_laborcost, post_hours' || ml_script_from || ml_script_table || ml_script_where || ml_script_and_active;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_b_reg_e';
ml_script := 'select region_code, description' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_b_fac_e';
ml_script := 'select fac_id, region_code, description' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_l_stock_d';
ml_script := 'select stock_no, stock_location, stock_cost, delete_flag' || ml_script_from || ml_script_table || ml_script_where;
ml_script := null;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_s_sec_c';
ml_script := 'select login, order_type, category, region_code, fac_id, bldg, labor_class, shop, employee_id, company_id, dept_id, oc_code, requestor, contractor, crt_flag, warehouse, employee_id, mfm_download, default_org, loc_id, location_code' || ml_script_from || ml_script_table || ml_script_where || ' and rtrim(upper(login)) = rtrim(upper(?))';
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_s_sys_c';
ml_script := 'select company, version_no, program_fy' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_s_sys_f';
ml_script := 'select flag_id, description, flag_value, parameter, data_type' || ml_script_from || ml_script_table || ml_script_where || ' and flag_id in (100, 109, 118, 117)';
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_l_stock_e';
ml_script := 'select stock_no, stock_desc, uom, delete_flag' || ml_script_from || ml_script_table || ml_script_where;
ml_script := null;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_l_stock_loc';
ml_script := 'select stock_location, stock_loc_desc, shop, truck_no, region_code, fac_id, bldg, location_code, loc_id, delete_flag' || ml_script_from || ml_script_table || ml_script_where;
ml_script := null;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_i_rte_d';
ml_script := 'select route_no, description' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_i_rej_e';
ml_script := 'select reject_code, description' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_i_rec_t';
ml_script := 'select ship_type, description' || ml_script_from || ml_script_table || ml_script_where || ' and active = ''Y''';
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );
ml_add_table_script( 'po_rec', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_s_bld_shp_sup';
ml_script := 'select region_code, fac_id, bldg, shop' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_i_uom_d';
ml_script := 'select uom, description' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_script := null;
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_r_eqm_s';
ml_script := 'select eqm_status, description, complete_yn, seq ' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'mfm_time';
ml_script := 'select 1, sysdate from ae_s_sys_c';
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );
ml_add_table_script( 'inv', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_p_action_taken';
ml_script := 'select action_taken, description, active ' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_x_action_taken';
ml_script := 'select action_taken, craft_code, order_type, category ' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_authz';
ml_script := 'select role_id, description, active ' || ml_script_from || ml_script_table || ml_script_where;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_authz_principal';
ml_script := 'select role_id, login, ''Y'' ' || ml_script_from || ml_script_table || ml_script_where || ' and upper(login) = upper(?)';
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

ml_script_table := 'ae_authz_privilege';
ml_script := 'select role_id, previlege_id, ''Y'' ' || ml_script_from || ml_script_table || ml_script_where || ' and upper(login) = upper(?)';
ml_script := null;
ml_add_table_script( 'wr', ml_script_table, 'download_cursor', ml_script );

-- upload by stored procedure

ml_script_start  := '{ call ';
ml_script_end    := ' } ';

ml_script_table := 'ae_p_pro_e';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'mfm_routes_dl';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'mfm_warehouse_for_po_download';
ml_script := ml_script_start || 'beg_ul_mfm_warehouse_for_po_dl' || '( ?, ? )' || ml_script_end;
ml_add_table_script('inv', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_i_poe_e';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_add_table_script('inv', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'mfm_routes_download';
ml_script := ml_script_start || 'beg_ul_mfm_routes_dl( ?, ? )' || ml_script_end;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'mfm_cycle_count_to_dl';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_add_table_script('inv', 'mfm_cycle_count_to_download', 'begin_upload', ml_script );

ml_script_table := 'ae_i_ptn_e';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('inv', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'mfm_meter_reading';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_p_wka_d';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_p_req_e';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_i_ext_e';
ml_script := ml_script_start || 'beg_ul_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'mfm_equipment_meter_reading';
ml_script := ml_script_start || 'beg_ul_mfm_eqp_meter_reading' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_p_sta_e';
ml_script := ml_script_start || 'beg_ul_ae_p_sta_e' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_p_pst_e';
ml_script := ml_script_start || 'beg_ul_ae_p_pst_e' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_p_dsc_e';
ml_script := ml_script_start || 'beg_ul_ae_p_dsc_e' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_p_dsc_h';
ml_script := ml_script_start || 'beg_ul_ae_p_dsc_h' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_r_eqm_notes';
ml_script := ml_script_start || 'beg_ul_ae_r_eqm_notes' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'begin_upload', ml_script );

ml_script_table := 'ae_p_dsc_e';
ml_script := ml_script_start || 'end_ul_ae_p_dsc_e' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'end_upload', ml_script );

ml_script_table := 'ae_p_dsc_h';
ml_script := ml_script_start || 'end_ul_ae_p_dsc_h' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'end_upload', ml_script );

ml_script_table := 'ae_r_eqm_notes';
ml_script := ml_script_start || 'end_ul_ae_r_eqm_notes' || '( ?, ? )' || ml_script_end;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'end_upload', ml_script );


ml_script_table := 'mfm_setup';
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || '( ?, ? )' || ml_script_end;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'ae_p_pro_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_p_phs_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_p_pro_s';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script := 'delete from ae_p_pro_s where proposal = ? and sort_code = ? and shop_person = ?';
ml_add_table_script('wr', ml_script_table, 'upload_delete', ml_script );


ml_script_table := 'ae_p_dsc_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_p_dsc_h';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_p_wka_d';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_p_req_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'ae_i_ext_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'mfm_meter_reading';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_l_stock_use';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );


ml_script_table := 'mfm_routes_download';
ml_script_parms := '(?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_mfm_routes_dl' || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'mfm_warehouse_for_po_download';
ml_script_parms := '(?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_mfm_warehouse_for_po_dl' || ' ' || ml_script_parms;
ml_add_table_script('inv', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'ae_i_poe_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('inv', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_i_poe_d';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('inv', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'mfm_cycle_count_to_download';
ml_script_parms := '(?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_mfm_cycle_count_to_dl' || ' ' || ml_script_parms;
ml_add_table_script('inv', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'mfm_cycle_count_to_download';
ml_script_parms := '(?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_upd_mfm_cycle_count_to_dl' || ' ' || ml_script_parms;
ml_add_table_script('inv', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'mfm_cycle_count';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('inv', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_i_ptn_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('inv', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'ae_i_ptn_d';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_' || ml_script_table || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('inv', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'ae_r_eqm_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_upd_' || ml_script_table || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'mfm_equipment_meter_reading';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_upd_mfm_eqp_meter_read' || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'ae_r_eqm_notes';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_ae_r_eqm_notes' || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script := ml_script_start || 'ul_upd_ae_r_eqm_notes' || ' ' || ml_script_parms;
ml_script := null;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );

ml_script_table := 'mfm_reload';
ml_script_parms := '(?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_mfm_reload' || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );
ml_add_table_script('inv', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'ae_p_sta_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_ae_p_sta_e' || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'ae_p_pst_e';
ml_script_parms := '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_ae_p_pst_e' || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'mfm_user_pda';
ml_script_parms := '(?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_ins_mfm_user_pda' || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_insert', ml_script );
ml_add_table_script('inv', ml_script_table, 'upload_insert', ml_script );

ml_script_table := 'mfm_user_pda';
ml_script_parms := '(?, ?)' || ml_script_end;
ml_script := ml_script_start || 'ul_upd_mfm_user_pda' || ' ' || ml_script_parms;
ml_add_table_script('wr', ml_script_table, 'upload_update', ml_script );
ml_add_table_script('inv', ml_script_table, 'upload_update', ml_script );

ml_script := '{ call mfm_authentic_user (?, ?, ?, ?) }';
ml_script := null;
ml_add_connection_script('wr', 'authenticate_user', ml_script);
ml_add_connection_script('inv', 'authenticate_user', ml_script);

ml_script := 'MobileAuth.AuthenticateUser';
ml_add_java_connection_script( 'wr', 'authenticate_user', ml_script);
ml_add_java_connection_script( 'reload', 'authenticate_user', ml_script);
ml_add_java_connection_script( 'inv', 'authenticate_user', ml_script);

ml_script := '{ call  mfm_handle_error( ?, ?, ?, ?, ?) }';
ml_add_connection_script('wr', 'handle_error', ml_script);
ml_add_connection_script('inv', 'handle_error', ml_script);

ml_script := '{ call  mfm_report_error( ?, ?, ?, ?, ?) }';
ml_add_connection_script('wr', 'report_error', ml_script);
ml_add_connection_script('inv', 'report_error', ml_script);

ml_script := '{ call  mfm_handle_odbc_error( ?, ?, ?, ?, ?) }';
ml_script := null;
ml_add_connection_script('wr', 'handle_odbc_error', ml_script);
ml_add_connection_script('inv', 'handle_odbc_error', ml_script);

ml_script := '{ call  mfm_report_odbc_error( ?, ?, ?, ?, ?) }';
ml_script := null;
ml_add_connection_script('wr', 'report_odbc_error', ml_script);
ml_add_connection_script('inv', 'report_odbc_error', ml_script);

end;
/


create or replace procedure UL_INS_AE_I_EXT_E(v_trans_no             ae_i_ext_e.trans_no%type,
    v_subledger_type       varchar,
    v_req_no               varchar,
    v_inv_no               varchar,
    v_cash_no              varchar,
    v_batch_no             varchar,
    v_proposal             in out varchar,
    v_sort_code            varchar,
    v_craft_code           varchar,
    v_login                varchar,
    v_amount               ae_i_ext_e.amount%type,
    v_shop_person          varchar,
    v_payment_date         date,
    v_description             varchar,
    v_inv_date             date,
    v_part                 varchar,
    v_itm_qty              numeric,
    v_contractor           varchar,
    v_address_code         varchar,
    v_inv_uom              varchar,
    v_trans_date           date,
    v_post_date            date,
    v_posted_yn            varchar,
    v_action_flag          varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_edit_clerk            varchar,
    v_shop                  varchar,
    v_po_code               varchar)
as
        v_con_trans_no ae_i_ext_e.trans_no%type;
        v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
             v_con_proposal ae_p_pro_e.proposal%type;
             v_message  varchar(1000);
begin
mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'EXTERNAL_CHARGES_INSERT';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

mfm_check_proposal_xref( v_login, v_pda_id, v_proposal, v_con_proposal);

v_proposal := v_con_proposal;

v_message := 'Inserting External Charge ' || rtrim(to_char(v_trans_no)) || ' into WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code);
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;

mfm_gen_transaction_number('G', v_con_trans_no);

insert into ae_i_ext_e(
    trans_no,
    subledger_type,
    proposal,
    sort_code,
    amount,
    description,
    craft_code,
    trans_date,
    posted_yn,
    edit_clerk,
    edit_date
) values (
    v_con_trans_no,
    rtrim(v_subledger_type),
    rtrim(v_proposal),
    rtrim(v_sort_code),
    v_amount,
    rtrim(v_description),
    v_craft_code,
    v_edit_date,
    'N',
    v_edit_clerk,
    v_edit_date
);

insert into mfm_ae_i_ext_e_delete values(
v_trans_no,
v_edit_clerk,
v_pda_id,
v_edit_date);

end;
/


create or replace procedure UL_INS_AE_I_PTN_D(v_pick_ticket_num      numeric,
    v_pick_ticket_item     numeric,
    v_pt_item_desc         varchar,
    v_part                 varchar,
    v_itm_dsc              varchar,
    v_req_qty             numeric,
    v_bin_location         varchar,
    v_action_flag          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date)
as
/*
        v_con_pick_ticket_num  numeric(16,0);
        v_con_pick_ticket_status varchar(20);
        v_rowcount      numeric(8,0);
        v_con_pick_ticket_item    numeric(16,0);
        v_error  numeric(8,0);
        v_complete_yn  varchar(1);
        v_warehouse    varchar(5);
        v_proposal    varchar(15);
        v_sort_code    varchar(15);
        v_date_needed    date;
        v_inv_commit_cnt numeric(16,4);
        v_whs_commit_cnt numeric(16,4);
        v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
             v_part_active  varchar(1);
		cursor c_pick_tick_num(v_pick_ticket_num mfm_ae_i_ptn_e_trans_no.temp_pick_ticket_num%type,
                                v_login mfm_ae_i_ptn_e_trans_no.login%type,
                                v_pda_id mfm_ae_i_ptn_e_trans_no.pda_id%type) is
		    select pick_ticket_num,
		           pick_ticket_item
		      from mfm_ae_i_ptn_e_trans_no
		     where temp_pick_ticket_num = v_pick_ticket_num
               and upper(login) = upper(v_login)
               and pda_id = v_pda_id;
		cursor c_pick_ticket(v_con_pick_ticket_num ae_i_ptn_e.pick_ticket_num%type) is
		    select pick_ticket_status,
		           warehouse,
		           proposal,
		           sort_code,
		           date_needed
		      from ae_i_ptn_e
		     where pick_ticket_num = v_con_pick_ticket_num;
		cursor c_status_type(v_con_pick_ticket_status ae_i_sta_c.status_code%type) is
		    select complete_yn
		      from ae_i_sta_c
		     where tranx_type = 'TK'
		       and status_code = v_con_pick_ticket_status;
	    cursor c_inv_commit(v_part ae_i_inv_e.part%type) is
			select inv_commit
			from ae_i_inv_e
			where part = v_part;
		cursor c_whs_commit(v_part ae_i_inv_w.part%type,
							v_warehouse ae_i_inv_w.warehouse%type) is
			select whs_commit
			from ae_i_inv_w
			where part = v_part
			and warehouse = v_warehouse;
	    cursor c_part_active(v_part ae_i_inv_w.part%type) is
	        select complete_yn
	          from ae_i_inv_e, ae_i_inv_s
	         where ae_i_inv_e.inv_status = ae_i_inv_s.inv_status
	           and ae_i_inv_e.part = v_part;
        v_message   varchar(1000);
        */
begin
/*
	mfm_version_security( v_version_security );
	if v_version_security <> 1 then
	    return;
	end if;
	v_prompt := 'inv.w_i_ptn_e.insert';
	mfm_screen_security ( v_screen_security, v_login, v_prompt);
	if v_screen_security <> 1 then
	    return;
	end if;
	open c_part_active(v_part);
	fetch c_part_active into v_part_active;
	close c_part_active;
    if v_part_active = 'D' then
        v_message :=  v_part || ' is not active, Skipping Record.';
        raise_application_error (-20000, v_message);
    end if;
	open c_pick_tick_num(v_pick_ticket_num, v_login, v_pda_id);
	fetch c_pick_tick_num into v_con_pick_ticket_num, v_con_pick_ticket_item;
	if c_pick_tick_num%notfound then
        raise_application_error(-20000, 'Unable to lookup mfm_ae_i_ptn_e_trans_no in table, Skipping Record');
	end if;
	close c_pick_tick_num;
    v_con_pick_ticket_item := v_con_pick_ticket_item + 1;
    update mfm_ae_i_ptn_e_trans_no
       set pick_ticket_item = v_con_pick_ticket_item
     where temp_pick_ticket_num = v_pick_ticket_num
       and upper(login) = upper(v_login)
       and pda_id = v_pda_id;
	open c_pick_ticket(v_con_pick_ticket_num);
	fetch c_pick_ticket into v_con_pick_ticket_status, v_warehouse, v_proposal, v_sort_code, v_date_needed;
	if c_pick_ticket%notfound then
        raise_application_error(-20000, 'Unable to lookup pick ticket header in table, Skipping Record');
	end if;
	close c_pick_ticket;
	open c_status_type(v_con_pick_ticket_status);
	fetch c_status_type into v_complete_yn;
	close c_status_type;
	insert into ae_i_ptn_d
		(pick_ticket_num,
        pick_ticket_item,
        part,
        bin_location,
        req_qty,
        warehouse,
        proposal,
        sort_code,
        itm_status,
        date_needed,
        rel_qty,
        itm_dsc,
        edit_date)
	values
		(v_con_pick_ticket_num,
        v_con_pick_ticket_item,
        v_part,
        v_bin_location,
        v_req_qty,
        v_warehouse,
        v_proposal,
        v_sort_code,
        'O',
        v_date_needed,
        0.0,
        v_itm_dsc,
        sysdate);
    if v_complete_yn = 'F' then
    	open c_inv_commit(v_part);
    	fetch c_inv_commit into v_inv_commit_cnt;
    	close c_inv_commit;
		open c_whs_commit(v_part, v_warehouse);
		fetch c_whs_commit into v_whs_commit_cnt;
		close c_whs_commit;
		if v_inv_commit_cnt = 0 or v_inv_commit_cnt is null then
			v_inv_commit_cnt := v_req_qty;
    	else
			v_inv_commit_cnt := v_inv_commit_cnt + v_req_qty;
		end if;
		if v_whs_commit_cnt = 0 or v_whs_commit_cnt is null then
			v_whs_commit_cnt := v_req_qty;
		else
			v_whs_commit_cnt := v_whs_commit_cnt + v_req_qty;
		end if;
		update ae_i_inv_e
           set inv_commit = v_inv_commit_cnt
		 where part = v_part;
		update ae_i_inv_w
           set whs_commit = v_whs_commit_cnt
		 where part = v_part
		   and warehouse = v_warehouse;
	end if;
*/
null;
end;
/


create or replace procedure UL_INS_AE_I_PTN_E(v_pick_ticket_num      numeric,
    v_pick_ticket_desc     varchar,
    v_pick_ticket_status   varchar,
    v_date_created         date,
    v_created_by           varchar,
    v_warehouse            varchar,
    v_proposal             in out varchar,
    v_sort_code            varchar,
    v_date_needed          date,
    v_action_flag          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date)
as
/*
        v_con_pick_ticket_num  numeric(16,0);
        v_con_pick_ticket_status varchar(20);
        v_rowcount      numeric(8,0);
        v_con_pick_ticket_item    numeric(16,0);
        v_error  numeric(8,0);
        v_shop  varchar(15);
        v_supervisor_id    varchar(15);
        v_warehouse_active varchar(1);
        v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
             v_message   varchar(1000);
             v_con_proposal varchar(15);
             v_con_region_code ae_i_ptn_e.region_code%type;
             v_con_fac_id ae_i_ptn_e.fac_id%type;
             v_con_bldg ae_i_ptn_e.bldg%type;
             v_con_location_code ae_i_ptn_e.location_code%type;
		cursor c_default_status is
			select min(status_code), count(*)
			  from ae_i_sta_c
			 where mfm_default_status = 'Y';
		cursor c_status_security_count(v_con_pick_ticket_status ae_i_sta_d.status_code%type) is
			select count(*)
			  from ae_i_sta_d
			 where tranx_type = 'TK'
			   and status_code = v_con_pick_ticket_status;
		cursor c_status_security(v_con_pick_ticket_status ae_i_sta_d.status_code%type,
                                 v_login ae_i_sta_d.login%type) is
			select count(*)
			  from ae_i_sta_d
			 where tranx_type = 'TK'
			   and status_code = v_con_pick_ticket_status
               and upper(login) = upper(v_login);
		cursor c_phase_shop(v_proposal ae_p_phs_e.proposal%type,
							v_sort_code ae_p_phs_e.sort_code%type) is
			select shop
			from ae_p_phs_e
			where proposal = v_proposal
			and sort_code = v_sort_code;
		cursor c_shop_supervisor(v_shop ae_l_shp_e.shop%type) is
			select supervisor_id, region_code, fac_id, bldg, location_code
			from ae_l_shp_e
			where shop = v_shop
              and active = 'Y';
        cursor c_warehouse_active(v_warehouse ae_i_whs_e.warehouse%type) is
            select active
              from ae_i_whs_e
             where warehouse = v_warehouse;
             */
begin
/*
mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;
v_prompt := 'inv.w_i_ptn_e.insert';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;
mfm_check_proposal_xref( v_login, v_pda_id, v_proposal, v_con_proposal);
v_proposal := v_con_proposal;
v_message := 'Inserting Pick Ticket Header for WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code);
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;
open c_warehouse_active(v_warehouse);
fetch c_warehouse_active into v_warehouse_active;
close c_warehouse_active;
if v_warehouse_active <> 'Y' then
    v_message :=  v_warehouse || ' is not active, Skipping Record.';
    raise_application_error (-20000, v_message);
end if;
mfm_gen_transaction_number('C', v_con_pick_ticket_num);
v_con_pick_ticket_item := 0;
insert into mfm_ae_i_ptn_e_trans_no values(v_con_pick_ticket_num, v_pick_ticket_num, v_con_pick_ticket_item, v_login, v_pda_id);
open c_default_status;
fetch c_default_status into v_con_pick_ticket_status, v_rowcount;
close c_default_status;
if v_rowcount = 0 then
        v_message :=  'No default pick ticket status set, Skipping Record.';
        raise_application_error (-20000, v_message);
end if;
open c_status_security_count(v_con_pick_ticket_status);
fetch c_status_security_count into v_rowcount;
close c_status_security_count;
if v_rowcount > 0 then
    open c_status_security(v_con_pick_ticket_status, v_login);
    fetch c_status_security into v_rowcount;
    close c_status_security;
    if v_rowcount <> 1 then
            v_message :=  rtrim(v_login) || ' does not have access to change to status ' || rtrim(v_con_pick_ticket_status) || ', Skipping Record.';
            raise_application_error (-20000, v_message);
    end if;
end if;
open c_phase_shop(v_proposal, v_sort_code);
fetch c_phase_shop into v_shop;
close c_phase_shop;
open c_shop_supervisor(v_shop);
fetch c_shop_supervisor into v_supervisor_id, v_con_region_code, v_con_fac_id, v_con_bldg, v_con_location_code;
close c_shop_supervisor;
insert into ae_i_ptn_e ( pick_ticket_num,
                        pick_ticket_desc,
                        date_created,
                        created_by,
	                    warehouse,
                        proposal,
                        sort_code,
                        date_needed,
                        pick_ticket_status,
                        shop_person,
                        edit_date,
                        region_code,
                        fac_id,
                        bldg,
                        location_code
                        )
values 	(v_con_pick_ticket_num,
        rtrim(v_pick_ticket_desc),
        v_date_created,
        rtrim(v_created_by),
	    rtrim(v_warehouse),
        rtrim(v_proposal),
        rtrim(v_sort_code),
        v_date_needed,
        rtrim(v_con_pick_ticket_status),
        rtrim(v_supervisor_id),
        sysdate,
        v_con_region_code,
        v_con_fac_id,
        v_con_bldg,
        v_con_location_code
        );
insert into ae_i_sta_e
	(tranx_no, status_date, status_code, login, tranx_type)
values
	(v_con_pick_ticket_num, v_date_created, v_con_pick_ticket_status, v_created_by, 'TK');
*/
null;

end;
/


create or replace procedure UL_INS_AE_L_STOCK_USE(v_stock_location       varchar,
    v_trans_date           date,
    v_proposal             varchar,
    v_sort_code            varchar,
    v_stock_no             varchar,
    v_qty_used             numeric,
    v_ext_cost             numeric,
    v_posted_yn            varchar,
    v_trans_no             numeric,
    v_action_flag          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date)
as
             v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
             v_con_proposal varchar(15);
             v_in_proposal ae_p_pro_e.proposal%type;
             v_message  varchar(1000);
begin

mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'pro.w_i_stock_use.insert';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

mfm_check_proposal_xref( v_login, v_pda_id, v_proposal, v_con_proposal);

v_in_proposal := v_con_proposal;

v_message := 'Inserting Shop Stock for Part ' || rtrim(v_stock_no) || ' into WR ' || rtrim(v_in_proposal) || ' Phase ' || rtrim(v_sort_code);
mfm_bo_wr_phase_open( v_message, v_in_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;



insert into ae_l_stock_use (stock_location,
				trans_date,
				proposal,
				sort_code,
				stock_no,
				qty_used,
				ext_cost,
				posted_yn,
                edit_date)
			values (v_stock_location,
				v_trans_date,
				v_in_proposal,
				v_sort_code,
				v_stock_no,
				v_qty_used,
				v_ext_cost,
				'N',
                sysdate);

end;
/


create or replace procedure UL_INS_AE_P_PHS_E(v_proposal             in out ae_p_phs_e.proposal%type,
    v_sort_code            ae_p_phs_e.sort_code%type,
    v_phsdsc               ae_p_phs_e.description%type,
/*    v_beg_dt               ae_p_phs_e.beg_dt%type,
    v_end_dt               ae_p_phs_e.end_dt%type,
    v_craft_code           ae_p_phs_e.craft_code%type,
    v_labor_class          ae_p_phs_e.labor_class%type,
    v_shop                 ae_p_phs_e.shop%type,
    v_status_code          ae_p_phs_e.status_code%type,
    v_repair_code          ae_p_phs_e.repair_code%type,
    v_problem_code         ae_p_phs_e.problem_code%type,
    v_pri_code             ae_p_phs_e.pri_code%type,
    v_part                 ae_p_phs_e.part%type,
    v_serial_no            ae_p_phs_e.serial_no%type,
    v_login                ae_p_phs_e.login%type,
    v_default_dist         ae_p_phs_e.default_dist%type,
    v_action_flag          varchar,
    v_wr_category             ae_p_pro_e.category%type,
    v_wr_type              ae_p_pro_e.order_type%type,
    v_pmi_basic            ae_p_phs_e.pmi_basic%type,
    v_start_time           date,
    v_tot_hrs              ae_p_phs_e.tot_hrs%type,
    v_tot_lab              ae_p_phs_e.tot_lab%type,
    v_tot_mat              ae_p_phs_e.tot_mat%type,
    v_tot_eqp              ae_p_phs_e.tot_eqp%type,
    v_tot_oth              ae_p_phs_e.tot_oth%type,
    v_tot_ext              ae_p_phs_e.tot_ext%type,
    v_pda_id               in out varchar,
    v_edit_date            in out ae_p_phs_e.edit_date%type,
    v_wr_ref                    ae_p_pro_e.ref%type,
    v_wr_requestor              ae_p_pro_e.requestor%type,
    v_wr_region_code            ae_p_pro_e.region_code%type,
    v_wr_fac_id                 ae_p_pro_e.fac_id%type,
    v_wr_bldg                   ae_p_pro_e.bldg%type,
    v_wr_edit_date           ae_p_pro_e.edit_date%type,
    v_location_code          ae_p_phs_e.location_code%type,
    v_loc_id                 ae_p_phs_e.loc_id%type, */
    v_download_date         date)
as
         v_hazardous               ae_p_phs_e.hazardous%type;
        v_con_status_code       ae_p_phs_e.status_code%type;
        v_con_default_dist      ae_p_phs_e.default_dist%type;
        v_prompt                varchar(50);
        v_screen_security       integer;
        v_version_security      integer;
        v_con_proposal          ae_p_phs_e.proposal%type;
        v_pda_proposal          ae_p_phs_e.proposal%type;
    v_old_phase_shop            ae_p_phs_e.shop%type;
    v_old_phase_status_code     ae_p_phs_e.status_code%type;
    v_old_phase_pri_code        ae_p_phs_e.pri_code%type;
    v_old_phase_default_dist        ae_p_phs_e.default_dist%type;
    v_pda_edit_date             date;
    v_message                   varchar(1000);
    v_shop_active               integer;
begin
/*
mfm_version_security( v_version_security);
if v_version_security <> 1 then
    return;
end if;
v_prompt := 'pro.w_i_wra_p.insert';
mfm_screen_security( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;
v_pda_edit_date := v_edit_date;
v_edit_date := sysdate;
v_hazardous := 'N';
v_pda_proposal := rtrim(v_proposal);
mfm_check_proposal_xref ( v_login, v_pda_id, v_proposal, v_con_proposal );
v_proposal := rtrim(v_con_proposal);
mfm_check_shop(v_shop_active, v_shop);
if v_shop_active = 0 then
    return;
end if;
v_message := 'Inserting Phase ' || rtrim(v_sort_code) || ' into WR ' || rtrim(v_proposal);
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;
mfm_bo_ae_p_phs_e_status( v_proposal, v_sort_code, v_login, v_wr_type, v_wr_category, v_status_code, v_screen_security);
if v_screen_security <> 1 then
    return;
end if;
insert into ae_p_phs_e(
    proposal,
    sort_code,
    phsdsc,
    beg_dt,
    end_dt,
    craft_code,
    labor_class,
    shop,
    status_code,
    repair_code,
    problem_code,
    pri_code,
    part,
    serial_no,
    login,
    default_dist,
    pmi_basic,
    edit_date,
    tot_hrs,
    tot_lab,
    tot_mat,
    tot_eqp,
    tot_oth,
    tot_ext,
    hazardous,
    labor_indx,
    coe_indx,
    fixed_actual,
    fixed_amount,
    region_code,
    fac_id,
    bldg,
    location_code,
    loc_id
) values (
    rtrim(v_proposal),
    rtrim(v_sort_code),
    rtrim(v_phsdsc),
    v_beg_dt,
    v_end_dt,
    rtrim(v_craft_code),
    rtrim(v_labor_class),
    rtrim(v_shop),
    rtrim(v_status_code),
    rtrim(v_repair_code),
    rtrim(v_problem_code),
    rtrim(v_pri_code),
    rtrim(v_part),
    rtrim(v_serial_no),
    rtrim(v_login),
    rtrim(v_default_dist),
    rtrim(v_pmi_basic),
    sysdate,
    v_tot_hrs,
    v_tot_lab,
    v_tot_mat,
    v_tot_eqp,
    v_tot_oth,
    v_tot_ext,
    rtrim(v_hazardous),
    1,
    1,
    'A',
    0,
    rtrim(v_wr_region_code),
    rtrim(v_wr_fac_id),
    rtrim(v_wr_bldg),
    rtrim(v_location_code),
    rtrim(v_loc_id)
);
v_old_phase_shop := '';
v_old_phase_status_code := '';
v_old_phase_pri_code := '';
v_old_phase_default_dist := '';
insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action)
    values(v_pda_proposal, v_sort_code, v_login, v_pda_id, 'D');
mfm_bo_ae_p_phs_e( v_proposal, v_sort_code, v_login, 'Y', v_wr_ref, v_wr_requestor, v_wr_region_code, v_wr_fac_id, v_wr_bldg, v_wr_edit_date, v_wr_type, v_wr_category, v_old_phase_shop, v_old_phase_status_code, v_old_phase_pri_code, v_old_phase_default_dist, v_pda_edit_date);
*/
null;
end;
/


create or replace procedure UL_INS_AE_P_PRO_E(v_proposal             varchar,
    v_title                varchar,
    v_status_code          varchar,
    v_region_code          varchar,
    v_fac_id               varchar,
    v_bldg                 varchar,
    v_ref                  varchar,
    v_category             varchar,
    v_requestor            varchar,
    v_contact              varchar,
    v_contact_ph           varchar,
    v_desired_date         date,
    v_order_type           varchar,
    v_reference_no         varchar,
    v_ent_clerk            varchar,
    v_ent_date             date,
    v_action_flag          varchar,
    v_shop                 varchar,
    v_shop_person          varchar,
    v_req_date             date,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_wr_edit_date         date,
    v_program_fy           varchar,
    v_requestor_name       varchar,
    v_requestor_ph         varchar,
    v_requestor_mc         varchar,
    v_bldgdsc              varchar,
    v_download_date        date)
as
/*        v_print_flag varchar(1);
        v_budget numeric(12,4);
        v_prompt varchar(50);
        v_screen_security integer;
        v_version_security integer;
        v_con_proposal   varchar(15);
        v_rowcount      integer;
cursor c_status_security_count(v_category ae_p_pro_e.category%type,
                               v_status_code ae_p_pro_e.status_code%type) is
                        select count(*)
                          from ae_p_sta_d
                         where category = v_category
                           and status_code = v_status_code;
cursor c_status_security(v_category ae_p_pro_e.category%type,
                               v_status_code ae_p_pro_e.status_code%type,
                               v_login ae_s_sec_c.login%type) is
    select count(*)
      from ae_p_sta_d
     where category = v_category
       and status_code = v_status_code
       and upper(login) = upper(v_login);
    v_shop_active   integer;
    */
begin
/*
mfm_version_security( v_version_security);
if v_version_security <> 1 then
    return;
end if;
v_prompt := 'pro.w_i_wra_p.insert';
mfm_screen_security( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;
mfm_bo_ae_p_pro_e_status( v_proposal, v_login, v_order_type, v_category, v_status_code, v_screen_security);
if v_screen_security <> 1 then
    return;
end if;
mfm_check_shop(v_shop_active, v_shop);
if v_shop_active = 0 then
    return;
end if;
v_print_flag := 'N';
v_budget := 0.0;
mfm_gen_transaction_string('R', v_con_proposal, v_region_code, v_fac_id, v_order_type, v_program_fy, v_ent_date);
insert into ae_p_pro_e(proposal, title, status_code, region_code, fac_id, bldg,
                                ref, category, requestor, contact,
                                contact_ph, desired_date, order_type, reference_no,
                                ent_clerk, ent_date, shop_person, shop, edit_date, req_date,
                                budget, print_flag, program_fy, requestor_name, requestor_ph,
                                requestor_mc)
		 values(v_con_proposal, v_title, v_status_code, v_region_code, v_fac_id, v_bldg,
                                v_ref, v_category, v_requestor, v_contact,
                                v_contact_ph, v_desired_date, v_order_type, v_proposal,
                                v_ent_clerk, v_ent_date, v_shop_person, v_shop, sysdate, v_req_date,
                                v_budget, v_print_flag, v_program_fy, v_requestor_name, v_requestor_ph,
                                v_requestor_mc );
insert into mfm_proposal_xref values(v_login, v_pda_id, v_proposal, v_con_proposal);
open c_status_security_count(v_category, v_status_code);
fetch  c_status_security_count into v_rowcount;
close c_status_security_count;
if v_rowcount > 0 then
    open c_status_security(v_category, v_status_code, v_login);
    fetch c_status_security into v_rowcount;
    close c_status_security;
    if v_rowcount = 0 then
        raise_application_error(-20000, 'User ' || rtrim(v_login) || ' does not have access to change to status ' || rtrim(v_status_code) || ' for WR ' || rtrim(v_proposal));
    end if;
end if;
*/

null;
/*
insert into ae_p_sta_e (proposal, status_code, status_date, login, category)
	values (v_con_proposal, v_status_code, v_edit_date, v_login, v_category);
*/

end;
/


create or replace procedure UL_INS_AE_P_PRO_S(v_proposal             in out varchar,
    v_sort_code            varchar,
    v_shop_person          varchar,
    v_primary_yn           varchar,
    v_ent_clerk            varchar,
    v_entrydate            date,
    v_action_flag          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_certified_yn         varchar,
    v_edit_clerk           varchar)
as

        v_prompt varchar(50);
        v_screen_security integer;
        v_version_security integer;
        v_con_proposal   ae_p_pro_e.proposal%type;
        v_message        varchar(1000);
        v_shopperson_count integer;
        v_new_primary_yn  ae_p_pro_s.primary_yn%type;
        cursor c_dup_shopperson(v_proposal ae_p_pro_s.proposal%type,
                                       v_sort_code ae_p_pro_s.sort_code%type,
                                       v_shop_person ae_p_pro_s.shop_person%type) is
            select count(*)
              from ae_p_pro_s
             where proposal = v_proposal
               and sort_code = v_sort_code
               and shop_person = v_shop_person;

        cursor c_primary_shopperson(v_proposal ae_p_pro_s.proposal%type,
                                       v_sort_code ae_p_pro_s.sort_code%type) is
        select count(*)
          from ae_p_pro_s
         where proposal = v_proposal
           and sort_code = v_sort_code
           and primary_yn = 'Y';

begin

mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'WORKORDER_UPDATE';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;


mfm_check_proposal_xref(v_login, v_pda_id, v_proposal, v_con_proposal);

v_proposal := v_con_proposal;

v_message := 'Inserting shop person ' || rtrim(v_shop_person) || ' into WR ' || rtrim(v_proposal)|| ' Phase ' || rtrim(v_sort_code);
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;


v_shopperson_count := 0;
open c_dup_shopperson(v_proposal, v_sort_code, v_shop_person);
fetch c_dup_shopperson into v_shopperson_count;
close c_dup_shopperson;

if v_shopperson_count > 0 then
    v_message := 'Shop Person ' + trim(v_shop_person) + ' is already assigned to WO ' + trim(v_proposal) + ' Phase ' + trim(v_sort_code) + ', Skipping Record.';
    raise_application_error(-20000,  v_message);
end if;

open c_primary_shopperson(v_proposal, v_sort_code);
fetch c_primary_shopperson into v_shopperson_count;
close c_primary_shopperson;
if v_shopperson_count > 0 then
    v_new_primary_yn := 'N';
else
    v_new_primary_yn := v_primary_yn;
end if;

insert into ae_p_pro_s(
    proposal,
    sort_code,
    shop_person,
    primary_yn,
    ent_clerk,
    entrydate,
    edit_date,
    certified_yn,
    edit_clerk
) values (
    rtrim(v_proposal),
    rtrim(v_sort_code),
    rtrim(v_shop_person),
    rtrim(v_new_primary_yn),
    rtrim(v_ent_clerk),
    v_entrydate,
    v_edit_date,
    v_certified_yn,
    rtrim(v_edit_clerk)
);

end;
/


create or replace procedure UL_INS_AE_P_PST_E(v_proposal             in out varchar,
    v_sort_code            varchar,
    v_status_code            varchar,
    v_status_date            date,
    v_login                  varchar,
    v_category               varchar,
    v_pda_id                 varchar,
    v_action_flag            varchar,
    v_edit_date            date,
    v_download_date         date,
    v_order_type            varchar,
    v_edit_clerk            varchar)
as
        v_prompt varchar(50);
        v_screen_security integer;
        v_version_security integer;
        v_con_proposal ae_p_phs_e.proposal%type;
        v_last_status_date date;
        v_status_count integer;
        v_status_exists integer;
        v_post_date date;
        /*
        cursor c_last_status(v_proposal ae_p_pro_e.proposal%type,
                             v_sort_code ae_p_phs_e.sort_code%type,
                             v_status_code ae_p_pro_e.status_code%type) is
         select max(status_date), count(*)
           from ae_p_pst_e
          where proposal = v_proposal
            and sort_code = v_sort_code
            and status_code = v_status_code
            ;
         */
        cursor c_check_status(v_proposal ae_p_pro_e.proposal%type,
                             v_sort_code ae_p_phs_e.sort_code%type,
                             v_status_code ae_p_pro_e.status_code%type,
                             v_status_date ae_p_sta_e.status_date%type) is
         select count(*)
           from ae_p_pst_e
          where proposal = v_proposal
            and sort_code = v_sort_code
--            and status_code = v_status_code
            and status_date = v_status_date;
        v_message varchar(1000);
        v_shop_active   integer;
    cursor c_old_phase(v_proposal ae_p_phs_e.proposal%type,
                        v_sort_code ae_p_phs_e.sort_code%type) is
        select status_code
          from ae_p_phs_e
        where proposal = v_proposal
          and sort_code = v_sort_code;
    v_old_edit_date      date;
    v_old_status_code   ae_p_phs_e.status_code%type;
begin
mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'WORKORDER_UPDATE';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

mfm_check_proposal_xref(v_login, v_pda_id, v_proposal, v_con_proposal);

v_proposal := v_con_proposal;

mfm_check_shop_by_wr_phase(v_shop_active, v_proposal, v_sort_code);
if v_shop_active = 0 then
    return;
end if;

/*
v_message := 'Inserting Status History ' || rtrim(v_status_code) || ' into WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code);
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;
*/

/* old
open c_last_status(v_proposal, v_sort_code, v_status_code);
fetch c_last_status into v_last_status_date, v_status_count;
close c_last_status;
*/

open c_old_phase(v_proposal, v_sort_code);
fetch c_old_phase into v_old_status_code;
close c_old_phase;

if rtrim(v_old_status_code) <> rtrim(v_status_code) then
    v_message := 'WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code) || ' has been updated by another user or rejected by the upload, Status Change history ' || rtrim(v_status_code) || ' ignored, Skipping Record';
    raise_application_error(-20000, v_message);
end if;

v_post_date := sysdate;

while true
loop
    open c_check_status(v_proposal, v_sort_code, v_status_code, v_post_date);
    fetch c_check_status into v_status_exists;
    close c_check_status;

    if v_status_exists > 0 then
        v_post_date := v_post_date + (1/24/60/60);
    else
        exit;
    end if;
end loop;



insert into ae_p_pst_e(proposal, sort_code, status_code, status_date, login, category, order_type, edit_clerk)
	values(trim(v_proposal), trim(v_sort_code), trim(v_status_code), v_post_date, trim(v_login), trim(v_category), v_order_type, v_edit_clerk);

insert into mfm_ae_p_pst_e_delete(proposal, sort_code, status_code, status_date, login, pda_id)
	values(trim(v_proposal), trim(v_sort_code), trim(v_status_code), v_status_date, trim(v_login), trim(v_pda_id));


/*
open c_last_status(v_proposal, v_sort_code);
fetch c_last_status into v_last_status_date, v_status_count;
close c_last_status;

if (v_status_count > 0) and (v_last_status_date < v_status_date) then
    update ae_p_phs_e
       set status_code = v_status_code,
            edit_date = sysdate
     where proposal = v_proposal
       and sort_code = v_sort_code;
end if;
*/

end;
/


create or replace procedure UL_INS_AE_P_REQ_E(v_doc_no               numeric,
    v_doc_stat             varchar,
    v_proposal             varchar,
    v_requestor            varchar,
    v_req_date             date,
    v_desired_date         date,
    v_description          varchar,
    v_region_code          varchar,
    v_fac_id               varchar,
    v_bldg                 varchar,
    v_in_location          varchar,
    v_budget               ae_p_req_e.budget%type,
    v_contact              varchar,
    v_contact_ph           varchar,
    v_contact_mc           varchar,
    v_problem_code         varchar,
    v_wr_comment           varchar,
    v_reference_no         varchar,
    v_funding_code         varchar,
    v_sub_code             varchar,
    v_cust_pri             varchar,
    v_crt_flag             varchar,
    v_login                varchar,
    v_ent_date             date,
    v_shop                 varchar,
    v_in_loc_id               varchar,
    v_action_code          varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_edit_clerk            varchar,
    v_company_id            varchar,
    v_dept_id               varchar,
    v_oc_code               varchar,
    v_sort_code             varchar,
    v_long_desc             varchar)
as
        v_location  ae_p_req_e.location_code%type;
        v_con_doc_no numeric(8,0);
        v_loc_id ae_b_loc_d.loc_id%type;
        v_screen_security integer;
        v_prompt varchar(50);
        v_version_security integer;
        v_oc_code2 ae_p_req_e.oc_code%TYPE;
        v_dept_id2 ae_p_req_e.dept_id%TYPE;
        v_company_id2 ae_p_req_e.company_id%TYPE;
        v_status_code ae_p_req_e.status_code%TYPE;
        v_seq numeric(8,0);
    cursor c_loc_id(v_region_code ae_b_loc_d.region_code%type,
                    v_fac_id ae_b_loc_d.fac_id%type,
                    v_bldg ae_b_loc_d.bldg%type,
                    v_location ae_b_loc_d.location_code%type) is
    	select min(loc_id)
    	  from ae_b_loc_d, ae_b_loc_s
    	 where region_code = v_region_code
    	   and fac_id = v_fac_id
    	   and bldg = v_bldg
    	   and location_code = v_location
           and ae_b_loc_d.loc_status = ae_b_loc_s.loc_status
           and complete_yn <> 'Y';
    cursor c_oc_code(v_requestor ae_s_usr_d.requestor%type) is
        select oc_code,
                dept_id,
                company_id
          from ae_s_usr_d
         where requestor = v_requestor;
    cursor c_status_code is
        select status_code, seq
          from ae_p_req_stat_e
         where complete_yn = 'O'
           and active = 'Y'
         order by seq, status_code;
begin
mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'CUSTOMER_REQUEST_INSERT';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

mfm_gen_transaction_number( 'N', v_con_doc_no);

if (rtrim(v_in_location) = '' ) or (v_in_location is null) then
    v_location := null;
    v_loc_id := null;
else
    v_location := v_in_location;
    v_loc_id := v_in_loc_id;
end if;

if (rtrim(v_in_loc_id) = '' ) or (v_in_loc_id is null) then
    v_loc_id := null;
else
    v_loc_id := v_in_loc_id;
end if;

if v_location is not null and v_loc_id is null then
    open c_loc_id(v_region_code, v_fac_id, v_bldg, v_location);
    fetch c_loc_id into v_loc_id;
    close c_loc_id;
end if;

if v_requestor is not null and ((rtrim(v_oc_code) = '' ) or (v_oc_code is null)) then
    open c_oc_code(v_requestor);
    fetch c_oc_code into v_oc_code2, v_dept_id2, v_company_id2;
    close c_oc_code;
else
    v_oc_code2 := v_oc_code;
    v_dept_id2 := v_dept_id;
    v_company_id2 := v_company_id;
end if;

open c_status_code;
fetch c_status_code into v_status_code, v_seq;
close c_status_code;

insert into ae_p_req_e(
    doc_no,
    status_code,
    proposal,
    requestor,
    req_date,
    desired_date,
    description,
    region_code,
    fac_id,
    bldg,
    location_code,
    loc_id,
    budget,
    contact,
    contact_ph,
    contact_mc,
    problem_code,
    wr_comment,
    reference_no,
    funding_code,
    sub_code,
    cust_pri,
    crt_flag,
    login,
    ent_date,
    shop,
    edit_date,
    edit_clerk,
    company_id,
    dept_id,
    oc_code,
    sort_code,
    long_desc
) values (
    v_con_doc_no,
    v_status_code,
    v_proposal,
    v_requestor,
    v_req_date,
    v_desired_date,
    v_description,
    v_region_code,
    v_fac_id,
    v_bldg,
    v_location,
    v_loc_id,
    v_budget,
    v_contact,
    v_contact_ph,
    v_contact_mc,
    v_problem_code,
    v_wr_comment,
    v_reference_no,
    v_funding_code,
    v_sub_code,
    v_cust_pri,
    v_crt_flag,
    v_login,
    v_ent_date,
    v_shop,
    v_edit_date,
    v_edit_clerk,
    v_company_id2,
    v_dept_id2,
    v_oc_code2,
    v_sort_code,
    v_long_desc
);

insert into mfm_ae_p_req_e_delete values(
v_doc_no,
v_login,
v_pda_id,
v_edit_clerk
);

insert into ae_p_req_stat_hist values(
v_con_doc_no,
v_status_code,
sysdate,
v_login,
null,
sysdate,
v_edit_clerk
);

end;
/


create or replace procedure UL_INS_AE_P_STA_E(v_proposal             in out varchar,
    v_status_code            varchar,
    v_status_date            date,
    v_login                  varchar,
    v_category               varchar,
    v_pda_id                 varchar,
    v_action_flag            varchar,
    v_edit_date            date,
    v_download_date        date,
    v_order_type           varchar,
    v_edit_clerk           varchar)
as
        v_prompt varchar(50);
        v_screen_security integer;
        v_version_security integer;
        v_con_proposal ae_p_pro_e.proposal%type;
        v_last_status_date date;
        v_status_count integer;
        v_status_exists integer;
        v_post_date date;
--        cursor c_last_status(v_proposal ae_p_pro_e.proposal%type,
--                             v_status_code ae_p_pro_e.status_code%type) is
--         select max(status_date), count(*)
--           from ae_p_sta_e
--          where proposal = v_proposal
--            and status_code = v_status_code;
        cursor c_check_status(v_proposal ae_p_pro_e.proposal%type,
                             v_status_code ae_p_pro_e.status_code%type,
                             v_status_date ae_p_sta_e.status_date%type) is
         select count(*)
           from ae_p_sta_e
          where proposal = v_proposal
--            and status_code = v_status_code
            and status_date = v_status_date;
        v_message varchar(1000);
       cursor c_old_wr(v_proposal   ae_p_pro_e.proposal%type) is
            select status_code
              from ae_p_pro_e
             where proposal = v_proposal;
             v_shop_active  integer;
            v_old_edit_date            date;
            v_old_status_code   ae_p_phs_e.status_code%type;
begin
mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'WORKORDER_UPDATE';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

mfm_check_proposal_xref(v_login, v_pda_id, v_proposal, v_con_proposal);

v_proposal := v_con_proposal;

/*
v_message := 'Inserting Status History ' || rtrim(v_status_code) || ' into WR ' || rtrim(v_proposal) ;
mfm_bo_wr_phase_open( v_message, v_proposal, '', v_screen_security );
if v_screen_security <> 1 then
    return;
end if;
*/

/* old
open c_last_status(v_proposal, v_status_code);
fetch c_last_status into v_last_status_date, v_status_count;
close c_last_status;
*/


open c_old_wr(v_proposal);
fetch c_old_wr into v_old_status_code;
close c_old_wr;

if rtrim(v_old_status_code) <> rtrim(v_status_code) then
    v_message := 'WR ' || rtrim(v_proposal) || ' has been updated by another user or pda status update was rejected, ignoring status change history ' || trim(v_status_code) ||', Skipping Record';
    raise_application_error(-20000, v_message);
end if;

v_post_date := sysdate;

while true
loop
    open c_check_status(v_proposal, v_status_code, v_post_date);
    fetch c_check_status into v_status_exists;
    close c_check_status;

    if v_status_exists > 0 then
        v_post_date := v_post_date + (1/24/60/60);
    else
        exit;
    end if;
end loop;


insert into ae_p_sta_e(proposal, status_code, status_date, login, category, order_type, edit_clerk)
	values(trim(v_proposal), trim(v_status_code), v_post_date, trim(v_login), trim(v_category), v_order_type, v_edit_clerk);

insert into mfm_ae_p_sta_e_delete(proposal, status_code, status_date, login, pda_id)
	values(trim(v_proposal), trim(v_status_code), v_status_date, trim(v_login), trim(v_pda_id));



/*
if (v_status_count > 0) and (v_last_status_date < v_status_date) then
    update ae_p_pro_e
       set status_code = v_status_code,
            category = v_category,
            edit_date = sysdate
     where proposal = v_proposal;
end if;
*/

end;
/


create or replace procedure UL_INS_AE_P_WKA_D(v_shop_person          varchar,
    v_sched_date           date,
    v_act_hrs              ae_p_wka_d.act_hrs%type,
    v_trans_no             numeric,
    v_item_no              in out numeric,
    v_time_type            varchar,
    v_proposal             in out varchar,
    v_sort_code            varchar,
    v_start_time           numeric,
    v_stop_time            numeric,
    v_action_flag          varchar,
    v_entry_clerk          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_action_taken         varchar,
    v_labor_class          varchar,
    v_lev_code             varchar,
    v_edit_clerk           varchar,
    v_craft_code           varchar)
as
    v_status_flag ae_p_pst_c.complete_yn%type;
    v_con_trans_no numeric(8,0);
    v_header_count   numeric(8,0);
    v_con_post_flag  varchar(1);
    v_detail_count   numeric(8,0);
    v_screen_security integer;
    v_prompt varchar(50);
    v_version_security integer;
    v_con_proposal ae_p_pro_e.proposal%type;
    v_pda_item_no numeric(8,0);
    v_overlapping_timecards integer;
    cursor c_timecard_header(v_shop_person ae_p_wka_e.shop_person%type,
                             v_sched_date ae_p_wka_e.sched_date%type) is
                    select 	count(*),
                            min(trans_no)
                    from 	ae_p_wka_e
                    where 	shop_person = v_shop_person
                    and 	trunc(sched_date) = trunc(v_sched_date);
    cursor c_timecard_post_flag(v_con_trans_no ae_p_wka_e.trans_no%type) is
                    select post_flag
                      from ae_p_wka_e
                     where trans_no = v_con_trans_no;
    cursor c_timecard_item_no(v_con_trans_no ae_p_wka_d.item_no%type) is
                    select max(item_no),
                            count(*)
                    from ae_p_wka_d
                    where	trans_no = v_con_trans_no;
    cursor c_phase_status_flag(v_proposal ae_p_phs_e.proposal%type,
                      v_sort_code ae_p_phs_e.sort_code%type) is
                    select ae_p_pst_c.complete_yn
                      from ae_p_phs_e, ae_p_pst_c
                     where ae_p_phs_e.proposal = v_proposal
                       and ae_p_phs_e.sort_code = v_sort_code
                       and ae_p_phs_e.order_type = ae_p_pst_c.order_type
                       and ae_p_phs_e.category = ae_p_pst_c.category
                       and ae_p_phs_e.status_code = ae_p_pst_c.status_code
                       ;
    cursor c_phase_status_date(v_proposal ae_p_phs_e.proposal%type,
                      v_sort_code ae_p_phs_e.sort_code%type) is
                    select max(ae_p_pst_e.status_date)
                      from ae_p_phs_e, ae_p_pst_e
                     where ae_p_phs_e.proposal = v_proposal
                       and ae_p_phs_e.sort_code = v_sort_code
                       and ae_p_phs_e.order_type = ae_p_pst_e.order_type
                       and ae_p_phs_e.category = ae_p_pst_e.category
                       and ae_p_phs_e.status_code = ae_p_pst_e.status_code
                       ;
    v_status_date date;
    v_message varchar(1000);
    v_shop_active integer;
    cursor c_labor_class_count(v_shop_person ae_h_emp_e.shop_person%type,
                            v_time_type ae_l_man_d.time_type%type,
                            v_labor_class ae_l_man_d.labor_class%type,
                            v_sched_date ae_p_wka_e.sched_date%type) is
                     select count(*), max(labor_rate)
                       from ae_l_man_d
                      where shop_person = v_shop_person
                        and labor_class = v_labor_class
                        and time_type = v_time_type
                        and (start_date <= v_sched_date or start_date is null)
                        and (end_date >= v_sched_date or end_date is null);
    cursor c_labor_class_shop_count(v_shop_person ae_h_emp_e.shop_person%type,
                            v_time_type ae_l_man_d.time_type%type,
                            v_labor_class ae_l_man_d.labor_class%type,
                            v_sched_date ae_p_wka_e.sched_date%type) is
               select count(*), max(labor_rate)
              from
              	ae_l_shp_d, ae_l_shp_e, ae_l_shp_c
              where  ae_l_shp_e.active = 'Y'
              and  ae_l_shp_d.shop_person = v_shop_person
              and  ae_l_shp_c.labor_class = v_labor_class
              and  ae_l_shp_c.time_type = v_time_type
              and ae_l_shp_e.shop = ae_l_shp_d.shop
              and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_sched_date)
              and ae_l_shp_e.shop = ae_l_shp_c.shop
              and (ae_l_shp_c.start_date is null
               or  ae_l_shp_c.start_date <= v_sched_date)
              and (ae_l_shp_c.end_date is null
               or  ae_l_shp_c.end_date >= v_sched_date);

    v_time_type_labor_class_count integer;
    v_time_type_labor_class_s_cnt integer;
    v_con_labor_rate ae_l_man_d.labor_rate%type;
      cursor c_active_yn(v_shop_person ae_h_emp_e.shop_person%type) is
         select active
           from ae_h_emp_e
          where shop_person = v_shop_person;
     v_active ae_h_emp_e.active%type;
     cursor c_sum_hrs(a_trans_no ae_p_wka_e.trans_no%type) is
      select sum(act_hrs)
        from ae_p_wka_d
       where trans_no = a_trans_no;
     cursor c_24_hr_flag is
      select parameter
        from ae_s_sys_f
       where flag_id = 109;
     v_sum_hrs ae_p_wka_d.act_hrs%type;
     v_24_hr_flag ae_s_sys_f.parameter%type;
    cursor c_overlap(v_shop_person ae_p_wka_e.shop_person%TYPE,
                     v_sched_date ae_p_wka_e.sched_date%TYPE,
                     v_start_time ae_p_wka_d.start_time%TYPE,
                     v_stop_time ae_p_wka_d.stop_time%TYPE) is
             select count(*)
          from ae_p_wka_d, ae_p_wka_e
         where ae_p_wka_e.shop_person = v_shop_person
        	and ae_p_wka_e.sched_date = v_sched_date
        	and ae_p_wka_e.trans_no = ae_p_wka_d.trans_no
        	and ae_p_wka_d.start_time is not null
        	and ( (ae_p_wka_d.start_time <= v_start_time
        				and v_start_time < ae_p_wka_d.stop_time)
        		or  (ae_p_wka_d.start_time < v_stop_time
        				and v_stop_time <= ae_p_wka_d.stop_time)
        		or (v_start_time < ae_p_wka_d.start_time
        				and ae_p_wka_d.stop_time < v_stop_time)
        			);

begin

mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'TIMECARD_INSERT';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

mfm_check_proposal_xref( v_login, v_pda_id, v_proposal, v_con_proposal);

v_proposal := v_con_proposal;

v_message := 'Timecard for Shop Person ' || rtrim(v_shop_person) || ' Work Date ' || to_char(v_sched_date);
v_message := v_message || ' WO: ' || v_proposal || ' Phase: ' || v_sort_code || ' Hours: ' || rtrim(ltrim(to_char( v_act_hrs))) || ' Time Type: ' || v_time_type;
v_message := v_message || ' Labor Class: ' || v_labor_class || ' Craft Code: ' || v_craft_code;
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;

v_pda_item_no := v_item_no;

v_status_flag := null;
open c_phase_status_flag(v_proposal, v_sort_code);
fetch c_phase_status_flag into v_status_flag;
close c_phase_status_flag;

if v_status_flag = 'Y' then
    v_message := 'WO/Phase for timecard for Shop Person ' || rtrim(v_shop_person) || ' Work Date ' || to_char(v_sched_date) || ' is closed, Skipping Record';
    v_message := v_message || ' WO: ' || v_proposal || ' Phase: ' || v_sort_code ;
    raise_application_error(-20000, v_message);
    return;
end if;

if v_status_flag = 'E' then
    v_status_date := null;
    open c_phase_status_date(v_proposal, v_sort_code);
    fetch c_phase_status_date into v_status_date;
    close c_phase_status_date;

    if trunc(v_sched_date) > trunc(v_status_date) then
        v_message := 'WO/Phase for timecard for Shop Person ' || rtrim(v_shop_person) || ' Work Date ' || to_char(v_sched_date) || ' is PM Complete, Skipping Record';
        v_message := v_message || ' WO: ' || v_proposal || ' Phase: ' || v_sort_code ;
        raise_application_error(-20000, v_message);
        return;
    end if;
end if;

if v_status_flag = 'C' then
    v_status_date := null;
    open c_phase_status_date(v_proposal, v_sort_code);
    fetch c_phase_status_date into v_status_date;
    close c_phase_status_date;

    if trunc(v_sched_date) > trunc(v_status_date) then
        v_message := 'WO/Phase for timecard for Shop Person ' || rtrim(v_shop_person) || ' Work Date ' || to_char(v_sched_date) || ' is Work Complete, Skipping Record';
        v_message := v_message || ' WO: ' || v_proposal || ' Phase: ' || v_sort_code ;
        raise_application_error(-20000, v_message);
        return;
    end if;
end if;

if v_act_hrs <= 0.0 then
    raise_application_error(-20000, 'Timecard hours must be positive, Skipping Record');
    return;
end if;

open c_active_yn(v_shop_person);
fetch c_active_yn into v_active;
close c_active_yn;
if trim(v_active) = 'Y' then
    null;
else
    raise_application_error(-20000,  v_shop_person || ' is inactive, Skipping Record');
    return;
end if;

open c_timecard_header(v_shop_person, v_sched_date);
fetch c_timecard_header into v_header_count, v_con_trans_no;
close c_timecard_header;

if v_header_count = 0 or v_header_count is null then
    mfm_gen_transaction_number('M', v_con_trans_no);
	insert into ae_p_wka_e(shop_person, entry_clerk, entry_date, trans_no,
                           post_flag, sched_date, edit_date, edit_clerk)
                   values (rtrim(v_shop_person), rtrim(v_entry_clerk), v_edit_date, v_con_trans_no,
                           'N', v_sched_date, v_edit_date, rtrim(v_entry_clerk) );
   	v_item_no := 1;
else
    open c_timecard_post_flag(v_con_trans_no);
    fetch c_timecard_post_flag into v_con_post_flag;
    close c_timecard_post_flag;
    if v_con_post_flag = 'Y' then
        v_message := 'Timecard for Shop Person ' || rtrim(v_shop_person) || ' Work Date ' || to_char(v_sched_date) || ' is already approved, Skipping Record';
        v_message := v_message || ' WO: ' || v_proposal || ' Phase: ' || v_sort_code || ' Hours: ' || rtrim(ltrim(to_char( v_act_hrs))) || ' Time Type: ' || v_time_type;
        v_message := v_message || ' Labor Class: ' || v_labor_class || ' Craft Code: ' || v_craft_code;
        raise_application_error(-20000, v_message);
        return;
    end if;

    open c_timecard_item_no(v_con_trans_no);
    fetch c_timecard_item_no into v_item_no, v_detail_count;
    close c_timecard_item_no;

	if v_detail_count = 0 then
     	v_item_no := 1;
	else
		v_item_no := v_item_no + 1;
    end if;
end if;

v_time_type_labor_class_count := null;
open c_labor_class_count(v_shop_person, v_time_type, v_labor_class, v_sched_date);
fetch c_labor_class_count into v_time_type_labor_class_count, v_con_labor_rate;
close c_labor_class_count;

v_time_type_labor_class_s_cnt := null;
open c_labor_class_shop_count(v_shop_person, v_time_type, v_labor_class, v_sched_date);
fetch c_labor_class_shop_count into v_time_type_labor_class_s_cnt, v_con_labor_rate;
close c_labor_class_shop_count;

if (v_time_type_labor_class_count is null or v_time_type_labor_class_count < 1) and
    (v_time_type_labor_class_s_cnt is null or v_time_type_labor_class_s_cnt < 1) then
    v_message := 'Timecard for Shop Person ' || rtrim(v_shop_person) || ' Work Date ' || to_char(v_sched_date) || ' has invalid time type/labor class, Skipping Record';
    v_message := v_message || ' WO: ' || v_proposal || ' Phase: ' || v_sort_code || ' Hours: ' || rtrim(ltrim(to_char( v_act_hrs))) || ' Time Type: ' || v_time_type;
    v_message := v_message || ' Labor Class: ' || v_labor_class || ' Craft Code: ' || v_craft_code;
    raise_application_error(-20000, v_message);
    return;
end if;

open c_24_hr_flag;
fetch c_24_hr_flag into v_24_hr_flag;
close c_24_hr_flag;

if v_24_hr_flag = 'Y' then
    open c_sum_hrs(v_con_trans_no);
    fetch c_sum_hrs into v_sum_hrs;
    close c_sum_hrs;

    if v_sum_hrs is null then
        v_sum_hrs := 0;
    end if;

    v_sum_hrs := v_sum_hrs + v_act_hrs;

    if v_sum_hrs > 24.0 then
        v_message := 'Timecard for Shop Person ' || rtrim(v_shop_person) || ' Work Date ' || to_char(v_sched_date) || ' exceeds 24 hrs';
        raise_application_error(-20000, v_message);
        return;
    end if;

end if;

open c_overlap(v_shop_person, v_sched_date, v_start_time, v_stop_time);
fetch c_overlap into v_overlapping_timecards;
close c_overlap;

if (v_overlapping_timecards > 0) then
    v_message := 'Timecard for Shop Person ' || rtrim(v_shop_person) || ' Work Date ' || to_char(v_sched_date) || ' overlaps an existing timecard, Skipping Record.';
    v_message := v_message || ' WO: ' || v_proposal || ' Phase: ' || v_sort_code || ' Start Time: ' || rtrim(ltrim(to_char( v_start_time))) || 
     ' Stop Time: ' || rtrim(ltrim(to_char( v_stop_time))) || ' Time Type: ' || v_time_type;
    v_message := v_message || ' Labor Class: ' || v_labor_class || ' Craft Code: ' || v_craft_code;
    raise_application_error(-20000, v_message);
    return;
end if;


insert into ae_p_wka_d(
    sort_code,
    proposal,
    act_hrs,
    item_no,
    time_type,
    craft_code,
    action_taken,
    labor_class,
    lev_code,
    trans_no,
    start_time,
    stop_time,
    edit_date,
    edit_clerk
) values (
    v_sort_code,
    v_proposal,
    v_act_hrs,
    v_item_no,
    v_time_type,
    v_craft_code,
    v_action_taken,
    v_labor_class,
    v_lev_code,
    v_con_trans_no,
    v_start_time,
    v_stop_time,
    v_edit_date,
    v_edit_clerk
);

insert into mfm_ae_p_wka_d_delete(trans_no, item_no, login, pda_id )  values(
    v_trans_no,
    v_pda_item_no,
    v_login,
    v_pda_id
    );



end;
/


create or replace procedure UL_INS_MFM_CYCLE_COUNT_TO_DL(v_warehouse mfm_cycle_count_to_download.warehouse%type,
     v_set_no mfm_cycle_count_to_download.set_no%type,
     v_login mfm_cycle_count_to_download.login%type,
     v_pda_id mfm_cycle_count_to_download.pda_id%type,
     v_edit_date mfm_cycle_count_to_download.edit_date%type,
     v_edit_clerk mfm_cycle_count_to_download.edit_clerk%type)
as
begin

insert into mfm_cycle_count_to_download(warehouse, set_no, login, pda_id, edit_date, edit_clerk) 
values(v_warehouse, v_set_no, v_login, v_pda_id, v_edit_date, v_edit_clerk);
end;
/


create or replace procedure UL_INS_MFM_RELOAD(v_login  varchar,
    v_pda_id in out varchar)
as
begin

v_pda_id := 'PDA_ID';

update ml_subscription
   set progress = 0
 where user_id in (select user_id
                   from ml_user
                  where upper(name) = upper(v_login));

	delete from mfm_ae_p_phs_e_download
	 where upper(rtrim(login)) = upper(rtrim(v_login))
	   and upper(rtrim(pda_id)) = upper(rtrim(v_pda_id));

end;
/


create or replace procedure UL_INS_MFM_ROUTES_DL(v_route_no varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_action_flag          varchar)
as
begin

insert into mfm_routes_download values(v_route_no, v_login, v_pda_id, v_login);
end;
/


create or replace procedure UL_INS_MFM_SETUP(v_login  varchar,
    v_pda_id varchar)
as
begin
null;
    insert into mfm_setup values( v_login, v_pda_id, null, null);
end;
/


create or replace procedure UL_INS_MFM_USER_PDA(v_login                varchar,
    v_memory               numeric)
as
begin

delete from mfm_user_pda where upper(login) = upper(v_login);

insert into mfm_user_pda values(v_login, v_memory, sysdate, v_login);

end;
/


create or replace procedure UL_INS_MFM_WAREHOUSE_FOR_PO_DL(v_warehouse varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date)
as
begin

insert into mfm_warehouse_for_po_download values(v_warehouse, v_login, v_pda_id, v_login);
end;
/


create or replace procedure UL_UPD_AE_I_POE_D(
   v_vend_part            varchar,
    v_vend_dsc             varchar,
    v_vend_uom             varchar,
    v_po_vend_qty             numeric,
    v_po_rec_qty           numeric,
    v_po_rej_qty           numeric,
    v_vend_qty              in out numeric,
    v_rec_qty              in out numeric,
    v_rej_qty              in out numeric,
    v_reject_code          varchar,
    v_action_flag          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_edit_clerk            varchar,
    v_po_code               varchar,
    v_po_item              numeric)
as
        v_con_doc_num  numeric(8,0);
        v_rowcount      numeric(8,0);
        v_con_seq    numeric(8,0);
        v_error  numeric(8,0);
        v_complete_yn    varchar(1);
        v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
		cursor c_doc_num(v_po_code mfm_ae_i_rec_c_trans_no.po_code%type,
						v_login mfm_ae_i_rec_c_trans_no.login%type,
						v_pda_id mfm_ae_i_rec_c_trans_no.pda_id%type) is
		    select doc_num,
		            seq
		      from mfm_ae_i_rec_c_trans_no
		      where po_code = v_po_code
		        and upper(login) = upper(v_login)
		        and pda_id = v_pda_id;
       cursor c_rej_desc(v_reject_code ae_i_poe_r.reject_code%type) is
             select description
               from ae_i_rej_e
              where reject_code = v_reject_code;
       v_description ae_i_rej_e.description%type;
       v_inv_flag   ae_i_poe_d.inventory_flag%type;
       v_part       ae_i_poe_d.part%type;
       v_inv_dsc   ae_i_inv_e.description%type;
       v_inv_cost   ae_i_inv_w.whse_cost%type;
begin

mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'PURCHASE_ORDER_RECEIVE_INSERT';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

open c_doc_num(v_po_code, v_login, v_pda_id);
fetch c_doc_num into v_con_doc_num, v_con_seq;
close c_doc_num;

v_con_seq := v_con_seq + 1;

if v_vend_qty is null then
	v_vend_qty := 0;
end if;
if v_rej_qty is null then
	v_rej_qty := 0;
end if;
if v_rec_qty is null then
	v_rec_qty := 0;
end if;

insert into ae_i_poe_f (po_item,
            vend_part,
			vend_qty, rec_qty, tot_dist_qty, doc_num, doc_item, edit_date, edit_clerk  )
select 	po_item,
        vend_part,
        v_vend_qty,
        v_rec_qty,
        0,
        v_con_doc_num,
        v_con_seq,
        v_edit_date,
        v_edit_clerk
from
	ae_i_poe_d
where
	    po_code = v_po_code
	and po_item = v_po_item
	and po_line_status = 'O';

if v_rej_qty > 0 then
    open c_rej_desc(v_reject_code);
    fetch c_rej_desc into v_description;
    close c_rej_desc;
    insert into ae_i_poe_r( doc_num, doc_item, rej_date, rej_qty, seq, reject_code, login, edit_date, edit_clerk, description)
    values( v_con_doc_num,
        v_con_seq, v_edit_date, v_rej_qty, 1, v_reject_code, v_login, v_edit_date, v_edit_clerk, v_description); 
end if;

update mfm_ae_i_rec_c_trans_no
    set seq = v_con_seq
  where po_code = v_po_code
    and upper(login) = upper(v_login)
    and pda_id = v_pda_id;

end;
/


create or replace procedure UL_UPD_AE_I_POE_E(
    v_purchase_order            varchar,
    v_description              varchar,
    v_status_code          varchar,
    v_contractor           varchar,
    v_address_code         varchar,
    v_warehouse            varchar,
    v_recentered           varchar,
    v_action_flag          varchar,
    v_date_rec             date,
    v_recieved_by          varchar,
    v_packing_slip         varchar,
    v_packing_slip_date    date,
    v_ship_type            varchar,
    v_login               varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_bpo_code              varchar,
    v_rec_description              varchar,
    v_po_code               varchar)
as
        v_con_doc_num  numeric(8,0);
        v_rowcount      numeric(8,0);
        v_con_seq    numeric(8,0);
        v_error  numeric(8,0);
        v_addr1  varchar(25);
        v_addr2  varchar(25);
        v_city   varchar(25);
        v_state  varchar(15);
        v_zip    varchar(15);
        v_con_doc_status varchar(20);
        v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
             v_con_bpo_code ae_i_poe_e.bpo_code%type;
		cursor c_bpo(v_po_code ae_i_poe_e.po_code%type) is
			select bpo_code
			  from ae_i_poe_e
			 where po_code = v_po_code;
begin
mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'PURCHASE_ORDER_RECEIVE_INSERT';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

mfm_gen_transaction_number( 'S', v_con_doc_num );
v_con_seq := 0;
insert into mfm_ae_i_rec_c_trans_no values(v_con_doc_num, v_po_code, v_con_seq, v_login, v_pda_id);

select min(status_code)
  into v_con_doc_status
  from ae_i_rec_status_e
 where active = 'Y'
   and complete_yn = 'O'
   and seq = (select min(seq)
                from ae_i_rec_status_e
                where active = 'Y'
                   and complete_yn = 'O');

open c_bpo(v_po_code);
fetch c_bpo into v_con_bpo_code;
close c_bpo;

insert into ae_i_rec_e (doc_num, description, contractor, address_code, date_rec, received_by,
warehouse, packing_slip, packing_slip_date, po_code, bpo_code, edit_date, edit_clerk,
ent_date, entry_clerk, ship_type, status_code)
values (
	v_con_doc_num,
	v_description,
	v_contractor,
    v_address_code,
	v_date_rec,
	v_recieved_by,
	v_warehouse,
	v_packing_slip,
	v_packing_slip_date,
	v_po_code,
    v_con_bpo_code,
    sysdate,
    v_login,
    sysdate,
    v_login,
    v_ship_type,
    v_con_doc_status
    );

insert into ae_i_rec_status_hist(doc_num, status_date, status_code, login, edit_date, edit_clerk)
values( v_con_doc_num,
        sysdate,
        v_con_doc_status,
        v_login,
        sysdate,
        v_login
        );

end;
/


create or replace procedure UL_UPD_AE_L_STOCK_USE(v_qty_used             numeric,
    v_ext_cost             numeric,
    v_posted_yn            varchar,
    v_trans_no             numeric,
    v_action_flag          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_stock_location       varchar,
    v_trans_date           date,
    v_proposal             varchar,
    v_sort_code            varchar,
    v_stock_no             varchar)
as
             v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
             v_con_posted_yn varchar(1);
cursor c_posted_yn(    v_stock_location       ae_l_stock_use.stock_location%type,
                       v_trans_date           ae_l_stock_use.trans_date%type,
                       v_proposal             ae_l_stock_use.proposal%type,
                       v_sort_code            ae_l_stock_use.sort_code%type,
                       v_stock_no             ae_l_stock_use.stock_no%type) is
               select posted_yn
                  from ae_l_stock_use
                where stock_location = v_stock_location
                  and trans_date = v_trans_date
                  and proposal = v_proposal
                  and sort_code = v_sort_code
                  and stock_no = v_stock_no;
     v_message varchar(1000);
begin

mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'pro.w_i_stock_use.update';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

v_message := 'Updating Shop Stock for Part ' || rtrim(v_stock_no) || ' into WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code);
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;


open c_posted_yn(    v_stock_location, v_trans_date, v_proposal, v_sort_code, v_stock_no);
fetch c_posted_yn into v_con_posted_yn;
close c_posted_yn;

if rtrim(v_con_posted_yn) = 'Y' then
    raise_application_error(-20000, 'Stock Shop entry already posted, Skipping Record');
    return;
end if;

update ae_l_stock_use
set qty_used = v_qty_used,
    ext_cost = v_ext_cost,
    posted_yn = 'N',
    edit_date = sysdate
where stock_location = v_stock_location
  and trans_date = v_trans_date
  and proposal = v_proposal
  and sort_code = v_sort_code
  and stock_no = v_stock_no;

end;
/


create or replace procedure UL_UPD_AE_P_PHS_E(v_description               varchar,
    v_beg_dt               date,
    v_end_dt               date,
    v_craft_code           varchar,
    v_shop                 varchar,
    v_status_code          varchar,
    v_pri_code             varchar,
    v_login                varchar,
    v_default_dist         varchar,
    v_action_flag          varchar,
    v_wr_category             varchar,
    v_wr_type              varchar,
    v_pmi_basic            varchar,
    v_start_time           date,
    v_tot_hrs              ae_p_phs_e.tot_hrs%type,
    v_tot_lab              ae_p_phs_e.tot_lab%type,
    v_tot_mat              ae_p_phs_e.tot_mat%type,
    v_tot_eqp              ae_p_phs_e.tot_eqp%type,
    v_tot_oth              ae_p_phs_e.tot_oth%type,
    v_pda_id               varchar,
    v_edit_date            in out date,
    v_wr_project           varchar,
    v_wr_requestor         varchar,
    v_wr_region_code       varchar,
    v_wr_fac_id            varchar,
    v_wr_bldg              varchar,
    v_wr_edit_date         date,
    v_location_code        varchar,
    v_loc_id               varchar,
    v_eqp_tag_id           varchar,
    v_asset_tag            varchar,
    v_download_date        date,
    v_entry_clerk          varchar,
    v_long_desc            varchar,
    v_edit_clerk           varchar,
    v_proposal             varchar,
    v_sort_code            varchar)
as
    v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
             v_count int;
    v_old_phase_shop         ae_p_phs_e.shop%type;
    v_old_phase_status_code       ae_p_phs_e.status_code%type;
    v_old_phase_pri_code     ae_p_phs_e.pri_code%type;
    v_old_phase_default_dist    varchar(1);
    v_pda_edit_date             date;
    cursor c_old_phase(v_proposal ae_p_phs_e.proposal%type,
                        v_sort_code ae_p_phs_e.sort_code%type) is
        select shop,
                status_code,
                pri_code,
                default_dist,
                description,
                beg_dt,
                end_dt,
                craft_code,
                eqp_tag_id,
                ent_clerk,
                pmi_basic,
                tot_hrs,
                tot_lab,
                tot_mat,
                tot_eqp,
                tot_oth,
                edit_date
          from ae_p_phs_e
        where proposal = v_proposal
          and sort_code = v_sort_code;
     v_message varchar(1000);
     v_shop_active  integer;
    v_old_description         ae_p_phs_e.description%type;
    v_old_beg_dt         ae_p_phs_e.beg_dt%type;
    v_old_end_dt         ae_p_phs_e.end_dt%type;
    v_old_craft_code     ae_p_phs_e.craft_code%type;
    v_old_eqp_tag_id     ae_p_phs_e.eqp_tag_id%type;
    v_old_login          ae_p_phs_e.ent_clerk%type;
    v_old_pmi_basic      ae_p_phs_e.pmi_basic%type;
    v_old_tot_hrs        ae_p_phs_e.tot_hrs%type;
    v_old_tot_lab        ae_p_phs_e.tot_lab%type;
    v_old_tot_mat        ae_p_phs_e.tot_mat%type;
    v_old_tot_eqp        ae_p_phs_e.tot_eqp%type;
    v_old_tot_oth        ae_p_phs_e.tot_oth%type;
    v_old_edit_date      ae_p_phs_e.edit_date%type;
begin
mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'WORKORDER_UPDATE';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

mfm_check_shop(v_shop_active, v_shop);
if v_shop_active = 0 then
    return;
end if;

v_message := 'Updating Phase ' || rtrim(v_sort_code) || ' into WR ' || rtrim(v_proposal);
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;

v_pda_edit_date := v_edit_date;

open c_old_phase(v_proposal, v_sort_code);
fetch c_old_phase into v_old_phase_shop, v_old_phase_status_code, v_old_phase_pri_code, v_old_phase_default_dist, v_old_description, v_old_beg_dt, v_old_end_dt, v_old_craft_code, v_old_eqp_tag_id, v_old_login, v_old_pmi_basic, v_old_tot_hrs, v_old_tot_lab, v_old_tot_mat, v_old_tot_eqp, v_old_tot_oth, v_old_edit_date;
close c_old_phase;

if v_old_edit_date > v_download_date then
    v_message := 'WR ' || rtrim(v_proposal) || ' Phase ' || rtrim(v_sort_code) || ' has been updated by another user, Skipping Record';
    raise_application_error(-20000, v_message);
end if;

mfm_bo_ae_p_phs_e_status( v_proposal, v_sort_code, v_login, v_wr_type, v_wr_category, v_status_code, v_screen_security);
if v_screen_security <> 1 then
    return;
end if;


/* old
v_pda_edit_date := v_edit_date;
open c_old_phase(v_proposal, v_sort_code);
fetch c_old_phase into v_old_phase_shop, v_old_phase_status_code, v_old_phase_pri_code, v_old_phase_default_dist;
close c_old_phase;
*/

v_edit_date := sysdate;

update ae_p_phs_e
set description = v_description,
    beg_dt = v_beg_dt,
    end_dt = v_end_dt,
    craft_code = v_craft_code,
    shop = v_shop,
    status_code = v_status_code,
    pri_code = v_pri_code,
--    login = v_entry_clerk,
--    default_dist = v_default_dist,
    pmi_basic = v_pmi_basic,
    tot_hrs = v_tot_hrs,
    tot_lab = v_tot_lab,
    tot_mat = v_tot_mat,
    tot_eqp = v_tot_eqp,
    tot_oth = v_tot_oth,
    edit_date = v_edit_date,
    region_code = v_wr_region_code,
    fac_id = v_wr_fac_id,
    bldg = v_wr_bldg,
    location_code = v_location_code,
    loc_id = v_loc_id,
    eqp_tag_id = v_eqp_tag_id,
    ent_clerk = v_entry_clerk,
    long_desc = v_long_desc,
    edit_clerk = v_edit_clerk
where proposal = v_proposal
  and sort_code = v_sort_code;

mfm_bo_ae_p_phs_e(v_proposal, v_sort_code, v_entry_clerk, 'N', v_wr_project, v_wr_requestor, v_wr_region_code, v_wr_fac_id, v_wr_bldg, v_wr_edit_date, v_wr_type, v_wr_category, v_old_phase_shop, v_old_phase_status_code, v_old_phase_pri_code, v_old_phase_default_dist, v_pda_edit_date);


end;
/


create or replace procedure UL_UPD_AE_P_PRO_E(v_description                varchar,
    v_status_code          varchar,
    v_region_code          varchar,
    v_fac_id               varchar,
    v_bldg                 varchar,
    v_category             varchar,
    v_requestor            varchar,
    v_contact              varchar,
    v_contact_ph           varchar,
    v_desired_date         date,
    v_order_type           varchar,
    v_reference_no         varchar,
    v_ent_clerk            varchar,
    v_ent_date             date,
    v_action_flag          varchar,
    v_shop                 varchar,
    v_shop_person          varchar,
    v_req_date             date,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_wr_edit_date         date,
    v_bldgdsc              varchar,
    v_download_date        date,
    v_long_desc            varchar,
    v_project              varchar,
    v_problem_code         varchar,
    v_company_id           varchar,
    v_dept_id              varchar,
    v_oc_code              varchar,
    v_edit_clerk           varchar,
    v_proposal             varchar)
as
             v_prompt varchar(50);
             v_message varchar(1000);
        v_screen_security integer;
             v_version_security integer;
             v_old_status_code   ae_p_pro_e.status_code%type;
             v_old_category ae_p_pro_e.category%type;
       cursor c_old_wr(v_proposal   ae_p_pro_e.proposal%type) is
/*            select category,
                    status_code,
                    description         ,
                    region_code   ,
                    fac_id        ,
                    bldg          ,
                    project           ,
                    requestor     ,
                    contact       ,
                    contact_ph    ,
                    desired_date  ,
                    order_type    ,
                    reference_no  ,
                    ent_clerk     ,
                    ent_date      ,
                    shop          ,
                    shop_person   ,
                    req_date      , */
             select edit_date
              from ae_p_pro_e
             where proposal = v_proposal;
             v_shop_active  integer;
/*            v_old_title                varchar(40);
            v_old_region_code          varchar(6);
            v_old_fac_id               varchar(15);
            v_old_bldg                 varchar(15);
            v_old_ref                  varchar(15);
            v_old_requestor            varchar(25);
            v_old_contact              varchar(25);
            v_old_contact_ph           varchar(15);
            v_old_desired_date         date;
            v_old_order_type           varchar(1);
            v_old_reference_no         varchar(15);
            v_old_ent_clerk            varchar(15);
            v_old_ent_date             date;
            v_old_shop                 varchar(15);
            v_old_shop_person          varchar(15);
            v_old_req_date             date;
            v_old_program_fy           varchar(4);
            v_old_requestor_name       varchar(40);
            v_old_requestor_ph         varchar(15);
            v_old_requestor_mc         varchar(50); */
            v_old_edit_date            date;
begin
mfm_version_security( v_version_security);
if v_version_security <> 1 then
    return;
end if;
v_prompt := 'WORKORDER_UPDATE';
mfm_screen_security( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;
mfm_check_shop(v_shop_active, v_shop);
if v_shop_active = 0 then
    return;
end if;
v_message := 'Update WR ' || v_proposal;
mfm_bo_wr_phase_open( v_message, v_proposal, '', v_screen_security );
if v_screen_security <> 1 then
    return;
end if;
open c_old_wr(v_proposal);
--fetch c_old_wr into v_old_category, v_old_status_code, v_old_title , v_old_region_code , v_old_fac_id , v_old_bldg , v_old_ref , v_old_requestor , v_old_contact , v_old_contact_ph , v_old_desired_date , v_old_order_type , v_old_reference_no , v_old_ent_clerk , v_old_ent_date , v_old_shop , v_old_shop_person , v_old_req_date , v_old_program_fy , v_old_requestor_name, v_old_requestor_ph , v_old_requestor_mc, v_old_edit_date;
fetch c_old_wr into v_old_edit_date;
close c_old_wr;
if v_old_edit_date > v_download_date then
    v_message := 'WR ' || rtrim(v_proposal) || ' has been updated by another user, Skipping Record';
    raise_application_error(-20000, v_message);
end if;
mfm_bo_ae_p_pro_e_status( v_proposal, v_login, v_order_type, v_category, v_status_code, v_screen_security);
if v_screen_security <> 1 then
    return;
end if;


/* old
open c_old_wr(v_proposal);
fetch c_old_wr into v_old_category, v_old_status_code;
close c_old_wr;
*/


update ae_p_pro_e
set description = v_description,
    status_code = v_status_code,
    region_code = v_region_code,
    fac_id = v_fac_id,
    bldg = v_bldg,
    category = v_category,
    requestor = v_requestor,
    contact = v_contact,
    contact_ph = v_contact_ph,
    desired_date = v_desired_date,
    order_type = v_order_type,
    reference_no = v_reference_no,
    ent_clerk = v_ent_clerk,
    ent_date = v_ent_date,
    shop = v_shop,
    shop_person = v_shop_person,
    edit_date = v_edit_date,
    long_desc = v_long_desc,
    project = v_project,
    problem_code = v_problem_code,
    company_id = v_company_id,
    dept_id = v_dept_id,
    oc_code = v_oc_code,
    edit_clerk = v_edit_clerk
where proposal = v_proposal;


/* old
if rtrim(v_status_code) <> rtrim(v_old_status_code) then

    insert into ae_p_sta_e (proposal, status_code, status_date, login, category)
    	values (v_proposal, v_status_code, v_edit_date, v_login, v_category);

end if;
*/

end;
/


create or replace procedure UL_UPD_AE_P_PRO_S(v_primary_yn           varchar,
    v_ent_clerk            varchar,
    v_entrydate            date,
    v_action_flag          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_certified_yn         varchar,
    v_edit_clerk           varchar,
    v_proposal             varchar,
    v_sort_code            varchar,
    v_shop_person          varchar)
as
        v_prompt varchar(50);
        v_screen_security integer;
        v_version_security integer;
        v_message varchar(1000);
        v_new_primary_yn  ae_p_pro_s.primary_yn%type;
        v_shopperson_count integer;
        cursor c_primary_shopperson(v_proposal ae_p_pro_s.proposal%type,
                                       v_sort_code ae_p_pro_s.sort_code%type,
                                       v_shop_person ae_p_pro_s.shop_person%type) is
        select count(*)
          from ae_p_pro_s
         where proposal = v_proposal
           and sort_code = v_sort_code
           and shop_person <> v_shop_person
           and primary_yn = 'Y';
begin
mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'WORKORDER_UPDATE';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

v_message := 'Inserting shop person ' || rtrim(v_shop_person) || ' into WR ' || rtrim(v_proposal)|| ' Phase ' || rtrim(v_sort_code);
mfm_bo_wr_phase_open( v_message, v_proposal, v_sort_code, v_screen_security );
if v_screen_security <> 1 then
    return;
end if;

open c_primary_shopperson(v_proposal, v_sort_code, v_shop_person);
fetch c_primary_shopperson into v_shopperson_count;
close c_primary_shopperson;
if v_shopperson_count > 0 then
    v_new_primary_yn := 'N';
else
    v_new_primary_yn := v_primary_yn;
end if;

update ae_p_pro_s
  set primary_yn = v_primary_yn,
    edit_date = v_edit_date,
    certified_yn = v_certified_yn,
    edit_clerk = v_edit_clerk
where proposal = v_proposal
  and sort_code = v_sort_code
  and shop_person = v_shop_person;

end;
/


create or replace procedure UL_UPD_AE_P_WKA_D(v_shop_person          varchar,
    v_sched_date           date,
    v_act_hrs              ae_p_wka_d.act_hrs%type,
    v_time_type            varchar,
    v_proposal             in out varchar,
    v_sort_code            varchar,
    v_start_time           numeric,
    v_stop_time            numeric,
    v_action_flag          varchar,
    v_entry_clerk          varchar,
    v_login                varchar,
    v_pda_id               varchar,
    v_edit_date            date,
    v_action_taken         varchar,
    v_labor_class          varchar,
    v_lev_code             varchar,
    v_edit_clerk           varchar,
    v_craft_code           varchar,
    v_trans_no             numeric,
    v_item_no              in out numeric)
as
begin

ul_ins_ae_p_wka_d(v_shop_person,
                    v_sched_date,
                    v_act_hrs,
                    v_trans_no,
                    v_item_no,
                    v_time_type,
                    v_proposal,
                    v_sort_code,
                    v_start_time,
                    v_stop_time,
                    v_action_flag,
                    v_entry_clerk,
                    v_login,
                    v_pda_id,
                    v_edit_date,
                    v_action_taken,
                    v_labor_class,
                    v_lev_code,
                    v_edit_clerk,
                    v_craft_code
                    );

end;
/


create or replace procedure UL_UPD_AE_R_EQM_E(v_description   varchar,
    v_region_code    in out varchar,
    v_fac_id         in out varchar,
    v_bldg           in out varchar,
    v_location_code  in out varchar,
    v_loc_id         in out varchar,
    v_shop           varchar,
    v_shop_person    varchar,
    v_warehouse      in out varchar,
    v_bin_location   in out varchar,
    v_eqm_status     in out varchar,
    v_original_cost  ae_r_eqm_e.original_cost%type,
    v_action_flag    varchar,
    v_login          varchar,
    v_pda_id         varchar,
    v_edit_date      date,
    v_inv_dsc    varchar,
    v_eqm_group       varchar,
    long_desc       varchar,
    v_part       varchar,
    v_edit_clerk    varchar,
    v_eqp_tag_id       varchar)
as

            v_now    date;
            v_con_region_code    ae_r_eqm_e.region_code%type;
            v_con_fac_id         ae_r_eqm_e.fac_id%type;
            v_con_bldg           ae_r_eqm_e.bldg%type;
            v_con_location_code  ae_r_eqm_e.location_code%type;
            v_con_loc_id         ae_r_eqm_e.loc_id%type;
            v_con_warehouse      ae_r_eqm_e.warehouse%type;
            v_con_bin_location   ae_r_eqm_e.bin_location%type;
            v_con_eqm_status     ae_r_eqm_e.eqm_status%type;
            v_new_region_code    ae_r_eqm_e.region_code%type;
            v_new_fac_id         ae_r_eqm_e.fac_id%type;
            v_new_bldg           ae_r_eqm_e.bldg%type;
            v_new_location_code  ae_r_eqm_e.location_code%type;
            v_new_loc_id         ae_r_eqm_e.loc_id%type;
            v_new_warehouse      ae_r_eqm_e.warehouse%type;
            v_new_bin_location   ae_r_eqm_e.bin_location%type;
            v_new_eqm_status     ae_r_eqm_e.eqm_status%type;
            v_update_location         varchar(1);
            v_update_status          varchar(1);
            v_con_complete_yn            varchar(1);
            v_message               varchar(100);
        v_new_trans_num   numeric(12,0);
        v_prompt varchar(50);
        v_screen_security integer;
        v_version_security integer;
		cursor c_eqp_location(v_eqp_tag_id	ae_r_eqm_e.eqp_tag_id%type) is
		    select ae_r_eqm_e.region_code,
		            ae_r_eqm_e.fac_id,
		            ae_r_eqm_e.bldg,
		            ae_r_eqm_e.location_code,
		            ae_r_eqm_e.loc_id,
		            ae_r_eqm_e.warehouse,
		            ae_r_eqm_e.bin_location,
		            ae_r_eqm_e.eqm_status,
                    ae_r_eqm_s.complete_yn
		      from ae_r_eqm_e, ae_r_eqm_s
		      where ae_r_eqm_e.eqp_tag_id = v_eqp_tag_id
                ;
--    cursor c_loc_id(v_region_code ae_b_loc_d.region_code%type,
--    				v_fac_id ae_b_loc_d.fac_id%type,
--    				v_bldg ae_b_loc_d.bldg%type,
--    				v_location_code ae_b_loc_d.location_code%type) is
--        select loc_id
--          from ae_b_loc_d
--         where region_code = v_region_code
--           and  fac_id = v_fac_id
--           and  bldg = v_bldg
--           and  location_code = v_location_code;

begin
	mfm_version_security( v_version_security );
	if v_version_security <> 1 then
	    return;
	end if;

	v_prompt := 'EQUIPMENT_DEFINITION_UPDATE';
	mfm_screen_security ( v_screen_security, v_login, v_prompt);
	if v_screen_security <> 1 then
	    return;
	end if;

    v_now := sysdate;
    v_update_location := 'N';
    v_update_status := 'N';

	open c_eqp_location(v_eqp_tag_id);
	fetch c_eqp_location into v_con_region_code, v_con_fac_id, v_con_bldg, v_con_location_code,
    		v_con_loc_id, v_con_warehouse, v_con_bin_location, v_con_eqm_status, v_con_complete_yn;
	close c_eqp_location;

    if v_con_complete_yn = 'D' then
        v_message := 'Eqp Tag ' || trim(v_eqp_tag_id) || ' has been deactivated.';
        raise_application_error(-20000, v_message);
    	return;
    end if;

    if v_con_region_code is null then
    	v_con_region_code := '';
    end if;
    if v_region_code is null then
    	 v_region_code := '';
    end if;
    if v_con_region_code = v_region_code then
        v_new_region_code := v_con_region_code;
    else
        v_update_location := 'Y';
        v_new_region_code := rtrim(v_region_code);
    end if;

    if v_con_fac_id is null then
    	 v_con_fac_id := '';
    end if;
    if v_fac_id is null then
    	 v_fac_id := '';
    end if;
    if v_con_fac_id = v_fac_id then
        v_new_fac_id := v_con_fac_id;
    else
        v_update_location := 'Y';
        v_new_fac_id := rtrim(v_fac_id);
	end if;

    if v_con_bldg is null then
    	 v_con_bldg := '';
    end if;
    if v_bldg is null then
    	 v_bldg := '';
    end if;
    if v_con_bldg = v_bldg then
        v_new_bldg := v_con_bldg;
    else
        v_update_location := 'Y';
        v_new_bldg := rtrim(v_bldg);
	end if;

    if v_con_location_code is null then
    	 v_con_location_code := '';
    end if;
    if v_location_code is null then
    	 v_location_code := '';
    end if;
    if v_con_location_code = v_location_code then
        v_new_location_code := v_con_location_code;
        v_new_loc_id := rtrim(v_con_loc_id);
    else
        v_update_location := 'Y';
        v_new_location_code := rtrim(v_location_code);
        v_new_loc_id := rtrim(v_loc_id);
	end if;

    if v_con_warehouse is null then
    	 v_con_warehouse := '';
    end if;
    if v_warehouse is null then
    	 v_warehouse := '';
    end if;
    if v_con_warehouse = v_warehouse then
        v_new_warehouse := v_con_warehouse;
    else
        v_update_location := 'Y';
        v_new_warehouse := rtrim(v_warehouse);
	end if;

    if v_con_bin_location is null then
    	 v_con_bin_location := '';
    end if;
    if v_bin_location is null then
    	 v_bin_location := '';
    end if;
    if v_con_bin_location = v_bin_location then
        v_new_bin_location := v_con_bin_location;
    else
        v_update_location := 'Y';
        v_new_bin_location := rtrim(v_bin_location);
	end if;

    if v_con_eqm_status is null then
    	 v_con_eqm_status := '';
    end if;
    if v_eqm_status is null then
    	 v_eqm_status := '';
    end if;
    if v_con_eqm_status = v_eqm_status then
        v_new_eqm_status := v_con_eqm_status;
    else
        v_update_status := 'Y';
        v_new_eqm_status := rtrim(v_eqm_status);
	end if;

    if v_update_status = 'N' and v_update_location = 'N' then
    	return;
   	end if;

    if rtrim(v_new_region_code) = '' then
		 v_new_region_code := null;
    end if;
    if rtrim(v_new_fac_id) = '' then
		 v_new_fac_id := null;
    end if;
    if rtrim(v_new_bldg) = '' then
		 v_new_bldg := null;
    end if;
    if rtrim(v_new_location_code) = '' then
		 v_new_location_code := null;
    end if;
    if rtrim(v_new_loc_id) = '' then
		 v_new_loc_id := null;
    end if;
    if rtrim(v_new_warehouse) = '' then
		 v_new_warehouse := null;
    end if;
    if rtrim(v_new_bin_location) = '' then
		 v_new_bin_location := null;
    end if;
    if rtrim(v_new_eqm_status) = '' then
		 v_new_eqm_status := null;
    end if;

--    if v_region_code is not null then
--    	open c_loc_id(v_region_code, v_fac_id, v_bldg, v_location_code);
--    	fetch c_loc_id into v_new_loc_id;
--    	close c_loc_id;
--    else
--        v_new_loc_id := null;
--    end if;

    update ae_r_eqm_e
       set region_code = v_new_region_code,
            fac_id = v_new_fac_id,
            bldg = v_new_bldg,
            location_code = v_new_location_code,
            loc_id = v_new_loc_id,
            warehouse = v_new_warehouse,
            bin_location = v_new_bin_location,
            eqm_status = v_new_eqm_status,
            edit_date = v_edit_date,
            edit_clerk = v_edit_clerk
      where eqp_tag_id = v_eqp_tag_id;

    if v_update_location = 'Y' then
        mfm_gen_transaction_number( 'EQM_HIST', v_new_trans_num );
        insert into ae_i_eqm_loc_hist(trans_num, date_created, created_by,
                                region_code, fac_id, bldg, location_code,
                                loc_id, warehouse, bin_location, edit_date,
                                edit_clerk, eqp_tag_id)
                values (v_new_trans_num, v_now, v_login,
                        v_new_region_code, v_new_fac_id, v_new_bldg, v_new_location_code,
                        v_new_loc_id, v_new_warehouse, v_new_bin_location, v_edit_date,
                        v_edit_clerk, v_eqp_tag_id);
    end if;

    if v_update_status = 'Y' then
		insert into ae_r_eqm_h (eqm_status, status_date, login, eqp_tag_id)
			values (v_new_eqm_status, v_now, v_login, v_eqp_tag_id);
    end if;

end;
/


create or replace procedure UL_UPD_MFM_CYCLE_COUNT(
    v_warehouse            ae_i_cct_e.warehouse%TYPE,
    v_count_num            ae_i_cct_d.count_num%TYPE,
    v_sched_date           ae_i_cct_d.sched_date%TYPE,
    v_part                 ae_i_cct_d.part%TYPE,
    v_bin_location         ae_i_cct_d.bin_location%TYPE,
    v_count_date           ae_i_cct_d.count_date%TYPE,
    v_count_login          ae_i_cct_d.count_login%TYPE,
    v_count_no             ae_i_cct_d.count_no%TYPE,
    v_sys_qoh              ae_i_cct_d.sys_qoh%TYPE,
    v_edit_date            ae_i_cct_d.edit_date%TYPE,
    v_edit_clerk           ae_i_cct_d.edit_clerk%TYPE,
    v_description          ae_i_inv_e.description%TYPE,
    v_cycle_code           ae_i_inv_e.cycle_code%TYPE,
    v_inv_uom              ae_i_inv_e.inv_uom%TYPE,
    v_login                mfm_cycle_count_to_download.login%TYPE,
    v_pda_id               mfm_cycle_count_to_download.pda_id%TYPE,
    v_action_flag          varchar,
    v_trans_no             ae_i_cct_e.trans_no%TYPE,
    v_set_no               ae_i_cct_d.set_no%TYPE,
    v_item_no              ae_i_cct_d.item_no%TYPE
)
as
             v_screen_security integer;
             v_prompt varchar(50);
             v_version_security integer;
             v_message varchar(100);
             cursor cc_status(a_trans_no ae_i_cct_e.trans_no%type,
                                a_set_no ae_i_cct_e.set_no%type) is
             select count(*)
               from ae_i_cct_e,
                    ae_i_cct_status
              where ae_i_cct_e.trans_no = a_trans_no
                and ae_i_cct_e.set_no = a_set_no
                and ae_i_cct_e.status_code = ae_i_cct_status.status_code
                and ae_i_cct_status.complete_yn = 'C'
                and ae_i_cct_status.active = 'Y';
             v_cc_count integer;   
              
begin

mfm_version_security( v_version_security );
if v_version_security <> 1 then
    return;
end if;

v_prompt := 'CYCLE_COUNT_UPDATE';
mfm_screen_security ( v_screen_security, v_login, v_prompt);
if v_screen_security <> 1 then
    return;
end if;

open cc_status(v_trans_no, v_set_no);
fetch cc_status into v_cc_count;
close cc_status;

if v_cc_count <> 1 then
    v_message := 'Cycle Count ' || to_char(v_trans_no) || ' set no ' || to_char(v_set_no) || ' is not in a counting status.';
    raise_application_error(-20000, v_message);
	return;
end if;


update ae_i_cct_d
set
	count_no = v_count_no,
	count_date = v_count_date,
	count_login = v_login
where trans_no = v_trans_no
	and set_no = v_set_no
	and item_no = v_item_no;

end;
/


create or replace procedure UL_UPD_MFM_CYCLE_COUNT_TO_DL(

     v_pda_id mfm_cycle_count_to_download.pda_id%type,
     v_edit_date mfm_cycle_count_to_download.edit_date%type,
     v_edit_clerk mfm_cycle_count_to_download.edit_clerk%type,
     v_warehouse mfm_cycle_count_to_download.warehouse%type,
     v_set_no mfm_cycle_count_to_download.set_no%type,
     v_login mfm_cycle_count_to_download.login%type)
as
begin

insert into mfm_cycle_count_to_download(warehouse, set_no, login, pda_id, edit_date, edit_clerk) 
values(v_warehouse, v_set_no, v_login, v_pda_id, v_edit_date, v_edit_clerk);
end;
/


create or replace procedure UL_UPD_MFM_RELOAD(v_login  varchar,
    v_pda_id in out varchar)
as
begin

v_pda_id := 'PDA_ID';

end;
/


create or replace procedure UL_UPD_MFM_USER_PDA(v_memory               numeric,
    v_login                varchar)
as
begin

delete from mfm_user_pda where upper(login) = upper(v_login);

insert into mfm_user_pda values(v_login, v_memory, sysdate, v_login);

end;
/

/*==============================================================*/
/* Database package: MFM                                        */
/*==============================================================*/
create or replace package MFM as
   type AE_P_PHS_E_REC is record (
                                                     proposal        ae_p_phs_e.proposal%type,
                                                     sort_code        ae_p_phs_e.sort_code%type,
                                                     description        ae_p_phs_e.description%type,
                                                     beg_dt        ae_p_phs_e.beg_dt%type,
                                                     end_dt        ae_p_phs_e.end_dt%type,
                                                     craft_code        ae_p_phs_e.craft_code%type,
                                                     shop        ae_p_phs_e.shop%type,
                                                     status_code        ae_p_phs_e.status_code%type,
                                                     pri_code        ae_p_phs_e.pri_code%type,
                                                     login        mfm_ae_p_phs_e_download.login%type,
                                                     default_dist        ae_p_phs_e.default_dist%type,
                                                     action_flag      varchar(1),
                                                     category        ae_p_pro_e.category%type,
                                                     order_type        ae_p_pro_e.order_type%type,
                                                     pmi_basic        ae_p_phs_e.pmi_basic%type,
                                                     start_time       date,
                                                     tot_hrs        ae_p_phs_e.tot_hrs%type,
                                                     tot_lab        ae_p_phs_e.tot_lab%type,
                                                     tot_mat        ae_p_phs_e.tot_mat%type,
                                                     tot_eqp        ae_p_phs_e.tot_eqp%type,
                                                     tot_oth        ae_p_phs_e.tot_oth%type,
                                                     pda_id           varchar(128),
                                                     edit_date        date,
                                                     project        ae_p_pro_e.project%type,
                                                     requestor        ae_p_pro_e.requestor%type,
                                                     region_code        ae_p_pro_e.region_code%type,
                                                     fac_id        ae_p_pro_e.fac_id%type,
                                                     bldg        ae_p_pro_e.bldg%type,
                                                     wr_edit_date        ae_p_pro_e.edit_date%type,
                                                     location_code    ae_p_phs_e.location_code%type,
                                                     loc_id                 ae_p_phs_e.loc_id%type,
                                                     eqp_tag_id          ae_p_phs_e.eqp_tag_id%type,
                                                     asset_tag            ae_p_phs_e.asset_tag%type,
                                                     download_date  date,
                                                     ent_clerk          ae_p_phs_e.ent_clerk%type,
                                                     long_desc          ae_p_phs_e.long_desc%type,
                                                     edit_clerk           ae_p_phs_e.edit_clerk%type
                                                     );
   type AE_P_PHS_E_CURSOR is ref cursor return ae_p_phs_e_rec;
   type AE_P_PRO_E_REC is record (
                                              	   proposal        ae_p_pro_e.proposal%type,
                                                     description        ae_p_pro_e.description%type,
                                                     status_code        ae_p_pro_e.status_code%type,
                                                     region_code        ae_p_pro_e.region_code%type,
                                                     fac_id        ae_p_pro_e.fac_id%type,
                                                     bldg        ae_p_pro_e.bldg%type,
                                                     category        ae_p_pro_e.category%type,
                                                     requestor        ae_p_pro_e.requestor%type,
                                                     contact        ae_p_pro_e.contact%type,
                                                     contact_ph        ae_p_pro_e.contact_ph%type,
                                                     desired_date        ae_p_pro_e.desired_date%type,
                                                     order_type        ae_p_pro_e.order_type%type,
                                                     reference_no        ae_p_pro_e.reference_no%type,
                                                     ent_clerk        ae_p_pro_e.ent_clerk%type,
                                                     ent_date        ae_p_pro_e.ent_date%type,
                                                     action_flag      varchar(1),
                                                     shop        ae_p_pro_e.shop%type,
                                                     shop_person        ae_p_pro_e.shop_person%type,
                                                     req_date        ae_p_pro_e.req_date%type,
                                                     login            ae_s_sec_c.login%type,
                                                     pda_id           varchar(128),
                                                     edit_date        date,
                                                     wr_edit_date        ae_p_pro_e.edit_date%type,
                                                     bldg_descripiton ae_s_bld_c.description%type,
                                                     download_date    date,
                                                     long_desc       ae_p_pro_e.long_desc%type,
                                                     project       ae_p_pro_e.project%type,
                                                     problem_code       ae_p_pro_e.problem_code%type,
                                                     company_id       ae_p_pro_e.company_id%type,
                                                     dept_id       ae_p_pro_e.dept_id%type,
                                                     oc_code       ae_p_pro_e.oc_code%type,
                                                     edit_clerk       ae_p_pro_e.edit_clerk%type
                                                     );
   type AE_P_PRO_E_CURSOR is ref cursor return ae_p_pro_e_rec;
   type AE_P_PRO_S_REC is record (
                                                      proposal        ae_p_pro_s.proposal%type,
                                                     sort_code        ae_p_pro_s.sort_code%type,
                                                     shop_person        ae_p_pro_s.shop_person%type,
                                                     primary_yn        ae_p_pro_s.primary_yn%type,
                                                     ent_clerk        ae_p_pro_s.ent_clerk%type,
                                                     entrydate        ae_p_pro_s.entrydate%type,
                                                     action_flag      varchar(1),
                                                     login            ae_s_sec_c.login%type,
                                                     pda_id           varchar(128),
                                                     edit_date        date,
                                                     certified_yn  ae_p_pro_s.certified_yn%type,
                                                     edit_clerk     ae_p_pro_s.edit_clerk%type
                                                     );
   type AE_P_PRO_S_CURSOR is ref cursor return ae_p_pro_s_rec;
   type AE_P_WKA_D_REC is record (
                                                     shop_person ae_p_wka_e.shop_person%type,
                                                     sched_date   ae_p_wka_e.sched_date%type,
                                                     act_hrs        ae_p_wka_d.act_hrs%type,
                                                     trans_no        ae_p_wka_d.trans_no%type,
                                                     item_no        ae_p_wka_d.item_no%type,
                                                     time_type        ae_p_wka_d.time_type%type,
                                                     proposal        ae_p_wka_d.proposal%type,
                                                     sort_code        ae_p_wka_d.sort_code%type,
                                                     start_time        ae_p_wka_d.start_time%type,
                                                     stop_time        ae_p_wka_d.stop_time%type,
                                                     action_flag      varchar(1),
                                                     entry_clerk        ae_p_wka_e.entry_clerk%type,
                                                     login            ae_s_sec_c.login%type,
                                                     pda_id           varchar(128),
                                                     edit_date        date,
                                                     action_taken  ae_p_wka_d.action_taken%type,
                                                     labor_class     ae_p_wka_d.labor_class%type,
                                                     lev_code        ae_p_wka_d.lev_code%type,
                                                     edit_clerk        ae_p_wka_d.edit_clerk%type,
                                                     craft_code      ae_p_wka_d.craft_code%type
                                                     );
   type AE_P_WKA_D_CURSOR is ref cursor return ae_p_wka_d_rec;
   type AE_P_WKA_E_REC is record (
                                                     shop_person        ae_p_wka_e.shop_person%type,
                                                     sched_date        ae_p_wka_e.sched_date%type,
                                                     entry_clerk        ae_p_wka_e.entry_clerk%type,
                                                     entry_date        ae_p_wka_e.entry_date%type,
                                                     trans_no        ae_p_wka_e.trans_no%type
                                                     );
   type AE_P_WKA_E_CURSOR is ref cursor return ae_p_wka_e_rec;
   type AE_I_PTN_E_REC is record (
                                                  pick_ticket_num        ae_i_ptn_e.pick_ticket_num%type,
                                                  description                 ae_i_ptn_e.description%type,
                                                  pick_ticket_status        ae_i_ptn_e.pick_ticket_status%type,
                                                  date_created        ae_i_ptn_e.date_created%type,
                                                  created_by        ae_i_ptn_e.created_by%type,
                                                  warehouse        ae_i_ptn_e.warehouse%type,
                                                  proposal        ae_i_ptn_e.proposal%type,
                                                  sort_code        ae_i_ptn_e.sort_code%type,
                                                  date_needed        ae_i_ptn_e.date_needed%type,
                                                     action_flag      varchar(1),
                                                     login            ae_s_sec_c.login%type,
                                                     pda_id           varchar(128),
                                                     edit_date        date
                                                     );
   type AE_I_PTN_E_CURSOR is ref cursor return ae_i_ptn_e_rec;
   type AE_I_PTN_D_REC is record (
                                                  pick_ticket_num        ae_i_ptn_d.pick_ticket_num%type,
                                                  pick_ticket_item        ae_i_ptn_d.pick_ticket_item%type,
                                                  itm_status        ae_i_ptn_d.itm_status%type,
                                                  part        ae_i_ptn_d.part%type,
                                                  req_qty        ae_i_ptn_d.req_qty%type,
                                                  bin_location        ae_i_ptn_d.bin_location%type,
                                                     action_flag      varchar(1),
                                                     login            ae_s_sec_c.login%type,
                                                     pda_id           varchar(128),
                                                     edit_date        date
                                                     );
   type AE_I_PTN_D_CURSOR is ref cursor return ae_i_ptn_d_rec;
   type AE_I_POE_D_REC is record (
                                                     po_code          ae_i_poe_d.po_code%type,
                                                 	po_item     ae_i_poe_d.po_item%type,
                                                 	vend_part     ae_i_poe_d.vend_part%type,
                                                 	vend_dsc     ae_i_poe_d.vend_dsc%type,
                                                 	vend_uom     ae_i_poe_d.vend_uom%type,
                                                 	po_vend_qty     ae_i_poe_d.vend_qty%type,
                                                 	po_rec_qty     ae_i_poe_d.rec_qty%type,
                                                     po_rej_qty     ae_i_poe_d.rec_qty%type,
                                                 	vend_qty     ae_i_poe_d.vend_qty%type,
                                                 	rec_qty     ae_i_poe_d.rec_qty%type,
                                                     rej_qty     ae_i_poe_d.rec_qty%type,
                                                     reject_code     ae_i_rej_e.reject_code%type,
                                                     action_code varchar(1),
                                                     login ae_s_sec_c.login%type,
                                                     pda_id varchar(128),
                                                     edit_date date,
                                                     edit_clerk varchar(128)
                                                     );
   type AE_I_POE_E_REC is record (
                                                 	purchase_order     ae_i_poe_e.purchase_order%type,
                                                 	po_code     ae_i_poe_e.po_code%type,
                                                 	description     ae_i_poe_e.description%type,
                                                 	status_code     ae_i_poe_e.status_code%type,
                                                 	contractor     ae_i_poe_e.contractor%type,
                                                 	address_code     ae_i_poe_e.address_code%type,
                                                 	warehouse     ae_i_poe_e.warehouse%type,
                                                 	recentered     varchar(1),
                                                     action_flag     varchar(1),
                                                     date_rec     ae_i_rec_e.date_rec%type,
                                                     received_by     ae_i_rec_e.received_by%type,
                                                     packing_slip     ae_i_rec_e.packing_slip%type,
                                                     packing_slip_date     ae_i_rec_e.packing_slip_date%type,
                                                     ship_type     ae_i_rec_e.ship_type%type,
                                                     login ae_s_sec_c.login%type,
                                                     pda_id varchar(128),
                                                     edit_date date,
                                                     bpo_code     ae_i_rec_e.bpo_code%type,
                                                     rec_description     ae_i_rec_e.description%type
                                                     );
   type AE_P_PHS_E_DELETE_REC is record (
                                              proposal    ae_p_phs_e.proposal%type,
                                              sort_code    ae_p_phs_e.sort_code%type
                                              );
   type AE_P_PHS_E_DELETE_CURSOR is ref cursor return ae_p_phs_e_delete_rec;
   type AE_R_EQM_E_REC is record (
                                description   ae_r_eqm_e.description%type,
                                region_code    ae_r_eqm_e.region_code%type,
                                fac_id         ae_r_eqm_e.fac_id%type,
                                bldg           ae_r_eqm_e.bldg%type,
                                location_code  ae_r_eqm_e.location_code%type,
                                loc_id               ae_r_eqm_e.loc_id%type,
                                shop           ae_r_eqm_e.shop%type,
                                shop_person    ae_r_eqm_e.shop_person%type,
                                warehouse      ae_r_eqm_e.warehouse%type,
                                bin_location   ae_r_eqm_e.bin_location%type,
                                eqm_status     ae_r_eqm_e.eqm_status%type,
                                original_cost  ae_r_eqm_e.original_cost%type,
                                action_flag    varchar(1),
                                login          varchar(128),
                                pda_id         varchar(128),
                                edit_date      ae_r_eqm_e.edit_date%type,
                                inv_dsc        ae_i_inv_e.description%type,
                                eqm_group   ae_r_eqm_e.eqm_group%type,
                                eqp_tag_id   ae_r_eqm_e.eqp_tag_id%type,
                                long_desc    ae_r_eqm_e.long_desc%type,
                                part              ae_r_eqm_e.part%type,
                                edit_clerk      ae_r_eqm_e.edit_clerk%type
                                              );
   type AE_R_EQM_E_CURSOR is ref cursor return ae_r_eqm_e_rec;
   type AE_R_PMS_D_REC is record (                     checkbox      varchar(1),
                                                      proposal        ae_p_phs_e.proposal%type,
                                                     sort_code        ae_p_phs_e.sort_code%type,
                                                     pmi_basic        ae_r_pms_d.pmi_basic%type,
                                                     check_point        ae_r_pms_d.check_point%type,
                                                     description        ae_r_pms_d.description%type,
                                                     lab_unit_hrs        ae_r_pms_d.lab_unit_hrs%type,
                                                     means_freq        ae_r_pms_d.means_freq%type,
                                                     done_yn          varchar(1),
                                                     action_flag      varchar(1),
                                                     login            ae_s_sec_c.login%type,
                                                     pda_id           varchar(128),
                                                     edit_date        date,
                                                     long_desc    ae_r_pms_d.long_desc%type
                                                     );
   type AE_R_PMS_D_CURSOR is ref cursor return ae_r_pms_d_rec;
   type AE_P_PRO_E_DELETE_REC is record (
                                              proposal    ae_p_phs_e.proposal%type
                                              );
   type AE_P_PRO_E_DELETE_CURSOR is ref cursor return ae_p_pro_e_delete_rec;
   type AE_P_WKA_D_DELETE_REC is record (
                                              trans_no ae_p_wka_d.trans_no%type,
                                               item_no ae_p_wka_d.item_no%type
                                              );
   type AE_P_WKA_D_DELETE_CURSOR is ref cursor return ae_p_wka_d_delete_rec;
   type AE_P_REQ_E_DELETE_REC is record (
                                              doc_no ae_p_req_e.doc_no%type
                                              );
   type AE_P_REQ_E_DELETE_CURSOR is ref cursor return ae_p_req_e_delete_rec;
   type AE_I_EXT_E_DELETE_REC is record (
                                              trans_no ae_i_ext_e.trans_no%type
                                              );
   type AE_I_EXT_E_DELETE_CURSOR is ref cursor return ae_i_ext_e_delete_rec;
   type MFM_ERROR_LOG_REC is record (
                                error_no            mfm_error_log.error_no%type,
                                error_type          mfm_error_log.error_type%type,
                                action              mfm_error_log.action%type,
                                error_code          mfm_error_log.error_code%type,
                                odbc_state          mfm_error_log.odbc_state%type,
                                error_message       mfm_error_log.error_message%type,
                                user_name           mfm_error_log.user_name%type,
                                table_name          mfm_error_log.table_name%type,
                                error_date          mfm_error_log.error_date%type,
                                pda_id              mfm_error_log.pda_id%type,
                               download_date date
                                              );
   type MFM_ERROR_LOG_CURSOR is ref cursor return mfm_error_log_rec;
   type AE_S_BLD_C_REC is record (
       
                                          	region_code     ae_s_bld_c.region_code%type,
                                          	fac_id     ae_s_bld_c.fac_id%type,
                                          	bldg     ae_s_bld_c.bldg%type,
                                          	description     ae_s_bld_c.description%type
                                              );
   type AE_S_BLD_C_CURSOR is ref cursor return ae_s_bld_c_rec;
   type AE_B_LOC_D_REC is record (
       
                                          	region_code     ae_b_loc_d.region_code%type,
                                          	fac_id     ae_b_loc_d.fac_id%type,
                                          	bldg     ae_b_loc_d.bldg%type,
                                          	location_code     ae_b_loc_d.location_code%type,
                                          	flr_id     ae_b_loc_d.flr_id%type,
                                          	description     ae_b_loc_d.description%type,
                                          	loc_id     ae_b_loc_d.loc_id%type
                                              );
   type AE_B_LOC_D_CURSOR is ref cursor return ae_b_loc_d_rec;
   type AE_P_PST_E_REC is record (
                                proposal             ae_p_pst_e.proposal%type,
                                sort_code            ae_p_pst_e.sort_code%type,
                                status_code                 ae_p_pst_e.status_code%type,
                                status_date            ae_p_pst_e.status_date%type,
                                login             ae_p_pst_e.login%type,
                                category            ae_p_pst_e.category%type,
                                pda_id               varchar(128),
                                action_flag          varchar(1),
                                edit_date            date,
                                download_date   date,
                                order_type  ae_p_pst_e.order_type%type,
                                edit_clerk ae_p_pst_e.edit_clerk%type
                                              );
   type AE_P_PST_E_CURSOR is ref cursor return ae_p_pst_e_rec;
   type AE_L_STOCK_USE_DELETE_REC is record (
                                                     stock_location ae_l_stock_use.stock_location%type,
                                                     trans_date ae_l_stock_use.trans_date%type,
                                                     proposal ae_l_stock_use.proposal%type,
                                                     sort_code ae_l_stock_use.sort_code%type,
                                                     stock_no ae_l_stock_use.stock_no%type
                                                     );
   type AE_L_STOCK_USE_REC is record (
                                                        stock_location        ae_l_stock_use.stock_location%type,
                                                        trans_date        ae_l_stock_use.trans_date%type,
                                                        proposal        ae_l_stock_use.proposal%type,
                                                        sort_code        ae_l_stock_use.sort_code%type,
                                                        stock_no        ae_l_stock_use.stock_no%type,
                                                        qty_used        ae_l_stock_use.qty_used%type,
                                                        ext_cost        ae_l_stock_use.ext_cost%type,
                                                        posted_yn        ae_l_stock_use.posted_yn%type,
                                                        trans_no        ae_l_stock_use.trans_no%type,
                                                     action_code varchar(1),
                                                     login ae_s_sec_c.login%type,
                                                     pda_id varchar(128),
                                                     edit_date date
                                                     );
   type AE_P_STA_E_REC is record (
                                proposal             ae_p_sta_e.proposal%type,
                                status_code                 ae_p_sta_e.status_code%type,
                                status_date            ae_p_sta_e.status_date%type,
                                login             ae_p_sta_e.login%type,
                                category            ae_p_sta_e.category%type,
                                pda_id               varchar(128),
                                action_flag          varchar(1),
                                edit_date            date,
                                download_date   date,
                                order_type          ae_p_sta_e.order_type%type,
                                edit_clerk            ae_p_sta_e.edit_clerk%type
                                              );
   type AE_P_STA_E_CURSOR is ref cursor return ae_p_sta_e_rec;
   type MFM_TIME_CARD_SUMMARY_REC is record (
                                                     shop_person        ae_p_wka_e.shop_person%type,
                                                     sched_date        ae_p_wka_e.sched_date%type
                                                     );
   type MFM_TIME_CARD_SUMMARY_CURSOR is ref cursor return mfm_time_card_summary_rec;
   type AE_P_STA_E_DEL_REC is record (
                                proposal             ae_p_sta_e.proposal%type,
                                status_code                 ae_p_sta_e.status_code%type,
                                status_date            ae_p_sta_e.status_date%type
                                              );
   type AE_P_STA_E_DEL_CURSOR is ref cursor return ae_p_sta_e_del_rec;
   type AE_P_PST_E_DEL_REC is record (
                                proposal             ae_p_pst_e.proposal%type,
                                sort_code           ae_p_pst_e.sort_code%type,
                                status_code                 ae_p_pst_e.status_code%type,
                                status_date            ae_p_pst_e.status_date%type
                                              );
   type AE_P_PST_E_DEL_CURSOR is ref cursor return ae_p_pst_e_del_rec;
   type AE_I_INV_E_REC is record (
       
                                          	part     ae_i_inv_e.part%type,
                                          	inv_class     ae_i_inv_e.inv_class%type,
                                          	description   ae_i_inv_e.description%type,
                                          	inv_uom     ae_i_inv_e.inv_uom%type,
                                          	comm_code     ae_i_inv_e.comm_code%type,
                                              item_type     ae_i_inv_e.item_type%type,
                                          	cycle_code     ae_i_inv_e.cycle_code%type
                                              );
   type AE_I_INV_E_CURSOR is ref cursor return ae_i_inv_e_rec;
   type AE_R_EQM_E_DELETE_REC is record (
                                eqp_tag_id    ae_r_eqm_e.eqp_tag_id%type
                                              );
   type AE_R_EQM_E_DELETE_CURSOR is ref cursor return ae_r_eqm_e_delete_rec;
   type AE_I_WHS_E_REC is record (
                            warehouse  ae_i_whs_e.warehouse%type,
                            description ae_i_whs_e.description%type,
                            active ae_i_whs_e.active%TYPE
                                              );
   type AE_I_WHS_E_CURSOR is ref cursor return ae_i_whs_e_rec;
   type AE_I_WHS_E_DELETE_REC is record (
                            warehouse  ae_i_whs_e.warehouse%type
                                              );
   type AE_I_WHS_E_DELETE_CURSOR is ref cursor return ae_i_whs_e_delete_rec;
   type AE_I_LOC_E_REC is record (
                            warehouse  ae_i_loc_e.warehouse%type,
                            bin_location ae_i_loc_e.bin_location%type,
                            part ae_i_loc_e.part%type,
                            qty ae_i_loc_e.qty%type
                                              );
   type AE_I_LOC_E_CURSOR is ref cursor return ae_i_loc_e_rec;
   type AE_I_LOC_E_DELETE_REC is record (
                            warehouse  ae_i_loc_e.warehouse%type,
                            bin_location ae_i_loc_e.bin_location%type
                                              );
   type AE_I_LOC_E_DELETE_CURSOR is ref cursor return ae_i_loc_e_delete_rec;
   type AE_I_INV_E_DELETE_REC is record (
       
                                          	part     ae_i_inv_e.part%type
                                              );
   type AE_I_INV_E_DELETE_CURSOR is ref cursor return ae_i_inv_e_delete_rec;
   type AE_L_SHP_E_REC is record (
                            shop  ae_l_shp_e.shop%type,
                            description ae_l_shp_e.description%type,
                            supervisor_id  ae_l_shp_e.supervisor_id%type
                                              );
   type AE_L_SHP_E_CURSOR is ref cursor return ae_l_shp_e_rec;
   type AE_L_SHP_E_DELETE_REC is record (
                            shop  ae_l_shp_d.shop%type
                                              );
   type AE_L_SHP_D_REC is record (
                            shop  ae_l_shp_d.shop%type,
                            shop_person  ae_l_shp_d.shop_person%type,
                            seq       ae_l_shp_d.seq%type,
                            date_from ae_l_shp_d.date_from%type,
                            date_to ae_l_shp_d.date_to%type
                                              );
   type AE_L_SHP_E_DELETE_CURSOR is ref cursor return ae_l_shp_e_delete_rec;
   type AE_L_SHP_D_DELETE_REC is record (
                            shop  ae_l_shp_d.shop%type,
                            shop_person  ae_l_shp_d.shop_person%type
                                              );
   type AE_L_SHP_D_DELETE_CURSOR is ref cursor return ae_l_shp_d_delete_rec;
   type AE_L_SHP_D_CURSOR is ref cursor return ae_l_shp_d_rec;
   type AE_S_BLD_C_DEL_REC is record (
       
                                          	region_code     ae_s_bld_c.region_code%type,
                                          	fac_id     ae_s_bld_c.fac_id%type,
                                          	bldg     ae_s_bld_c.bldg%type
                                              );
   type AE_S_BLD_C_DEL_CUR is ref cursor return ae_s_bld_c_del_rec;
   type MFM_USER_PDA_REC is record (
       
                                          	login           mfm_user_pda.login%type,
                                          	memory      mfm_user_pda.memory%type
                                              );
   type MFM_USER_PDA_CURSOR is ref cursor return mfm_user_pda_rec;
   type AE_L_MAN_E_REC is record (
                                          	shop_person   ae_h_emp_e.shop_person%type,
                                          	name   varchar2(40),
                                                     time_type ae_h_emp_e.time_type%type,
                                                     labor_class ae_h_emp_e.labor_class%type
                                       );
   type AE_L_MAN_E_CURSOR is ref cursor return ae_l_man_e_rec;
   type AE_L_MAN_D_REC is record (
       
                                          	seq     ae_l_man_d.seq%type,
                                          	shop_person     ae_l_man_d.shop_person%type,
                                          	labor_class     ae_l_man_d.labor_class%type,
                                          	time_type     ae_l_man_d.time_type%type,
                                          	labor_rate     ae_l_man_d.labor_rate%type,
                                          	start_date     ae_l_man_d.start_date%type,
                                          	end_date     ae_l_man_d.end_date%type
                                              );
   type AE_L_MAN_D_CURSOR is ref cursor return ae_l_man_d_rec;
   type AE_X_CFT_E_REC is record (
       
                                          	craft_code     ae_x_cft_e.craft_code%type,
                                          	description     ae_x_cft_e.description%type,
                                          	order_type     ae_x_cft_e.order_type%type,
                                          	category     ae_x_cft_e.category%type
                                      );
   type AE_X_CFT_E_CURSOR is ref cursor return ae_x_cft_e_rec;
   type AE_X_CFT_E_ONLY_REC is record (
       
                                          	craft_code     ae_x_cft_e.craft_code%type,
                                          	description     ae_x_cft_e.description%type
                                      );
   type AE_X_CFT_E_ONLY_CURSOR is ref cursor return ae_x_cft_e_only_rec;
   type MFM_CYCLE_COUNT_REC is record (
          trans_no             ae_i_cct_d.trans_no%TYPE,    
          warehouse            ae_i_cct_e.warehouse%TYPE,   
          count_num            ae_i_cct_d.count_num%TYPE,   
          set_no               ae_i_cct_d.set_no%TYPE,      
          sched_date           ae_i_cct_d.sched_date%TYPE,  
          part                 ae_i_cct_d.part%TYPE,        
          bin_location         ae_i_cct_d.bin_location%TYPE,
          count_date           ae_i_cct_d.count_date%TYPE,  
          count_login          ae_i_cct_d.count_login%TYPE, 
          count_no             ae_i_cct_d.count_no%TYPE,    
          sys_qoh              ae_i_cct_d.sys_qoh%TYPE,     
          item_no              ae_i_cct_d.item_no%TYPE,     
          edit_date            ae_i_cct_d.edit_date%TYPE,   
          edit_clerk           ae_i_cct_d.edit_clerk%TYPE,  
          description                ae_i_inv_e.description%TYPE,
          cycle_code                ae_i_inv_e.cycle_code%TYPE,
          inv_uom                ae_i_inv_e.inv_uom%TYPE,
                                                     login ae_s_sec_c.login%type,
                                                     pda_id varchar(128),
                                                     action_code varchar(1)
                                                     );
   type AE_B_LOC_D_DELETE_REC is record (
       
                                          	region_code     ae_b_loc_d.region_code%type,
                                          	fac_id     ae_b_loc_d.fac_id%type,
                                          	bldg     ae_b_loc_d.bldg%type,
                                          	loc_id     ae_b_loc_d.loc_id%type
                                              );
   type AE_B_LOC_D_DELETE_CURSOR is ref cursor return ae_b_loc_d_delete_rec;
   type AE_P_STA_D_REC is record (
                                status_code                 ae_p_sta_d.status_code%type,
                                role_id                          ae_p_sta_d.role_id%type,
                                category                       ae_p_sta_d.category%type,
                                order_type                    ae_p_sta_d.order_type%type,
                                active                           ae_p_sta_c.active%type
                                              );
   type AE_P_STA_D_CURSOR is ref cursor return ae_p_sta_d_rec;
   type AE_P_PST_D_REC is record (
                                status_code                 ae_p_pst_d.status_code%type,
                                role_id                          ae_p_pst_d.role_id%type,
                                category                       ae_p_pst_d.category%type,
                                order_type                    ae_p_pst_d.order_type%type,
                                active                           ae_p_pst_c.active%type
                                              );
   type AE_P_PST_D_CURSOR is ref cursor return ae_p_pst_d_rec;
   type AE_I_POE_D_CURSOR is ref cursor return ae_i_poe_d_rec;
   type AE_I_POE_E_CURSOR is ref cursor return ae_i_poe_e_rec;
   type AE_L_STOCK_USE_CURSOR is ref cursor return AE_L_STOCK_USE_REC;
   type AE_L_STOCK_USE_DELETE_CUR is ref cursor return AE_L_STOCK_USE_DELETE_REC;
   type MFM_CYCLE_COUNT_CURSOR is ref cursor return mfm_cycle_count_rec;
   type AE_A_ASSET_E_REC is record (
                                asset_tag ae_a_asset_e.asset_tag%type,
                                asset_type ae_a_asset_e.asset_type%type,
                                description   ae_a_asset_e.description%type,
                                region_code    ae_a_asset_e.region_code%type,
                                fac_id         ae_a_asset_e.fac_id%type,
                                bldg           ae_a_asset_e.bldg%type,
                                location_code  ae_a_asset_e.location_code%type,
                                loc_id               ae_a_asset_e.loc_id%type
                                              );
   type AE_A_ASSET_E_CURSOR is ref cursor return ae_a_asset_e_rec;
   type AE_A_ASSET_E_DELETE_REC is record (
                                asset_tag    ae_a_asset_e.asset_tag%type
                                              );
   type AE_A_ASSET_E_DELETE_CURSOR is ref cursor return ae_a_asset_e_delete_rec;
   procedure BEG_DL_INV (V_LAST_DOWNLOAD date,V_ML_USER ae_s_sec_c.login%type);
   procedure DL_CUR_AE_I_PTN_D (V_AE_I_PTN_D_CURSOR in out mfm.ae_i_ptn_d_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_I_PTN_E (V_AE_I_PTN_E_CURSOR in out mfm.ae_i_ptn_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_PHS_E (V_AE_P_PHS_E_CURSOR in out mfm.ae_p_phs_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_I_LOC_E_INV (V_AE_I_LOC_E_CURSOR in out mfm.ae_i_loc_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_PRO_E (V_AE_P_PRO_E_CURSOR in out mfm.ae_p_pro_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_I_POE_D (V_AE_I_POE_D_CURSOR in out mfm.ae_i_poe_d_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_I_POE_E (V_AE_I_POE_E_CURSOR in out mfm.ae_i_poe_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_PRO_S (V_AE_P_PRO_S_CURSOR in out mfm.ae_p_pro_s_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_WKA_D (V_AE_P_WKA_D_CURSOR in out mfm.ae_p_wka_d_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_WKA_E (V_AE_P_WKA_E_CURSOR in out mfm.ae_p_wka_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_I_WHS_E_INV (V_AE_I_WHS_E_CURSOR in out mfm.ae_i_whs_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_R_EQM_E (V_AE_R_EQM_E_CUR in out mfm.ae_r_eqm_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type);
   procedure DL_DEL_CUR_AE_P_PHS_E (V_AE_P_PHS_E_DELETE_CURSOR in out mfm.ae_p_phs_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_R_PMS_D (V_AE_R_PMS_D_CURSOR in out ae_r_pms_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type);
   procedure END_DL_WR (V_LAST_DOWNLOAD date,V_ML_USER ae_s_sec_c.login%type);
   procedure DL_DEL_CUR_AE_P_PRO_E (V_AE_P_PRO_E_DELETE_CURSOR in out ae_p_pro_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_L_STOCK_USE (V_AE_L_STOCK_USE_CURSOR in out mfm.ae_l_stock_use_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_P_WKA_D (V_AE_P_WKA_D_DELETE_CURSOR in out mfm.ae_p_wka_d_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_P_REQ_E (V_AE_P_REQ_E_DELETE_CURSOR in out mfm.ae_p_req_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_I_EXT_E (V_AE_I_EXT_E_DELETE_CURSOR in out mfm.ae_i_ext_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_MFM_ERROR_LOG (V_MFM_ERROR_LOG_CUR in out mfm.mfm_error_log_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type);
   procedure DL_CUR_AE_S_BLD_C (V_AE_S_BLD_C_CURSOR in out mfm.ae_s_bld_c_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_B_LOC_D (V_AE_B_LOC_D_CURSOR in out mfm.ae_b_loc_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_STA_E (V_AE_P_STA_E_CURSOR in out mfm.ae_p_sta_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_PST_E (V_AE_P_PST_E_CUR in out mfm.ae_p_pst_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_MFM_TIME_CARD_SUM (V_MFM_TIME_CARD_SUMMARY_CURSOR in out mfm.mfm_time_card_summary_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_P_STA_E (V_AE_P_STA_E_DEL_CURSOR in out mfm.ae_p_sta_e_del_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_P_PST_E (V_AE_P_PST_E_DEL_CURSOR in out mfm.ae_p_pst_e_del_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_I_INV_E (V_AE_I_INV_E_CURSOR in out mfm.ae_i_inv_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_R_EQM_E (V_AE_R_EQM_E_DELETE_CUR in out mfm.ae_r_eqm_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type);
   procedure DL_CUR_AE_I_WHS_E_WR (V_AE_I_WHS_E_CURSOR in out mfm.ae_i_whs_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_I_WHS_E_WR (V_AE_I_WHS_E_DELETE_CURSOR in out mfm.ae_i_whs_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_MFM_CYCLE_COUNT (V_MFM_CYCLE_COUNT_CURSOR in out mfm.mfm_cycle_count_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_CUR_AE_I_LOC_E_WR (V_AE_I_LOC_E_CURSOR in out mfm.ae_i_loc_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_I_LOC_E_WR (V_AE_I_LOC_E_DELETE_CURSOR in out mfm.ae_i_loc_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_I_LOC_E_INV (V_AE_I_LOC_E_DELETE_CURSOR in out mfm.ae_i_loc_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_I_INV_E (V_AE_I_INV_E_DELETE_CURSOR in out mfm.ae_i_inv_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_L_SHP_E (V_AE_L_SHP_E_CURSOR in out mfm.ae_l_shp_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_I_WHS_E_INV (V_AE_I_WHS_E_DELETE_CURSOR in out mfm.ae_i_whs_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_L_SHP_E (V_AE_L_SHP_E_DELETE_CURSOR in out mfm.ae_l_shp_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_L_SHP_D (V_AE_L_SHP_D_CURSOR in out mfm.ae_l_shp_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_L_SHP_D (V_AE_L_SHP_D_DELETE_CURSOR in out mfm.ae_l_shp_d_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_L_STOCK_USE (V_AE_L_STOCK_USE_DELETE_CUR in out mfm.ae_l_stock_use_delete_cur,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_S_BLD_C (V_AE_S_BLD_C_DEL_CUR in out mfm.ae_s_bld_c_del_cur,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_L_MAN_E (V_AE_L_MAN_E_CURSOR in out mfm.ae_l_man_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_L_MAN_D (V_AE_L_MAN_D_CURSOR in out mfm.ae_l_man_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_X_CFT_E (V_AE_X_CFT_E_CURSOR in out mfm.ae_x_cft_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure BEG_DL_WR (V_LAST_DOWNLOAD date,V_ML_USER ae_s_sec_c.login%type);
   procedure DL_CUR_AE_X_CFT_E_ONLY (V_AE_X_CFT_E_ONLY_CURSOR in out mfm.ae_x_cft_e_only_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_DEL_CUR_AE_B_LOC_D (V_AE_B_LOC_D_DEL_CUR in out mfm.ae_b_loc_d_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_STA_D (V_AE_P_STA_D_CUR in out mfm.ae_p_sta_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type);
   procedure DL_CUR_AE_P_PST_D (V_AE_P_PST_D_CUR in out mfm.ae_p_pst_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER in out mfm_routes_download.login%type);
   procedure END_DL_INV (V_LAST_DOWNLOAD date,V_ML_USER ae_s_sec_c.login%type);
   procedure DL_CUR_AE_A_ASSET_E (V_AE_A_ASSET_E_CUR in out mfm.ae_a_asset_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type);
   procedure DL_DEL_CUR_AE_A_ASSET_E (V_AE_A_ASSET_E_DELETE_CUR in out mfm.ae_a_asset_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type);
end MFM;
/

create or replace package body MFM as
   procedure BEG_DL_INV (V_LAST_DOWNLOAD date,V_ML_USER ae_s_sec_c.login%type) as
   v_shop_person    ae_h_emp_e.shop_person%TYPE;
                          v_pda_id         mfm_ae_p_phs_e_download.pda_id %type;
                          v_download_type  ae_s_sec_c.mfm_download%type;
                          v_start_date     date;
                          v_whse           ae_s_sec_c.warehouse%type;
                          v_login          ae_s_sec_c.login%type;
                  cursor c_download(a_login ae_s_sec_c.login%TYPE) is
                      select warehouse
                        from ae_s_sec_c
                       where rtrim(upper(login)) = rtrim(upper(a_login));
                   cursor c_whse_security(v_warehouse ae_s_sec_c.warehouse%type) is
                       select count(*)
                         from ae_i_whs_e
                        where ae_i_whs_e.warehouse = v_warehouse
                          and ae_i_whs_e.active = 'Y';
                   cursor c_whse_sup_shop(v_warehouse ae_s_sec_c.warehouse%type) is
                       select count(*)
                         from ae_i_whs_e_sup_shop, ae_i_whs_e, ae_l_shp_e
                        where ae_i_whs_e_sup_shop.warehouse = v_warehouse
                          and ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                          and ae_i_whs_e.active = 'Y'
                          and ae_i_whs_e_sup_shop.shop = ae_l_shp_e.shop
                          and ae_l_shp_e.active = 'Y';
                    v_security_count   number(8);
                    v_sup_shop_count   number(8);
                  begin
                  v_login := v_ml_user;
                  open c_download(v_ml_user);
                  fetch c_download into v_whse;
                  close c_download;
                  v_pda_id := 'PDA_ID';
                  v_start_date := null;
   
                  open c_whse_security(v_whse);
                  fetch c_whse_security into v_security_count;
                  close c_whse_security;
   
                  open c_whse_sup_shop(v_whse);
                  fetch c_whse_sup_shop into v_sup_shop_count;
                  close c_whse_sup_shop;
   
                     delete mfm_ae_p_phs_e_download
                      where rtrim(upper(login)) = rtrim(upper(v_login))
                        and rtrim(pda_id) = rtrim(v_pda_id)
                        and download_action = 'D';
   
                      update mfm_ae_p_phs_e_download
                         set download_action = null,
                              edit_date = ( select edit_date
                                              from ae_p_phs_e
                                              where ae_p_phs_e.proposal = mfm_ae_p_phs_e_download.proposal
                                                and ae_p_phs_e.sort_code = mfm_ae_p_phs_e_download.sort_code
                                                ),
                              start_date = ( select beg_dt
                                              from ae_p_phs_e
                                              where ae_p_phs_e.proposal = mfm_ae_p_phs_e_download.proposal
                                                and ae_p_phs_e.sort_code = mfm_ae_p_phs_e_download.sort_code
                                                )
                       where rtrim(upper(login)) = rtrim(upper(v_login))
                         and rtrim(pda_id) = rtrim(v_pda_id)
                         and (download_action <> 'D'
                          or download_action is null);
   
                  update mfm_ae_p_phs_e_download
                      set   edit_date = ( select edit_date
                                           from ae_p_pro_e
                                           where ae_p_pro_e.proposal = mfm_ae_p_phs_e_download.proposal
                                             )
                    where upper(login) = upper(v_ml_user)
                      and pda_id = v_pda_id
                      and (download_action <> 'D'
                       or download_action is null)
                      and edit_date <=  ( select edit_date
                                           from ae_p_pro_e
                                           where ae_p_pro_e.proposal = mfm_ae_p_phs_e_download.proposal
                                             );
   
                      update mfm_ae_p_phs_e_download
                         set download_action = 'U'
                       where edit_date >= v_last_download
                         and upper(login) = upper(v_login)
                         and rtrim(pda_id) = rtrim(v_pda_id);
   
                   if v_security_count > 0 and v_sup_shop_count > 0 then
                       insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action, edit_date, start_date)
                       select distinct phase.proposal, phase.sort_code, v_ml_user, v_pda_id, 'I', phase.edit_date, phase.beg_dt
                         from ae_p_phs_e phase,
                              ae_p_pro_e wr,
                              ae_i_whs_e_sup_shop whse_support_shop,
                              ae_p_pst_c phase_status,
                              ae_i_whs_e,
                              ae_l_shp_e
                        where (phase.edit_date >= v_last_download
                           or ae_l_shp_e.edit_date >= v_last_download
                           or whse_support_shop.edit_date >= v_last_download)
                          and wr.proposal = phase.proposal
                          and whse_support_shop.shop = phase.shop
                          and ae_l_shp_e.shop = phase.shop
                          and ae_l_shp_e.active = 'Y'
                          and whse_support_shop.warehouse = ae_i_whs_e.warehouse
                          and ae_i_whs_e.active = 'Y'
                          and whse_support_shop.warehouse = v_whse
                          and wr.category = phase_status.category
                          and phase.status_code = phase_status.status_code
                          and phase_status.complete_yn not in ('Y', 'C', 'P')
                          and not exists ( select *
                                           from mfm_ae_p_phs_e_download download
                                           where download.proposal = phase.proposal
                                             and download.sort_code = phase.sort_code
                                             and upper(download.login) = upper(v_login)
                                             and rtrim(download.pda_id) = rtrim(v_pda_id));
                   end if;
   
                   if v_security_count = 0 and v_sup_shop_count = 0 then
                       insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action, edit_date, start_date)
                       select distinct phase.proposal, phase.sort_code, v_ml_user, v_pda_id, 'I', phase.edit_date, phase.beg_dt
                         from ae_p_phs_e phase,
                              ae_p_pro_e wr,
                              ae_p_pst_c phase_status,
                              ae_l_shp_e
                        where phase.edit_date >= v_last_download
                          and wr.proposal = phase.proposal
                          and wr.category = phase_status.category
                          and phase.status_code = phase_status.status_code
                          and phase_status.complete_yn not in ('Y', 'C', 'P')
                          and phase.shop = ae_l_shp_e.shop
                          and ae_l_shp_e.active = 'Y'
                          and not exists ( select *
                                           from mfm_ae_p_phs_e_download download
                                           where download.proposal = phase.proposal
                                             and download.sort_code = phase.sort_code
                                             and upper(download.login) = upper(v_login)
                                             and rtrim(download.pda_id) = rtrim(v_pda_id));
                   end if;
   
                   if v_security_count = 0 and v_sup_shop_count > 0 then
                       insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action, edit_date, start_date)
                       select distinct phase.proposal, phase.sort_code, v_ml_user, v_pda_id, 'I', phase.edit_date, phase.beg_dt
                         from ae_p_phs_e phase,
                              ae_p_pro_e wr,
                              ae_i_whs_e_sup_shop whse_support_shop,
                              ae_p_pst_c phase_status,
                              ae_i_whs_e,
                              ae_l_shp_e
                        where (phase.edit_date >= v_last_download
                           or whse_support_shop.edit_date >= v_last_download
                           or ae_l_shp_e.edit_date >= v_last_download)
                          and wr.proposal = phase.proposal
                          and whse_support_shop.shop = phase.shop
                          and whse_support_shop.warehouse = v_whse
                          and whse_support_shop.warehouse = ae_i_whs_e.warehouse
                          and ae_i_whs_e.active = 'Y'
                          and wr.category = phase_status.category
                          and phase.status_code = phase_status.status_code
                          and phase_status.complete_yn not in ('Y', 'C', 'P')
                          and phase.shop = ae_l_shp_e.shop
                          and ae_l_shp_e.active = 'Y'
                          and not exists ( select *
                                           from mfm_ae_p_phs_e_download download
                                           where download.proposal = phase.proposal
                                             and download.sort_code = phase.sort_code
                                             and upper(download.login) = upper(v_login)
                                             and rtrim(download.pda_id) = rtrim(v_pda_id));
                   end if;
                   if v_security_count > 0 and v_sup_shop_count = 0 then
                           insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action, edit_date, start_date)
                       select distinct phase.proposal, phase.sort_code, v_ml_user, v_pda_id, 'I', phase.edit_date, phase.beg_dt
                         from ae_p_phs_e phase,
                              ae_p_pro_e wr,
                              ae_p_pst_c phase_status,
                              ae_i_whs_e,
                              ae_l_shp_e
                        where (phase.edit_date >= v_last_download
                           or  ae_l_shp_e.edit_date >= v_last_download)
                          and wr.proposal = phase.proposal
                          and ae_i_whs_e.active = 'Y'
                          and wr.category = phase_status.category
                          and phase.status_code = phase_status.status_code
                          and phase_status.complete_yn not in ('Y', 'C', 'P')
                          and phase.shop = ae_l_shp_e.shop
                          and ae_l_shp_e.active = 'Y'
                          and not exists ( select *
                                           from mfm_ae_p_phs_e_download download
                                           where download.proposal = phase.proposal
                                             and download.sort_code = phase.sort_code
                                             and upper(download.login) = upper(v_login)
                                             and rtrim(download.pda_id) = rtrim(v_pda_id));
                   end if;
   
                   update mfm_ae_p_phs_e_download
                      set download_action = 'D'
                    where upper(login) = upper(v_login)
                      and pda_id = v_pda_id
                      and (exists ( select *
                                     from ae_p_phs_e phase,
                                          ae_p_pro_e wr,
                                          ae_p_pst_c phase_status
                                    where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                      and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                      and wr.proposal = phase.proposal
                                      and wr.category = phase_status.category
                                      and phase.status_code = phase_status.status_code
                                      and phase_status.complete_yn in ('Y', 'C', 'P')
                                      )
                            or
                            exists ( select *
                                     from ae_p_phs_e phase,
                                          ae_l_shp_e
                                    where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                      and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                      and ae_l_shp_e.shop = phase.shop
                                      and ae_l_shp_e.active = 'N'
                                      )
                            )
                                      ;
                  end;
   procedure DL_CUR_AE_I_PTN_D (V_AE_I_PTN_D_CURSOR in out mfm.ae_i_ptn_d_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   open v_ae_i_ptn_d_cursor for
   
               select pt_detail.pick_ticket_num,
                       pt_detail.pick_ticket_item,
                       pt_detail.itm_status,
                       pt_detail.part,
                       pt_detail.req_qty,
                       pt_detail.bin_location,
                       '' action_flag,
                          null,
                          null,
                          v_edit_date
                 from ae_i_ptn_d pt_detail,
                      ae_i_ptn_e pt_header,
                      mfm_ae_p_phs_e_download download
                where pt_header.proposal = download.proposal
                  and pt_header.sort_code = download.sort_code
                  and pt_header.pick_ticket_num = pt_detail.pick_ticket_num
                  and upper(download.login) = upper(v_ml_user)
                  and rtrim(download.pda_id) = rtrim(v_pda_id)
                  and (download.download_action = 'I'
                   or pt_detail.edit_date >= v_last_download);
   
               end;
   procedure DL_CUR_AE_I_PTN_E (V_AE_I_PTN_E_CURSOR in out mfm.ae_i_ptn_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   open v_ae_i_ptn_e_cursor for
               select pt_header.pick_ticket_num,
                       pt_header.description,
                       pt_header.pick_ticket_status,
                       pt_header.date_created,
                       pt_header.created_by,
                       pt_header.warehouse,
                       pt_header.proposal,
                       pt_header.sort_code,
                       pt_header.date_needed,
                       '' action_flag,
                          null,
                          null,
                          v_edit_date
                 from ae_i_ptn_e pt_header,
                      mfm_ae_p_phs_e_download download
                where pt_header.proposal = download.proposal
                  and pt_header.sort_code = download.sort_code
                  and upper(download.login) = upper(v_ml_user)
                  and rtrim(download.pda_id) = rtrim(v_pda_id)
                  and (download.download_action = 'I'
                   or pt_header.edit_date >= v_last_download);
   
               end;
   procedure DL_CUR_AE_P_PHS_E (V_AE_P_PHS_E_CURSOR in out mfm.ae_p_phs_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                      open v_ae_p_phs_e_cursor for select
                             phase.proposal,
                             phase.sort_code,
                             phase.description,
                             phase.beg_dt,
                             phase.end_dt,
                             phase.craft_code,
                             phase.shop,
                             phase.status_code,
                             phase.pri_code,
                             dw.login,
                             phase.default_dist,
                             '' active_flag,
                             phase.category,
                             phase.order_type,
                             phase.pmi_basic,
                             null,
                             phase.tot_hrs,
                             phase.tot_lab,
                             phase.tot_mat,
                             phase.tot_eqp,
                             phase.tot_oth,
                             null,
                             v_edit_date,
                             wr.project,
                             wr.requestor,
                             wr.region_code,
                             wr.fac_id,
                             wr.bldg,
                             wr.edit_date,
                             phase.location_code,
                             phase.loc_id,
                             phase.eqp_tag_id,
                             phase.asset_tag,
                             sysdate,
                             phase.ent_clerk,
                             phase.long_desc,
                             phase.edit_clerk
                        from ae_p_phs_e phase,
                             ae_p_pro_e wr,
                             mfm_ae_p_phs_e_download dw
                       where phase.proposal = dw.proposal
                         and phase.sort_code = dw.sort_code
                         and wr.proposal = phase.proposal
                         and upper(dw.login) = upper(v_ml_user)
                         and rtrim(dw.pda_id) = rtrim(v_pda_id)
                         and dw.download_action in ('I', 'U')
                         ;
               end;
   procedure DL_CUR_AE_I_LOC_E_INV (V_AE_I_LOC_E_CURSOR in out mfm.ae_i_loc_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                         v_edit_date  date;
                         v_login      ae_s_sec_c.login%type;
                         v_action_flag   varchar(1);
                         v_null_string   varchar(10);
                         v_null_date     date;
                     begin
                         v_pda_id := 'PDA_ID';
                         v_edit_date := null;
                         v_login := null;
                         v_action_flag := null;
                         v_null_string := null;
                         v_null_date := null;
                         open v_ae_i_loc_e_cursor for
                     select
                         	ae_i_loc_e.warehouse,
                         	ae_i_loc_e.bin_location,
                         	ae_i_loc_e.part,
                         	ae_i_loc_e.qty
                     from ae_i_inv_e, ae_i_inv_w, ae_s_sec_c, ae_i_whs_e, ae_i_loc_e
                     where ae_i_loc_e.warehouse = ae_i_inv_w.warehouse
                      and  ae_i_loc_e.part = ae_i_inv_w.part
                      and  ae_i_inv_e.part = ae_i_inv_w.part
                        and ae_i_inv_w.warehouse = ae_s_sec_c.warehouse
                        and ae_i_whs_e.warehouse = ae_s_sec_c.warehouse
                        and ae_i_whs_e.active = 'Y'
                        and upper(ae_s_sec_c.login) = upper(V_ML_USER)
                        and (ae_i_inv_e.edit_date >= V_LAST_DOWNLOAD
                         or  ae_i_inv_w.edit_date >= V_LAST_DOWNLOAD
                         or  ae_i_loc_e.edit_date >= V_LAST_DOWNLOAD
                         or  ae_i_whs_e.edit_date >= V_LAST_DOWNLOAD)
                        and ae_i_inv_e.active = 'Y'
                     union
                     select
                         	ae_i_loc_e.warehouse,
                         	ae_i_loc_e.bin_location,
                         	ae_i_loc_e.part,
                         	ae_i_loc_e.qty
                     from ae_i_inv_e, ae_i_inv_w, ae_s_sec_c, ae_i_whs_e, ae_i_loc_e
                     where ae_i_loc_e.warehouse = ae_i_inv_w.warehouse
                      and  ae_i_loc_e.part = ae_i_inv_w.part
                      and  ae_i_inv_e.part = ae_i_inv_w.part
                        and ae_i_inv_w.warehouse = ae_s_sec_c.warehouse
                        and ae_i_whs_e.warehouse = ae_s_sec_c.warehouse
                        and ae_i_whs_e.active = 'Y'
                        and upper(ae_s_sec_c.login) = upper(V_ML_USER)
                        and (ae_i_inv_e.edit_date >= V_LAST_DOWNLOAD
                         or  ae_i_inv_w.edit_date >= V_LAST_DOWNLOAD
                         or  ae_i_loc_e.edit_date >= V_LAST_DOWNLOAD
                         or  ae_i_whs_e.edit_date >= V_LAST_DOWNLOAD)
                        and ae_i_inv_e.active = 'Y'
                      ;
                  end;
   procedure DL_CUR_AE_P_PRO_E (V_AE_P_PRO_E_CURSOR in out mfm.ae_p_pro_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   open v_ae_p_pro_e_cursor for
                       select distinct
                   	   wr.proposal,
                          wr.description,
                          wr.status_code,
                          wr.region_code,
                          wr.fac_id,
                          wr.bldg,
                          wr.category,
                          wr.requestor,
                          wr.contact,
                          wr.contact_ph,
                          wr.desired_date,
                          wr.order_type,
                          wr.reference_no,
                          wr.ent_clerk,
                          wr.ent_date,
                          '' action_flag,
                          wr.shop,
                          wr.shop_person,
                          wr.req_date,
                          null,
                          null,
                          v_edit_date,
                          wr.edit_date,
                          ae_s_bld_c.description,
                          sysdate,
                          wr.long_desc,
                          wr.project,
                          wr.problem_code,
                          wr.company_id,
                          wr.dept_id,
                          wr.oc_code,
                          wr.edit_clerk
                     from ae_p_pro_e wr,
                          mfm_ae_p_phs_e_download dw,
                          ae_s_bld_c
                    where wr.proposal = dw.proposal
                      and wr.region_code = ae_s_bld_c.region_code
                      and wr.fac_id = ae_s_bld_c.fac_id
                      and wr.bldg = ae_s_bld_c.bldg
                      and upper(dw.login) = upper(v_ml_user)
                      and rtrim(dw.pda_id) = rtrim(v_pda_id)
                      and dw.download_action in ('I', 'U')
                      and exists ( select dl.proposal
                          from mfm_ae_p_phs_e_download dl
                         where upper(rtrim(dl.login)) = upper(rtrim(v_ml_user))
                           and rtrim(dl.pda_id) = rtrim(v_pda_id)
                           and ((dl.download_action <> 'D' and dl.download_action <> 'H')
                            or dl.download_action is null)
                           and dl.proposal = dw.proposal
                           )
            ;
               end;
   procedure DL_CUR_AE_I_POE_D (V_AE_I_POE_D_CURSOR in out mfm.ae_i_poe_d_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(10);
                      v_null_string   varchar(10);
                      v_null_date     date;
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      v_null_string := null;
                      v_null_date := null;
                      open v_ae_i_poe_d_cursor for
   
                  select ae_i_poe_e.po_code,
                  	ae_i_poe_d.po_item,
                  	ae_i_poe_d.vend_part,
                  	ae_i_poe_d.vend_dsc,
                  	ae_i_poe_d.vend_uom,
                  	ae_i_poe_d.vend_qty,
                  	ae_i_poe_d.rec_qty,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string
   
                  from
                  	ae_i_poe_e,
                  	ae_i_poe_d,
                  	ae_i_poe_status_e,
                      ae_i_whs_security,
                      mfm_warehouse_for_po_download,
                      ae_i_whs_e,
                      ae_authz_principal, 
                      ae_authz
                  where	ae_i_poe_e.po_code = ae_i_poe_d.po_code
                      and	ae_i_poe_e.warehouse = ae_i_whs_security.warehouse
                  	and (ae_i_poe_e.warehouse = mfm_warehouse_for_po_download.warehouse
                        or mfm_warehouse_for_po_download.warehouse = 'GITMB')
                   and ae_i_poe_e.warehouse = ae_i_whs_e.warehouse
                   and ae_i_whs_e.active = 'Y'
                  	and ae_i_poe_e.status_code = ae_i_poe_status_e.status_code
                  	and ae_i_poe_status_e.complete_yn = 'F'
                      and upper(mfm_warehouse_for_po_download.login) = upper(v_ml_user)
                      and rtrim(mfm_warehouse_for_po_download.pda_id) = 'PDA_ID'
                      and upper(ae_authz_principal.login) = upper(v_ml_user)
                      and ae_authz_principal.role_id = ae_i_whs_security.role_id
                      and ae_authz.role_id = ae_authz_principal.role_id
                      and ae_authz.active = 'Y'
                  union
                  select ae_i_poe_e.po_code,
                  	ae_i_poe_d.po_item,
                  	ae_i_poe_d.vend_part,
                  	ae_i_poe_d.vend_dsc,
                  	ae_i_poe_d.vend_uom,
                  	ae_i_poe_d.vend_qty,
                  	ae_i_poe_d.rec_qty,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string
   
                  from
                  	ae_i_poe_e,
                  	ae_i_poe_d,
                  	ae_i_poe_status_e,
                      mfm_warehouse_for_po_download,
                      ae_i_whs_e
                  where	ae_i_poe_e.po_code = ae_i_poe_d.po_code
                      and	ae_i_poe_e.warehouse = mfm_warehouse_for_po_download.warehouse
                      and	ae_i_poe_e.warehouse = ae_i_whs_e.warehouse
                      and  ae_i_whs_e.active = 'Y'
                  	and ae_i_poe_e.status_code = ae_i_poe_status_e.status_code
                  	and ae_i_poe_status_e.complete_yn = 'F'
                      and upper(mfm_warehouse_for_po_download.login) = upper(v_ml_user)
                      and rtrim(mfm_warehouse_for_po_download.pda_id) = 'PDA_ID'
                      and not exists ( select *
                                        from ae_i_whs_security, ae_i_whs_e
                                       where ae_i_whs_security.warehouse = ae_i_poe_e.warehouse
                                         and ae_i_whs_security.warehouse = ae_i_whs_e.warehouse
                                         and ae_i_whs_e.active = 'Y'
                                       )
                  union
                  select ae_i_poe_e.po_code,
                  	ae_i_poe_d.po_item,
                  	ae_i_poe_d.vend_part,
                  	ae_i_poe_d.vend_dsc,
                  	ae_i_poe_d.vend_uom,
                  	ae_i_poe_d.vend_qty,
                  	ae_i_poe_d.rec_qty,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string
   
                  from
                  	ae_i_poe_e,
                  	ae_i_poe_d,
                  	ae_i_poe_status_e,
                      mfm_warehouse_for_po_download
                  where	ae_i_poe_e.po_code = ae_i_poe_d.po_code
                      and mfm_warehouse_for_po_download.warehouse = 'GITMB'
                  	and ae_i_poe_e.status_code = ae_i_poe_status_e.status_code
                  	and ae_i_poe_status_e.complete_yn = 'F'
                      and upper(mfm_warehouse_for_po_download.login) = upper(v_ml_user)
                      and rtrim(mfm_warehouse_for_po_download.pda_id) = 'PDA_ID'
                      and not exists ( select *
                                        from ae_i_whs_security, ae_i_whs_e
                                       where ae_i_whs_security.warehouse = ae_i_poe_e.warehouse
                                         and ae_i_whs_security.warehouse = ae_i_whs_e.warehouse
                                         and ae_i_whs_e.active = 'Y'
                                       );
                  end;
   procedure DL_CUR_AE_I_POE_E (V_AE_I_POE_E_CURSOR in out mfm.ae_i_poe_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(1);
                      v_null_string   varchar(10);
                      v_null_date     date;
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      v_null_string := null;
                      v_null_date := null;
                      open v_ae_i_poe_e_cursor for
                  select
                  	ae_i_poe_e.purchase_order,
                  	ae_i_poe_e.po_code,
                  	ae_i_poe_e.description,
                  	ae_i_poe_e.status_code,
                  	ae_i_poe_e.contractor,
                  	ae_i_poe_e.address_code,
                  	ae_i_poe_e.warehouse,
                  	'N',
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string
                  from
                  	ae_i_poe_e,
                  	ae_i_poe_status_e,
                  	ae_i_whs_security,
                      mfm_warehouse_for_po_download,
                      ae_i_whs_e,
                      ae_authz_principal, 
                      ae_authz
                  where	ae_i_poe_e.warehouse = ae_i_whs_security.warehouse
                   and 	ae_i_whs_security.warehouse = ae_i_whs_e.warehouse
                   and     ae_i_whs_e.active = 'Y'
                  	and (ae_i_poe_e.warehouse = mfm_warehouse_for_po_download.warehouse
                        or mfm_warehouse_for_po_download.warehouse = 'GITMB')
                  	and ae_i_poe_e.status_code = ae_i_poe_status_e.status_code
                  	and ae_i_poe_status_e.complete_yn = 'F'
                      and upper(mfm_warehouse_for_po_download.login) = upper(v_ml_user)
                      and rtrim(mfm_warehouse_for_po_download.pda_id) = 'PDA_ID'
                      and upper(ae_authz_principal.login) = upper(v_ml_user)
                      and ae_authz_principal.role_id = ae_i_whs_security.role_id
                      and ae_authz.role_id = ae_authz_principal.role_id
                      and ae_authz.active = 'Y'
                  union
                  select
                  	ae_i_poe_e.purchase_order,
                  	ae_i_poe_e.po_code,
                  	ae_i_poe_e.description,
                  	ae_i_poe_e.status_code,
                  	ae_i_poe_e.contractor,
                  	ae_i_poe_e.address_code,
                  	ae_i_poe_e.warehouse,
                  	'N',
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string
                  from
                  	ae_i_poe_e,
                  	ae_i_poe_status_e,
                      mfm_warehouse_for_po_download,
                      ae_i_whs_e
                  where ae_i_poe_e.warehouse = mfm_warehouse_for_po_download.warehouse
                    and ae_i_poe_e.warehouse = ae_i_whs_e.warehouse
                    and ae_i_whs_e.active = 'Y'
                  	and ae_i_poe_e.status_code = ae_i_poe_status_e.status_code
                  	and ae_i_poe_status_e.complete_yn = 'F'
                      and upper(mfm_warehouse_for_po_download.login) = upper(v_ml_user)
                      and rtrim(mfm_warehouse_for_po_download.pda_id) = 'PDA_ID'
                      and not exists ( select *
                                        from ae_i_whs_security, ae_i_whs_e
                                       where ae_i_whs_security.warehouse = ae_i_poe_e.warehouse
                                         and ae_i_whs_e.warehouse = ae_i_whs_e.warehouse
                                         and ae_i_whs_e.active = 'Y')
                  union
                  select
                  	ae_i_poe_e.purchase_order,
                  	ae_i_poe_e.po_code,
                  	ae_i_poe_e.description,
                  	ae_i_poe_e.status_code,
                  	ae_i_poe_e.contractor,
                  	ae_i_poe_e.address_code,
                  	ae_i_poe_e.warehouse,
                  	'N',
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string,
                      v_null_string,
                      v_null_date,
                      v_null_string,
                      v_null_string
                  from
                  	ae_i_poe_e,
                  	ae_i_poe_status_e,
                      mfm_warehouse_for_po_download
                  where mfm_warehouse_for_po_download.warehouse = 'GITMB'
                  	and ae_i_poe_e.status_code = ae_i_poe_status_e.status_code
                  	and ae_i_poe_status_e.complete_yn = 'F'
                      and upper(mfm_warehouse_for_po_download.login) = upper(v_ml_user)
                      and rtrim(mfm_warehouse_for_po_download.pda_id) = 'PDA_ID'
                      and not exists ( select *
                                        from ae_i_whs_security, ae_i_whs_e
                                       where ae_i_whs_security.warehouse = ae_i_poe_e.warehouse
                                         and ae_i_whs_e.warehouse = ae_i_whs_e.warehouse
                                         and ae_i_whs_e.active = 'Y');
                  end;
   procedure DL_CUR_AE_P_PRO_S (V_AE_P_PRO_S_CURSOR in out mfm.ae_p_pro_s_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   open v_ae_p_pro_s_cursor for
                   select trim(shop_person.proposal),
                          trim(shop_person.sort_code),
                          trim(shop_person.shop_person),
                          shop_person.primary_yn,
                          shop_person.ent_clerk,
                          shop_person.entrydate,
                          '' action_flag,
                          null,
                          null,
                          v_edit_date,
                          shop_person.certified_yn,
                          shop_person.edit_clerk
                     from ae_p_pro_s shop_person,
                          ae_p_phs_e phase,
                          mfm_ae_p_phs_e_download dw
                    where shop_person.proposal = dw.proposal
                      and shop_person.sort_code = dw.sort_code
                      and phase.proposal = dw.proposal
                      and phase.sort_code = dw.sort_code
                      and upper(dw.login) = upper(v_ml_user)
                      and rtrim(dw.pda_id) = rtrim(v_pda_id)
                      and (dw.download_action = 'I'
                       or shop_person.edit_date >= v_last_download);
               end;
   procedure DL_CUR_AE_P_WKA_D (V_AE_P_WKA_D_CURSOR in out mfm.ae_p_wka_d_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   open v_ae_p_wka_d_cursor for
                   select time_card_header.shop_person,
                          time_card_header.sched_date,
                          time_card_detail.act_hrs,
                          time_card_detail.trans_no,
                          time_card_detail.item_no,
                          time_card_detail.time_type,
                          time_card_detail.proposal,
                          time_card_detail.sort_code,
                          time_card_detail.start_time,
                          time_card_detail.stop_time,
                          '' action_flag,
                          time_card_header.entry_clerk,
                          null,
                          null,
                          v_edit_date,
                          time_card_detail.action_taken,
                          time_card_detail.labor_class,
                          time_card_detail.lev_code,
                          time_card_detail.edit_clerk,
                          time_card_detail.craft_code
                     from ae_p_wka_d time_card_detail,
                          ae_p_wka_e time_card_header,
                          ae_p_pro_e wr,
                          mfm_ae_p_phs_e_download dw
                    where time_card_detail.proposal = dw.proposal
                      and time_card_detail.sort_code = dw.sort_code
                      and time_card_detail.trans_no = time_card_header.trans_no
                      and wr.proposal = dw.proposal
                      and upper(dw.login) = upper(v_ml_user)
                      and rtrim(dw.pda_id) = rtrim(v_pda_id)
                      and (dw.download_action = 'I'
                       or time_card_detail.edit_date >= v_last_download);
               end;
   procedure DL_CUR_AE_P_WKA_E (V_AE_P_WKA_E_CURSOR in out mfm.ae_p_wka_e_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   open v_ae_p_wka_e_cursor for
                   select time_card_header.shop_person,
                          time_card_header.sched_date,
                          time_card_header.entry_clerk,
                          time_card_header.entry_date,
                          time_card_header.trans_no
                     from ae_p_wka_d time_card_detail,
                          ae_p_wka_e time_card_header,
                          mfm_ae_p_phs_e_download dw
                    where time_card_detail.proposal = dw.proposal
                      and time_card_detail.sort_code = dw.sort_code
                      and time_card_detail.trans_no = time_card_header.trans_no
                      and upper(dw.login) = upper(v_ml_user)
                      and rtrim(dw.pda_id) = rtrim(v_pda_id)
                      and (dw.download_action = 'I'
                       or time_card_header.edit_date >= v_last_download);
               end;
   procedure DL_CUR_AE_I_WHS_E_INV (V_AE_I_WHS_E_CURSOR in out mfm.ae_i_whs_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                         v_edit_date  date;
                         v_login      ae_s_sec_c.login%type;
                         v_action_flag   varchar(1);
                         v_null_string   varchar(10);
                         v_null_date     date;
                     begin
                         v_pda_id := 'PDA_ID';
                         v_edit_date := null;
                         v_login := null;
                         v_action_flag := null;
                         v_null_string := null;
                         v_null_date := null;
                         open v_ae_i_whs_e_cursor for
                     select
                         	ae_i_whs_e.warehouse,
                         	ae_i_whs_e.description,
                           ae_i_whs_e.active
                     from
                     	ae_i_whs_e,
                     	ae_i_whs_security,
                      ae_authz_principal, 
                      ae_authz
                     where	ae_i_whs_e.warehouse = ae_i_whs_security.warehouse
                      and ae_i_whs_e.active = 'Y'
                     	and ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                      and upper(ae_authz_principal.login) = upper(v_ml_user)
                      and ae_authz_principal.role_id = ae_i_whs_security.role_id
                      and ae_authz.role_id = ae_authz_principal.role_id
                      and ae_authz.active = 'Y'
                     union
                     select
                         	ae_i_whs_e.warehouse,
                         	ae_i_whs_e.description,
                           ae_i_whs_e.active
                     from
                     	ae_i_whs_e
                     where ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                         and ae_i_whs_e.active = 'Y'
                         and not exists ( select *
                                           from ae_i_whs_security
                                          where ae_i_whs_security.warehouse = ae_i_whs_e.warehouse);
                end;
   procedure DL_CUR_AE_R_EQM_E (V_AE_R_EQM_E_CUR in out mfm.ae_r_eqm_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                         v_edit_date  date;
                         v_login      ae_s_sec_c.login%type;
                         v_action_flag   varchar(10);
                         v_now    date;
                         v_null_string    varchar(1);
                         v_count_sup_shop numeric(8,0);
                         v_count_whse_sup_shop numeric(8,0);
                         v_mfm_date  date;
                         cursor c_sup_shop(v_login    ae_s_sec_c.login%type) is
                             select count(*)
                                from ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup
                               where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
                                 and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                 and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                                 and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                                 and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= sysdate)
                                 and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= sysdate)
                                 and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop;
                         cursor c_whse_sup_shop(v_login    ae_s_sec_c.login%type) is
                             select count(*)
                                from ae_s_sec_c, ae_l_shp_d, ae_i_whs_e_sup_shop, ae_i_whs_e
                               where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
                                 and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                 and ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                                 and ae_i_whs_e.active = 'Y'
                                 and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                                 and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                                 and (ae_i_whs_e_sup_shop.start_date is null or ae_i_whs_e_sup_shop.start_date <= sysdate)
                                 and (ae_i_whs_e_sup_shop.end_date is null or ae_i_whs_e_sup_shop.end_date >= sysdate)
                                 and ae_l_shp_d.shop = ae_i_whs_e_sup_shop.shop;
                         v_pda_memory mfm_user_pda.memory%type;
                         v_flag_147 ae_s_sys_f.parameter%type;
                         cursor c_flag_147 is
                           select parameter
                             from ae_s_sys_f
                            where flag_id = 147;
                     begin
                         v_pda_id := 'PDA_ID';
                         v_edit_date := null;
                         v_login := V_ML_USER;
                         v_action_flag := null;
                         v_now := sysdate;
                         v_null_string := null;
                         mfm_get_pda_memory(v_ml_user, v_pda_memory);
                         open c_sup_shop(v_login);
                         fetch c_sup_shop into v_count_sup_shop;
                         close c_sup_shop;
   
                         open c_whse_sup_shop(v_login);
                         fetch c_whse_sup_shop into v_count_whse_sup_shop;
                         close c_whse_sup_shop;
   
                         v_mfm_date := sysdate;
   
                         delete from mfm_ae_r_eqm_e
                         where upper(mfm_login) = upper(v_login);
   
                         if v_pda_memory > 70 then
                             if v_count_sup_shop > 0 and v_count_whse_sup_shop > 0 then
                                 insert into mfm_ae_r_eqm_e
                                      SELECT
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM 	ae_l_shp_d,
                                     	    ae_i_whs_e_sup_shop,
                                             ae_r_eqm_e,
                                             ae_s_sec_c,
                                             ae_i_inv_e,
                                             ae_i_whs_e,
                                             ae_r_eqm_s
                                     WHERE    upper(ae_s_sec_c.login) = upper(v_ml_user)
                                       and    ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                       and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                       and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                       and	ae_l_shp_d.shop = ae_i_whs_e_sup_shop.shop
                                       and 	ae_i_whs_e_sup_shop.warehouse = ae_r_eqm_e.warehouse
                                       and 	ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                                       and    ae_i_whs_e.active = 'Y'
                                       and (ae_i_whs_e_sup_shop.start_date is null or ae_i_whs_e_sup_shop.start_date <= v_now)
                                       and (ae_i_whs_e_sup_shop.end_date is null or ae_i_whs_e_sup_shop.end_date >= v_now)
                                       and	(ae_r_eqm_e.edit_date >= v_last_download
                                        or     ae_i_whs_e_sup_shop.edit_date >= v_last_download)
                                       and     ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                    UNION
                                      SELECT
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM 	ae_l_shp_d,
                                     	    ae_s_bld_shp_sup,
                                             ae_r_eqm_e,
                                             ae_s_sec_c,
                                             ae_i_inv_e,
                                           ae_r_eqm_s
                                     WHERE    upper(ae_s_sec_c.login) = upper(v_ml_user)
                                       and    ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                       and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                       and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                       and	ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                                       and 	ae_s_bld_shp_sup.region_code = ae_r_eqm_e.region_code
                                       and 	ae_s_bld_shp_sup.fac_id = ae_r_eqm_e.fac_id
                                       and 	ae_s_bld_shp_sup.bldg = ae_r_eqm_e.bldg
                                       and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= v_now)
                                       and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= v_now)
                                       and	(ae_r_eqm_e.edit_date >= v_last_download
                                        or     ae_s_bld_shp_sup.edit_date >= v_last_download)
                                       and     ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                       ;
                                 end if;
                             if v_count_sup_shop = 0 and v_count_whse_sup_shop > 0 then
                                 insert into mfm_ae_r_eqm_e
                                      SELECT
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM 	ae_l_shp_d,
                                     	    ae_i_whs_e_sup_shop,
                                             ae_r_eqm_e,
                                             ae_s_sec_c,
                                             ae_i_inv_e,
                                             ae_i_whs_e,
                                           ae_r_eqm_s
                                     WHERE    upper(trim(ae_s_sec_c.login)) = upper(trim(v_ml_user))
                                       and    ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                       and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                       and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                       and	ae_l_shp_d.shop = ae_i_whs_e_sup_shop.shop
                                       and 	ae_i_whs_e_sup_shop.warehouse = ae_r_eqm_e.warehouse
                                       and 	ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                                       and    ae_i_whs_e.active = 'Y'
                                       and (ae_i_whs_e_sup_shop.start_date is null or ae_i_whs_e_sup_shop.start_date <= v_now)
                                       and (ae_i_whs_e_sup_shop.end_date is null or ae_i_whs_e_sup_shop.end_date >= v_now)
                                       and	(ae_r_eqm_e.edit_date >= v_last_download
                                        or     ae_i_whs_e_sup_shop.edit_date >= v_last_download)
                                       and     ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                       ;
                                 end if;
                             if v_count_sup_shop > 0 and v_count_whse_sup_shop = 0 then
                                 insert into mfm_ae_r_eqm_e
                                      SELECT
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM 	ae_l_shp_d,
                                     	    ae_s_bld_shp_sup,
                                             ae_r_eqm_e,
                                             ae_s_sec_c,
                                             ae_i_inv_e,
                                           ae_r_eqm_s
                                     WHERE    upper(trim(ae_s_sec_c.login)) = upper(trim(v_ml_user))
                                       and    ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                       and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                       and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                       and	ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                                       and 	ae_s_bld_shp_sup.region_code = ae_r_eqm_e.region_code
                                       and 	ae_s_bld_shp_sup.fac_id = ae_r_eqm_e.fac_id
                                       and 	ae_s_bld_shp_sup.bldg = ae_r_eqm_e.bldg
                                       and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= v_now)
                                       and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= v_now)
                                       and	(ae_r_eqm_e.edit_date >= v_last_download
                                        or     ae_s_bld_shp_sup.edit_date >= v_last_download)
                                       and     ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                       ;
                                 end if;
                             if v_count_sup_shop = 0 and v_count_whse_sup_shop = 0 then
                                 insert into mfm_ae_r_eqm_e
                                      SELECT
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM  ae_r_eqm_e,
                                           ae_i_inv_e,
                                           ae_r_eqm_s
                                     WHERE  ae_r_eqm_e.edit_date >= v_last_download
                                       and  ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                      and ( ae_r_eqm_e.warehouse is null or
                                            ae_r_eqm_e.warehouse = '' or
                                            exists ( select *
                                                       from ae_i_whs_e
                                                      where ae_i_whs_e.warehouse = ae_r_eqm_e.warehouse
                                                        and ae_i_whs_e.active = 'Y'))
                                        ;
                              end if;
                          else
                             if v_count_sup_shop > 0 and v_count_whse_sup_shop > 0 then
                                 insert into mfm_ae_r_eqm_e
                                      SELECT distinct
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM 	ae_l_shp_d,
                                     	        ae_i_whs_e_sup_shop,
                                             ae_r_eqm_e,
                                             ae_s_sec_c,
                                             ae_i_inv_e,
                                             ae_i_whs_e,
                                             ae_r_eqm_s,
                                              mfm_ae_p_phs_e_download
                                     WHERE    upper(trim(ae_s_sec_c.login)) = upper(trim(v_ml_user))
                                       and    ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                       and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                       and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                       and	ae_l_shp_d.shop = ae_i_whs_e_sup_shop.shop
                                       and 	ae_i_whs_e_sup_shop.warehouse = ae_r_eqm_e.warehouse
                                       and 	ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                                       and    ae_i_whs_e.active = 'Y'
                                       and (ae_i_whs_e_sup_shop.start_date is null or ae_i_whs_e_sup_shop.start_date <= v_now)
                                       and (ae_i_whs_e_sup_shop.end_date is null or ae_i_whs_e_sup_shop.end_date >= v_now)
                                       and	(ae_r_eqm_e.edit_date >= v_last_download
                                        or     ae_i_whs_e_sup_shop.edit_date >= v_last_download)
                                       and     ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                        and upper(mfm_ae_p_phs_e_download.login) = upper(v_ml_user)
                                        and rtrim(mfm_ae_p_phs_e_download.pda_id) = rtrim(v_pda_id)
                                    UNION
                                      SELECT distinct
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM 	ae_l_shp_d,
                                     	    ae_s_bld_shp_sup,
                                             ae_r_eqm_e,
                                             ae_s_sec_c,
                                             ae_i_inv_e,
                                             ae_r_eqm_s,
                                              mfm_ae_p_phs_e_download,
                                              ae_p_pro_e
                                     WHERE    upper(trim(ae_s_sec_c.login)) = upper(trim(v_ml_user))
                                       and    ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                       and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                       and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                       and	ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                                       and 	ae_s_bld_shp_sup.region_code = ae_r_eqm_e.region_code
                                       and 	ae_s_bld_shp_sup.fac_id = ae_r_eqm_e.fac_id
                                       and 	ae_s_bld_shp_sup.bldg = ae_r_eqm_e.bldg
                                       and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= v_now)
                                       and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= v_now)
                                       and	(ae_r_eqm_e.edit_date >= v_last_download
                                        or     ae_p_pro_e.edit_date >= v_last_download
                                        or     ae_s_bld_shp_sup.edit_date >= v_last_download)
                                       and     ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                        and    ae_p_pro_e.region_code = ae_r_eqm_e.region_code
                                        and    ae_p_pro_e.fac_id = ae_r_eqm_e.fac_id
                                        and    ae_p_pro_e.bldg = ae_r_eqm_e.bldg
                                        and    mfm_ae_p_phs_e_download.proposal = ae_p_pro_e.proposal
                                        and upper(mfm_ae_p_phs_e_download.login) = upper(v_ml_user)
                                        and rtrim(mfm_ae_p_phs_e_download.pda_id) = rtrim(v_pda_id)
                                       ;
                                 end if;
                             if v_count_sup_shop = 0 and v_count_whse_sup_shop > 0 then
                                 insert into mfm_ae_r_eqm_e
                                      SELECT distinct
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM 	ae_l_shp_d,
                                     	    ae_i_whs_e_sup_shop,
                                             ae_r_eqm_e,
                                             ae_s_sec_c,
                                             ae_i_inv_e,
                                             ae_i_whs_e,
                                             ae_r_eqm_s,
                                              mfm_ae_p_phs_e_download
                                     WHERE    upper(trim(ae_s_sec_c.login)) = upper(trim(v_ml_user))
                                       and    ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                       and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                       and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                       and	ae_l_shp_d.shop = ae_i_whs_e_sup_shop.shop
                                       and 	ae_i_whs_e_sup_shop.warehouse = ae_r_eqm_e.warehouse
                                       and 	ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                                       and    ae_i_whs_e.active = 'Y'
                                       and (ae_i_whs_e_sup_shop.start_date is null or ae_i_whs_e_sup_shop.start_date <= v_now)
                                       and (ae_i_whs_e_sup_shop.end_date is null or ae_i_whs_e_sup_shop.end_date >= v_now)
                                       and	(ae_r_eqm_e.edit_date >= v_last_download
                                        or     ae_i_whs_e_sup_shop.edit_date >= v_last_download)
                                       and     ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                        and upper(mfm_ae_p_phs_e_download.login) = upper(v_ml_user)
                                        and rtrim(mfm_ae_p_phs_e_download.pda_id) = rtrim(v_pda_id)
                                       ;
                                 end if;
                             if v_count_sup_shop > 0 and v_count_whse_sup_shop = 0 then
                                 insert into mfm_ae_r_eqm_e
                                      SELECT distinct
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM 	ae_l_shp_d,
                                     	       ae_s_bld_shp_sup,
                                             ae_r_eqm_e,
                                             ae_s_sec_c,
                                             ae_i_inv_e,
                                             ae_r_eqm_s,
                                              mfm_ae_p_phs_e_download,
                                              ae_p_pro_e
                                     WHERE    upper(trim(ae_s_sec_c.login)) = upper(trim(v_ml_user))
                                       and    ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                       and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                       and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                       and	ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                                       and 	ae_s_bld_shp_sup.region_code = ae_r_eqm_e.region_code
                                       and 	ae_s_bld_shp_sup.fac_id = ae_r_eqm_e.fac_id
                                       and 	ae_s_bld_shp_sup.bldg = ae_r_eqm_e.bldg
                                       and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= v_now)
                                       and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= v_now)
                                       and	(ae_r_eqm_e.edit_date >= v_last_download
                                        or     ae_p_pro_e.edit_date >= v_last_download
                                        or     ae_s_bld_shp_sup.edit_date >= v_last_download)
                                       and     ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                        and    ae_p_pro_e.region_code = ae_r_eqm_e.region_code
                                        and    ae_p_pro_e.fac_id = ae_r_eqm_e.fac_id
                                        and    ae_p_pro_e.bldg = ae_r_eqm_e.bldg
                                        and    mfm_ae_p_phs_e_download.proposal = ae_p_pro_e.proposal
                                        and upper(mfm_ae_p_phs_e_download.login) = upper(v_ml_user)
                                        and rtrim(mfm_ae_p_phs_e_download.pda_id) = rtrim(v_pda_id)
                                       ;
                                 end if;
                             if v_count_sup_shop = 0 and v_count_whse_sup_shop = 0 then
                                 insert into mfm_ae_r_eqm_e
                                      SELECT distinct
                                         v_login,
                                         v_mfm_date,
                                         ae_r_eqm_e.description,
                                         ae_r_eqm_e.region_code,
                                         ae_r_eqm_e.fac_id,
                                         ae_r_eqm_e.bldg,
                                         ae_r_eqm_e.location_code,
                                         ae_r_eqm_e.loc_id,
                                         ae_r_eqm_e.shop,
                                         ae_r_eqm_e.shop_person,
                                         ae_r_eqm_e.warehouse,
                                         ae_r_eqm_e.bin_location,
                                         ae_r_eqm_e.eqm_status,
                                         ae_r_eqm_e.original_cost,
                                         v_null_string action_flag,
                                         v_null_string,
                                         v_null_string,
                                         v_edit_date,
                                         ae_i_inv_e.description,
                                         ae_r_eqm_e.eqm_group,
                                         ae_r_eqm_e.eqp_tag_id,
                                         ae_r_eqm_e.long_desc,
                                         ae_r_eqm_e.part,
                                         ae_r_eqm_e.edit_clerk
                                     FROM  ae_r_eqm_e,
                                           ae_i_inv_e,
                                           ae_r_eqm_s,
                                              mfm_ae_p_phs_e_download,
                                              ae_p_pro_e
                                     WHERE  (ae_r_eqm_e.edit_date >= v_last_download
                                        or   ae_p_pro_e.edit_date >= v_last_download)
                                       and  ae_i_inv_e.part = ae_r_eqm_e.part
                                       and     ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                                       and     ae_r_eqm_s.complete_yn <> 'D'
                                        and    ae_p_pro_e.region_code = ae_r_eqm_e.region_code
                                        and    ae_p_pro_e.fac_id = ae_r_eqm_e.fac_id
                                        and    ae_p_pro_e.bldg = ae_r_eqm_e.bldg
                                        and    mfm_ae_p_phs_e_download.proposal = ae_p_pro_e.proposal
                                        and upper(mfm_ae_p_phs_e_download.login) = upper(v_ml_user)
                                        and rtrim(mfm_ae_p_phs_e_download.pda_id) = rtrim(v_pda_id)
                                        ;
                         end if;
                   end if;
   
                         open V_AE_R_EQM_E_CUR for
                              SELECT distinct
                                 mfm_ae_r_eqm_e.description,
                                 mfm_ae_r_eqm_e.region_code,
                                 mfm_ae_r_eqm_e.fac_id,
                                 mfm_ae_r_eqm_e.bldg,
                                 mfm_ae_r_eqm_e.location_code,
                                 mfm_ae_r_eqm_e.loc_id,
                                 mfm_ae_r_eqm_e.shop,
                                 mfm_ae_r_eqm_e.shop_person,
                                 mfm_ae_r_eqm_e.warehouse,
                                 mfm_ae_r_eqm_e.bin_location,
                                 mfm_ae_r_eqm_e.eqm_status,
                                 mfm_ae_r_eqm_e.original_cost,
                                 mfm_ae_r_eqm_e.action_flag,
                                 mfm_ae_r_eqm_e.login,
                                 mfm_ae_r_eqm_e.pda_id,
                                 mfm_ae_r_eqm_e.edit_date,
                                 mfm_ae_r_eqm_e.description,
                                 mfm_ae_r_eqm_e.eqm_group,
                                 mfm_ae_r_eqm_e.eqp_tag_id,
                                 mfm_ae_r_eqm_e.long_desc,
                                 mfm_ae_r_eqm_e.part,
                                 mfm_ae_r_eqm_e.edit_clerk
                             FROM  mfm_ae_r_eqm_e
                             where upper(mfm_login) = upper(v_login)
                               and mfm_date = v_mfm_date;
               end;
   procedure DL_DEL_CUR_AE_P_PHS_E (V_AE_P_PHS_E_DELETE_CURSOR in out mfm.ae_p_phs_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
   
               begin
   
               v_pda_id := 'PDA_ID';
                   open v_ae_p_phs_e_delete_cursor for
   
            select proposal, sort_code
              from mfm_ae_p_phs_e_download
             where rtrim(login) = rtrim(v_ml_user)
               and rtrim(pda_id) = rtrim(v_pda_id)
               and (download_action = 'D'
                or  download_action = 'H');
   
               end;
   procedure DL_CUR_AE_R_PMS_D (V_AE_R_PMS_D_CURSOR in out ae_r_pms_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   open v_ae_r_pms_d_cursor for
                select 'N' checkbox,
                       phase.proposal,
                	      phase.sort_code,
                       phase.pmi_basic,
                       pmi.check_point,
                       pmi.description,
                       pmi.lab_unit_hrs,
                       pmi.means_freq,
                       'N',
                       '' action_flag,
                       null,
                       null,
                       v_edit_date,
                       pmi.long_desc
                  from ae_r_pms_d pmi,
                       ae_p_phs_e phase,
                       mfm_ae_p_phs_e_download dw
                 where phase.proposal = dw.proposal
                   and phase.sort_code = dw.sort_code
                   and upper(dw.login) = upper(v_ml_user)
                   and rtrim(dw.pda_id) = rtrim(v_pda_id)
                   and dw.download_action in ('I', 'U')
                   and phase.pmi_basic = pmi.pmi_basic;
               end;
   procedure END_DL_WR (V_LAST_DOWNLOAD date,V_ML_USER ae_s_sec_c.login%type) as
   v_pda_id         mfm_ae_p_phs_e_download.pda_id %type;
               begin
                   v_pda_id := 'PDA_ID';
                   update mfm_ae_p_phs_e_download
                      set download_action = 'X'
                    where upper(login) = upper(v_ml_user)
                      and rtrim(pda_id) = rtrim(v_pda_id)
                      and download_action = 'D';
               end;
   procedure DL_DEL_CUR_AE_P_PRO_E (V_AE_P_PRO_E_DELETE_CURSOR in out ae_p_pro_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open V_ae_p_pro_e_DELETE_CURSOR for
   
               select distinct proposal
                 from mfm_ae_p_phs_e_download
                where upper(rtrim(login)) = upper(rtrim(v_ml_user))
                  and rtrim(pda_id) = rtrim(v_pda_id)
                  and download_action in ('D', 'H', 'X')
                  and not exists ( select dl.proposal
                                     from mfm_ae_p_phs_e_download dl
                                    where upper(rtrim(dl.login)) = upper(rtrim(v_ml_user))
                                      and rtrim(dl.pda_id) = rtrim(v_pda_id)
                                      and (dl.download_action not in ('D', 'H', 'X')
                                       or dl.download_action is null)
               		               and dl.proposal = mfm_ae_p_phs_e_download.proposal
                                      );
   
               end;
   procedure DL_CUR_AE_L_STOCK_USE (V_AE_L_STOCK_USE_CURSOR in out mfm.ae_l_stock_use_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(10);
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      open V_AE_L_STOCK_USE_CURSOR for
                  select stock_use.stock_location,
                         stock_use.trans_date,
                         stock_use.proposal,
                         stock_use.sort_code,
                         stock_use.stock_no,
                         stock_use.qty_used,
                         stock_use.ext_cost,
                         stock_use.posted_yn,
                         stock_use.trans_no,
                         '' action_code,
                             null,
                             null,
                             v_edit_date
                    from ae_l_stock_use stock_use,
                         mfm_ae_p_phs_e_download download
                   where stock_use.proposal = download.proposal
                     and stock_use.sort_code = download.sort_code
                     and upper(download.login) = upper(v_ml_user)
                     and rtrim(download.pda_id) = rtrim(v_pda_id)
                     and (download.download_action = 'I'
                      or stock_use.edit_date >= v_last_download)
                     and stock_use.posted_yn = 'N';
                  end;
   procedure DL_DEL_CUR_AE_P_WKA_D (V_AE_P_WKA_D_DELETE_CURSOR in out mfm.ae_p_wka_d_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
   
               begin
   
               v_pda_id := 'PDA_ID';
                   open v_ae_p_wka_d_delete_cursor for
   
            select trans_no, item_no
              from mfm_ae_p_wka_d_delete
             where upper(rtrim(login)) = upper(rtrim(v_ml_user))
               and rtrim(pda_id) = rtrim(v_pda_id);
   
   
               end;
   procedure DL_DEL_CUR_AE_P_REQ_E (V_AE_P_REQ_E_DELETE_CURSOR in out mfm.ae_p_req_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
   
               begin
   
               v_pda_id := 'PDA_ID';
                   open v_ae_p_req_e_delete_cursor for
   
            select doc_no
              from mfm_ae_p_req_e_delete
             where upper(rtrim(login)) = upper(rtrim(v_ml_user))
               and rtrim(pda_id) = rtrim(v_pda_id);
   
   
               end;
   procedure DL_DEL_CUR_AE_I_EXT_E (V_AE_I_EXT_E_DELETE_CURSOR in out mfm.ae_i_ext_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
   
               begin
   
               v_pda_id := 'PDA_ID';
                   open v_ae_i_ext_e_delete_cursor for
   
            select trans_no
              from mfm_ae_i_ext_e_delete
             where upper(rtrim(login)) = upper(rtrim(v_ml_user))
               and rtrim(pda_id) = rtrim(v_pda_id);
   
   
               end;
   procedure DL_CUR_MFM_ERROR_LOG (V_MFM_ERROR_LOG_CUR in out mfm.mfm_error_log_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_download_date date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_download_date := null;
                   open v_mfm_error_log_cur for
                select error_no,
                        error_type,
                        action,
                        error_code,
                        odbc_state,
                        error_message,
                        user_name,
                        table_name,
                        error_date,
                        pda_id,
                        v_download_date
                  from mfm_error_log
                 where rtrim(upper(user_name)) = rtrim(upper(v_ml_user))
                   and rtrim(pda_id) = rtrim(v_pda_id)
                   and error_date > v_last_download
                   and v_last_download <> to_date('01-JAN-1900','dd-mon-yyyy');
              end;
   procedure DL_CUR_AE_S_BLD_C (V_AE_S_BLD_C_CURSOR in out mfm.ae_s_bld_c_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_null_string   varchar(10);
                   v_null_date     date;
                   v_count_sup_shop numeric(8,0);
                   cursor c_sup_shop(v_login    ae_s_sec_c.login%type) is
                       select count(*)
                          from ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup
                         where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
                           and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                           and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                           and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                           and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                              and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= sysdate)
                              and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= sysdate)
                           ;
   
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := V_ML_USER;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   v_login := v_ml_user;
   
                   open c_sup_shop(v_login);
                   fetch c_sup_shop into v_count_sup_shop;
                   close c_sup_shop;
   
                   if v_count_sup_shop > 0 then
                       open v_ae_s_bld_c_cursor for
   
                    select ae_s_bld_c.region_code,
                            ae_s_bld_c.fac_id,
                            ae_s_bld_c.bldg,
                            ae_s_bld_c.description
                      from ae_s_bld_c, ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup, ae_s_bld_s
                     where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
                       and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                       and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                       and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                       and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                       and ae_s_bld_shp_sup.region_code = ae_s_bld_c.region_code
                       and ae_s_bld_shp_sup.fac_id = ae_s_bld_c.fac_id
                       and ae_s_bld_shp_sup.bldg = ae_s_bld_c.bldg
                       and (ae_s_bld_c.edit_date >= v_last_download
                        or  ae_s_bld_shp_sup.edit_date >= v_last_download)
                       and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= sysdate)
                       and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= sysdate)
                           and ae_s_bld_c.bldg_status = ae_s_bld_s.bldg_status
                           and ae_s_bld_s.complete_yn <> 'Y'
                        ;
                   else
                       open v_ae_s_bld_c_cursor for
   
                    select ae_s_bld_c.region_code,
                            ae_s_bld_c.fac_id,
                            ae_s_bld_c.bldg,
                            ae_s_bld_c.description
                      from ae_s_bld_c, ae_s_bld_s
                     where ae_s_bld_c.edit_date >= v_last_download
                           and ae_s_bld_c.bldg_status = ae_s_bld_s.bldg_status
                           and ae_s_bld_s.complete_yn <> 'Y'
                           ;
                    end if;
               end;
   procedure DL_CUR_AE_B_LOC_D (V_AE_B_LOC_D_CURSOR in out mfm.ae_b_loc_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_null_string   varchar(10);
                   v_null_date     date;
                   v_count_sup_shop numeric(8,0);
                   cursor c_sup_shop(v_login    ae_s_sec_c.login%type) is
                       select count(*)
                          from ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup
                         where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
                           and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                           and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                           and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                           and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := V_ML_USER;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   v_login := v_ml_user;
   
                   open c_sup_shop(v_login);
                   fetch c_sup_shop into v_count_sup_shop;
                   close c_sup_shop;
   
                   if v_count_sup_shop > 0 then
                       open v_ae_b_loc_d_cursor for
                            select ae_b_loc_d.region_code,
                                    ae_b_loc_d.fac_id,
                                    ae_b_loc_d.bldg,
                                    ae_b_loc_d.location_code,
                                    ae_b_loc_d.flr_id,
                                    trim(ae_b_loc_d.description),
                                    ae_b_loc_d.loc_id
                              from ae_b_loc_d, ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup, ae_b_loc_s
                             where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
                               and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                               and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                               and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                               and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                               and ae_s_bld_shp_sup.region_code = ae_b_loc_d.region_code
                               and ae_s_bld_shp_sup.fac_id = ae_b_loc_d.fac_id
                               and ae_s_bld_shp_sup.bldg = ae_b_loc_d.bldg
                               and (ae_b_loc_d.edit_date >= v_last_download
                                or  ae_s_bld_shp_sup.edit_date >= v_last_download)
                               and ae_b_loc_d.loc_status = ae_b_loc_s.loc_status
                               and ae_b_loc_s.complete_yn <> 'Y'
                                ;
                    else
                       open v_ae_b_loc_d_cursor for
                            select ae_b_loc_d.region_code,
                                    ae_b_loc_d.fac_id,
                                    ae_b_loc_d.bldg,
                                    ae_b_loc_d.location_code,
                                    ae_b_loc_d.flr_id,
                                    trim(ae_b_loc_d.description),
                                    ae_b_loc_d.loc_id
                              from ae_b_loc_d, ae_b_loc_s
                             where ae_b_loc_d.edit_date >= v_last_download
                               and ae_b_loc_d.loc_status = ae_b_loc_s.loc_status
                               and ae_b_loc_s.complete_yn <> 'Y'
                               ;
                    end if;
               end;
   procedure DL_CUR_AE_P_STA_E (V_AE_P_STA_E_CURSOR in out mfm.ae_p_sta_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open V_AE_P_STA_E_CURSOR for
   
               select distinct hist.proposal,
                    hist.status_code,
                    hist.status_date,
                    hist.login,
                    hist.category,
                          null,
                          '' action_flag,
                          v_edit_date,
                          sysdate,
                          hist.order_type,
                          hist.edit_clerk
                     from ae_p_sta_e hist,
                          mfm_ae_p_phs_e_download dw
                    where hist.proposal = dw.proposal
                      and upper(dw.login) = upper(v_ml_user)
                      and rtrim(dw.pda_id) = rtrim(v_pda_id)
                      and (dw.download_action = 'I'
                       or  hist.status_date >= v_last_download);
               end;
   procedure DL_CUR_AE_P_PST_E (V_AE_P_PST_E_CUR in out mfm.ae_p_pst_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(10);
                      v_null_string   varchar(10);
                      v_null_date     date;
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      v_null_string := null;
                      v_null_date := null;
                      open V_AE_P_PST_E_CUR for
   
                  select hist.proposal,
                       hist.sort_code,
                       hist.status_code,
                       hist.status_date,
                       hist.login,
                       hist.category,
                             null,
                             '' action_flag,
                             v_edit_date,
                             sysdate,
                       hist.order_type,
                       hist.edit_clerk
                        from ae_p_pst_e hist,
                             mfm_ae_p_phs_e_download dw
                       where hist.proposal = dw.proposal
                         and upper(dw.login) = upper(v_ml_user)
                         and rtrim(dw.pda_id) = rtrim(v_pda_id)
                         and (dw.download_action = 'I'
                          or  hist.status_date >= v_last_download);
                  end;
   procedure DL_DEL_CUR_MFM_TIME_CARD_SUM (V_MFM_TIME_CARD_SUMMARY_CURSOR in out mfm.mfm_time_card_summary_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
   
               begin
   
               v_pda_id := 'PDA_ID';
                   open v_mfm_time_card_summary_cursor for
   
            select shop_person, sched_date
              from ae_p_wka_e
             where edit_date > v_last_download
               and post_flag = 'Y'
               and v_last_download > to_date('1900-JAN-01', 'YYYY-MM-DD');
   
   
               end;
   procedure DL_DEL_CUR_AE_P_STA_E (V_AE_P_STA_E_DEL_CURSOR in out mfm.ae_p_sta_e_del_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
               begin
                   v_pda_id := 'PDA_ID';
                   open V_AE_P_STA_E_DEL_CURSOR for
   
               select proposal,
                    status_code,
                    status_date
                     from mfm_ae_p_sta_e_delete
                    where upper(login) = upper(v_ml_user)
                      and rtrim(pda_id) = rtrim(v_pda_id);
               end;
   procedure DL_DEL_CUR_AE_P_PST_E (V_AE_P_PST_E_DEL_CURSOR in out mfm.ae_p_pst_e_del_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
               begin
                   v_pda_id := 'PDA_ID';
                   open V_AE_P_PST_E_DEL_CURSOR for
   
               select proposal,
                    sort_code,
                    status_code,
                    status_date
                     from mfm_ae_p_pst_e_delete
                    where upper(login) = upper(v_ml_user)
                      and rtrim(pda_id) = rtrim(v_pda_id);
               end;
   procedure DL_CUR_AE_I_INV_E (V_AE_I_INV_E_CURSOR in out mfm.ae_i_inv_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open V_ae_i_inv_e_CURSOR for
   
              select distinct ae_i_inv_e.part,
                        ae_i_inv_e.inv_class,
                        ae_i_inv_e.description,
                        ae_i_inv_e.inv_uom,
                        ae_i_inv_e.comm_code,
                        ae_i_inv_e.item_type,
                        ae_i_inv_e.cycle_code
                 from ae_i_inv_e, ae_i_inv_w
                where ae_i_inv_e.part = ae_i_inv_w.part
                  and (ae_i_inv_e.edit_date >= v_last_download
                   or  ae_i_inv_w.edit_date >= v_last_download)
                  and ae_i_inv_e.active = 'Y'
             union all
              select distinct ae_i_inv_e.part,
                        ae_i_inv_e.inv_class,
                        ae_i_inv_e.description,
                        ae_i_inv_e.inv_uom,
                        ae_i_inv_e.comm_code,
                        ae_i_inv_e.item_type,
                        ae_i_inv_e.cycle_code
                 from ae_i_inv_e, ae_i_inv_w, ae_i_inv_s
                where ae_i_inv_e.part = ae_i_inv_w.part
                  and (ae_i_inv_e.edit_date >= v_last_download
                   or  ae_i_inv_w.edit_date >= v_last_download)
                  and ae_i_inv_e.active = 'Y'
                  ;
               end;
   procedure DL_DEL_CUR_AE_R_EQM_E (V_AE_R_EQM_E_DELETE_CUR in out mfm.ae_r_eqm_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_now    date;
                   v_null_string    varchar(1);
                   v_count_sup_shop numeric(8,0);
                   v_count_whse_sup_shop numeric(8,0);
                   cursor c_sup_shop(v_login    ae_s_sec_c.login%type) is
                       select count(*)
                          from ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup
                         where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
                           and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                           and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                           and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                           and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= sysdate)
                           and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= sysdate)
                           and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop;
                   cursor c_whse_sup_shop(v_login    ae_s_sec_c.login%type) is
                       select count(*)
                          from ae_s_sec_c, ae_l_shp_d, ae_i_whs_e_sup_shop, ae_i_whs_e
                         where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
                           and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                           and ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                           and ae_i_whs_e.active = 'Y'
                           and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                           and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                           and (ae_i_whs_e_sup_shop.start_date is null or ae_i_whs_e_sup_shop.start_date <= sysdate)
                           and (ae_i_whs_e_sup_shop.end_date is null or ae_i_whs_e_sup_shop.end_date >= sysdate)
                           and ae_l_shp_d.shop = ae_i_whs_e_sup_shop.shop;
                  v_mfm_date date;
               begin
   
                   delete from mfm_ae_r_eqm_e_delete
                    where upper(mfm_login) = upper(v_ml_user);
   
                  if v_last_download > to_date('01-JAN-1900','dd-mon-yyyy') then
                       v_pda_id := 'PDA_ID';
                       v_now := sysdate;
                       v_mfm_date := v_now;
                       open c_sup_shop(v_ml_user);
                       fetch c_sup_shop into v_count_sup_shop;
                       close c_sup_shop;
   
                       open c_whse_sup_shop(v_ml_user);
                       fetch c_whse_sup_shop into v_count_whse_sup_shop;
                       close c_whse_sup_shop;
   
                       if v_count_sup_shop is null then
                            v_count_sup_shop := 0;
                       end if;
   
                       if v_count_whse_sup_shop is null then
                            v_count_whse_sup_shop := 0;
                       end if;
   
                       if v_count_sup_shop > 0 and v_count_whse_sup_shop > 0 then
                            insert into mfm_ae_r_eqm_e_delete
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e
                            WHERE 	(ae_r_eqm_e.edit_date > v_last_download
                         	   or exists ( select *
                         			from ae_i_whs_e_sup_shop
                         			where edit_date > v_last_download
                                                   and 	ae_i_whs_e_sup_shop.warehouse = ae_r_eqm_e.warehouse
                         			)
                         		)
                                   and not exists( select *
                                                from ae_l_shp_d,
                            	                     ae_i_whs_e_sup_shop,
                                                     ae_s_sec_c,
                                                     ae_i_whs_e
                                              where rtrim(upper(ae_s_sec_c.login)) = rtrim(upper(v_ml_user))
                                              and   ae_l_shp_d.shop_person = ae_s_sec_c.employee_id
                                              and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                              and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                              and	ae_l_shp_d.shop = ae_i_whs_e_sup_shop.shop
                                              and (ae_i_whs_e_sup_shop.start_date is null or ae_i_whs_e_sup_shop.start_date <= sysdate)
                                              and (ae_i_whs_e_sup_shop.end_date is null or ae_i_whs_e_sup_shop.end_date >= sysdate)
                                              and 	ae_i_whs_e_sup_shop.warehouse = ae_r_eqm_e.warehouse
                                              and 	ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                                              and   ae_i_whs_e.active = 'Y')
                             UNION
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e
                            WHERE 	(	ae_r_eqm_e.edit_date > v_last_download
                         	   or exists ( select *
                         			from ae_s_bld_shp_sup
                         		       where edit_date > v_last_download
                                                   and 	ae_s_bld_shp_sup.region_code = ae_r_eqm_e.region_code
                                                   and 	ae_s_bld_shp_sup.fac_id = ae_r_eqm_e.fac_id
                                                   and 	ae_s_bld_shp_sup.bldg = ae_r_eqm_e.bldg
                         			)
                         		)
                                   and not exists( select *
                                                            from ae_l_shp_d,
                            	                     ae_s_bld_shp_sup,
                                                     ae_s_sec_c
                                              where rtrim(upper(ae_s_sec_c.login)) = rtrim(upper(v_ml_user))
                                              and   ae_l_shp_d.shop_person = ae_s_sec_c.employee_id
                                              and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                              and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                              and	ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                                              and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= sysdate)
                                              and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= sysdate)
                                              and 	ae_s_bld_shp_sup.region_code = ae_r_eqm_e.region_code
                                              and 	ae_s_bld_shp_sup.fac_id = ae_r_eqm_e.fac_id
                                              and 	ae_s_bld_shp_sup.bldg = ae_r_eqm_e.bldg)
                             UNION
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e, ae_i_whs_e
                            WHERE 	ae_r_eqm_e.warehouse = ae_i_whs_e.warehouse
                              and   ae_i_whs_e.active = 'N'
                              and   ae_i_whs_e.edit_date >  v_last_download
                             UNION
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e, ae_r_eqm_s
                            WHERE 	ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                              and   ae_r_eqm_s.complete_yn = 'D'
                              and   ae_r_eqm_e.edit_date >  v_last_download
                                 ;
                        end if;
                       if v_count_sup_shop = 0 and v_count_whse_sup_shop > 0 then
                            insert into mfm_ae_r_eqm_e_delete
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e
                            WHERE 	(ae_r_eqm_e.edit_date > v_last_download
                         	   or exists ( select *
                         			from ae_i_whs_e_sup_shop
                         			where edit_date > v_last_download
                                                   and 	ae_i_whs_e_sup_shop.warehouse = ae_r_eqm_e.warehouse
                         			)
                         		)
                                  and not exists( select *
                                                from ae_l_shp_d,
                            	                     ae_i_whs_e_sup_shop,
                                                     ae_s_sec_c,
                                                     ae_i_whs_e
                                              where rtrim(upper(ae_s_sec_c.login)) = rtrim(upper(v_ml_user))
                                              and   ae_l_shp_d.shop_person = ae_s_sec_c.employee_id
                                              and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                              and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                              and	ae_l_shp_d.shop = ae_i_whs_e_sup_shop.shop
                                              and (ae_i_whs_e_sup_shop.start_date is null or ae_i_whs_e_sup_shop.start_date <= sysdate)
                                              and (ae_i_whs_e_sup_shop.end_date is null or ae_i_whs_e_sup_shop.end_date >= sysdate)
                                              and 	ae_i_whs_e_sup_shop.warehouse = ae_r_eqm_e.warehouse
                                              and 	ae_i_whs_e_sup_shop.warehouse = ae_i_whs_e.warehouse
                                              and 	ae_i_whs_e.active = 'Y')
                             UNION
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e, ae_i_whs_e
                            WHERE 	ae_r_eqm_e.warehouse = ae_i_whs_e.warehouse
                              and   ae_i_whs_e.active = 'N'
                              and   ae_i_whs_e.edit_date >  v_last_download
                             UNION
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e, ae_r_eqm_s
                            WHERE 	ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                              and   ae_r_eqm_s.complete_yn = 'D'
                              and   ae_r_eqm_e.edit_date >  v_last_download
                                 ;
                        end if;
                       if v_count_sup_shop > 0 and v_count_whse_sup_shop = 0 then
                            insert into mfm_ae_r_eqm_e_delete
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e
                            WHERE 	(	ae_r_eqm_e.edit_date > v_last_download
                         	   or exists ( select *
                         			from ae_s_bld_shp_sup
                         		       where edit_date > v_last_download
                                                   and 	ae_s_bld_shp_sup.region_code = ae_r_eqm_e.region_code
                                                   and 	ae_s_bld_shp_sup.fac_id = ae_r_eqm_e.fac_id
                                                   and 	ae_s_bld_shp_sup.bldg = ae_r_eqm_e.bldg
                         			)
                         		)
                                   and not exists( select *
                                                            from ae_l_shp_d,
                            	                     ae_s_bld_shp_sup,
                                                     ae_s_sec_c
                                              where rtrim(upper(ae_s_sec_c.login)) = rtrim(upper(v_ml_user))
                                              and   ae_l_shp_d.shop_person = ae_s_sec_c.employee_id
                                              and  ( ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= v_now )
                                              and  ( ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_now )
                                              and	ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                                              and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= sysdate)
                                              and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= sysdate)
                                              and 	ae_s_bld_shp_sup.region_code = ae_r_eqm_e.region_code
                                              and 	ae_s_bld_shp_sup.fac_id = ae_r_eqm_e.fac_id
                                              and 	ae_s_bld_shp_sup.bldg = ae_r_eqm_e.bldg)
                             UNION
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e, ae_i_whs_e
                            WHERE 	ae_r_eqm_e.warehouse = ae_i_whs_e.warehouse
                              and   ae_i_whs_e.active = 'N'
                              and   ae_i_whs_e.edit_date >  v_last_download
                             UNION
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e, ae_r_eqm_s
                            WHERE 	ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                              and   ae_r_eqm_s.complete_yn = 'D'
                              and   ae_r_eqm_e.edit_date >  v_last_download
                                 ;
                        end if;
                       if v_count_sup_shop = 0 and v_count_whse_sup_shop = 0 then
                            insert into mfm_ae_r_eqm_e_delete
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e, ae_i_whs_e
                            WHERE 	ae_r_eqm_e.warehouse = ae_i_whs_e.warehouse
                              and   ae_i_whs_e.active = 'N'
                              and   ae_i_whs_e.edit_date >  v_last_download
                             UNION
                            SELECT
                                   v_ml_user,
                                   v_mfm_date,
                                   ae_r_eqm_e.eqp_tag_id
                            FROM 	ae_r_eqm_e, ae_r_eqm_s
                            WHERE 	ae_r_eqm_e.eqm_status = ae_r_eqm_s.eqm_status
                              and   ae_r_eqm_s.complete_yn = 'D'
                              and   ae_r_eqm_e.edit_date >  v_last_download;
                        end if;
                  end if;
   
                  open V_AE_R_EQM_E_DELETE_CUR for
                        SELECT
                           eqp_tag_id
                           from mfm_ae_r_eqm_e_delete
                          where mfm_login = v_ml_user;
   
              end;
   procedure DL_CUR_AE_I_WHS_E_WR (V_AE_I_WHS_E_CURSOR in out mfm.ae_i_whs_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open v_ae_i_whs_e_cursor for
               select
               	ae_i_whs_e.warehouse,
               	ae_i_whs_e.description,
                   ae_i_whs_e.active
               from
               	ae_i_whs_e
               where ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                   and ae_i_whs_e.active = 'Y';
               end;
   procedure DL_DEL_CUR_AE_I_WHS_E_WR (V_AE_I_WHS_E_DELETE_CURSOR in out mfm.ae_i_whs_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open V_AE_I_WHS_E_DELETE_CURSOR for
               select
               	ae_i_whs_e.warehouse
               from
               	ae_i_whs_e
               where ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                   and ae_i_whs_e.active = 'N';
               end;
   procedure DL_CUR_MFM_CYCLE_COUNT (V_MFM_CYCLE_COUNT_CURSOR in out mfm.mfm_cycle_count_cursor,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(10);
                      v_null_string   varchar(10);
                      v_null_date     date;
                      v_null_number   int;
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      v_null_string := null;
                      v_null_date := null;
                      v_null_number := null;
                      open v_mfm_cycle_count_cursor for
   
                  select
                       ae_i_cct_d.trans_no,                        
                       ae_i_cct_e.warehouse,                       
                       ae_i_cct_d.count_num,                       
                       ae_i_cct_d.set_no,                          
                       ae_i_cct_d.sched_date,                      
                       ae_i_cct_d.part,                            
                       ae_i_cct_d.bin_location,                    
                       ae_i_cct_d.count_date,                      
                       ae_i_cct_d.count_login,                     
                       ae_i_cct_d.count_no,                        
                       ae_i_cct_d.sys_qoh,                         
                       ae_i_cct_d.item_no,                         
                       ae_i_cct_d.edit_date,                       
                       ae_i_cct_d.edit_clerk,
                       ae_i_inv_e.description,
                       ae_i_inv_e.cycle_code,
                       ae_i_inv_e.inv_uom,                      
                        v_null_string,
                      v_null_date,
                      v_null_string
                  from
                  	ae_i_cct_e,
                  	ae_i_cct_d,
                  	ae_i_inv_e,
                      mfm_cycle_count_to_download,
                      ae_i_cct_status
                  where ae_i_cct_d.count_date is null
                  	and ae_i_cct_e.status_code = ae_i_cct_status.status_code
                  	and ae_i_cct_status.complete_yn = 'C'
                  	and ae_i_cct_status.active = 'Y'
                  	and ae_i_inv_e.part = ae_i_cct_d.part
                  	and ae_i_cct_e.trans_no = ae_i_cct_d.trans_no
                  	and ae_i_cct_e.set_no = ae_i_cct_d.set_no
                  	and ae_i_cct_e.warehouse = mfm_cycle_count_to_download.warehouse
                  	and ae_i_cct_e.set_no = mfm_cycle_count_to_download.set_no
                   and rtrim(upper(mfm_cycle_count_to_download.login)) = rtrim(upper(v_ml_user))
                   and rtrim(mfm_cycle_count_to_download.pda_id) = rtrim(v_pda_id)
                   and (ae_i_cct_d.recount_flag is null or ae_i_cct_d.recount_flag <> 'Y')
                       ;
                  end;
   procedure DL_CUR_AE_I_LOC_E_WR (V_AE_I_LOC_E_CURSOR in out mfm.ae_i_loc_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open v_ae_i_loc_e_cursor for
               select
               	ae_i_loc_e.warehouse,
               	ae_i_loc_e.bin_location,
               	ae_i_loc_e.part,
               	ae_i_loc_e.qty
               from
               	ae_i_whs_e,
                ae_i_loc_e
               where (ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                    or ae_i_loc_e.edit_date > V_LAST_DOWNLOAD)
                   and ae_i_whs_e.active = 'Y'
                   and ae_i_whs_e.warehouse = ae_i_loc_e.warehouse;
               end;
   procedure DL_DEL_CUR_AE_I_LOC_E_WR (V_AE_I_LOC_E_DELETE_CURSOR in out mfm.ae_i_loc_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open v_ae_i_loc_e_delete_cursor for
               select
               	ae_i_loc_e.warehouse,
                ae_i_loc_e.bin_location
               from
               	ae_i_whs_e,
                ae_i_loc_e
               where (ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                    or ae_i_loc_e.edit_date > V_LAST_DOWNLOAD)
                   and ae_i_whs_e.warehouse = ae_i_loc_e.warehouse
                   and ae_i_whs_e.active = 'N';
               end;
   procedure DL_DEL_CUR_AE_I_LOC_E_INV (V_AE_I_LOC_E_DELETE_CURSOR in out mfm.ae_i_loc_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(1);
                      v_null_string   varchar(10);
                      v_null_date     date;
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      v_null_string := null;
                      v_null_date := null;
                      open v_ae_i_loc_e_delete_cursor for
                  select
                  	ae_i_loc_e.warehouse,
                   ae_i_loc_e.bin_location
                  from
                  	ae_i_whs_e,
                   ae_i_loc_e
                  where	ae_i_whs_e.warehouse = ae_i_loc_e.warehouse
                   and ae_i_whs_e.active = 'N'
                  	and (ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                    or ae_i_loc_e.edit_date > V_LAST_DOWNLOAD)
                  union
                  select
                  	ae_i_loc_e.warehouse,
                   ae_i_loc_e.bin_location
                  from
                  	ae_i_whs_e,
                   ae_i_loc_e
                  where (ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                    or ae_i_loc_e.edit_date > V_LAST_DOWNLOAD)
                      and ae_i_whs_e.active = 'N';
                  end;
   procedure DL_DEL_CUR_AE_I_INV_E (V_AE_I_INV_E_DELETE_CURSOR in out mfm.ae_i_inv_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open V_AE_I_INV_E_DELETE_CURSOR for
              select ae_i_inv_e.part
                 from ae_i_inv_e
                where ae_i_inv_e.edit_date >= v_last_download
                  and ae_i_inv_e.active <> 'Y'
                  ;
               end;
   procedure DL_CUR_AE_L_SHP_E (V_AE_L_SHP_E_CURSOR in out mfm.ae_l_shp_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
                   v_pda_memory mfm_user_pda.memory%type;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   mfm_get_pda_memory(v_ml_user, v_pda_memory);
                   if v_pda_memory > 70 then
                       open V_AE_L_SHP_E_CURSOR for
                       select
                       	ae_l_shp_e.shop,
                       	ae_l_shp_e.description,
                       	ae_l_shp_e.supervisor_id
                       from
                       	ae_l_shp_e
                       where ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                           and ae_l_shp_e.active = 'Y';
                   else
                       open V_AE_L_SHP_E_CURSOR for
                       select distinct
                       	ae_l_shp_e.shop,
                       	ae_l_shp_e.description,
                       	ae_l_shp_e.supervisor_id
                       from
                       	ae_l_shp_e, ae_l_shp_d, ae_s_sec_c
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                            or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                            or ae_s_sec_c.edit_date > V_LAST_DOWNLOAD)
                           and ae_l_shp_e.active = 'Y'
                           and ae_l_shp_e.shop = ae_l_shp_d.shop
                           and ae_l_shp_d.shop_person = ae_s_sec_c.employee_id
                           and upper(ae_s_sec_c.login) = upper(V_ML_USER)
                           and (ae_l_shp_d.date_to is null
                            or  ae_l_shp_d.date_to >= (sysdate - 7));
                   end if;
               end;
   procedure DL_DEL_CUR_AE_I_WHS_E_INV (V_AE_I_WHS_E_DELETE_CURSOR in out mfm.ae_i_whs_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(1);
                      v_null_string   varchar(10);
                      v_null_date     date;
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      v_null_string := null;
                      v_null_date := null;
                      open v_ae_i_whs_e_delete_cursor for
                  select
                  	ae_i_whs_e.warehouse
                  from
                  	ae_i_whs_e,
                  	ae_i_whs_security,
                      ae_authz_principal, 
                      ae_authz
                  where	ae_i_whs_e.warehouse = ae_i_whs_security.warehouse
                   and ae_i_whs_e.active = 'N'
                  	and ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                      and upper(ae_authz_principal.login) = upper(v_ml_user)
                      and ae_authz_principal.role_id = ae_i_whs_security.role_id
                      and ae_authz.role_id = ae_authz_principal.role_id
                      and ae_authz.active = 'Y'
                  union
                  select
                  	ae_i_whs_e.warehouse
                  from
                  	ae_i_whs_e
                  where ae_i_whs_e.edit_date > V_LAST_DOWNLOAD
                      and ae_i_whs_e.active = 'N'
                      and not exists ( select *
                                        from ae_i_whs_security
                                       where ae_i_whs_security.warehouse = ae_i_whs_e.warehouse);
                  end;
   procedure DL_DEL_CUR_AE_L_SHP_E (V_AE_L_SHP_E_DELETE_CURSOR in out mfm.ae_l_shp_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   open V_AE_L_SHP_E_DELETE_CURSOR for
               select
               	ae_l_shp_e.shop
               from
               	ae_l_shp_e
               where ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                   and ae_l_shp_e.active = 'N';
               end;
   procedure DL_CUR_AE_L_SHP_D (V_AE_L_SHP_D_CURSOR in out mfm.ae_l_shp_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
                   v_end_date       date;
                   v_pda_memory mfm_user_pda.memory%type;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   v_end_date := trunc(sysdate) - 7;
                   mfm_get_pda_memory(v_ml_user, v_pda_memory);
                   if v_pda_memory > 70 then
                       open V_AE_L_SHP_D_CURSOR for
                       select
                       	ae_l_shp_d.shop,
                       	ae_l_shp_d.shop_person,
                       	ae_l_shp_d.seq,
                        ae_l_shp_d.date_from,
                        ae_l_shp_d.date_to
                       from
                       	ae_l_shp_d, ae_l_shp_e
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                         or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD)
                       and ae_l_shp_e.active = 'Y'
                       and ae_l_shp_e.shop = ae_l_shp_d.shop
                       and ((
                              (date_to is null or date_to >= v_end_date)
                       and   V_LAST_DOWNLOAD = to_date('01/JAN/1900', 'DD/MON/YYYY')
                                )
                        or (V_LAST_DOWNLOAD > to_date('01/JAN/1900', 'DD/MON/YYYY'))
                        );
                   else
                       open V_AE_L_SHP_D_CURSOR for
                       select distinct
                       	ae_l_shp_d.shop,
                       	ae_l_shp_d.shop_person,
                       	ae_l_shp_d.seq,
                        ae_l_shp_d.date_from,
                        ae_l_shp_d.date_to
                       from
                       	ae_l_shp_e, ae_l_shp_d, ae_s_sec_c, ae_l_shp_d shop_link
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                            or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                            or ae_s_sec_c.edit_date > V_LAST_DOWNLOAD)
                           and ae_l_shp_e.active = 'Y'
                           and ae_l_shp_e.shop = ae_l_shp_d.shop
                           and ae_l_shp_e.shop = shop_link.shop
                           and shop_link.shop_person = ae_s_sec_c.employee_id
                           and (shop_link.date_to >= v_end_date
                            or  shop_link.date_to is null)
                           and upper(ae_s_sec_c.login) = upper(V_ML_USER)
                           and ((
                                (ae_l_shp_d.date_to is null
                            or  ae_l_shp_d.date_to >= v_end_date)
                           and   V_LAST_DOWNLOAD = to_date('01/JAN/1900', 'DD/MON/YYYY'))
                            or (V_LAST_DOWNLOAD > to_date('01/JAN/1900', 'DD/MON/YYYY')));
                   end if;
               end;
   procedure DL_DEL_CUR_AE_L_SHP_D (V_AE_L_SHP_D_DELETE_CURSOR in out mfm.ae_l_shp_d_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
                   v_date_to     date;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   v_date_to := trunc(sysdate) - 7;
                   open V_AE_L_SHP_D_DELETE_CURSOR for
               select
               	ae_l_shp_d.shop,
               	ae_l_shp_d.shop_person
               from
               	ae_l_shp_d, ae_l_shp_e
               where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                     or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD)
                   and V_LAST_DOWNLOAD <> to_date('01-JAN-1900','dd-mon-yyyy')
                   and ae_l_shp_e.shop = ae_l_shp_d.shop
                   and (ae_l_shp_e.active = 'N'
                   or ae_l_shp_d.date_to < v_date_to
                   );
               end;
   procedure DL_DEL_CUR_AE_L_STOCK_USE (V_AE_L_STOCK_USE_DELETE_CUR in out mfm.ae_l_stock_use_delete_cur,V_LAST_DOWNLOAD in date,V_ML_USER in mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(10);
                      v_null_string   varchar(10);
                      v_null_date     date;
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      v_null_string := null;
                      v_null_date := null;
                      open V_ae_l_stock_use_delete_CUR for
                       select stock_use.stock_location,
                              stock_use.trans_date,
                              stock_use.proposal,
                              stock_use.sort_code,
                              stock_use.stock_no
                         from ae_l_stock_use stock_use,
                              mfm_ae_p_phs_e_download download
                        where stock_use.proposal = download.proposal
                          and stock_use.sort_code = download.sort_code
                          and upper(download.login) = upper(v_ml_user)
                          and rtrim(download.pda_id) = rtrim(v_pda_id)
                          and stock_use.edit_date >= v_last_download
                          and (stock_use.posted_yn = 'Y') ;
   
                  end;
   procedure DL_DEL_CUR_AE_S_BLD_C (V_AE_S_BLD_C_DEL_CUR in out mfm.ae_s_bld_c_del_cur,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
         v_edit_date  date;
         v_login      ae_s_sec_c.login%type;
         v_action_flag   varchar(10);
         v_null_string   varchar(10);
         v_null_date     date;
         v_count_sup_shop numeric(8,0);
         cursor c_sup_shop(v_login    ae_s_sec_c.login%type) is
           select count(*)
              from ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup
             where upper(trim(ae_s_sec_c.login)) = upper(trim(v_login))
               and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
               and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
               and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
               and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop;
   
         begin
             v_pda_id := 'PDA_ID';
             v_edit_date := null;
             v_login := V_ML_USER;
             v_action_flag := null;
             v_null_string := null;
             v_null_date := null;
             v_login := v_ml_user;
   
             open v_ae_s_bld_c_del_cur for
   
             select ae_s_bld_c.region_code,
                    ae_s_bld_c.fac_id,
                    ae_s_bld_c.bldg
              from ae_s_bld_c, ae_s_bld_s
             where ae_s_bld_c.edit_date >= v_last_download
               and ae_s_bld_c.bldg_status = ae_s_bld_s.bldg_status
               and ae_s_bld_s.complete_yn = 'Y'
             union
             select ae_s_bld_c.region_code,
                     ae_s_bld_c.fac_id,
                     ae_s_bld_c.bldg
               from ae_s_bld_c, ae_s_bld_s
              where ae_s_bld_c.bldg_status = ae_s_bld_s.bldg_status
                and ae_s_bld_s.complete_yn <> 'Y'
               and exists  (     select ae_s_sec_c.login
                                   from ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup
                                  where upper(ae_s_sec_c.login) = upper(v_login)
                                    and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                    and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                                    and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                                    and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                                    and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= sysdate)
                                    and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= sysdate) )
               and not exists (  select ae_s_sec_c.login
                                   from ae_s_sec_c, ae_l_shp_d, ae_s_bld_shp_sup
                                  where upper(ae_s_sec_c.login) = upper(v_login)
                                    and ae_s_sec_c.employee_id = ae_l_shp_d.shop_person
                                    and (ae_l_shp_d.date_from is null or ae_l_shp_d.date_from <= sysdate)
                                    and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= sysdate)
                                    and ae_l_shp_d.shop = ae_s_bld_shp_sup.shop
                                    and ae_s_bld_shp_sup.region_code = ae_s_bld_c.region_code
                                    and ae_s_bld_shp_sup.fac_id = ae_s_bld_c.fac_id
                                    and ae_s_bld_shp_sup.bldg = ae_s_bld_c.bldg
                                    and (ae_s_bld_shp_sup.start_date is null or ae_s_bld_shp_sup.start_date <= sysdate)
                                    and (ae_s_bld_shp_sup.end_date is null or ae_s_bld_shp_sup.end_date >= sysdate) )
               and (ae_s_bld_c.edit_date > v_last_download
                or  exists ( select ae_s_bld_shp_sup.bldg
                               from ae_s_bld_shp_sup
                              where ae_s_bld_shp_sup.region_code = ae_s_bld_c.region_code
                                and ae_s_bld_shp_sup.fac_id = ae_s_bld_c.fac_id
                                and ae_s_bld_shp_sup.bldg = ae_s_bld_c.bldg
                                and ae_s_bld_shp_sup.edit_date > v_last_download )
                            ) ;
         end;
   procedure DL_CUR_AE_L_MAN_E (V_AE_L_MAN_E_CURSOR in out mfm.ae_l_man_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
                   v_end_date       date;
                   v_pda_memory mfm_user_pda.memory%type;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   v_end_date := trunc(sysdate) - 7;
                   mfm_get_pda_memory(v_ml_user, v_pda_memory);
                   if v_pda_memory > 70 then
                       open V_AE_L_MAN_E_CURSOR for
                     select ae_h_emp_e.shop_person, substr(trim(ae_h_emp_e.lname) || ', ' || trim(ae_h_emp_e.fname) || ' ' || trim(ae_h_emp_e.mi) || '.', 1, 40), ae_h_emp_e.time_type, ae_h_emp_e.labor_class
                       from ae_h_emp_e, ae_l_shp_d, ae_l_shp_e
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                         or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                         or ae_h_emp_e.edit_date > V_LAST_DOWNLOAD)
                       and ae_l_shp_e.active = 'Y'
                       and ae_l_shp_e.shop = ae_l_shp_d.shop
                       and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_end_date)
                       and ae_h_emp_e.shop_person = ae_l_shp_d.shop_person
                       and ae_h_emp_e.emp_type = 'S'
                       and length(ae_h_emp_e.mi) > 0
                     union
                     select ae_h_emp_e.shop_person, substr(trim(ae_h_emp_e.lname) || ', ' || trim(ae_h_emp_e.fname), 1, 40), ae_h_emp_e.time_type, ae_h_emp_e.labor_class
                       from ae_h_emp_e, ae_l_shp_d, ae_l_shp_e
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                         or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                         or ae_h_emp_e.edit_date > V_LAST_DOWNLOAD)
                       and ae_l_shp_e.active = 'Y'
                       and ae_l_shp_e.shop = ae_l_shp_d.shop
                       and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_end_date)
                       and ae_h_emp_e.emp_type = 'S'
                       and (length(ae_h_emp_e.mi) = 0 or ae_h_emp_e.mi is null)
                       ;
                   else
                       open V_AE_L_MAN_E_CURSOR for
                     select distinct ae_h_emp_e.shop_person, substr(trim(ae_h_emp_e.lname) || ', ' || trim(ae_h_emp_e.fname) || ' ' || trim(ae_h_emp_e.mi) || '.', 1, 40), ae_h_emp_e.time_type, ae_h_emp_e.labor_class
                         from ae_h_emp_e, ae_l_shp_d, ae_l_shp_e, ae_s_sec_c, ae_l_shp_d shop_link
                         where ae_l_shp_d.shop = ae_l_shp_e.shop
                         and ae_l_shp_d.shop_person = ae_s_sec_c.employee_id
                         and upper(ae_s_sec_c.login) = upper(V_ML_USER)
                         and ae_l_shp_e.shop = shop_link.shop
                         and ae_h_emp_e.shop_person = shop_link.shop_person
                         and (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                            or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                            or ae_h_emp_e.edit_date > V_LAST_DOWNLOAD
                            or ae_s_sec_c.edit_date > V_LAST_DOWNLOAD)
                           and ae_l_shp_e.active ='Y'
                           and (ae_l_shp_d.date_to is null
                            or  ae_l_shp_d.date_to >= v_end_date)
                           and ae_h_emp_e.emp_type = 'S'
                           and length(ae_h_emp_e.mi) > 0
                      union
                     select distinct ae_h_emp_e.shop_person, substr(trim(ae_h_emp_e.lname) || ', ' || trim(ae_h_emp_e.fname), 1, 40), ae_h_emp_e.time_type, ae_h_emp_e.labor_class
                         from ae_h_emp_e, ae_l_shp_d, ae_l_shp_e, ae_s_sec_c, ae_l_shp_d shop_link
                         where ae_l_shp_d.shop = ae_l_shp_e.shop
                         and ae_l_shp_d.shop_person = ae_s_sec_c.employee_id
                         and upper(ae_s_sec_c.login) = upper(V_ML_USER)
                         and ae_l_shp_e.shop = shop_link.shop
                         and ae_h_emp_e.shop_person = shop_link.shop_person
                         and (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                            or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                            or ae_h_emp_e.edit_date > V_LAST_DOWNLOAD
                            or ae_s_sec_c.edit_date > V_LAST_DOWNLOAD)
                           and ae_l_shp_e.active ='Y'
                           and (ae_l_shp_d.date_to is null
                            or  ae_l_shp_d.date_to >= v_end_date)
                           and ae_h_emp_e.emp_type = 'S'
                           and (length(ae_h_emp_e.mi) = 0 or ae_h_emp_e.mi is null)
                           ;
                   end if;
               end;
   procedure DL_CUR_AE_L_MAN_D (V_AE_L_MAN_D_CURSOR in out mfm.ae_l_man_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
                   v_end_date       date;
                   v_pda_memory mfm_user_pda.memory%type;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   v_end_date := trunc(sysdate) - 7;
                   mfm_get_pda_memory(v_ml_user, v_pda_memory);
                   if v_pda_memory > 70 then
                       open V_ae_l_man_d_CURSOR for
                        select ae_l_man_d.seq,
                                ae_l_man_d.shop_person,
                                ae_l_man_d.labor_class,
                                ae_l_man_d.time_type,
                                ae_l_man_d.labor_rate,
                                ae_l_man_d.start_date,
                                ae_l_man_d.end_date
                       from
                       	ae_l_shp_d, ae_l_shp_e, ae_l_man_d
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                         or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                         or ae_l_man_d.edit_date > V_LAST_DOWNLOAD)
                       and ae_l_shp_e.active = 'Y'
                       and ae_l_shp_e.shop = ae_l_shp_d.shop
                       and (ae_l_man_d.end_date is null or ae_l_man_d.end_date >= v_end_date)
                       and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_end_date)
                       and ae_l_man_d.shop_person = ae_l_shp_d.shop_person
                     union
                        select distinct ae_l_shp_c.seq + 10000,
                                ae_l_shp_d.shop_person,
                                ae_l_shp_c.labor_class,
                                ae_l_shp_c.time_type,
                                ae_l_shp_c.labor_rate,
                                ae_l_shp_c.start_date,
                                ae_l_shp_c.end_date
                       from
                       	ae_l_shp_d, ae_l_shp_e, ae_l_shp_c
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                         or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                         or ae_l_shp_c.edit_date > V_LAST_DOWNLOAD)
                       and ae_l_shp_e.active = 'Y'
                       and ae_l_shp_e.shop = ae_l_shp_d.shop
                       and (ae_l_shp_d.date_to is null or ae_l_shp_d.date_to >= v_end_date)
                       and ae_l_shp_e.shop = ae_l_shp_c.shop
                       and (ae_l_shp_c.end_date is null or ae_l_shp_c.end_date >= v_end_date)
                       ;
                   else
                       open V_ae_l_man_d_CURSOR for
                        select distinct ae_l_man_d.seq,
                                ae_l_man_d.shop_person,
                                ae_l_man_d.labor_class,
                                ae_l_man_d.time_type,
                                ae_l_man_d.labor_rate,
                                ae_l_man_d.start_date,
                                ae_l_man_d.end_date
                       from
                       	ae_l_shp_e, ae_l_shp_d, ae_s_sec_c, ae_l_man_d, ae_l_shp_d shop_link
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                            or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                            or ae_l_man_d.edit_date > V_LAST_DOWNLOAD
                            or ae_s_sec_c.edit_date > V_LAST_DOWNLOAD)
                           and ae_l_shp_e.active = 'Y'
                           and ae_l_shp_e.shop = ae_l_shp_d.shop
                           and ae_l_shp_e.shop = shop_link.shop
                           and shop_link.shop_person = ae_s_sec_c.employee_id
                           and (ae_l_man_d.end_date is null or  ae_l_man_d.end_date >= v_end_date)
                           and (shop_link.date_to >= v_end_date or  shop_link.date_to is null)
                           and (ae_l_shp_d.date_to >= v_end_date or  ae_l_shp_d.date_to is null)
                           and upper(ae_s_sec_c.login) = upper(V_ML_USER)
                           and ae_l_man_d.shop_person = ae_l_shp_d.shop_person
                     union
                        select distinct ae_l_shp_c.seq + 10000,
                                ae_l_shp_d.shop_person,
                                ae_l_shp_c.labor_class,
                                ae_l_shp_c.time_type,
                                ae_l_shp_c.labor_rate,
                                ae_l_shp_c.start_date,
                                ae_l_shp_c.end_date
                       from
                       	ae_l_shp_e, ae_l_shp_d, ae_s_sec_c, ae_l_shp_d shop_link, ae_l_shp_c
                       where (ae_l_shp_e.edit_date > V_LAST_DOWNLOAD
                            or ae_l_shp_d.edit_date > V_LAST_DOWNLOAD
                            or ae_l_shp_c.edit_date > V_LAST_DOWNLOAD
                            or ae_s_sec_c.edit_date > V_LAST_DOWNLOAD)
                           and ae_l_shp_e.active = 'Y'
                           and ae_l_shp_e.shop = ae_l_shp_d.shop
                           and ae_l_shp_e.shop = shop_link.shop
                           and shop_link.shop_person = ae_s_sec_c.employee_id
                           and (shop_link.date_to >= v_end_date or  shop_link.date_to is null)
                           and (ae_l_shp_d.date_to >= v_end_date or  ae_l_shp_d.date_to is null)
                           and upper(ae_s_sec_c.login) = upper(V_ML_USER)
                           and shop_link.shop = ae_l_shp_c.shop
                           and (ae_l_shp_c.end_date is null or ae_l_shp_c.end_date >= v_end_date)
                           ;
                   end if;
               end;
   procedure DL_CUR_AE_X_CFT_E (V_AE_X_CFT_E_CURSOR in out mfm.ae_x_cft_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                      v_edit_date  date;
                      v_login      ae_s_sec_c.login%type;
                      v_action_flag   varchar(1);
                      v_null_string   varchar(10);
                      v_null_date     date;
                      v_end_date       date;
                      v_pda_memory mfm_user_pda.memory%type;
                      v_flag_value ae_s_sys_f.parameter%type;
                  begin
                      v_pda_id := 'PDA_ID';
                      v_edit_date := null;
                      v_login := null;
                      v_action_flag := null;
                      v_null_string := null;
                      v_null_date := null;
                      v_end_date := trunc(sysdate) - 7;
                      mfm_get_flag_147(v_flag_value);
                      if rtrim(v_flag_value) = 'Y' then
                          open V_AE_X_CFT_E_CURSOR for
                          select '',
                                   '',
                                   '',
                                   ''
                            from dual
                           where 1 = 2;
                      else
                          open V_AE_X_CFT_E_CURSOR for
                          select craft_code,
                                   description,
                                   order_type,
                                   category
                            from ae_x_cft_e
                           where edit_date >= V_LAST_DOWNLOAD;
                       end if;
                  end;
   procedure BEG_DL_WR (V_LAST_DOWNLOAD date,V_ML_USER ae_s_sec_c.login%type) as
                       v_shop_person    ae_h_emp_e.shop_person%TYPE;
                       v_pda_id         mfm_ae_p_phs_e_download.pda_id%type;
                       v_download_type  ae_s_sec_c.mfm_download%type;
                       v_login          ae_s_sec_c.login%type;
                       cursor c_download(a_login ae_s_sec_c.login%TYPE) is
                           select mfm_download, employee_id
                             from ae_s_sec_c
                            where upper(login) = upper(a_login);
                       v_pda_memory mfm_user_pda.memory%type;
                       v_days_forward      numeric(2);
                       v_week_day          varchar(3);
               begin
                   v_login := v_ml_user;
                   open c_download(v_ml_user);
               	   fetch c_download into v_download_type, v_shop_person;
               	   close c_download;
                   if v_download_type is null or rtrim(ltrim(v_download_type)) = '' then
                      v_download_type := 'SHOPPERSON';
                   end if;
                   v_pda_id := 'PDA_ID';
                   mfm_get_pda_memory(v_ml_user, v_pda_memory);
                    v_week_day := to_char(sysdate, 'DY');
                    if v_week_day = 'FRI' then
                        v_days_forward := 4;
                    elsif v_week_day = 'SAT' then
                        v_days_forward := 3;
                    else
                        v_days_forward := 2;
                    end if;
   
                    v_days_forward := 2;
   
                   delete from mfm_ae_p_phs_e_download
                    where upper(login) = upper(v_login)
                      and rtrim(pda_id) = rtrim(v_pda_id)
                      and download_action = 'X';
   
                   update mfm_ae_p_phs_e_download
                      set download_action = null,
                           edit_date = ( select edit_date
                                           from ae_p_phs_e
                                           where ae_p_phs_e.proposal = mfm_ae_p_phs_e_download.proposal
                                             and ae_p_phs_e.sort_code = mfm_ae_p_phs_e_download.sort_code
                                             ),
                           start_date = ( select beg_dt
                                           from ae_p_phs_e
                                           where ae_p_phs_e.proposal = mfm_ae_p_phs_e_download.proposal
                                             and ae_p_phs_e.sort_code = mfm_ae_p_phs_e_download.sort_code
                                             )
                    where upper(login) = upper(v_login)
                      and rtrim(pda_id) = rtrim(v_pda_id)
                          and (download_action <> 'H'
                           or  download_action is null);
   
                     update mfm_ae_p_phs_e_download
                        set download_action = null,
                             edit_date = ( select max(edit_date)
                                             from ae_p_pro_s
                                             where ae_p_pro_s.proposal = mfm_ae_p_phs_e_download.proposal
                                               and ae_p_pro_s.sort_code = mfm_ae_p_phs_e_download.sort_code
                                               )
                      where upper(login) = upper(v_login)
                        and rtrim(pda_id) = rtrim(v_pda_id)
                        and edit_date < ( select max(edit_date)
                                             from ae_p_pro_s
                                             where ae_p_pro_s.proposal = mfm_ae_p_phs_e_download.proposal
                                               and ae_p_pro_s.sort_code = mfm_ae_p_phs_e_download.sort_code
                                               )
                          and (download_action <> 'H'
                           or  download_action is null);
   
                    update mfm_ae_p_phs_e_download
                       set download_action = null,
                             edit_date = ( select edit_date
                                            from ae_p_pro_e
                                            where ae_p_pro_e.proposal = mfm_ae_p_phs_e_download.proposal
                                              )
                     where upper(login) = upper(v_ml_user)
                       and pda_id = v_pda_id
                       and edit_date < ( select edit_date
                                            from ae_p_pro_e
                                            where ae_p_pro_e.proposal = mfm_ae_p_phs_e_download.proposal
                                              )
                          and (download_action <> 'H'
                           or  download_action is null);
   
                   update mfm_ae_p_phs_e_download
                      set edit_date = ( select edit_date
                                           from ae_p_phs_e
                                           where ae_p_phs_e.proposal = mfm_ae_p_phs_e_download.proposal
                                             and ae_p_phs_e.sort_code = mfm_ae_p_phs_e_download.sort_code
                                             ),
                           start_date = ( select beg_dt
                                           from ae_p_phs_e
                                           where ae_p_phs_e.proposal = mfm_ae_p_phs_e_download.proposal
                                             and ae_p_phs_e.sort_code = mfm_ae_p_phs_e_download.sort_code
                                             )
                    where upper(login) = upper(v_login)
                      and rtrim(pda_id) = rtrim(v_pda_id)
                          and download_action = 'H';
   
                     update mfm_ae_p_phs_e_download
                        set edit_date = ( select max(edit_date)
                                             from ae_p_pro_s
                                             where ae_p_pro_s.proposal = mfm_ae_p_phs_e_download.proposal
                                               and ae_p_pro_s.sort_code = mfm_ae_p_phs_e_download.sort_code
                                               )
                      where upper(login) = upper(v_login)
                        and rtrim(pda_id) = rtrim(v_pda_id)
                        and edit_date < ( select max(edit_date)
                                             from ae_p_pro_s
                                             where ae_p_pro_s.proposal = mfm_ae_p_phs_e_download.proposal
                                               and ae_p_pro_s.sort_code = mfm_ae_p_phs_e_download.sort_code
                                               )
                          and download_action = 'H'
                        ;
   
                    update mfm_ae_p_phs_e_download
                       set edit_date = ( select edit_date
                                            from ae_p_pro_e
                                            where ae_p_pro_e.proposal = mfm_ae_p_phs_e_download.proposal
                                              )
                     where upper(login) = upper(v_ml_user)
                       and pda_id = v_pda_id
                       and edit_date < ( select edit_date
                                            from ae_p_pro_e
                                            where ae_p_pro_e.proposal = mfm_ae_p_phs_e_download.proposal
                                              )
                          and download_action = 'H';
   
                   update mfm_ae_p_phs_e_download
                      set download_action = 'U'
                    where edit_date >= v_last_download
                      and upper(login) = upper(v_login)
                      and rtrim(pda_id) = rtrim(v_pda_id);
   
                   if v_pda_memory < 70 then
                      update mfm_ae_p_phs_e_download
                          set download_action = 'I'
                        where start_date < trunc(sysdate) + v_days_forward
                          and upper(login) = upper(v_login)
                          and rtrim(pda_id) = rtrim(v_pda_id)
                          and download_action = 'H';
                   end if;
   
                   v_download_type := upper(v_download_type);
                   if v_download_type = 'DAILY' then
                       update mfm_ae_p_phs_e_download
                          set download_action = 'D'
                        where upper(login) = upper(v_login)
                          and rtrim(pda_id) = rtrim(v_pda_id);
                          
                       update mfm_ae_p_phs_e_download
                          set download_action = 'U'
                        where upper(login) = upper(v_login)
                          and rtrim(pda_id) = rtrim(v_pda_id)
                          and exists ( select *
                                         from ae_daily_assign_e,
                                              ae_daily_assign_d
                                        where ae_daily_assign_d.trans_no = ae_daily_assign_e.trans_no
                                          and ae_daily_assign_d.proposal = mfm_ae_p_phs_e_download.proposal
                                          and ae_daily_assign_d.sort_code = mfm_ae_p_phs_e_download.sort_code
                                          and trunc(ae_daily_assign_e.sched_date) = trunc(sysdate)
                                          and ae_daily_assign_e.shop_person = upper(v_shop_person) )
                          ;
   
                      insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action, edit_date, start_date)
                       select distinct phase.proposal, phase.sort_code, v_ml_user, v_pda_id, 'I', phase.edit_date, phase.beg_dt
                         from ae_p_phs_e phase,
                              ae_p_pro_e wr,
                              ae_daily_assign_e,
                              ae_daily_assign_d
                        where wr.proposal = phase.proposal
                          and ae_daily_assign_d.proposal = phase.proposal
                          and ae_daily_assign_d.sort_code = phase.sort_code
                          and ae_daily_assign_d.trans_no = ae_daily_assign_e.trans_no
                          and trunc(ae_daily_assign_e.sched_date) = trunc(sysdate)
                          and ae_daily_assign_e.shop_person = upper(v_shop_person)
                          and not exists ( select *
                                           from mfm_ae_p_phs_e_download download
                                           where download.proposal = phase.proposal
                                             and download.sort_code = phase.sort_code
                                             and upper(download.login) = upper(v_login)
                                             and rtrim(download.pda_id) = rtrim(v_pda_id));
   
                   end if;
                   if v_download_type = 'SHOPPERSON' then
                      insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action, edit_date, start_date)
                       select distinct phase.proposal, phase.sort_code, v_ml_user, v_pda_id, 'I', phase.edit_date, phase.beg_dt
                         from ae_p_phs_e phase,
                              ae_p_pro_s shop_person,
                              ae_p_pro_e wr,
                              ae_l_shp_d shop_shop_person,
                              ae_p_pst_c phase_status,
                              ae_l_shp_e shop
                        where phase.proposal = shop_person.proposal
                          and phase.sort_code = shop_person.sort_code
                          and wr.proposal = phase.proposal
                          and (phase.edit_date >= v_last_download
                           or  shop.edit_date >= v_last_download
                           or  shop_shop_person.edit_date >= v_last_download
                           or  shop_person.edit_date >= v_last_download)
                          and shop_person.shop_person = v_shop_person
                          and shop_shop_person.shop = phase.shop
                          and shop.shop = phase.shop
                          and shop.active = 'Y'
                          and shop_shop_person.shop_person = shop_person.shop_person
                          and wr.order_type = phase_status.order_type
                          and wr.category = phase_status.category
                          and phase.status_code = phase_status.status_code
                          and phase_status.work_queue = 'Y'
                          and not exists ( select *
                                           from mfm_ae_p_phs_e_download download
                                           where download.proposal = phase.proposal
                                             and download.sort_code = phase.sort_code
                                             and upper(download.login) = upper(v_login)
                                             and rtrim(download.pda_id) = rtrim(v_pda_id));
   
                       update mfm_ae_p_phs_e_download
                          set download_action = 'D'
                        where ((exists ( select *
                                         from ae_p_phs_e phase,
                                              ae_p_pro_e wr,
                                              ae_p_pst_c phase_status
                                        where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                          and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                          and wr.proposal = phase.proposal
                                          and wr.order_type = phase_status.order_type
                                          and wr.category = phase_status.category
                                          and phase.status_code = phase_status.status_code
                                          and (phase_status.work_queue <> 'Y'
                                           or  phase_status.work_queue is null)
                   							))
                           or (not exists ( select *
                                           from ae_p_pro_s
                                          where ae_p_pro_s.proposal = mfm_ae_p_phs_e_download.proposal
                                            and ae_p_pro_s.sort_code = mfm_ae_p_phs_e_download.sort_code
                                            and ae_p_pro_s.shop_person = v_shop_person
                               ))
                           or (exists ( select *
                                         from ae_p_phs_e phase,
                                              ae_l_shp_e shop
                                        where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                          and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                          and shop.shop = phase.shop
                                          and shop.active = 'N'
                                          and shop.edit_date > v_last_download
                   							))
   
                               )
                          and upper(login) = upper(v_login)
                          and rtrim(pda_id) = rtrim(v_pda_id);
                   end if;
                   if v_download_Type = 'SHOP' then
                      insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action, edit_date, start_date)
                       select distinct phase.proposal, phase.sort_code, v_ml_user, v_pda_id, 'I', phase.edit_date, phase.beg_dt
                         from ae_p_phs_e phase,
                              ae_p_pro_e wr,
                              ae_l_shp_d shop_shop_person,
                              ae_p_pst_c phase_status,
                              ae_l_shp_e shop
                        where (phase.edit_date >= v_last_download
                           or  shop.edit_date >= v_last_download)
                          and wr.proposal = phase.proposal
                          and shop_shop_person.shop = phase.shop
                          and shop.shop = phase.shop
                          and shop.active = 'Y'
                          and shop_shop_person.shop_person = v_shop_person
                          and (shop_shop_person.date_from is null or shop_shop_person.date_from <= sysdate)
                          and (shop_shop_person.date_to is null or shop_shop_person.date_to >= sysdate)
                          and wr.order_type = phase_status.order_type
                          and wr.category = phase_status.category
                          and phase.status_code = phase_status.status_code
                          and phase_status.work_queue = 'Y'
                          and not exists ( select *
                                           from mfm_ae_p_phs_e_download download
                                           where download.proposal = phase.proposal
                                             and download.sort_code = phase.sort_code
                                             and upper(download.login) = upper(v_login)
                                             and rtrim(download.pda_id) = rtrim(v_pda_id));
   
                       update mfm_ae_p_phs_e_download
                          set download_action = 'D'
                        where ((exists ( select *
                                         from ae_p_phs_e phase,
                                              ae_p_pro_e wr,
                                              ae_p_pst_c phase_status
                                        where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                          and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                          and wr.proposal = phase.proposal
                                          and wr.order_type = phase_status.order_type
                                          and wr.category = phase_status.category
                                          and phase.status_code = phase_status.status_code
                                          and (phase_status.work_queue <> 'Y'
                                           or  phase_status.work_queue is null)
                   							))
                           or (not exists ( select *
                                           from ae_p_phs_e phase,
                                                ae_l_shp_d shop_shop_person
                                          where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                            and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                            and phase.shop = shop_shop_person.shop
                                            and shop_shop_person.shop_person = v_shop_person
                                            and (shop_shop_person.date_from is null or shop_shop_person.date_from <= sysdate)
                                            and (shop_shop_person.date_to is null or shop_shop_person.date_to >= sysdate)
                                        )
                               )
                           or (exists ( select *
                                         from ae_p_phs_e phase,
                                              ae_l_shp_e shop
                                        where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                          and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                          and shop.shop = phase.shop
                                          and shop.active = 'N'
                                          and shop.edit_date > v_last_download
                   							))
                               )
                          and upper(login) = upper(v_login)
                          and rtrim(pda_id) = rtrim(v_pda_id);
                   end if;
                   if v_download_Type = 'PRIMARY' then
                      insert into mfm_ae_p_phs_e_download(proposal, sort_code, login, pda_id, download_action, edit_date, start_date)
                       select distinct phase.proposal, phase.sort_code, v_ml_user, v_pda_id, 'I', phase.edit_date, phase.beg_dt
                         from ae_p_phs_e phase,
                              ae_p_pro_s shop_person,
                              ae_p_pro_e wr,
                              ae_l_shp_d shop_shop_person,
                              ae_p_pst_c phase_status,
                              ae_l_shp_e shop
                        where phase.proposal = shop_person.proposal
                          and phase.sort_code = shop_person.sort_code
                          and wr.proposal = phase.proposal
                          and (phase.edit_date >= v_last_download
                           or  shop.edit_date >= v_last_download)
                          and shop_person.primary_yn = 'Y'
                          and shop_person.shop_person = v_shop_person
                          and shop_shop_person.shop = phase.shop
                          and shop.shop = phase.shop
                          and shop.active = 'Y'
                          and shop_shop_person.shop_person = shop_person.shop_person
                          and wr.order_type = phase_status.order_type
                          and wr.category = phase_status.category
                          and phase.status_code = phase_status.status_code
                          and phase_status.work_queue = 'Y'
                          and not exists ( select *
                                           from mfm_ae_p_phs_e_download download
                                           where download.proposal = phase.proposal
                                             and download.sort_code = phase.sort_code
                                             and upper(download.login) = upper(v_login)
                                             and rtrim(download.pda_id) = rtrim(v_pda_id));
                       update mfm_ae_p_phs_e_download
                          set download_action = 'D'
                        where ((exists ( select *
                                         from ae_p_phs_e phase,
                                              ae_p_pro_e wr,
                                              ae_p_pst_c phase_status
                                        where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                          and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                          and wr.proposal = phase.proposal
                                          and wr.order_type = phase_status.order_type
                                          and wr.category = phase_status.category
                                          and phase.status_code = phase_status.status_code
                                          and (phase_status.work_queue <> 'Y'
                                           or  phase_status.work_queue is null)
                   							))
                           or (not exists ( select *
                                           from ae_p_pro_s
                                          where ae_p_pro_s.proposal = mfm_ae_p_phs_e_download.proposal
                                            and ae_p_pro_s.sort_code = mfm_ae_p_phs_e_download.sort_code
                                            and ae_p_pro_s.primary_yn = 'Y'
                                            and ae_p_pro_s.shop_person = v_shop_person
                                        )
                               )
                           or (exists ( select *
                                         from ae_p_phs_e phase,
                                              ae_l_shp_e shop
                                        where phase.proposal = mfm_ae_p_phs_e_download.proposal
                                          and phase.sort_code = mfm_ae_p_phs_e_download.sort_code
                                          and shop.shop = phase.shop
                                          and shop.active = 'N'
                                          and shop.edit_date > v_last_download
                   							))
                               )
                          and upper(login) = upper(v_login)
                          and rtrim(pda_id) = rtrim(v_pda_id);
                   end if;
   
                   if v_pda_memory < 70 then
                      update mfm_ae_p_phs_e_download
                          set download_action = 'H'
                        where start_date >= trunc(sysdate) + v_days_forward
                          and upper(login) = upper(v_login)
                          and rtrim(pda_id) = rtrim(v_pda_id);
                   end if;
               end;
   procedure DL_CUR_AE_X_CFT_E_ONLY (V_AE_X_CFT_E_ONLY_CURSOR in out mfm.ae_x_cft_e_only_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(1);
                   v_null_string   varchar(10);
                   v_null_date     date;
                   v_pda_memory mfm_user_pda.memory%type;
                   v_flag_value ae_s_sys_f.parameter%type;
               begin
                   v_pda_id := 'PDA_ID';
                   v_edit_date := null;
                   v_login := null;
                   v_action_flag := null;
                   v_null_string := null;
                   v_null_date := null;
                   mfm_get_pda_memory(v_ml_user, v_pda_memory);
                   mfm_get_flag_147(v_flag_value);
                   if rtrim(v_flag_value) <> 'Y' then
                       open V_AE_X_CFT_E_ONLY_CURSOR for
                       select '',
                                ''
                         from dual
                        where 1 = 2;
                   elsif v_pda_memory > 70 then
                       open V_AE_X_CFT_E_ONLY_CURSOR for
                       select distinct craft_code,
                                description
                         from ae_x_cft_e
                        where edit_date >= V_LAST_DOWNLOAD;
                   else
                       open V_AE_X_CFT_E_ONLY_CURSOR for
                      select distinct ae_x_cft_e.craft_code,
                               ae_x_cft_e.description
                         from ae_x_cft_e,
                                mfm_ae_p_phs_e_download,
                                ae_p_pro_e
                        where ae_x_cft_e.order_type = ae_p_pro_e.order_type
                          and ae_x_cft_e.category = ae_p_pro_e.category
                          and    mfm_ae_p_phs_e_download.download_action in ('I', 'U')
                          and    mfm_ae_p_phs_e_download.proposal = ae_p_pro_e.proposal
                          and upper(mfm_ae_p_phs_e_download.login) = upper(v_ml_user)
                          and rtrim(mfm_ae_p_phs_e_download.pda_id) = rtrim(v_pda_id)
                          and (ae_x_cft_e.edit_date >= V_LAST_DOWNLOAD
                           or mfm_ae_p_phs_e_download.edit_date >= V_LAST_DOWNLOAD);
                   end if;
               end;
   procedure DL_DEL_CUR_AE_B_LOC_D (V_AE_B_LOC_D_DEL_CUR in out mfm.ae_b_loc_d_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   begin
   
             open V_AE_B_LOC_D_DEL_CUR for
   
                            select ae_b_loc_d.region_code,
                                    ae_b_loc_d.fac_id,
                                    ae_b_loc_d.bldg,
                                    ae_b_loc_d.loc_id
                              from ae_b_loc_d, ae_b_loc_s
                             where ae_b_loc_d.edit_date >= v_last_download
                               and ae_b_loc_d.loc_status = ae_b_loc_s.loc_status
                               and ae_b_loc_s.complete_yn = 'Y'
                                ;
         end;
   procedure DL_CUR_AE_P_STA_D (V_AE_P_STA_D_CUR in out mfm.ae_p_sta_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   open V_AE_P_STA_D_CUR for
   
               select ae_p_sta_d.status_code,
                    ae_p_sta_d.role_id,
                    ae_p_sta_d.category,
                    ae_p_sta_d.order_type,
                    'Y'
                     from ae_p_sta_d, ae_authz, ae_authz_principal
                    where ae_p_sta_d.edit_date >= v_last_download
                      and ae_p_sta_d.role_id = ae_authz_principal.role_id
                      and ae_authz_principal.role_id = ae_authz.role_id
                      and ae_authz.active = 'Y'
                      and upper(ae_authz_principal.login) = upper(v_ml_user)
                union
               select distinct ae_p_sta_d.status_code,
                    'NO ROLE',
                    ae_p_sta_d.category,
                    ae_p_sta_d.order_type,
                    'Y'
                     from ae_p_sta_d
                    where ae_p_sta_d.edit_date >= v_last_download
                    and exists ( select *
                                   from ae_p_sta_d)
                    and not exists ( select *
                                         from ae_p_sta_d, ae_authz, ae_authz_principal
                                        where ae_p_sta_d.role_id = ae_authz_principal.role_id
                                          and ae_authz_principal.role_id = ae_authz.role_id
                                          and ae_authz.active = 'Y'
                                          and upper(ae_authz_principal.login) = upper(v_ml_user) )
                                    ;
               end;
   procedure DL_CUR_AE_P_PST_D (V_AE_P_PST_D_CUR in out mfm.ae_p_pst_d_cursor,V_LAST_DOWNLOAD date,V_ML_USER in out mfm_routes_download.login%type) as
   v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                   v_edit_date  date;
                   v_login      ae_s_sec_c.login%type;
                   v_action_flag   varchar(10);
                   v_null_string   varchar(10);
                   v_null_date     date;
               begin
                   open V_ae_p_pst_d_CUR for
   
               select ae_p_pst_d.status_code,
                    ae_p_pst_d.role_id,
                    ae_p_pst_d.category,
                    ae_p_pst_d.order_type,
                    'Y'
                     from ae_p_pst_d, ae_authz, ae_authz_principal
                    where ae_p_pst_d.edit_date >= v_last_download
                      and ae_p_pst_d.role_id = ae_authz_principal.role_id
                      and ae_authz_principal.role_id = ae_authz.role_id
                      and ae_authz.active = 'Y'
                      and upper(ae_authz_principal.login) = upper(v_ml_user)
                union
               select distinct ae_p_pst_d.status_code,
                    'NO ROLE',
                    ae_p_pst_d.category,
                    ae_p_pst_d.order_type,
                    'Y'
                     from ae_p_pst_d
                    where ae_p_pst_d.edit_date >= v_last_download
                    and exists ( select *
                                   from ae_p_pst_d)
                    and not exists ( select *
                                         from ae_p_pst_d, ae_authz, ae_authz_principal
                                        where ae_p_pst_d.role_id = ae_authz_principal.role_id
                                          and ae_authz_principal.role_id = ae_authz.role_id
                                          and ae_authz.active = 'Y'
                                          and upper(ae_authz_principal.login) = upper(v_ml_user) )
                                    ;
               end;
   procedure END_DL_INV (V_LAST_DOWNLOAD date,V_ML_USER ae_s_sec_c.login%type) as
   v_pda_id         mfm_ae_p_phs_e_download.pda_id %type;
               begin
                   v_pda_id := 'PDA_ID';
                   delete from mfm_cycle_count_to_download
                    where login = v_ml_user
                      and pda_id = v_pda_id;
               end;
   procedure DL_CUR_AE_A_ASSET_E (V_AE_A_ASSET_E_CUR in out mfm.ae_a_asset_e_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type) as
                 v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                     begin
                         v_pda_id := 'PDA_ID';
                         open V_AE_A_ASSET_E_CUR for
                              SELECT distinct
                                 ae_a_asset_e.asset_tag,
                                 ae_a_asset_e.asset_type,
                                 ae_a_asset_e.description,
                                 ae_a_asset_e.region_code,
                                 ae_a_asset_e.fac_id,
                                 ae_a_asset_e.bldg,
                                 ae_a_asset_e.location_code,
                                 ae_a_asset_e.loc_id
                             FROM  ae_a_asset_e, mfm_ae_p_phs_e_download dw, ae_p_phs_e phase
                           where phase.proposal = dw.proposal
                             and phase.sort_code = dw.sort_code
                             and upper(dw.login) = upper(v_ml_user)
                             and rtrim(dw.pda_id) = rtrim(v_pda_id)
                             and dw.download_action in ('I', 'U')
                             and ae_a_asset_e.asset_tag = phase.asset_tag
                             ;
               end;
   procedure DL_DEL_CUR_AE_A_ASSET_E (V_AE_A_ASSET_E_DELETE_CUR in out mfm.ae_a_asset_e_delete_cursor,V_LAST_DOWNLOAD date,V_ML_USER mfm_ae_p_phs_e_download.login%type) as
                 v_pda_id     mfm_ae_p_phs_e_download.pda_id%type;
                     begin
                         v_pda_id := 'PDA_ID';
                  open V_AE_A_ASSET_E_DELETE_CUR for
                        SELECT distinct
                           asset_tag
                           from mfm_ae_p_phs_e_download dw, ae_p_phs_e phase
                       where phase.proposal = dw.proposal
                         and phase.sort_code = dw.sort_code
               and rtrim(dw.login) = rtrim(v_ml_user)
               and rtrim(dw.pda_id) = rtrim(v_pda_id)
               and (dw.download_action = 'D'
                or  dw.download_action = 'H')
                and not exists ( select *
                                   from mfm_ae_p_phs_e_download, ae_p_phs_e
                                  where mfm_ae_p_phs_e_download.proposal = ae_p_phs_e.proposal
                                    and mfm_ae_p_phs_e_download.sort_code = ae_p_phs_e.sort_code
                                    and dw.download_action in ('I', 'U')
                                    and mfm_ae_p_phs_e_download.login = rtrim(v_ml_user)
                                    and mfm_ae_p_phs_e_download.pda_id = rtrim(v_pda_id)
                                    and phase.asset_tag = ae_p_phs_e.asset_tag
                                    );
              end;
end MFM;
/
