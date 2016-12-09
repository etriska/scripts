INSERT INTO AE_S_BLD_S (BLDG_STATUS, DESCRIPTION, COMPLETE_YN, EDIT_DATE, EDIT_CLERK, SEQ, ACTIVE) VALUES ('INSERVPRE1', 'IN SERVICE PREL', 'O', SYSDATE, 'ETRISKA', 20, 'Y');
INSERT INTO AE_S_BLD_S (BLDG_STATUS, DESCRIPTION, COMPLETE_YN, EDIT_DATE, EDIT_CLERK, SEQ, ACTIVE) VALUES ('INSERVICE', 'IN SERVICE', 'O', SYSDATE, 'ETRISKA', 10, 'Y');
INSERT INTO AE_S_BLD_S (BLDG_STATUS, DESCRIPTION, COMPLETE_YN, EDIT_DATE, EDIT_CLERK, SEQ, ACTIVE) VALUES ('AFFILIATED', 'AFFILIATED', 'O', SYSDATE, 'ETRISKA', 30, 'Y');
INSERT INTO AE_S_BLD_S (BLDG_STATUS, DESCRIPTION, COMPLETE_YN, EDIT_DATE, EDIT_CLERK, SEQ, ACTIVE) VALUES ('TEMPORARY', 'TEMPORARY', 'O', SYSDATE, 'ETRISKA', 40, 'Y');
INSERT INTO AE_S_BLD_S (BLDG_STATUS, DESCRIPTION, COMPLETE_YN, EDIT_DATE, EDIT_CLERK, SEQ, ACTIVE) VALUES ('PLANNING', 'PLANNING', 'O', SYSDATE, 'ETRISKA', 50, 'Y');
INSERT INTO AE_S_BLD_S (BLDG_STATUS, DESCRIPTION, COMPLETE_YN, EDIT_DATE, EDIT_CLERK, SEQ, ACTIVE) VALUES ('CONSTRUCT', 'IN CONSTRUCTION', 'O', SYSDATE, 'ETRISKA', 60, 'Y');
UPDATE AE_S_BLD_S SET ACTIVE = 'N' WHERE SEQ = 1;
COMMIT;