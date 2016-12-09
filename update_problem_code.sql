--move problem codes to problem code setup table
INSERT INTO ae_p_prb_e (problem_code, description, hazardous, edit_date, edit_clerk, active)
SELECT request_method, description, 'N', SYSDATE, 'ETRISKA', active
FROM ae_p_request_method
WHERE request_method NOT IN  (SELECT problem_code FROM ae_p_prb_e WHERE active='Y')
and active = 'Y';

--move problem code from phase to header
UPDATE ae_p_pro_e A SET A.problem_code = 
 (SELECT request_method FROM ae_p_phs_e b 
WHERE A.proposal = b.proposal
AND b.sort_code = 
 (SELECT MIN(sort_code) FROM ae_p_phs_e 
WHERE b.proposal = ae_p_phs_e.proposal));

--set request method in phase to null
update ae_p_phs_e set request_method = null where request is not null;

--remove old problem code setup from request method setup table
DELETE FROM ae_p_request_method;

--change labels
UPDATE ae_resource_bundle_values SET resource_value = 'Problem Code' WHERE resource_key = 'problem_code';

UPDATE ae_resource_bundle_values SET resource_value = 'Request Method' WHERE resource_key = 'request_method';

--update quick links
update ae_user_quick_link set link_url = 'http://portal.plantops.umich.edu' where link_url = 'http://portal.bf.umich.edu/';

--commit;  --Uncomment if you want to auto commit before script finishes.