select a.proposal, b.sort_code phase, a.description wo_desc, a.long_desc wo_x_desc, a.contact, a.contact_ph, a.bldg, a.status_code wo_desc, a.order_type, a.category, b.description phs_desc, b.long_desc phs_x_desc, 
b.status_code phs_status, b.craft_code, b.pri_code priority, b.location_code, b.asset_tag
from ae_p_pro_e a
join ae_p_phs_e b on a.proposal = b.proposal
where b.status_code not in ('CLOSED','CANCELLED','NOTCOMPLETED')
and b.shop = 'M2100';