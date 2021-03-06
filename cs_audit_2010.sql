SELECT A.PROPOSAL, A.SORT_CODE, A.SHOP, NVL(C.ACT_HRS,0) PHS_HRS, NVL(C.ACT_LAB,0) PHS_LABOR, NVL(C.ACT_MAT,0) PHS_MATERIAL, NVL(C.ACT_TOT,0) PHS_TOTAL, NVL(D.ACT_HRS,0) WO_HRS, nvl(d.act_lab,0) wo_labor, nvl(D.ACT_MAT,0) wo_material, nvl(D.ACT_TOT,0) wo_total, B.ORDER_TYPE type, B.CATEGORY       
FROM AE_P_PHS_E A
JOIN AE_P_PRO_E B ON A.PROPOSAL = B.PROPOSAL
LEFT OUTER JOIN RVIEW_PHS_TOTALS C ON A.PROPOSAL = C.PROPOSAL AND A.SORT_CODE = C.SORT_CODE
LEFT OUTER JOIN RVIEW_HDR_TOTALS D ON B.PROPOSAL = D.PROPOSAL
WHERE B.PROPOSAL IN (select proposal from ae_p_phs_e where shop in ('M4900','M4905'))
AND B.ENT_DATE >= '01-APR-09' AND B.ENT_DATE <= '31-JAN-10'
AND B.CATEGORY NOT IN ('Y')
AND d.ACT_TOT >= 15000
ORDER BY A.PROPOSAL, A.SORT_CODE