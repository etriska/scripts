SELECT 
  a.MRID TICKET_NO,
  REPLACE(REPLACE(REPLACE(a.MRTITLE, '&#58;',':'),'&#34;','"'), '&#39;', '''')
TITLE,
  CASE
    WHEN CAST(a.MRPRIORITY AS CHAR) = '1' THEN 'Emergency'
    WHEN CAST(a.MRPRIORITY AS CHAR) = '2' THEN 'Urgent'
    WHEN CAST(a.MRPRIORITY AS CHAR) = '3' THEN 'High'
    WHEN CAST(a.MRPRIORITY AS CHAR) = '4' THEN 'Medium'
    WHEN CAST(a.MRPRIORITY AS CHAR) = '5' THEN 'Low'
    WHEN CAST(a.MRPRIORITY AS CHAR) = '6' THEN 'As Time Permits'
    ELSE CAST(a.MRPRIORITY AS CHAR)
  END PRIORITY,
  CASE 
    WHEN REPLACE(a.mrSTATUS, '__b', ' ') = 'Waiting on User' THEN 'UserWait'
    WHEN REPLACE(a.mrSTATUS, '__b', ' ') = 'Waiting on Vendor' THEN 'VendorWait'
    WHEN REPLACE(a.mrSTATUS, '__b', ' ') = 'On Hold' THEN 'Hold'
    WHEN REPLACE(a.mrSTATUS, '__b', ' ') = 'Waiting on User' THEN 'UserWait'
    WHEN REPLACE(a.mrSTATUS, '__b', ' ') = 'In Progress' THEN 'InProg'
    WHEN REPLACE(REPLACE(a.mrSTATUS, '__u', '-'), '__b', ' ') = 'Complete-Release Wait' then 'CompRel'
    ELSE REPLACE(a.mrSTATUS, '__b', ' ')
  END STATUS,
   CASE
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Plant Payroll and Accounts Payable' THEN 'PPAPO'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Plant Information Technology' THEN 'IT'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Work Management' THEN 'WM'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Utilities and Plant Engineering' THEN 'UPE'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Facilities Maintenance' THEN 'FM'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Plant Material and Moving Services' THEN 'PMMS'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Plant Academy' THEN 'PA'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Construction Services' THEN 'CS'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Plant Building and Grounds Services' THEN 'PBGS'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Office of the Executive Director' THEN 'Dir'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Multiple Departments' THEN 'Multi'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Central Power Plant' THEN 'CPP'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Planet Blue Teams' THEN 'PBT'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Plant Administration' THEN 'Admin'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'External Customers' THEN 'Ext'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'AEC' THEN 'AEC'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'BFIT' THEN 'BFIT'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Housing' THEN 'HSG'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'OSEH' THEN 'OSEH'
   WHEN REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ') = 'Risk Management' THEN 'Risk'
   ELSE REPLACE(a.PLANTOPS__BDEPARTMENT, '__b',' ')
  END DEPT,
  b.full__Bname  CUSTOMER_NAME,
  a.MRASSIGNEES ASSIGNEES,
  a.Primary__bPerson PRIMARY_PERSON,
  a.MRSUBMITDATE SUBMIT_DATE, 
  a.MRUPDATEDATE LAST_UPDATE,
  DATE(a.Due__bDate) DUE_DATE
FROM MASTER374 a
JOIN MASTER374_ABDATA b ON a.MRID = b.MRID
WHERE a.MRSTATUS not in ('Closed','_DELETED_','Complete', 'Waiting__bon__bVendor','_SOLVED_','_REQUEST_')
and a.Primary__bPerson in ('etriska')
ORDER BY a.PlantOps__bDepartment, a.mrPRIORITY, a.mrSUBMITDATE