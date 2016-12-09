INSERT
INTO ae_i_adj_e
  (
    multitenant_id,
    trans_num,
    adjustment_type,
    description,
    warehouse,
    bin_location,
    part,
    inv_cost,
    adj_qty,
    edit_clerk,
    edit_date
  )
  VALUES
  (
    1,
    25961,
    'C',
    'TEST',
    'M2350',
    NULL,
    '101682',
    54.08,
    NULL,
    'ETRISKA',
    '2016-07-19 09:00:24'
  );
INSERT
INTO ae_i_trans_reg
  (
    multitenant_id,
    trans_num,
    source_screenname,
    source_tranx_no,
    source_tranx_item,
    warehouse,
    bin_location,
    part,
    inv_cost,
    bin_qty,
    trans_qty,
    dollar_adj,
    entry_clerk,
    entry_date,
    edit_clerk,
    edit_date,
    description,
    vend_cost,
    issue_factor,
    eqp_tag_id,
    asset_tag,
    sub_line_seq
  )
  VALUES
  (
    1,
    241880,
    'INVENTORY ADJUSTMENT',
    25961,
    0,
    'M2350',
    'UNIT1.B.2.2',
    '101682',
    0.01,
    NULL,
    -2,
    0,
    'ETRISKA',
    '2016-07-19 09:00:24',
    'ETRISKA',
    '2016-07-19 09:00:24',
    'INVENTORY PRICE ADJUSTEMENT',
    NULL,
    NULL,
    NULL,
    NULL,
    0
  );
UPDATE ae_i_loc_e
SET qty                            = 0,
  edit_date                        = '2016-07-19 09:00:24',
  edit_clerk                       = 'ETRISKA'
WHERE ( (ae_i_loc_e.multitenant_id = 1)
AND (ae_i_loc_e.warehouse          = 'M2350')
AND (ae_i_loc_e.bin_location       = 'UNIT1.B.2.2')
AND (ae_i_loc_e.multitenant_id     = 1) );

UPDATE ae_i_inv_w
SET whse_cost                      = 0,
  edit_date                        = '2016-07-19 09:00:24',
  edit_clerk                       = 'ETRISKA'
WHERE ( (ae_i_inv_w.multitenant_id = 1)
AND (ae_i_inv_w.part               = '101682')
AND (ae_i_inv_w.warehouse          = 'M2350')
AND (ae_i_inv_w.multitenant_id     = 1) );

INSERT
INTO ae_i_trans_reg
  (
    multitenant_id,
    trans_num,
    source_screenname,
    source_tranx_no,
    source_tranx_item,
    warehouse,
    bin_location,
    part,
    inv_cost,
    bin_qty,
    trans_qty,
    dollar_adj,
    entry_clerk,
    entry_date,
    edit_clerk,
    edit_date,
    description,
    vend_cost,
    issue_factor,
    eqp_tag_id,
    asset_tag,
    sub_line_seq
  )
  VALUES
  (
    1,
    241881,
    'INVENTORY ADJUSTMENT',
    25961,
    0,
    'M2350',
    'UNIT1.B.2.2',
    '101682',
    54.08,
    NULL,
    2,
    0,
    'ETRISKA',
    '2016-07-19 09:00:24',
    'ETRISKA',
    '2016-07-19 09:00:24',
    'INVENTORY PRICE ADJUSTEMENT',
    NULL,
    NULL,
    NULL,
    NULL,
    0
  );

UPDATE ae_i_loc_e
SET qty                            = 2
WHERE ( (ae_i_loc_e.multitenant_id = 1)
AND (ae_i_loc_e.warehouse          = 'M2350')
AND (ae_i_loc_e.bin_location       = 'UNIT1.B.2.2')
AND (ae_i_loc_e.multitenant_id     = 1) );

UPDATE ae_i_inv_w
SET whse_cost                      = 54.0800
WHERE ( (ae_i_inv_w.multitenant_id = 1)
AND (ae_i_inv_w.part               = '101682')
AND (ae_i_inv_w.warehouse          = 'M2350')
AND (ae_i_inv_w.multitenant_id     = 1) );