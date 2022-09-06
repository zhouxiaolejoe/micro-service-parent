--1.��Ŀ�ȵ������Ϣ��ѯ
-- Create table
create table PM_HOT_TOPICCATE
(
  pro_hot_topic_id    VARCHAR2(38) not null,
  mof_div_code        VARCHAR2(9) ,
  setup_year          VARCHAR2(4) ,
  pro_code            VARCHAR2(21) ,
  hot_topic_cate_code VARCHAR2(32) ,
  update_time         DATE ,
  is_deleted          VARCHAR2(1) ,
  create_time         DATE ,
  bgt_id              VARCHAR2(38),
  param_1             VARCHAR2(180),
  param_2             VARCHAR2(180),
  param_3             VARCHAR2(12),
  param_4             VARCHAR2(12),
  param_5             VARCHAR2(180),
  mof_div_name        VARCHAR2(100),
  pro_name            VARCHAR2(180),
  hot_topic_cate_name VARCHAR2(180)
);
-- Add comments to the table 
comment on table PM_HOT_TOPICCATE
  is '��Ŀ�ȵ������Ϣ��ѯ';
-- Add comments to the columns 
comment on column PM_HOT_TOPICCATE.pro_hot_topic_id
  is '��Ŀ�ȵ��������';
comment on column PM_HOT_TOPICCATE.mof_div_code
  is '������������';
comment on column PM_HOT_TOPICCATE.setup_year
  is '�������';
comment on column PM_HOT_TOPICCATE.pro_code
  is '��Ŀ����';
comment on column PM_HOT_TOPICCATE.hot_topic_cate_code
  is '�ȵ�������';
comment on column PM_HOT_TOPICCATE.update_time
  is '����ʱ��';
comment on column PM_HOT_TOPICCATE.is_deleted
  is '�Ƿ�ɾ��';
comment on column PM_HOT_TOPICCATE.create_time
  is '����ʱ��';
comment on column PM_HOT_TOPICCATE.bgt_id
  is 'ָ������';
comment on column PM_HOT_TOPICCATE.mof_div_name
  is '������������';
comment on column PM_HOT_TOPICCATE.pro_name
  is '��Ŀ����';
comment on column PM_HOT_TOPICCATE.hot_topic_cate_name
  is '�ȵ��������';

alter table PM_HOT_TOPICCATE
  add constraint PK_PM_HOT_TOPICCATE_ID primary key (PRO_HOT_TOPIC_ID);
--alter table PM_HOT_TOPICCATE
--  add constraint UN_PM_HOT_TOPICCATE_ID unique (MOF_DIV_CODE, SETUP_YEAR, PRO_CODE, HOT_TOPIC_CATE_CODE);
--Ŀǰ�����Ѿ�ȥ���������� ��������淶��һ��
  
/
--2.ָ����Ϣ
-- Create table
create table BA_BGT_INFO
(
  bgt_id              VARCHAR2(38) not null,
  mof_div_code        VARCHAR2(9) ,
  fiscal_year         VARCHAR2(4) ,
  cor_bgt_doc_no      VARCHAR2(100),
  bgt_doc_title       VARCHAR2(360),
  doc_date            DATE,
  bgt_dec             VARCHAR2(360),
  budget_level_code   VARCHAR2(1) ,
  sup_bgt_doc_no      VARCHAR2(100),
  pro_code            VARCHAR2(21) ,
  bgt_exe_flag        VARCHAR2(1) ,
  is_track            VARCHAR2(1) ,
  track_pro_code      VARCHAR2(21),
  agency_code         VARCHAR2(21),
  fund_type_code      VARCHAR2(10) ,
  manage_mof_dep_code VARCHAR2(6) ,
  tp_func_code        VARCHAR2(13),
  exp_func_code       VARCHAR2(13) ,
  gov_bgt_eco_code    VARCHAR2(11),
  dep_bgt_eco_code    VARCHAR2(20),
  bgt_type_code       VARCHAR2(50) ,
  amount              NUMBER ,
  bgt_mof_dep_code    VARCHAR2(6) ,
  is_gov_pur          VARCHAR2(1) ,
  update_time         DATE ,
  adj_batch_no        VARCHAR2(6),
  ori_bgt_id          VARCHAR2(38),
  dis_amt             NUMBER ,
  cur_amt             NUMBER ,
  bgt_pman_id         VARCHAR2(38),
  is_deleted          VARCHAR2(1) ,
  source_type_code    VARCHAR2(1) ,
  create_time         DATE,
  rec_div_code        VARCHAR2(9) ,
  count_fund_pro_code VARCHAR2(21) ,
  pay_app_amt         NUMBER,
  task_no             VARCHAR2(38),
  spe_pro_code        VARCHAR2(38),
  param_1             VARCHAR2(180),
  param_2             VARCHAR2(180),
  param_3             VARCHAR2(12),
  param_4             VARCHAR2(12),
  param_5             VARCHAR2(180),
  param_6             NUMBER,
  param_7             NUMBER,
  param_8             NUMBER,
  param_9             NUMBER,
  param_10            NUMBER,
  mof_div_name        VARCHAR2(100),
  pro_name            VARCHAR2(180),
  agency_name         VARCHAR2(300),
  fund_type_name      VARCHAR2(60),
  manage_mof_dep_name VARCHAR2(90),
  tp_func_name        VARCHAR2(360),
  exp_func_name       VARCHAR2(360),
  gov_bgt_eco_name    VARCHAR2(360),
  dep_bgt_eco_name    VARCHAR2(360),
  bgt_type_name       VARCHAR2(120),
  bgt_mof_dep_name    VARCHAR2(90),
  rec_div_name        VARCHAR2(100),
  task_nanme          VARCHAR2(180),
  pay_type_name       VARCHAR2(120),
  exp_level_code      VARCHAR2(1),
  pay_type_code       VARCHAR2(2),
  source_type_name    VARCHAR2(60),
  track_pro_name      VARCHAR2(180),
  spe_pro_name        VARCHAR2(180),
  exp_level_name      VARCHAR2(30)
);
-- Add comments to the table 
comment on table BA_BGT_INFO
  is 'ָ����Ϣ';
-- Add comments to the columns 
comment on column BA_BGT_INFO.bgt_id
  is 'ָ������';
comment on column BA_BGT_INFO.mof_div_code
  is '������������';
comment on column BA_BGT_INFO.fiscal_year
  is 'Ԥ�����';
comment on column BA_BGT_INFO.cor_bgt_doc_no
  is '����ָ���ĺ�';
comment on column BA_BGT_INFO.bgt_doc_title
  is 'ָ���ı���';
comment on column BA_BGT_INFO.doc_date
  is '����ʱ��';
comment on column BA_BGT_INFO.bgt_dec
  is 'ָ��˵��';
comment on column BA_BGT_INFO.budget_level_code
  is 'Ԥ�㼶�δ���';
comment on column BA_BGT_INFO.sup_bgt_doc_no
  is '�ϼ�ָ���ĺ�';
comment on column BA_BGT_INFO.pro_code
  is '��Ŀ����';
comment on column BA_BGT_INFO.bgt_exe_flag
  is 'ָ���ִ�б�־';
comment on column BA_BGT_INFO.is_track
  is '�Ƿ�׷��';
comment on column BA_BGT_INFO.track_pro_code
  is '��Ҫ׷����Ŀ����';
comment on column BA_BGT_INFO.agency_code
  is '��λ����';
comment on column BA_BGT_INFO.fund_type_code
  is '�ʽ����ʴ���';
comment on column BA_BGT_INFO.manage_mof_dep_code
  is 'ҵ�����ܴ��Ҵ���';
comment on column BA_BGT_INFO.tp_func_code
  is 'ת��֧��֧�����ܷ����Ŀ����';
comment on column BA_BGT_INFO.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_INFO.gov_bgt_eco_code
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_INFO.dep_bgt_eco_code
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_INFO.bgt_type_code
  is 'ָ�����ʹ���';
comment on column BA_BGT_INFO.amount
  is 'ָ����';
comment on column BA_BGT_INFO.bgt_mof_dep_code
  is 'ָ������Ҵ���';
comment on column BA_BGT_INFO.is_gov_pur
  is '�Ƿ������ɹ�';
comment on column BA_BGT_INFO.update_time
  is '����ʱ��';
comment on column BA_BGT_INFO.adj_batch_no
  is '�������κ�';
comment on column BA_BGT_INFO.ori_bgt_id
  is 'Դָ������';
comment on column BA_BGT_INFO.dis_amt
  is '������׷�������';
comment on column BA_BGT_INFO.cur_amt
  is 'ָ�����';
comment on column BA_BGT_INFO.bgt_pman_id
  is '��Ŀ���Ԥ������';
comment on column BA_BGT_INFO.is_deleted
  is '�Ƿ�ɾ��';
comment on column BA_BGT_INFO.source_type_code
  is 'ָ����Դ����';
comment on column BA_BGT_INFO.create_time
  is '����ʱ��';
comment on column BA_BGT_INFO.rec_div_code
  is '���շ�������������';
comment on column BA_BGT_INFO.count_fund_pro_code
  is '��Ӧ���װ��ŵ�������Ŀ����';
comment on column BA_BGT_INFO.pay_app_amt
  is '������֧�����';
comment on column BA_BGT_INFO.task_no
  is '�������';
comment on column BA_BGT_INFO.spe_pro_code
  is '����ʵʩ��Ŀ';
comment on column BA_BGT_INFO.mof_div_name
  is '������������';
comment on column BA_BGT_INFO.pro_name
  is '��Ŀ����';
comment on column BA_BGT_INFO.agency_name
  is '��λ����';
comment on column BA_BGT_INFO.fund_type_name
  is '�ʽ���������';
comment on column BA_BGT_INFO.manage_mof_dep_name
  is 'ҵ�����ܴ�������';
comment on column BA_BGT_INFO.tp_func_name
  is 'ת��֧�����ܷ����Ŀ����';
comment on column BA_BGT_INFO.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_INFO.gov_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_INFO.dep_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_INFO.bgt_type_name
  is 'ָ����������';
comment on column BA_BGT_INFO.bgt_mof_dep_name
  is 'ָ�����������';
comment on column BA_BGT_INFO.rec_div_name
  is '���շ�������������';
comment on column BA_BGT_INFO.task_nanme
  is '��������';
comment on column BA_BGT_INFO.pay_type_name
  is '֧����ʽ����';
comment on column BA_BGT_INFO.exp_level_code
  is '֧�����δ���';
comment on column BA_BGT_INFO.pay_type_code
  is '֧����ʽ����';
comment on column BA_BGT_INFO.source_type_name
  is 'ָ����Դ����';
comment on column BA_BGT_INFO.track_pro_name
  is '��Ҫ׷����Ŀ����';
comment on column BA_BGT_INFO.spe_pro_name
  is '������Ŀ����';
comment on column BA_BGT_INFO.exp_level_name
  is '֧����������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_INFO
  add constraint PK_BA_BGT_INFO_ID primary key (BGT_ID);
  
/
--3.���⼯��֧��������Ϣ
-- Create table
create table PAY_VOUCHER
(
  pay_cert_id           VARCHAR2(38) not null,
  fund_type_code        VARCHAR2(4),
  fiscal_year           VARCHAR2(4) ,
  pay_acct_name         VARCHAR2(300) ,
  pay_acct_no           VARCHAR2(40) ,
  pay_acct_bank_name    VARCHAR2(180) ,
  payee_acct_name       VARCHAR2(300),
  payee_acct_no         VARCHAR2(40),
  payee_acct_bank_name  VARCHAR2(180),
  exp_func_code         VARCHAR2(13),
  gov_bgt_eco_code      VARCHAR2(11),
  dep_bgt_eco_code      VARCHAR2(20),
  xpay_amt              NUMBER,
  agency_code           VARCHAR2(21),
  use_des               VARCHAR2(300) ,
  set_mode_code         VARCHAR2(2) ,
  pro_code              VARCHAR2(21),
  mof_div_code          VARCHAR2(9) ,
  foreign_amt           NUMBER,
  currency_code         VARCHAR2(3) ,
  est_rat               NUMBER(18,8),
  receiver_code         VARCHAR2(42),
  update_time           DATE ,
  is_deleted            VARCHAR2(1) ,
  create_time           DATE ,
  dept_code             VARCHAR2(40),
  pay_bus_type_code     VARCHAR2(40) ,
  param_1               VARCHAR2(180),
  param_2               VARCHAR2(180),
  param_3               VARCHAR2(12),
  param_4               VARCHAR2(12),
  param_5               VARCHAR2(180),
  param_6               NUMBER,
  param_7               NUMBER,
  param_8               NUMBER,
  param_9               NUMBER,
  param_10              NUMBER,
  bgt_id                VARCHAR2(38),
  mof_div_name          VARCHAR2(300),
  agency_name           VARCHAR2(300),
  dept_name             VARCHAR2(150),
  bgt_type_name         VARCHAR2(20),
  fund_type_name        VARCHAR2(60),
  exp_func_name         VARCHAR2(360),
  gov_bgt_eco_name      VARCHAR2(360),
  dep_bgt_eco_name      VARCHAR2(360),
  pro_name              VARCHAR2(180),
  pro_kind_name         VARCHAR2(30) ,
  pay_type_name         VARCHAR2(60) ,
  set_mode_name         VARCHAR2(60) ,
  fund_traobj_type_name VARCHAR2(50),
  currency_name         VARCHAR2(10) ,
  bond_name             VARCHAR2(200),
  bgt_type_code         VARCHAR2(50),
  bond_code             VARCHAR2(38),
  contract_no           VARCHAR2(100),
  create_date           DATE ,
  entpay_app_no         VARCHAR2(100),
  fund_traobj_type_code VARCHAR2(2),
  internal_dep_code     VARCHAR2(30) ,
  internal_dep_name     VARCHAR2(90) ,
  pay_app_amt           NUMBER ,
  pay_app_id            VARCHAR2(38) ,
  pay_app_no            VARCHAR2(100) ,
  pay_bus_type_name     VARCHAR2(30) ,
  pay_type_code         VARCHAR2(2) ,
  pro_cat_code          VARCHAR2(4) ,
  pro_loangrant_num     VARCHAR2(80)
);
-- Add comments to the table 
comment on table PAY_VOUCHER
  is '���⼯��֧��������Ϣ';
-- Add comments to the columns 
comment on column PAY_VOUCHER.pay_cert_id
  is '֧��ƾ֤����';
comment on column PAY_VOUCHER.fund_type_code
  is '�ʽ����ʴ���';
comment on column PAY_VOUCHER.fiscal_year
  is 'Ԥ�����';
comment on column PAY_VOUCHER.pay_acct_name
  is '������ȫ��';
comment on column PAY_VOUCHER.pay_acct_no
  is '�������˺�';
comment on column PAY_VOUCHER.pay_acct_bank_name
  is '�����˿�������';
comment on column PAY_VOUCHER.payee_acct_name
  is '�տ���ȫ��';
comment on column PAY_VOUCHER.payee_acct_no
  is '�տ����˺�';
comment on column PAY_VOUCHER.payee_acct_bank_name
  is '�տ��˿�������';
comment on column PAY_VOUCHER.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column PAY_VOUCHER.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column PAY_VOUCHER.dep_bgt_eco_code
  is '����֧�����÷������';
comment on column PAY_VOUCHER.xpay_amt
  is 'ʵ��֧�����';
comment on column PAY_VOUCHER.agency_code
  is '��λ����';
comment on column PAY_VOUCHER.use_des
  is '��;';
comment on column PAY_VOUCHER.set_mode_code
  is '���㷽ʽ����';
comment on column PAY_VOUCHER.pro_code
  is '��Ŀ����';
comment on column PAY_VOUCHER.mof_div_code
  is '������������';
comment on column PAY_VOUCHER.foreign_amt
  is '��ҽ��';
comment on column PAY_VOUCHER.currency_code
  is '���ִ���';
comment on column PAY_VOUCHER.est_rat
  is '����';
comment on column PAY_VOUCHER.receiver_code
  is '�տ��˴���';
comment on column PAY_VOUCHER.update_time
  is '����ʱ��';
comment on column PAY_VOUCHER.is_deleted
  is '�Ƿ�ɾ��';
comment on column PAY_VOUCHER.create_time
  is '����ʱ��';
comment on column PAY_VOUCHER.dept_code
  is '���Ŵ���';
comment on column PAY_VOUCHER.pay_bus_type_code
  is '֧��ҵ�����ʹ���';
comment on column PAY_VOUCHER.param_10
  is '';
comment on column PAY_VOUCHER.bgt_id
  is 'ָ������';
comment on column PAY_VOUCHER.mof_div_name
  is '������������';
comment on column PAY_VOUCHER.agency_name
  is '��λ����';
comment on column PAY_VOUCHER.dept_name
  is '��������';
comment on column PAY_VOUCHER.bgt_type_name
  is 'ָ����������';
comment on column PAY_VOUCHER.fund_type_name
  is '�ʽ���������';
comment on column PAY_VOUCHER.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column PAY_VOUCHER.gov_bgt_eco_name
  is '����֧�����÷�������';
comment on column PAY_VOUCHER.dep_bgt_eco_name
  is '����֧�����÷�������';
comment on column PAY_VOUCHER.pro_name
  is '��Ŀ����';
comment on column PAY_VOUCHER.pro_kind_name
  is '��Ŀ�������';
comment on column PAY_VOUCHER.pay_type_name
  is '֧����ʽ����';
comment on column PAY_VOUCHER.set_mode_name
  is '���㷽ʽ����';
comment on column PAY_VOUCHER.fund_traobj_type_name
  is '�ʽ����������������';
comment on column PAY_VOUCHER.currency_name
  is '��������';
comment on column PAY_VOUCHER.bond_name
  is 'ծȯ����';
comment on column PAY_VOUCHER.bgt_type_code
  is 'ָ�����ʹ���';
comment on column PAY_VOUCHER.bond_code
  is 'ծȯ����';
comment on column PAY_VOUCHER.contract_no
  is '�ɹ���ͬ���';
comment on column PAY_VOUCHER.create_date
  is '��������';
comment on column PAY_VOUCHER.entpay_app_no
  is '����������';
comment on column PAY_VOUCHER.fund_traobj_type_code
  is '�ʽ���������������';
comment on column PAY_VOUCHER.internal_dep_code
  is '��λ�ڲ���������';
comment on column PAY_VOUCHER.internal_dep_name
  is '��λ�ڲ���������';
comment on column PAY_VOUCHER.pay_app_amt
  is '֧��������';
comment on column PAY_VOUCHER.pay_app_id
  is '֧����������';
comment on column PAY_VOUCHER.pay_app_no
  is '֧��������';
comment on column PAY_VOUCHER.pay_bus_type_name
  is '֧��ҵ����������';
comment on column PAY_VOUCHER.pay_type_code
  is '֧����ʽ����';
comment on column PAY_VOUCHER.pro_cat_code
  is '��Ŀ���';
comment on column PAY_VOUCHER.pro_loangrant_num
  is '�����������Э���';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_VOUCHER
  add constraint PK_PAY_VOUCHER_ID primary key (PAY_APP_ID);
alter table PAY_VOUCHER
  add constraint UN_PAY_VOUCHER_ID unique (FISCAL_YEAR, MOF_DIV_CODE, PAY_APP_NO);

  
/
--4.���⼯��֧��ƾ֤��Ϣ
-- Create table
create table PAY_VOUCHER_BILL
(
  pay_cert_id           VARCHAR2(38) not null,
  fund_type_code        VARCHAR2(4),
  fiscal_year           VARCHAR2(4) ,
  vou_date              DATE ,
  pay_cert_no           VARCHAR2(100) ,
  pay_acct_name         VARCHAR2(300) ,
  pay_acct_no           VARCHAR2(40) ,
  pay_acct_bank_name    VARCHAR2(180) ,
  payee_acct_name       VARCHAR2(300),
  payee_acct_no         VARCHAR2(40),
  payee_acct_bank_name  VARCHAR2(180),
  pay_amt               NUMBER ,
  lqd_quota_notice_no   VARCHAR2(100),
  pay_cert_sum_no       VARCHAR2(100),
  lqd_cert_no           VARCHAR2(100),
  exp_func_code         VARCHAR2(13),
  gov_bgt_eco_code      VARCHAR2(11),
  dep_bgt_eco_code      VARCHAR2(20),
  agent_business_no     VARCHAR2(360),
  xpay_amt              NUMBER,
  xpay_date             DATE,
  agency_code           VARCHAR2(21),
  use_des               VARCHAR2(300) ,
  set_mode_code         VARCHAR2(2) ,
  pro_code              VARCHAR2(21),
  mof_div_code          VARCHAR2(9) ,
  foreign_amt           NUMBER,
  currency_code         VARCHAR2(3) ,
  est_rat               NUMBER(18,8),
  receiver_code         VARCHAR2(42),
  receipt_add_word      VARCHAR2(300),
  xpayee_acct_name      VARCHAR2(300),
  xpayee_acct_no        VARCHAR2(40),
  xpayee_acct_bank_name VARCHAR2(180),
  update_time           DATE ,
  is_deleted            VARCHAR2(1) ,
  create_time           DATE ,
  dept_code             VARCHAR2(40),
  pay_bus_type_code     VARCHAR2(40),
  act_lqd_date          DATE,
  param_1               VARCHAR2(180),
  param_2               VARCHAR2(180),
  param_3               VARCHAR2(12),
  param_4               VARCHAR2(12),
  param_5               VARCHAR2(180),
  param_6               NUMBER,
  param_7               NUMBER,
  param_8               NUMBER,
  param_9               NUMBER,
  param_10              NUMBER,
  mof_div_name          VARCHAR2(360),
  agency_name           VARCHAR2(300),
  dept_name             VARCHAR2(150),
  fund_type_name        VARCHAR2(60),
  exp_func_name         VARCHAR2(360),
  gov_bgt_eco_name      VARCHAR2(360),
  dep_bgt_eco_name      VARCHAR2(360),
  pro_name              VARCHAR2(180),
  pay_bus_type_name     VARCHAR2(30),
  set_mode_name         VARCHAR2(60),
  abstract              VARCHAR2(300),
  check_no              VARCHAR2(40),
  currency_name         VARCHAR2(10) ,
  pay_code              VARCHAR2(100),
  taxayer_id            VARCHAR2(15),
  tax_org_code          VARCHAR2(12),
  tax_bill_no           VARCHAR2(20)
);
-- Add comments to the table 
comment on table PAY_VOUCHER_BILL
  is '���⼯��֧��ƾ֤��Ϣ';
-- Add comments to the columns 
comment on column PAY_VOUCHER_BILL.pay_cert_id
  is '֧��ƾ֤����';
comment on column PAY_VOUCHER_BILL.fund_type_code
  is '�ʽ����ʴ���';
comment on column PAY_VOUCHER_BILL.fiscal_year
  is '���';
comment on column PAY_VOUCHER_BILL.vou_date
  is 'ƾ֤����';
comment on column PAY_VOUCHER_BILL.pay_cert_no
  is '֧��ƾ֤��';
comment on column PAY_VOUCHER_BILL.pay_acct_name
  is '������ȫ��';
comment on column PAY_VOUCHER_BILL.pay_acct_no
  is '�������˺�';
comment on column PAY_VOUCHER_BILL.pay_acct_bank_name
  is '�����˿�������';
comment on column PAY_VOUCHER_BILL.payee_acct_name
  is '�տ���ȫ��';
comment on column PAY_VOUCHER_BILL.payee_acct_no
  is '�տ����˺�';
comment on column PAY_VOUCHER_BILL.payee_acct_bank_name
  is '�տ��˿�������';
comment on column PAY_VOUCHER_BILL.pay_amt
  is '֧�����';
comment on column PAY_VOUCHER_BILL.lqd_quota_notice_no
  is '������֪ͨ����';
comment on column PAY_VOUCHER_BILL.pay_cert_sum_no
  is '֧��ƾ֤�����嵥��';
comment on column PAY_VOUCHER_BILL.lqd_cert_no
  is '����ƾ֤����';
comment on column PAY_VOUCHER_BILL.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column PAY_VOUCHER_BILL.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column PAY_VOUCHER_BILL.dep_bgt_eco_code
  is '����֧�����÷������';
comment on column PAY_VOUCHER_BILL.agent_business_no
  is '���н�����ˮ��';
comment on column PAY_VOUCHER_BILL.xpay_amt
  is 'ʵ��֧�����';
comment on column PAY_VOUCHER_BILL.xpay_date
  is 'ʵ��֧������';
comment on column PAY_VOUCHER_BILL.agency_code
  is '��λ����';
comment on column PAY_VOUCHER_BILL.use_des
  is '��;';
comment on column PAY_VOUCHER_BILL.set_mode_code
  is '���㷽ʽ����';
comment on column PAY_VOUCHER_BILL.pro_code
  is '��Ŀ����';
comment on column PAY_VOUCHER_BILL.mof_div_code
  is '������������';
comment on column PAY_VOUCHER_BILL.foreign_amt
  is '��ҽ��';
comment on column PAY_VOUCHER_BILL.currency_code
  is '���ִ���';
comment on column PAY_VOUCHER_BILL.est_rat
  is '����';
comment on column PAY_VOUCHER_BILL.receiver_code
  is '�տ��˴���';
comment on column PAY_VOUCHER_BILL.receipt_add_word
  is '�ص�����';
comment on column PAY_VOUCHER_BILL.xpayee_acct_name
  is 'ʵ���տ���ȫ��';
comment on column PAY_VOUCHER_BILL.xpayee_acct_no
  is 'ʵ���տ����˺�';
comment on column PAY_VOUCHER_BILL.xpayee_acct_bank_name
  is 'ʵ���տ��˿�����������';
comment on column PAY_VOUCHER_BILL.update_time
  is '����ʱ��';
comment on column PAY_VOUCHER_BILL.is_deleted
  is '�Ƿ�ɾ��';
comment on column PAY_VOUCHER_BILL.create_time
  is '����ʱ��';
comment on column PAY_VOUCHER_BILL.dept_code
  is '���Ŵ���';
comment on column PAY_VOUCHER_BILL.pay_bus_type_code
  is '֧��ҵ�����ʹ���';
comment on column PAY_VOUCHER_BILL.act_lqd_date
  is 'ʵ����������';
comment on column PAY_VOUCHER_BILL.mof_div_name
  is '������������';
comment on column PAY_VOUCHER_BILL.agency_name
  is '��λ����';
comment on column PAY_VOUCHER_BILL.dept_name
  is '��������';
comment on column PAY_VOUCHER_BILL.fund_type_name
  is '�ʽ���������';
comment on column PAY_VOUCHER_BILL.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column PAY_VOUCHER_BILL.gov_bgt_eco_name
  is '����֧�����÷�������';
comment on column PAY_VOUCHER_BILL.dep_bgt_eco_name
  is '����֧�����÷�������';
comment on column PAY_VOUCHER_BILL.pro_name
  is '��Ŀ����';
comment on column PAY_VOUCHER_BILL.pay_bus_type_name
  is '֧��ҵ����������';
comment on column PAY_VOUCHER_BILL.set_mode_name
  is '���㷽ʽ����';
comment on column PAY_VOUCHER_BILL.abstract
  is 'ƾ֤ժҪ';
comment on column PAY_VOUCHER_BILL.check_no
  is '֧Ʊ��';
comment on column PAY_VOUCHER_BILL.currency_name
  is '��������';
comment on column PAY_VOUCHER_BILL.pay_code
  is '�ɿ�ʶ����';
comment on column PAY_VOUCHER_BILL.taxayer_id
  is '��˰��ʶ���';
comment on column PAY_VOUCHER_BILL.tax_org_code
  is '˰�����ջ��ش���';
comment on column PAY_VOUCHER_BILL.tax_bill_no
  is '�걨˰ƾ֤��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_VOUCHER_BILL
  add constraint PK_PAY_VOUCHER_BILL_ID primary key (PAY_CERT_ID);
alter table PAY_VOUCHER_BILL
  add constraint UN_PAY_VOUCHER_BILL_ID unique (PAY_CERT_NO, MOF_DIV_CODE, PAYEE_ACCT_NO);


/

--5.���⼯��֧����ϸ��Ϣ
-- Create table
create table PAY_DETAIL
(
  pay_detail_id        VARCHAR2(38) not null,
  agency_code          VARCHAR2(21) ,
  payee_acct_name      VARCHAR2(300) ,
  payee_acct_no        VARCHAR2(40) ,
  payee_acct_bank_name VARCHAR2(180) ,
  pay_amt              NUMBER ,
  xpay_amt             NUMBER,
  add_word             VARCHAR2(300),
  pay_cert_no          VARCHAR2(100),
  pay_apply_id         VARCHAR2(38),
  tracking_id          VARCHAR2(38),
  mof_div_code         VARCHAR2(9) ,
  receiver_code        VARCHAR2(42),
  fiscal_year          VARCHAR2(4) ,
  update_time          DATE ,
  is_deleted           VARCHAR2(1) ,
  create_time          DATE ,
  is_to_peop_enterp    VARCHAR2(1) ,
  per_name             VARCHAR2(60),
  iden_no              VARCHAR2(20),
  corp_name            VARCHAR2(200),
  unifsoc_cred_code    VARCHAR2(18),
  pay_month            VARCHAR2(2),
  to_peop_enterp       VARCHAR2(2) ,
  town_code            VARCHAR2(40),
  town_name            VARCHAR2(400),
  village_code         VARCHAR2(40),
  village_name         VARCHAR2(400),
  to_peop_family       VARCHAR2(1),
  param_1              VARCHAR2(180),
  param_2              VARCHAR2(180),
  param_3              VARCHAR2(12),
  param_4              VARCHAR2(12),
  param_5              VARCHAR2(180),
  param_6              NUMBER,
  param_7              NUMBER,
  param_8              NUMBER,
  param_9              NUMBER,
  param_10             NUMBER,
  mof_div_name         VARCHAR2(360),
  agency_name          VARCHAR2(300)
);
-- Add comments to the table 
comment on table PAY_DETAIL
  is '���⼯��֧����ϸ��Ϣ';
-- Add comments to the columns 
comment on column PAY_DETAIL.pay_detail_id
  is '֧����ϸ������';
comment on column PAY_DETAIL.agency_code
  is '��λ����';
comment on column PAY_DETAIL.payee_acct_name
  is '�տ���ȫ��';
comment on column PAY_DETAIL.payee_acct_no
  is '�տ����˺�';
comment on column PAY_DETAIL.payee_acct_bank_name
  is '�տ��˿�������';
comment on column PAY_DETAIL.pay_amt
  is '֧�����';
comment on column PAY_DETAIL.xpay_amt
  is 'ʵ��֧�����';
comment on column PAY_DETAIL.add_word
  is '����';
comment on column PAY_DETAIL.pay_cert_no
  is '֧��ƾ֤��';
comment on column PAY_DETAIL.pay_apply_id
  is '֧����������';
comment on column PAY_DETAIL.tracking_id
  is 'ҵ��׷��ʶ����';
comment on column PAY_DETAIL.mof_div_code
  is '������������';
comment on column PAY_DETAIL.receiver_code
  is '�տ��˴���';
comment on column PAY_DETAIL.fiscal_year
  is 'Ԥ�����';
comment on column PAY_DETAIL.update_time
  is '����ʱ��';
comment on column PAY_DETAIL.is_deleted
  is '�Ƿ�ɾ��';
comment on column PAY_DETAIL.create_time
  is '����ʱ��';
comment on column PAY_DETAIL.is_to_peop_enterp
  is '��Ŀ�Ƿ��������';
comment on column PAY_DETAIL.per_name
  is '����';
comment on column PAY_DETAIL.iden_no
  is '֤������';
comment on column PAY_DETAIL.corp_name
  is '��ҵ����';
comment on column PAY_DETAIL.unifsoc_cred_code
  is 'ͳһ������ô���';
comment on column PAY_DETAIL.pay_month
  is '�����·�';
comment on column PAY_DETAIL.to_peop_enterp
  is '���������ʶ';
comment on column PAY_DETAIL.town_code
  is '�ֵ�(����)����';
comment on column PAY_DETAIL.town_name
  is '�ֵ�(����)����';
comment on column PAY_DETAIL.village_code
  is '�����';
comment on column PAY_DETAIL.village_name
  is '������';
comment on column PAY_DETAIL.to_peop_family
  is '�������˲�����ʶ';
comment on column PAY_DETAIL.mof_div_name
  is '������������';
comment on column PAY_DETAIL.agency_name
  is '��λ����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_DETAIL
  add constraint PK_PAY_DETAIL_ID primary key (PAY_DETAIL_ID);
alter table PAY_DETAIL
  add constraint UN_PAY_DETAIL_ID unique (MOF_DIV_CODE, AGENCY_CODE, PAYEE_ACCT_NO);

  
/

--6.Ԥ�㲦��ƾ֤��Ϣ
-- Create table
create table PAY_ALLOCATION_CERT
(
  pay_alloc_cert_id    VARCHAR2(38) not null,
  vou_date             DATE ,
  mof_div_code         VARCHAR2(9) ,
  fiscal_year          VARCHAR2(4) ,
  agency_code          VARCHAR2(21),
  pay_alloc_cert_no    VARCHAR2(100) ,
  pay_acct_name        VARCHAR2(300) ,
  pay_acct_no          VARCHAR2(40) ,
  pay_acct_bank_name   VARCHAR2(180) ,
  payee_acct_name      VARCHAR2(300) ,
  payee_acct_no        VARCHAR2(40) ,
  payee_acct_bank_name VARCHAR2(180) ,
  foreign_amt          NUMBER,
  currency_code        VARCHAR2(3) ,
  est_rat              NUMBER(18,8),
  use_des              VARCHAR2(300) ,
  exp_func_code        VARCHAR2(13),
  gov_bgt_eco_code     VARCHAR2(11),
  pro_code             VARCHAR2(21),
  bgt_id               VARCHAR2(38),
  fund_type_code       VARCHAR2(4),
  receiver_code        VARCHAR2(42),
  update_time          DATE ,
  is_deleted           VARCHAR2(1) ,
  create_time          DATE ,
  pay_alloc_type       VARCHAR2(1) ,
  acc_date             DATE,
  param_1              VARCHAR2(180),
  param_2              VARCHAR2(180),
  param_3              VARCHAR2(12),
  param_4              VARCHAR2(12),
  param_5              VARCHAR2(180),
  param_6              NUMBER,
  param_7              NUMBER,
  param_8              NUMBER,
  param_9              NUMBER,
  param_10             NUMBER,
  mof_div_name         VARCHAR2(360),
  agency_name          VARCHAR2(300),
  fund_type_name       VARCHAR2(60),
  exp_func_name        VARCHAR2(360),
  gov_bgt_eco_name     VARCHAR2(360),
  pro_name             VARCHAR2(180),
  currency_name        VARCHAR2(10),
  pay_alloc_type_name  VARCHAR2(120),
  pay_amt              NUMBER
);
-- Add comments to the table 
comment on table PAY_ALLOCATION_CERT
  is 'Ԥ�㲦��ƾ֤��Ϣ';
-- Add comments to the columns 
comment on column PAY_ALLOCATION_CERT.pay_alloc_cert_id
  is '����ƾ֤����';
comment on column PAY_ALLOCATION_CERT.vou_date
  is 'ƾ֤����';
comment on column PAY_ALLOCATION_CERT.mof_div_code
  is '������������';
comment on column PAY_ALLOCATION_CERT.fiscal_year
  is 'Ԥ�����';
comment on column PAY_ALLOCATION_CERT.agency_code
  is '��λ����';
comment on column PAY_ALLOCATION_CERT.pay_alloc_cert_no
  is '����ƾ֤��';
comment on column PAY_ALLOCATION_CERT.pay_acct_name
  is '������ȫ��';
comment on column PAY_ALLOCATION_CERT.pay_acct_no
  is '������';
comment on column PAY_ALLOCATION_CERT.pay_acct_bank_name
  is '�����˿�������';
comment on column PAY_ALLOCATION_CERT.payee_acct_name
  is '�տ���ȫ��';
comment on column PAY_ALLOCATION_CERT.payee_acct_no
  is '�տ����˺�';
comment on column PAY_ALLOCATION_CERT.payee_acct_bank_name
  is '�տ��˿�������';
comment on column PAY_ALLOCATION_CERT.foreign_amt
  is '��ҽ��';
comment on column PAY_ALLOCATION_CERT.currency_code
  is '���ִ���';
comment on column PAY_ALLOCATION_CERT.est_rat
  is '����';
comment on column PAY_ALLOCATION_CERT.use_des
  is '��;';
comment on column PAY_ALLOCATION_CERT.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column PAY_ALLOCATION_CERT.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column PAY_ALLOCATION_CERT.pro_code
  is '��Ŀ����';
comment on column PAY_ALLOCATION_CERT.bgt_id
  is 'ָ������';
comment on column PAY_ALLOCATION_CERT.fund_type_code
  is '�ʽ����ʴ���';
comment on column PAY_ALLOCATION_CERT.receiver_code
  is '�տ��˴���';
comment on column PAY_ALLOCATION_CERT.update_time
  is '����ʱ��';
comment on column PAY_ALLOCATION_CERT.is_deleted
  is '�Ƿ�ɾ��';
comment on column PAY_ALLOCATION_CERT.create_time
  is '����ʱ��';
comment on column PAY_ALLOCATION_CERT.pay_alloc_type
  is '�������ʹ���';
comment on column PAY_ALLOCATION_CERT.acc_date
  is 'ʵ�ʲ�������';
comment on column PAY_ALLOCATION_CERT.mof_div_name
  is '������������';
comment on column PAY_ALLOCATION_CERT.agency_name
  is '��λ����';
comment on column PAY_ALLOCATION_CERT.fund_type_name
  is '�ʽ���������';
comment on column PAY_ALLOCATION_CERT.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column PAY_ALLOCATION_CERT.gov_bgt_eco_name
  is '����֧�����÷�������';
comment on column PAY_ALLOCATION_CERT.pro_name
  is '��Ŀ����';
comment on column PAY_ALLOCATION_CERT.currency_name
  is '��������';
comment on column PAY_ALLOCATION_CERT.pay_alloc_type_name
  is '������������';
comment on column PAY_ALLOCATION_CERT.pay_amt
  is '������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_ALLOCATION_CERT
  add constraint PK_PAY_ALLOCATION_CERT_ID primary key (PAY_ALLOC_CERT_ID);

  
/
--7.��λ�ʽ�֧��������Ϣ
-- Create table
create table INC_APPLY
(
  pay_app_id            VARCHAR2(38) not null,
  pay_app_no            VARCHAR2(100) ,
  create_date           DATE ,
  agency_code           VARCHAR2(21) ,
  bgt_type_code         VARCHAR2(3),
  fund_type_code        VARCHAR2(4) ,
  exp_func_code         VARCHAR2(13),
  gov_bgt_eco_code      VARCHAR2(11),
  dep_bgt_eco_code      VARCHAR2(20),
  pro_code              VARCHAR2(21),
  bgt_id                VARCHAR2(38),
  set_mode_code         VARCHAR2(2) ,
  pay_type_code         VARCHAR2(2) ,
  use_des               VARCHAR2(300) ,
  pay_bus_type_code     VARCHAR2(2) ,
  pay_app_amt           NUMBER ,
  pay_cert_id           VARCHAR2(38),
  pay_acct_name         VARCHAR2(300) ,
  pay_acct_no           VARCHAR2(40) ,
  pay_acct_bank_name    VARCHAR2(180) ,
  payee_acct_name       VARCHAR2(300),
  payee_acct_no         VARCHAR2(40),
  payee_acct_bank_name  VARCHAR2(180),
  fund_traobj_type_code VARCHAR2(2),
  internal_dep_code     VARCHAR2(30),
  fiscal_year           VARCHAR2(4) ,
  mof_div_code          VARCHAR2(9) ,
  foreign_amt           NUMBER,
  currency_code         VARCHAR2(3) ,
  est_rat               NUMBER(18,8),
  receiver_code         VARCHAR2(42),
  contract_no           VARCHAR2(100),
  update_time           DATE ,
  is_deleted            VARCHAR2(1) ,
  create_time           DATE ,
  pro_cat_code          VARCHAR2(4) ,
  dept_code             VARCHAR2(21) ,
  param_1               VARCHAR2(180),
  param_2               VARCHAR2(180),
  param_3               VARCHAR2(12),
  param_4               VARCHAR2(12),
  param_5               VARCHAR2(180),
  param_6               NUMBER,
  param_7               NUMBER,
  param_8               NUMBER,
  param_9               NUMBER,
  param_10              NUMBER,
  mof_div_name          VARCHAR2(360),
  agency_name           VARCHAR2(300),
  dept_name             VARCHAR2(150),
  bgt_type_name         VARCHAR2(20),
  fund_type_name        VARCHAR2(60),
  exp_func_name         VARCHAR2(360),
  gov_bgt_eco_name      VARCHAR2(360),
  dep_bgt_eco_name      VARCHAR2(360),
  pro_name              VARCHAR2(180),
  pro_kind_name         VARCHAR2(30),
  pay_bus_type_name     VARCHAR2(30),
  pay_type_name         VARCHAR2(60),
  set_mode_name         VARCHAR2(60),
  internal_dep_name     VARCHAR2(90),
  currency_name         VARCHAR2(10),
  fund_traobj_type_name VARCHAR2(50)
);
-- Add comments to the table 
comment on table INC_APPLY
  is '��λ�ʽ�֧��������Ϣ';
-- Add comments to the columns 
comment on column INC_APPLY.pay_app_id
  is '';
comment on column INC_APPLY.pay_app_no
  is '֧��������';
comment on column INC_APPLY.create_date
  is '��������';
comment on column INC_APPLY.agency_code
  is '��λ����';
comment on column INC_APPLY.bgt_type_code
  is 'ָ�����ʹ���';
comment on column INC_APPLY.fund_type_code
  is '�ʽ����ʴ���';
comment on column INC_APPLY.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column INC_APPLY.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column INC_APPLY.dep_bgt_eco_code
  is '����֧�����÷������';
comment on column INC_APPLY.pro_code
  is '��Ŀ����';
comment on column INC_APPLY.bgt_id
  is 'ָ������';
comment on column INC_APPLY.set_mode_code
  is '���㷽ʽ����';
comment on column INC_APPLY.pay_type_code
  is '֧����ʽ����';
comment on column INC_APPLY.use_des
  is '��;';
comment on column INC_APPLY.pay_bus_type_code
  is '֧��ҵ�����ʹ���';
comment on column INC_APPLY.pay_app_amt
  is '֧��������';
comment on column INC_APPLY.pay_cert_id
  is '֧��ƾ֤����';
comment on column INC_APPLY.pay_acct_name
  is '������ȫ��';
comment on column INC_APPLY.pay_acct_no
  is '������';
comment on column INC_APPLY.pay_acct_bank_name
  is '�����˿�������';
comment on column INC_APPLY.payee_acct_name
  is '�տ���ȫ��';
comment on column INC_APPLY.payee_acct_no
  is '�տ����˺�';
comment on column INC_APPLY.payee_acct_bank_name
  is '�տ��˿�������';
comment on column INC_APPLY.fund_traobj_type_code
  is '�ʽ���������������';
comment on column INC_APPLY.internal_dep_code
  is '��λ�ڲ���������';
comment on column INC_APPLY.fiscal_year
  is 'Ԥ�����';
comment on column INC_APPLY.mof_div_code
  is '������������';
comment on column INC_APPLY.foreign_amt
  is '��ҽ��';
comment on column INC_APPLY.currency_code
  is '���ִ���';
comment on column INC_APPLY.est_rat
  is '����';
comment on column INC_APPLY.receiver_code
  is '�տ��˴���';
comment on column INC_APPLY.contract_no
  is '�ɹ���ͬ���';
comment on column INC_APPLY.update_time
  is '����ʱ��';
comment on column INC_APPLY.is_deleted
  is '�Ƿ�ɾ��';
comment on column INC_APPLY.create_time
  is '����ʱ��';
comment on column INC_APPLY.pro_cat_code
  is '��Ŀ���';
comment on column INC_APPLY.dept_code
  is '���Ŵ���';
comment on column INC_APPLY.mof_div_name
  is '������������';
comment on column INC_APPLY.agency_name
  is '��λ����';
comment on column INC_APPLY.dept_name
  is '��������';
comment on column INC_APPLY.bgt_type_name
  is 'ָ����������';
comment on column INC_APPLY.fund_type_name
  is '�ʽ���������';
comment on column INC_APPLY.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column INC_APPLY.gov_bgt_eco_name
  is '����֧�����÷�������';
comment on column INC_APPLY.dep_bgt_eco_name
  is '����֧�����÷�������';
comment on column INC_APPLY.pro_name
  is '��Ŀ����';
comment on column INC_APPLY.pro_kind_name
  is '��Ŀ�������';
comment on column INC_APPLY.pay_bus_type_name
  is '֧��ҵ����������';
comment on column INC_APPLY.pay_type_name
  is '֧����ʽ����';
comment on column INC_APPLY.set_mode_name
  is '���㷽ʽ����';
comment on column INC_APPLY.internal_dep_name
  is '��λ�ڲ���������';
comment on column INC_APPLY.currency_name
  is '��������';
comment on column INC_APPLY.fund_traobj_type_name
  is '�ʽ����������������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table INC_APPLY
  add constraint PK_INC_APPLY_ID primary key (PAY_APP_ID);
alter table INC_APPLY
  add constraint UN_INC_APPLY_ID unique (MOF_DIV_CODE, PAY_APP_NO);


/

--8.��λ�ʽ�֧��ƾ֤��Ϣ
-- Create table
create table INC_CERT
(
  pay_cert_id           VARCHAR2(38) not null,
  fund_type_code        VARCHAR2(38) ,
  vou_date              DATE ,
  fiscal_year           VARCHAR2(4) ,
  pay_cert_no           VARCHAR2(100) ,
  pay_acct_name         VARCHAR2(300) ,
  pay_acct_no           VARCHAR2(40) ,
  pay_acct_bank_name    VARCHAR2(180) ,
  payee_acct_name       VARCHAR2(300),
  payee_acct_no         VARCHAR2(40),
  payee_acct_bank_name  VARCHAR2(180),
  pay_amt               NUMBER ,
  exp_func_code         VARCHAR2(13),
  gov_bgt_eco_code      VARCHAR2(11),
  dep_bgt_eco_code      VARCHAR2(20),
  pro_code              VARCHAR2(21),
  agent_business_no     VARCHAR2(360),
  xpay_amt              NUMBER,
  xpay_date             DATE,
  agency_code           VARCHAR2(21) ,
  use_des               VARCHAR2(300) ,
  set_mode_code         VARCHAR2(1) ,
  mof_div_code          VARCHAR2(9) ,
  foreign_amt           NUMBER,
  currency_code         VARCHAR2(3) ,
  est_rat               NUMBER(18,8),
  receiver_code         VARCHAR2(42),
  receipt_add_word      VARCHAR2(300),
  xpayee_acct_name      VARCHAR2(300),
  xpayee_acct_no        VARCHAR2(40),
  xpayee_acct_bank_name VARCHAR2(180),
  update_time           DATE ,
  is_deleted            VARCHAR2(1) ,
  create_time           DATE ,
  dept_code             VARCHAR2(21),
  param_1               VARCHAR2(180),
  param_2               VARCHAR2(180),
  param_3               VARCHAR2(12),
  param_4               VARCHAR2(12),
  param_5               VARCHAR2(180),
  param_6               NUMBER,
  param_7               NUMBER,
  param_8               NUMBER,
  param_9               NUMBER,
  param_10              NUMBER,
  mof_div_name          VARCHAR2(360),
  agency_name           VARCHAR2(300),
  dept_name             VARCHAR2(150),
  fund_type_name        VARCHAR2(60),
  exp_func_name         VARCHAR2(360),
  gov_bgt_eco_name      VARCHAR2(360),
  dep_bgt_eco_name      VARCHAR2(360),
  pro_name              VARCHAR2(180),
  set_mode_name         VARCHAR2(60),
  abstract              VARCHAR2(300),
  currency_name         VARCHAR2(10)
);
-- Add comments to the table 
comment on table INC_CERT
  is '��λ�ʽ�֧��ƾ֤��Ϣ';
-- Add comments to the columns 
comment on column INC_CERT.pay_cert_id
  is '֧��ƾ֤����';
comment on column INC_CERT.fund_type_code
  is '�ʽ����ʴ���';
comment on column INC_CERT.vou_date
  is 'ƾ֤����';
comment on column INC_CERT.fiscal_year
  is 'Ԥ�����';
comment on column INC_CERT.pay_cert_no
  is '֧��ƾ֤��';
comment on column INC_CERT.pay_acct_name
  is '������';
comment on column INC_CERT.pay_acct_no
  is '�������˺�';
comment on column INC_CERT.pay_acct_bank_name
  is '�����˿�������';
comment on column INC_CERT.payee_acct_name
  is '�տ���ȫ��';
comment on column INC_CERT.payee_acct_no
  is '�տ����˺�';
comment on column INC_CERT.payee_acct_bank_name
  is '�տ��˿�������';
comment on column INC_CERT.pay_amt
  is '֧�����';
comment on column INC_CERT.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column INC_CERT.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column INC_CERT.dep_bgt_eco_code
  is '����֧�����÷������';
comment on column INC_CERT.pro_code
  is '��Ŀ����';
comment on column INC_CERT.agent_business_no
  is '���н�����ˮ��';
comment on column INC_CERT.xpay_amt
  is 'ʵ��֧�����';
comment on column INC_CERT.xpay_date
  is 'ʵ��֧������';
comment on column INC_CERT.agency_code
  is '��λ����';
comment on column INC_CERT.use_des
  is '��;';
comment on column INC_CERT.set_mode_code
  is '���㷽ʽ����';
comment on column INC_CERT.mof_div_code
  is '������������';
comment on column INC_CERT.foreign_amt
  is '��ҽ��';
comment on column INC_CERT.currency_code
  is '���ִ���';
comment on column INC_CERT.est_rat
  is '����';
comment on column INC_CERT.receiver_code
  is '�տ��˴���';
comment on column INC_CERT.receipt_add_word
  is '�ص�����';
comment on column INC_CERT.xpayee_acct_name
  is 'ʵ���տ���ȫ��';
comment on column INC_CERT.xpayee_acct_no
  is 'ʵ���տ����˺�';
comment on column INC_CERT.xpayee_acct_bank_name
  is 'ʵ���տ��˿�����������';
comment on column INC_CERT.update_time
  is '����ʱ��';
comment on column INC_CERT.is_deleted
  is '�Ƿ�ɾ��';
comment on column INC_CERT.create_time
  is '����ʱ��';
comment on column INC_CERT.dept_code
  is '���Ŵ���';
comment on column INC_CERT.mof_div_name
  is '������������';
comment on column INC_CERT.agency_name
  is '��λ����';
comment on column INC_CERT.dept_name
  is '��������';
comment on column INC_CERT.fund_type_name
  is '�ʽ���������';
comment on column INC_CERT.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column INC_CERT.gov_bgt_eco_name
  is '����֧�����÷�������';
comment on column INC_CERT.dep_bgt_eco_name
  is '����֧�����÷�������';
comment on column INC_CERT.pro_name
  is '��Ŀ����';
comment on column INC_CERT.set_mode_name
  is '���㷽ʽ����';
comment on column INC_CERT.abstract
  is 'ƾ֤ժҪ';
comment on column INC_CERT.currency_name
  is '��������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table INC_CERT
  add constraint PK_INC_CERT_ID primary key (PAY_CERT_ID);
alter table INC_CERT
  add constraint UN_INC_CERT_ID unique (PAY_CERT_NO, MOF_DIV_CODE);

  
/

--9.��λ�ʽ�֧����ϸ��Ϣ
-- Create table
create table INC_DETAIL
(
  pay_detail_id        VARCHAR2(38) not null,
  agency_code          VARCHAR2(21) ,
  payee_acct_name      VARCHAR2(300) ,
  payee_acct_no        VARCHAR2(40) ,
  payee_acct_bank_name VARCHAR2(180) ,
  pay_amt              NUMBER ,
  xpay_amt             NUMBER,
  add_word             VARCHAR2(300),
  pay_cert_no          VARCHAR2(100),
  pay_apply_id         VARCHAR2(38),
  tracking_id          VARCHAR2(38),
  fiscal_year          VARCHAR2(4) ,
  mof_div_code         VARCHAR2(9) ,
  receiver_code        VARCHAR2(42),
  update_time          DATE ,
  is_deleted           VARCHAR2(1) ,
  create_time          DATE ,
  param_1              VARCHAR2(180),
  param_2              VARCHAR2(180),
  param_3              VARCHAR2(12),
  param_4              VARCHAR2(12),
  param_5              VARCHAR2(180),
  param_6              NUMBER,
  param_7              NUMBER,
  param_8              NUMBER,
  param_9              NUMBER,
  param_10             NUMBER,
  mof_div_name         VARCHAR2(300),
  agency_name          VARCHAR2(300)
);
-- Add comments to the table 
comment on table INC_DETAIL
  is '��λ�ʽ�֧����ϸ��Ϣ';
-- Add comments to the columns 
comment on column INC_DETAIL.pay_detail_id
  is '֧����ϸ������';
comment on column INC_DETAIL.agency_code
  is '��λ����';
comment on column INC_DETAIL.payee_acct_name
  is '�տ���ȫ��';
comment on column INC_DETAIL.payee_acct_no
  is '�տ����˺�';
comment on column INC_DETAIL.payee_acct_bank_name
  is '�տ��˿�������';
comment on column INC_DETAIL.pay_amt
  is '֧�����';
comment on column INC_DETAIL.xpay_amt
  is 'ʵ��֧�����';
comment on column INC_DETAIL.add_word
  is '����';
comment on column INC_DETAIL.pay_cert_no
  is '֧��ƾ֤��';
comment on column INC_DETAIL.pay_apply_id
  is '֧����������';
comment on column INC_DETAIL.tracking_id
  is 'ҵ��׷��ʶ����';
comment on column INC_DETAIL.fiscal_year
  is 'Ԥ�����';
comment on column INC_DETAIL.mof_div_code
  is '������������';
comment on column INC_DETAIL.receiver_code
  is '�տ��˴���';
comment on column INC_DETAIL.update_time
  is '����ʱ��';
comment on column INC_DETAIL.is_deleted
  is '�Ƿ�ɾ��';
comment on column INC_DETAIL.create_time
  is '����ʱ��';
comment on column INC_DETAIL.mof_div_name
  is '������������';
comment on column INC_DETAIL.agency_name
  is '��λ����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table INC_DETAIL
  add constraint PK_INC_DETAIL_ID primary key (PAY_DETAIL_ID);
alter table INC_DETAIL
  add constraint UN_INC_DETAIL_ID unique (MOF_DIV_CODE, AGENCY_CODE, PAYEE_ACCT_NO);

  
/

--10.�����ʽ��תָ����Ϣ

-- Create table
create table BA_BGT_CARRYOVERS
(
  fiscal_year         VARCHAR2(4) ,
  approve_amt         NUMBER ,
  carryovers_amt      NUMBER ,
  bgt_type_code       VARCHAR2(50) ,
  bgt_mof_dep_code    VARCHAR2(6) ,
  manage_mof_dep_code VARCHAR2(6) ,
  cor_bgt_doc_no      VARCHAR2(100) ,
  bgt_dec             VARCHAR2(360) ,
  exp_func_code       VARCHAR2(13) ,
  gov_bgt_eco_code    VARCHAR2(11) ,
  fund_type_code      VARCHAR2(10) ,
  agency_code         VARCHAR2(21) ,
  pro_code            VARCHAR2(21) ,
  budget_level_code   VARCHAR2(1) ,
  bgt_exe_flag        VARCHAR2(1) ,
  ori_bgt_id          VARCHAR2(38) ,
  mof_div_code        VARCHAR2(9) ,
  carryovers_bgt_id   VARCHAR2(38) not null,
  update_time         DATE ,
  is_deleted          VARCHAR2(1) ,
  is_gov_pur          VARCHAR2(1) ,
  is_track            VARCHAR2(1) ,
  create_time         DATE ,
  param_1             VARCHAR2(180),
  param_2             VARCHAR2(180),
  param_3             VARCHAR2(12),
  param_4             VARCHAR2(12),
  param_5             VARCHAR2(180),
  param_6             NUMBER,
  param_7             NUMBER,
  param_8             NUMBER,
  param_9             NUMBER,
  param_10            NUMBER,
  mof_div_name        VARCHAR2(100),
  fund_type_name      VARCHAR2(60),
  bgt_type_name       VARCHAR2(120),
  bgt_mof_dep_name    VARCHAR2(90),
  manage_mof_dep_name VARCHAR2(90),
  exp_func_name       VARCHAR2(360),
  gov_bgt_eco_name    VARCHAR2(360),
  agency_name         VARCHAR2(300),
  pro_name            VARCHAR2(180),
  budget_level_name   VARCHAR2(30)
);
-- Add comments to the table 
comment on table BA_BGT_CARRYOVERS
  is '�����ʽ��תָ����Ϣ';
-- Add comments to the columns 
comment on column BA_BGT_CARRYOVERS.fiscal_year
  is 'Ԥ�����';
comment on column BA_BGT_CARRYOVERS.approve_amt
  is '������';
comment on column BA_BGT_CARRYOVERS.carryovers_amt
  is '��ת��';
comment on column BA_BGT_CARRYOVERS.bgt_type_code
  is 'ָ�����ʹ���';
comment on column BA_BGT_CARRYOVERS.bgt_mof_dep_code
  is 'ָ������Ҵ���';
comment on column BA_BGT_CARRYOVERS.manage_mof_dep_code
  is 'ҵ�����ܴ��Ҵ���';
comment on column BA_BGT_CARRYOVERS.cor_bgt_doc_no
  is '����ָ���ĺ�';
comment on column BA_BGT_CARRYOVERS.bgt_dec
  is 'ָ��˵��';
comment on column BA_BGT_CARRYOVERS.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_CARRYOVERS.gov_bgt_eco_code
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_CARRYOVERS.fund_type_code
  is '�ʽ����ʴ���';
comment on column BA_BGT_CARRYOVERS.agency_code
  is '����';
comment on column BA_BGT_CARRYOVERS.pro_code
  is '��Ŀ����';
comment on column BA_BGT_CARRYOVERS.budget_level_code
  is 'Ԥ�㼶�δ���';
comment on column BA_BGT_CARRYOVERS.bgt_exe_flag
  is 'ָ���ִ�б�־';
comment on column BA_BGT_CARRYOVERS.ori_bgt_id
  is 'Դָ������';
comment on column BA_BGT_CARRYOVERS.mof_div_code
  is '������������';
comment on column BA_BGT_CARRYOVERS.carryovers_bgt_id
  is '����';
comment on column BA_BGT_CARRYOVERS.update_time
  is '����ʱ��';
comment on column BA_BGT_CARRYOVERS.is_deleted
  is '�Ƿ�ɾ��';
comment on column BA_BGT_CARRYOVERS.is_gov_pur
  is '�Ƿ������ɹ�';
comment on column BA_BGT_CARRYOVERS.is_track
  is '�Ƿ�׷��';
comment on column BA_BGT_CARRYOVERS.create_time
  is '����ʱ��';
comment on column BA_BGT_CARRYOVERS.mof_div_name
  is '������������';
comment on column BA_BGT_CARRYOVERS.fund_type_name
  is '�ʽ���������';
comment on column BA_BGT_CARRYOVERS.bgt_type_name
  is 'ָ����������';
comment on column BA_BGT_CARRYOVERS.bgt_mof_dep_name
  is 'ָ�����������';
comment on column BA_BGT_CARRYOVERS.manage_mof_dep_name
  is 'ҵ�����ܴ�������';
comment on column BA_BGT_CARRYOVERS.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_CARRYOVERS.gov_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_CARRYOVERS.agency_name
  is '��λ����';
comment on column BA_BGT_CARRYOVERS.pro_name
  is '��Ŀ����';
comment on column BA_BGT_CARRYOVERS.budget_level_name
  is 'Ԥ�㼶������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_CARRYOVERS
  add constraint PK_BA_BGT_CARRYOVERS_ID primary key (CARRYOVERS_BGT_ID);
alter table BA_BGT_CARRYOVERS
  add constraint UN_BA_BGT_CARRYOVERS_ID unique (PRO_CODE, AGENCY_CODE, EXP_FUNC_CODE, GOV_BGT_ECO_CODE, FUND_TYPE_CODE);



/
--11.�����ʽ����ָ����Ϣ
-- Create table
create table BA_BGT_BALANCE
(
  fiscal_year         VARCHAR2(4) ,
  approve_amt         NUMBER ,
  balance             NUMBER ,
  bgt_type_code       VARCHAR2(50) ,
  bgt_mof_dep_code    VARCHAR2(6) ,
  manage_mof_dep_code VARCHAR2(6) ,
  cor_bgt_doc_no      VARCHAR2(100) ,
  bgt_dec             VARCHAR2(360) ,
  agency_code         VARCHAR2(21) ,
  exp_func_code       VARCHAR2(13) ,
  gov_bgt_eco_code    VARCHAR2(11) ,
  fund_type_code      VARCHAR2(10) ,
  bgt_exe_flag        VARCHAR2(1) ,
  pro_code            VARCHAR2(21) ,
  budget_level_code   VARCHAR2(1) ,
  ori_bgt_id          VARCHAR2(38) ,
  mof_div_code        VARCHAR2(9) ,
  balance_bgt_id      VARCHAR2(38) not null,
  update_time         DATE ,
  is_deleted          VARCHAR2(1) ,
  create_time         DATE ,
  is_rec_exp          VARCHAR2(1) ,
  back_balance        NUMBER ,
  param_1             VARCHAR2(180),
  param_2             VARCHAR2(180),
  param_3             VARCHAR2(12),
  param_4             VARCHAR2(12),
  param_5             VARCHAR2(180),
  param_6             NUMBER,
  param_7             NUMBER,
  param_8             NUMBER,
  param_9             NUMBER,
  param_10            NUMBER,
  mof_div_name        VARCHAR2(100),
  fund_type_name      VARCHAR2(60),
  bgt_type_name       VARCHAR2(120),
  bgt_mof_dep_name    VARCHAR2(90),
  manage_mof_dep_name VARCHAR2(90),
  agency_name         VARCHAR2(300),
  exp_func_name       VARCHAR2(360),
  gov_bgt_eco_name    VARCHAR2(360),
  pro_name            VARCHAR2(180),
  budget_level_name   VARCHAR2(30),
  carryovers_bgt_id   VARCHAR2(38) ,
  is_gov_pur          VARCHAR2(1) ,
  is_track            VARCHAR2(1) 
);
-- Add comments to the table 
comment on table BA_BGT_BALANCE
  is '�����ʽ����ָ����Ϣ';
-- Add comments to the columns 
comment on column BA_BGT_BALANCE.fiscal_year
  is 'Ԥ�����';
comment on column BA_BGT_BALANCE.approve_amt
  is '������';
comment on column BA_BGT_BALANCE.balance
  is '������';
comment on column BA_BGT_BALANCE.bgt_type_code
  is 'ָ�����ʹ���';
comment on column BA_BGT_BALANCE.bgt_mof_dep_code
  is 'ָ������Ҵ���';
comment on column BA_BGT_BALANCE.manage_mof_dep_code
  is 'ҵ�����ܴ��Ҵ���';
comment on column BA_BGT_BALANCE.cor_bgt_doc_no
  is 'ָ���ĺ�';
comment on column BA_BGT_BALANCE.bgt_dec
  is 'ָ��˵��';
comment on column BA_BGT_BALANCE.agency_code
  is '��λ����';
comment on column BA_BGT_BALANCE.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_BALANCE.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column BA_BGT_BALANCE.fund_type_code
  is '�ʽ����ʴ���';
comment on column BA_BGT_BALANCE.bgt_exe_flag
  is 'ָ���ִ�б�־';
comment on column BA_BGT_BALANCE.pro_code
  is '��Ŀ����';
comment on column BA_BGT_BALANCE.budget_level_code
  is 'Ԥ�㼶�δ���';
comment on column BA_BGT_BALANCE.ori_bgt_id
  is 'Դָ������';
comment on column BA_BGT_BALANCE.mof_div_code
  is '������������';
comment on column BA_BGT_BALANCE.update_time
  is '����ʱ��';
comment on column BA_BGT_BALANCE.is_deleted
  is '�Ƿ�ɾ��';
comment on column BA_BGT_BALANCE.create_time
  is '����ʱ��';
comment on column BA_BGT_BALANCE.is_rec_exp
  is '�Ƿ���֧';
comment on column BA_BGT_BALANCE.back_balance
  is '�ջ���';
comment on column BA_BGT_BALANCE.mof_div_name
  is '������������';
comment on column BA_BGT_BALANCE.fund_type_name
  is '�ʽ���������';
comment on column BA_BGT_BALANCE.bgt_type_name
  is 'ָ����������';
comment on column BA_BGT_BALANCE.bgt_mof_dep_name
  is 'ָ�����������';
comment on column BA_BGT_BALANCE.manage_mof_dep_name
  is 'ҵ�����ܴ�������';
comment on column BA_BGT_BALANCE.agency_name
  is '��λ����';
comment on column BA_BGT_BALANCE.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_BALANCE.gov_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_BALANCE.pro_name
  is '��Ŀ����';
comment on column BA_BGT_BALANCE.budget_level_name
  is 'Ԥ�㼶������';
comment on column BA_BGT_BALANCE.carryovers_bgt_id
  is '����';
comment on column BA_BGT_BALANCE.is_gov_pur
  is '�Ƿ������ɹ�';
comment on column BA_BGT_BALANCE.is_track
  is '�Ƿ�׷��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_BALANCE
  add constraint PK_BA_BGT_BALANCE_ID primary key (CARRYOVERS_BGT_ID);
alter table BA_BGT_BALANCE
  add constraint UN_BA_BGT_BALANCE_ID unique (PRO_CODE, AGENCY_CODE, EXP_FUNC_CODE, GOV_BGT_ECO_CODE, FUND_TYPE_CODE);


/


--12.��λ�ʽ��תָ����Ϣ
-- Create table
create table BA_BGT_CARRYOVERS_AGENCY
(
  carryovers_bgt_id   VARCHAR2(38) not null,
  fiscal_year         VARCHAR2(4) ,
  approve_amt         NUMBER ,
  carryovers_amt      NUMBER ,
  bgt_type_code       VARCHAR2(50) ,
  bgt_type_name       VARCHAR2(120) ,
  bgt_mof_dep_code    VARCHAR2(6) ,
  bgt_mof_dep_name    VARCHAR2(90) ,
  manage_mof_dep_code VARCHAR2(6) ,
  manage_mof_dep_name VARCHAR2(90) ,
  cor_bgt_doc_no      VARCHAR2(100) ,
  bgt_dec             VARCHAR2(360) ,
  exp_func_code       VARCHAR2(13) ,
  exp_func_name       VARCHAR2(360) ,
  gov_bgt_eco_code    VARCHAR2(11) ,
  gov_bgt_eco_name    VARCHAR2(360) ,
  fund_type_code      VARCHAR2(10) ,
  fund_type_name      VARCHAR2(60) ,
  agency_code         VARCHAR2(21) ,
  agency_name         VARCHAR2(300) ,
  pro_code            VARCHAR2(21) ,
  pro_name            VARCHAR2(180) ,
  budget_level_code   VARCHAR2(1) ,
  budget_level_name   VARCHAR2(30) ,
  bgt_exe_flag        VARCHAR2(1) ,
  ori_bgt_id          VARCHAR2(38) ,
  mof_div_code        VARCHAR2(9) ,
  mof_div_name        VARCHAR2(100) ,
  is_gov_pur          VARCHAR2(1) ,
  is_track            VARCHAR2(1) ,
  is_deleted          VARCHAR2(1) ,
  update_time         DATE ,
  create_time         DATE ,
  param_1             VARCHAR2(180),
  param_2             VARCHAR2(180),
  param_3             VARCHAR2(12),
  param_4             VARCHAR2(12),
  param_5             VARCHAR2(180),
  param_6             NUMBER,
  param_7             NUMBER,
  param_8             NUMBER,
  param_9             NUMBER,
  param_10            NUMBER
);
-- Add comments to the table 
comment on table BA_BGT_CARRYOVERS_AGENCY
  is '��λ�ʽ��תָ����Ϣ';
-- Add comments to the columns 
comment on column BA_BGT_CARRYOVERS_AGENCY.carryovers_bgt_id
  is '����';
comment on column BA_BGT_CARRYOVERS_AGENCY.fiscal_year
  is 'Ԥ�����';
comment on column BA_BGT_CARRYOVERS_AGENCY.approve_amt
  is '������';
comment on column BA_BGT_CARRYOVERS_AGENCY.carryovers_amt
  is '��ת��';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_type_code
  is 'ָ�����ʹ���';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_type_name
  is 'ָ����������';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_mof_dep_code
  is 'ָ������Ҵ���';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_mof_dep_name
  is 'ָ�����������';
comment on column BA_BGT_CARRYOVERS_AGENCY.manage_mof_dep_code
  is 'ҵ�����ܴ��Ҵ���';
comment on column BA_BGT_CARRYOVERS_AGENCY.manage_mof_dep_name
  is 'ҵ�����ܴ�������';
comment on column BA_BGT_CARRYOVERS_AGENCY.cor_bgt_doc_no
  is 'ָ���ĺ�';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_dec
  is 'ָ��˵��';
comment on column BA_BGT_CARRYOVERS_AGENCY.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_CARRYOVERS_AGENCY.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_CARRYOVERS_AGENCY.gov_bgt_eco_code
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_CARRYOVERS_AGENCY.gov_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_CARRYOVERS_AGENCY.fund_type_code
  is '�ʽ����ʴ���';
comment on column BA_BGT_CARRYOVERS_AGENCY.fund_type_name
  is '�ʽ���������';
comment on column BA_BGT_CARRYOVERS_AGENCY.agency_code
  is '��λ����';
comment on column BA_BGT_CARRYOVERS_AGENCY.agency_name
  is '��λ����';
comment on column BA_BGT_CARRYOVERS_AGENCY.pro_code
  is '��Ŀ����';
comment on column BA_BGT_CARRYOVERS_AGENCY.pro_name
  is '��Ŀ����';
comment on column BA_BGT_CARRYOVERS_AGENCY.budget_level_code
  is 'Ԥ�㼶�δ���';
comment on column BA_BGT_CARRYOVERS_AGENCY.budget_level_name
  is 'Ԥ�㼶������';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_exe_flag
  is 'ָ���ִ�б�־';
comment on column BA_BGT_CARRYOVERS_AGENCY.ori_bgt_id
  is 'Դָ������';
comment on column BA_BGT_CARRYOVERS_AGENCY.mof_div_code
  is '������������';
comment on column BA_BGT_CARRYOVERS_AGENCY.mof_div_name
  is '������������';
comment on column BA_BGT_CARRYOVERS_AGENCY.is_gov_pur
  is '�Ƿ������ɹ�';
comment on column BA_BGT_CARRYOVERS_AGENCY.is_track
  is '�Ƿ�׷��';
comment on column BA_BGT_CARRYOVERS_AGENCY.is_deleted
  is '�Ƿ�ɾ��';
comment on column BA_BGT_CARRYOVERS_AGENCY.update_time
  is '����ʱ��';
comment on column BA_BGT_CARRYOVERS_AGENCY.create_time
  is '����ʱ��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_CARRYOVERS_AGENCY
  add constraint PK_BA_BGT_CARRYOVERS_AGENCY_ID primary key (CARRYOVERS_BGT_ID);
alter table BA_BGT_CARRYOVERS_AGENCY
  add constraint UN_BA_BGT_CARRYOVERS_AGENCY_ID unique (PRO_CODE, AGENCY_CODE, EXP_FUNC_CODE, GOV_BGT_ECO_CODE, FUND_TYPE_CODE);


--13.��λ�ʽ����ָ����Ϣ


-- Create table
create table BA_BGT_BALANCE_AGENCY
(
  balance_bgt_id      VARCHAR2(38) not null,
  fiscal_year         VARCHAR2(4) ,
  approve_amt         NUMBER ,
  carryovers_amt      NUMBER ,
  bgt_type_code       VARCHAR2(50) ,
  bgt_type_name       VARCHAR2(120) ,
  bgt_mof_dep_code    VARCHAR2(6) ,
  bgt_mof_dep_name    VARCHAR2(90) ,
  manage_mof_dep_code VARCHAR2(6) ,
  manage_mof_dep_name VARCHAR2(90) ,
  cor_bgt_doc_no      VARCHAR2(100) ,
  bgt_dec             VARCHAR2(360) ,
  agency_code         VARCHAR2(21) ,
  agency_name         VARCHAR2(300) ,
  exp_func_code       VARCHAR2(13) ,
  exp_func_name       VARCHAR2(360) ,
  gov_bgt_eco_code    VARCHAR2(11) ,
  gov_bgt_eco_name    VARCHAR2(360) ,
  fund_type_code      VARCHAR2(10) ,
  fund_type_name      VARCHAR2(60) ,
  bgt_exe_flag        VARCHAR2(1) ,
  pro_code            VARCHAR2(21) ,
  pro_name            VARCHAR2(180) ,
  budget_level_code   VARCHAR2(1) ,
  budget_level_name   VARCHAR2(30) ,
  ori_bgt_id          VARCHAR2(38) ,
  mof_div_code        VARCHAR2(9) ,
  mof_div_name        VARCHAR2(100) ,
  update_time         DATE ,
  is_deleted          VARCHAR2(1),
  create_time         DATE,
  param_1             VARCHAR2(180),
  param_2             VARCHAR2(180),
  param_3             VARCHAR2(12),
  param_4             VARCHAR2(12),
  param_5             VARCHAR2(180),
  param_6             NUMBER,
  param_7             NUMBER,
  param_8             NUMBER,
  param_9             NUMBER,
  param_10            NUMBER
);
-- Add comments to the table 
comment on table BA_BGT_BALANCE_AGENCY
  is '��λ�ʽ����ָ����Ϣ';
-- Add comments to the columns 
comment on column BA_BGT_BALANCE_AGENCY.balance_bgt_id
  is '����';
comment on column BA_BGT_BALANCE_AGENCY.fiscal_year
  is 'Ԥ�����';
comment on column BA_BGT_BALANCE_AGENCY.approve_amt
  is '������';
comment on column BA_BGT_BALANCE_AGENCY.carryovers_amt
  is '������';
comment on column BA_BGT_BALANCE_AGENCY.bgt_type_code
  is 'ָ�����ʹ���';
comment on column BA_BGT_BALANCE_AGENCY.bgt_type_name
  is 'ָ����������';
comment on column BA_BGT_BALANCE_AGENCY.bgt_mof_dep_code
  is 'ָ������Ҵ���';
comment on column BA_BGT_BALANCE_AGENCY.bgt_mof_dep_name
  is 'ָ�����������';
comment on column BA_BGT_BALANCE_AGENCY.manage_mof_dep_code
  is 'ҵ�����ܴ��Ҵ���';
comment on column BA_BGT_BALANCE_AGENCY.manage_mof_dep_name
  is 'ҵ�����ܴ�������';
comment on column BA_BGT_BALANCE_AGENCY.cor_bgt_doc_no
  is 'ָ���ĺ�';
comment on column BA_BGT_BALANCE_AGENCY.bgt_dec
  is 'ָ��˵��';
comment on column BA_BGT_BALANCE_AGENCY.agency_code
  is '��λ����';
comment on column BA_BGT_BALANCE_AGENCY.agency_name
  is '��λ����';
comment on column BA_BGT_BALANCE_AGENCY.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_BALANCE_AGENCY.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column BA_BGT_BALANCE_AGENCY.gov_bgt_eco_code
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_BALANCE_AGENCY.gov_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BA_BGT_BALANCE_AGENCY.fund_type_code
  is '�ʽ����ʴ���';
comment on column BA_BGT_BALANCE_AGENCY.fund_type_name
  is '�ʽ���������';
comment on column BA_BGT_BALANCE_AGENCY.bgt_exe_flag
  is 'ָ���ִ�б�־';
comment on column BA_BGT_BALANCE_AGENCY.pro_code
  is '��Ŀ����';
comment on column BA_BGT_BALANCE_AGENCY.pro_name
  is '��Ŀ����';
comment on column BA_BGT_BALANCE_AGENCY.budget_level_code
  is 'Ԥ�㼶�δ���';
comment on column BA_BGT_BALANCE_AGENCY.budget_level_name
  is 'Ԥ�㼶������';
comment on column BA_BGT_BALANCE_AGENCY.ori_bgt_id
  is 'Դָ������';
comment on column BA_BGT_BALANCE_AGENCY.mof_div_code
  is '������������';
comment on column BA_BGT_BALANCE_AGENCY.mof_div_name
  is '������������';
comment on column BA_BGT_BALANCE_AGENCY.update_time
  is '����ʱ��';
comment on column BA_BGT_BALANCE_AGENCY.is_deleted
  is '�Ƿ�ɾ��';
comment on column BA_BGT_BALANCE_AGENCY.create_time
  is '����ʱ��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_BALANCE_AGENCY
  add constraint PK_BA_BGT_BALANCE_AGENCY_ID primary key (BALANCE_BGT_ID);
alter table BA_BGT_BALANCE_AGENCY
  add constraint UN_BA_BGT_BALANCE_AGENCY_ID unique (PRO_CODE, AGENCY_CODE, EXP_FUNC_CODE, GOV_BGT_ECO_CODE, FUND_TYPE_CODE);

/

--14.��˰һ��ɿ���
-- Create table
create table NON_TAX_PAY
(
  nt_pay_voucher_id    VARCHAR2(38) not null,
  non_tax_pay_code     VARCHAR2(100) ,
  mof_div_code         VARCHAR2(9) ,
  mof_div_name         VARCHAR2(360) ,
  exec_agency_code     VARCHAR2(21) ,
  exec_agency_name     VARCHAR2(300) ,
  non_tax_pay_no       VARCHAR2(100) ,
  author               VARCHAR2(120) ,
  bill_date            DATE ,
  eff_date             DATE,
  payer_name           VARCHAR2(300) ,
  payer_acc_no         VARCHAR2(40),
  payer_open_bank      VARCHAR2(180),
  act_payer_name       VARCHAR2(300),
  act_payer_acc_no     VARCHAR2(40),
  act_payer_open_bank  VARCHAR2(180),
  total_pay_amt        NUMBER ,
  pay_amt              NUMBER ,
  delay_amt            NUMBER,
  paid_amt             NUMBER,
  rec_accttype         VARCHAR2(1) ,
  payee_acct_name      VARCHAR2(300) ,
  payee_acct_no        VARCHAR2(40),
  payee_acct_bank_name VARCHAR2(180),
  payee_acct_bank_code VARCHAR2(12) ,
  pay_date             DATE,
  pay_way_code         VARCHAR2(2),
  pay_way_name         VARCHAR2(20),
  belong_org_code      VARCHAR2(9) ,
  belong_org_name      VARCHAR2(100) ,
  record_date          DATE,
  pay_in_met_code      VARCHAR2(1) ,
  pay_in_met_name      VARCHAR2(60) ,
  bus_type             VARCHAR2(2) ,
  update_time          DATE ,
  is_deleted           VARCHAR2(1) ,
  create_time          DATE ,
  hold1                VARCHAR2(300),
  hold2                VARCHAR2(300)
);
-- Add comments to the table 
comment on table NON_TAX_PAY
  is '��˰һ��ɿ���';
-- Add comments to the columns 
comment on column NON_TAX_PAY.nt_pay_voucher_id
  is '�ɿ�������';
comment on column NON_TAX_PAY.non_tax_pay_code
  is '������˰����ɿ�ʶ����';
comment on column NON_TAX_PAY.mof_div_code
  is '������������';
comment on column NON_TAX_PAY.mof_div_name
  is '������������';
comment on column NON_TAX_PAY.exec_agency_code
  is 'ִ�յ�λ����';
comment on column NON_TAX_PAY.exec_agency_name
  is 'ִ�յ�λ����';
comment on column NON_TAX_PAY.non_tax_pay_no
  is '������˰����һ��ɿ���Ʊ��';
comment on column NON_TAX_PAY.author
  is '��Ʊ��';
comment on column NON_TAX_PAY.bill_date
  is '��Ʊ����';
comment on column NON_TAX_PAY.eff_date
  is '�ɿ�����Ч��';
comment on column NON_TAX_PAY.payer_name
  is '�ɿ���ȫ��';
comment on column NON_TAX_PAY.payer_acc_no
  is '�ɿ����˺�';
comment on column NON_TAX_PAY.payer_open_bank
  is '�ɿ��˿�������';
comment on column NON_TAX_PAY.act_payer_name
  is 'ʵ�ʽɿ���ȫ��';
comment on column NON_TAX_PAY.act_payer_acc_no
  is 'ʵ�ʽɿ����˺�';
comment on column NON_TAX_PAY.act_payer_open_bank
  is 'ʵ�ʽɿ��˿�������';
comment on column NON_TAX_PAY.total_pay_amt
  is 'Ӧ�ɽ��ϼ�';
comment on column NON_TAX_PAY.pay_amt
  is 'Ӧ�ɽ��';
comment on column NON_TAX_PAY.delay_amt
  is '���ɽ���';
comment on column NON_TAX_PAY.paid_amt
  is '�ɿ���';
comment on column NON_TAX_PAY.rec_accttype
  is '�տ��˻�����';
comment on column NON_TAX_PAY.payee_acct_name
  is '�տ���ȫ��';
comment on column NON_TAX_PAY.payee_acct_no
  is '�տ����˺�';
comment on column NON_TAX_PAY.payee_acct_bank_name
  is '�տ��˿�������';
comment on column NON_TAX_PAY.payee_acct_bank_code
  is '�տ����д���';
comment on column NON_TAX_PAY.pay_date
  is '�ɿ�����';
comment on column NON_TAX_PAY.pay_way_code
  is '�ɿ���������';
comment on column NON_TAX_PAY.pay_way_name
  is '�ɿ���������';
comment on column NON_TAX_PAY.belong_org_code
  is '�����������';
comment on column NON_TAX_PAY.belong_org_name
  is '���������������';
comment on column NON_TAX_PAY.record_date
  is '��������';
comment on column NON_TAX_PAY.pay_in_met_code
  is '�սɷ�ʽ����';
comment on column NON_TAX_PAY.pay_in_met_name
  is '�սɷ�ʽ����';
comment on column NON_TAX_PAY.bus_type
  is '��˰��������';
comment on column NON_TAX_PAY.update_time
  is '����ʱ��';
comment on column NON_TAX_PAY.is_deleted
  is '�Ƿ�ɾ��';
comment on column NON_TAX_PAY.create_time
  is '����ʱ�� ';
comment on column NON_TAX_PAY.hold1
  is '�����ֶ�1';
comment on column NON_TAX_PAY.hold2
  is '�����ֶ�2';
-- Create/Recreate primary, unique and foreign key constraints 
alter table NON_TAX_PAY
  add constraint PK_NON_TAX_PAY_ID primary key (NT_PAY_VOUCHER_ID);


/

--15.��˰һ��ɿ�������
-- Create table
create table NON_TAX_PAY_DETAIL
(
  sort_no           VARCHAR2(38) not null,
  nt_pay_voucher_id VARCHAR2(38) ,
  non_tax_proj_code VARCHAR2(12) ,
  non_tax_code      VARCHAR2(20) ,
  non_tax_name      VARCHAR2(240) ,
  charge_stand_name VARCHAR2(300) ,
  fund_type_code    VARCHAR2(3) ,
  fund_type_name    VARCHAR2(60) ,
  charge_stand_unit VARCHAR2(10) ,
  pay_number        VARCHAR2(2) ,
  pay_amt           NUMBER ,
  update_time       DATE ,
  is_deleted        VARCHAR2(1) ,
  create_time       DATE ,
  hold1             VARCHAR2(300),
  hold2             VARCHAR2(300),
  hold3             VARCHAR2(300),
  hold4             VARCHAR2(300)
);
-- Add comments to the table 
comment on table NON_TAX_PAY_DETAIL
  is '��˰һ��ɿ�������';
-- Add comments to the columns 
comment on column NON_TAX_PAY_DETAIL.sort_no
  is '���';
comment on column NON_TAX_PAY_DETAIL.nt_pay_voucher_id
  is '�ɿ�������';
comment on column NON_TAX_PAY_DETAIL.non_tax_proj_code
  is '������˰����ִ����Ŀʶ����';
comment on column NON_TAX_PAY_DETAIL.non_tax_code
  is '������˰����ִ����Ŀ����';
comment on column NON_TAX_PAY_DETAIL.non_tax_name
  is '������˰����ִ����Ŀ����';
comment on column NON_TAX_PAY_DETAIL.charge_stand_name
  is '�սɱ�׼����';
comment on column NON_TAX_PAY_DETAIL.fund_type_code
  is '�ʽ����ʴ���';
comment on column NON_TAX_PAY_DETAIL.fund_type_name
  is '�ʽ���������';
comment on column NON_TAX_PAY_DETAIL.charge_stand_unit
  is '�սɱ�׼������λ';
comment on column NON_TAX_PAY_DETAIL.pay_number
  is 'ִ������';
comment on column NON_TAX_PAY_DETAIL.pay_amt
  is '�ɿ���';
comment on column NON_TAX_PAY_DETAIL.update_time
  is '����ʱ��';
comment on column NON_TAX_PAY_DETAIL.is_deleted
  is '�Ƿ�ɾ��';
comment on column NON_TAX_PAY_DETAIL.create_time
  is '����ʱ�� ';
comment on column NON_TAX_PAY_DETAIL.hold1
  is '�����ֶ�1';
comment on column NON_TAX_PAY_DETAIL.hold2
  is '�����ֶ�2';
comment on column NON_TAX_PAY_DETAIL.hold3
  is '�����ֶ�3';
comment on column NON_TAX_PAY_DETAIL.hold4
  is '�����ֶ�4';
-- Create/Recreate primary, unique and foreign key constraints 
alter table NON_TAX_PAY_DETAIL
  add constraint PK_NON_TAX_PAY_DETAIL_ID primary key (SORT_NO);

/

--16.��˰�˸�����
-- Create table
create table PAY_BACK_INFO
(
  ref_id                  VARCHAR2(38) not null,
  payback_type_code       VARCHAR2(1) ,
  mof_div_code            VARCHAR2(9) ,
  fiscal_year             VARCHAR2(4) ,
  exec_agency_code        VARCHAR2(21) ,
  ref_reason              VARCHAR2(100) ,
  non_tax_pay_no          VARCHAR2(100),
  non_tax_pay_code        VARCHAR2(100),
  ref_amt                 NUMBER ,
  payback_receiver_name   VARCHAR2(300) ,
  payback_receiver_acc_no VARCHAR2(40) ,
  payback_recbank_name    VARCHAR2(180) ,
  payback_bank_no         VARCHAR2(14) ,
  payback_acc_name        VARCHAR2(300),
  payback_acc_no          VARCHAR2(40),
  payback_accbank_name    VARCHAR2(180),
  ref_no                  VARCHAR2(100) ,
  ref_date                DATE ,
  update_time             DATE ,
  create_time             DATE ,
  non_tax_code            VARCHAR2(20) ,
  non_tax_name            VARCHAR2(240) ,
  hold1                   VARCHAR2(300),
  hold2                   VARCHAR2(300)
);
-- Add comments to the table 
comment on table PAY_BACK_INFO
  is '��˰�˸�����';
-- Add comments to the columns 
comment on column PAY_BACK_INFO.ref_id
  is '�˸�����������';
comment on column PAY_BACK_INFO.payback_type_code
  is '�˸����ʹ���';
comment on column PAY_BACK_INFO.mof_div_code
  is '������������';
comment on column PAY_BACK_INFO.fiscal_year
  is 'Ԥ�����';
comment on column PAY_BACK_INFO.exec_agency_code
  is 'ִ�յ�λ����';
comment on column PAY_BACK_INFO.ref_reason
  is '�˸�ԭ��';
comment on column PAY_BACK_INFO.non_tax_pay_no
  is 'ԭ��˰����һ��ɿ���Ʊ��';
comment on column PAY_BACK_INFO.non_tax_pay_code
  is 'ԭ��˰����һ��ɿ���ɿ�ʶ����';
comment on column PAY_BACK_INFO.ref_amt
  is '�˸����';
comment on column PAY_BACK_INFO.payback_receiver_name
  is '�˸��տ���ȫ��';
comment on column PAY_BACK_INFO.payback_receiver_acc_no
  is '�˸��տ����˺�';
comment on column PAY_BACK_INFO.payback_recbank_name
  is '�˸��տ��˿�������';
comment on column PAY_BACK_INFO.payback_bank_no
  is '�˿��տ��˻������к�';
comment on column PAY_BACK_INFO.payback_acc_name
  is '�˸��˻�ȫ��';
comment on column PAY_BACK_INFO.payback_acc_no
  is '�˸��˻��˺�';
comment on column PAY_BACK_INFO.payback_accbank_name
  is '�˸��˻�������������';
comment on column PAY_BACK_INFO.ref_no
  is '�˸������鵥��';
comment on column PAY_BACK_INFO.ref_date
  is '�˸�����';
comment on column PAY_BACK_INFO.update_time
  is '����ʱ��';
comment on column PAY_BACK_INFO.create_time
  is '����ʱ��';
comment on column PAY_BACK_INFO.non_tax_code
  is '������˰����ִ����Ŀ����';
comment on column PAY_BACK_INFO.non_tax_name
  is '������˰����ִ����Ŀ����';
comment on column PAY_BACK_INFO.hold1
  is '�����ֶ�1';
comment on column PAY_BACK_INFO.hold2
  is '�����ֶ�2';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_BACK_INFO
  add constraint PK_PAY_BACK_INFO_ID primary key (REF_ID);

/

--17.�ÿ�ƻ���Ϣ

-- Create table
create table PAY_PLAN_VOUCHER
(
  plan_id             VARCHAR2(38) not null,
  fiscal_year         VARCHAR2(4) ,
  mof_div_code        VARCHAR2(9) ,
  mof_div_name        VARCHAR2(360) ,
  plan_voucher_no     VARCHAR2(100) ,
  plan_month          VARCHAR2(2) ,
  agency_code         VARCHAR2(21) ,
  agency_name         VARCHAR2(300) ,
  fund_type_code      VARCHAR2(10) ,
  fund_type_name      VARCHAR2(60) ,
  plan_app_amt        NUMBER ,
  plan_amt            NUMBER ,
  bond_code           VARCHAR2(38),
  bond_name           VARCHAR2(200),
  update_time         DATE ,
  is_deleted          VARCHAR2(1) ,
  create_time         DATE ,
  bgt_id              VARCHAR2(38),
  bgt_dept_code       VARCHAR2(30),
  bgt_dept_name       VARCHAR2(150),
  bgt_mof_dep_code    VARCHAR2(6),
  bgt_mof_dep_name    VARCHAR2(90),
  manage_mof_dep_code VARCHAR2(6),
  manage_mof_dep_name VARCHAR2(90),
  bgt_type_code       VARCHAR2(50),
  bgt_type_name       VARCHAR2(20),
  exp_func_code       VARCHAR2(13),
  exp_func_name       VARCHAR2(360),
  gov_bgt_eco_code    VARCHAR2(11),
  gov_bgt_eco_name    VARCHAR2(360),
  dep_bgt_eco_code    VARCHAR2(20),
  dep_bgt_eco_name    VARCHAR2(360),
  pro_code            VARCHAR2(21),
  pro_name            VARCHAR2(180),
  pay_type_code       VARCHAR2(2),
  pay_type_name       VARCHAR2(120),
  use_des             VARCHAR2(300)
);
-- Add comments to the table 
comment on table PAY_PLAN_VOUCHER
  is '��˰�˸�����';
-- Add comments to the columns 
comment on column PAY_PLAN_VOUCHER.plan_id
  is '�ÿ�ƻ�����';
comment on column PAY_PLAN_VOUCHER.fiscal_year
  is 'Ԥ�����';
comment on column PAY_PLAN_VOUCHER.mof_div_code
  is '������������';
comment on column PAY_PLAN_VOUCHER.mof_div_name
  is '������������';
comment on column PAY_PLAN_VOUCHER.plan_voucher_no
  is '�ƻ���ϸ���';
comment on column PAY_PLAN_VOUCHER.plan_month
  is '�ƻ��·�';
comment on column PAY_PLAN_VOUCHER.agency_code
  is '��λ����';
comment on column PAY_PLAN_VOUCHER.agency_name
  is '��λ����';
comment on column PAY_PLAN_VOUCHER.fund_type_code
  is '�ʽ����ʴ���';
comment on column PAY_PLAN_VOUCHER.fund_type_name
  is '�ʽ���������';
comment on column PAY_PLAN_VOUCHER.plan_app_amt
  is '�ƻ�������';
comment on column PAY_PLAN_VOUCHER.plan_amt
  is '�ƻ��������';
comment on column PAY_PLAN_VOUCHER.bond_code
  is 'ծȯ����';
comment on column PAY_PLAN_VOUCHER.bond_name
  is 'ծȯ����';
comment on column PAY_PLAN_VOUCHER.update_time
  is '����ʱ��';
comment on column PAY_PLAN_VOUCHER.is_deleted
  is '�Ƿ�ɾ��';
comment on column PAY_PLAN_VOUCHER.create_time
  is '����ʱ�� ';
comment on column PAY_PLAN_VOUCHER.bgt_id
  is 'ָ������';
comment on column PAY_PLAN_VOUCHER.bgt_dept_code
  is 'Ԥ�㲿�Ŵ���';
comment on column PAY_PLAN_VOUCHER.bgt_dept_name
  is 'Ԥ�㲿������';
comment on column PAY_PLAN_VOUCHER.bgt_mof_dep_code
  is 'ָ�����';
comment on column PAY_PLAN_VOUCHER.bgt_mof_dep_name
  is 'ָ���������';
comment on column PAY_PLAN_VOUCHER.manage_mof_dep_code
  is 'ҵ�����ܴ�';
comment on column PAY_PLAN_VOUCHER.manage_mof_dep_name
  is 'ҵ�����ܴ�����';
comment on column PAY_PLAN_VOUCHER.bgt_type_code
  is 'ָ�����ʹ���';
comment on column PAY_PLAN_VOUCHER.bgt_type_name
  is 'ָ����������';
comment on column PAY_PLAN_VOUCHER.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column PAY_PLAN_VOUCHER.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column PAY_PLAN_VOUCHER.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column PAY_PLAN_VOUCHER.gov_bgt_eco_name
  is '����֧�����÷�������';
comment on column PAY_PLAN_VOUCHER.dep_bgt_eco_code
  is '����֧�����÷������';
comment on column PAY_PLAN_VOUCHER.dep_bgt_eco_name
  is '����֧�����÷�������';
comment on column PAY_PLAN_VOUCHER.pro_code
  is '��Ŀ����';
comment on column PAY_PLAN_VOUCHER.pro_name
  is '��Ŀ����';
comment on column PAY_PLAN_VOUCHER.pay_type_code
  is '֧����ʽ����';
comment on column PAY_PLAN_VOUCHER.pay_type_name
  is '֧����ʽ����';
comment on column PAY_PLAN_VOUCHER.use_des
  is '��;';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_PLAN_VOUCHER
  add constraint PK_PAY_PLAN_VOUCHER_ID primary key (PLAN_ID);
/

--18.����Ԥ����Ŀ���Ԥ�����Ϣ
create table BGT_PM_ANNUAL_ZK
(
  bz                  VARCHAR2(4000),
  dataversion         VARCHAR2(32),
  groupkey            VARCHAR2(32),
  isleaf              NUMBER(9) default 0,
  levelno             NUMBER(9) default 0,
  ordernum            NUMBER(12) default 0,
  stage               VARCHAR2(32),
  superguid           VARCHAR2(32),
  taskguid            VARCHAR2(32),
  templateguid        VARCHAR2(50),
  vchtypeid           VARCHAR2(255),
  version             NUMBER(12) default 0,
  fiscal_year         VARCHAR2(4),
  agency_code         VARCHAR2(21),
  pro_kind_code       VARCHAR2(4),
  pro_code            VARCHAR2(21),
  exp_func_code       VARCHAR2(13),
  gov_bgt_eco_code    VARCHAR2(11),
  dep_bgt_eco_code    VARCHAR2(20),
  fund_type_code      VARCHAR2(4),
  apply_up            NUMBER(20,2) default 0,
  fin_audit_money     NUMBER(20,2) default 0,
  dept_code           VARCHAR2(21),
  manage_mof_dep_code VARCHAR2(6),
  update_time         DATE,
  apply_link          VARCHAR2(1),
  reply_amt           NUMBER(20,2) default 0,
  adj_amt             NUMBER(20,2) default 0,
  dis_amt             NUMBER(20,2) default 0,
  cur_amt             NUMBER(20,2) default 0,
  is_deleted          NUMBER(1) default 0,
  budget_level_code   VARCHAR2(1),
  found_type_code     VARCHAR2(6),
  create_time         DATE,
  pro_name            VARCHAR2(255),
  agency_guid         VARCHAR2(255),
  pro_kind_name       VARCHAR2(255),
  finintorg_guid      VARCHAR2(255),
  is_govpurch         VARCHAR2(255),
  is_construction     VARCHAR2(255),
  busiorg_guid        VARCHAR2(32),
  agency_type         VARCHAR2(32),
  prodetailinfo       VARCHAR2(32),
  mof_div_code        VARCHAR2(9),
  bgt_pman_id         VARCHAR2(38) not null,
  batchno             VARCHAR2(32),
  exp_func_guid       VARCHAR2(32),
  xs                  VARCHAR2(20) default 1,
  dep_bgt_eco_guid    VARCHAR2(32),
  is_govserve         VARCHAR2(32),
  ismx                VARCHAR2(2),
  zxmc                VARCHAR2(32),
  amtcol              VARCHAR2(32),
  remark              VARCHAR2(4000),
  bgt_pro_type        VARCHAR2(2),
  srcguid             VARCHAR2(50),
  per_release_reason  VARCHAR2(4000),
  get_status          VARCHAR2(1),
  approval_file_no    VARCHAR2(500),
  busi_type_code      VARCHAR2(6) default 2,
  param_1             VARCHAR2(180),
  param_10            NUMBER,
  param_2             VARCHAR2(180),
  param_3             VARCHAR2(12),
  param_4             VARCHAR2(12),
  param_5             VARCHAR2(180),
  param_6             NUMBER,
  param_7             NUMBER,
  param_8             NUMBER,
  param_9             NUMBER,
  agency_name         VARCHAR2(300),
  budget_level_name   VARCHAR2(30),
  dept_name           VARCHAR2(300),
  exp_func_name       VARCHAR2(360),
  found_type_name     VARCHAR2(30),
  fund_type_name      VARCHAR2(60),
  gov_bgt_eco_name    VARCHAR2(360),
  is_assigned         VARCHAR2(1),
  manage_mof_dep_name VARCHAR2(90),
  mof_div_name        VARCHAR2(100),
  dep_bgt_eco_name    VARCHAR2(360),
  is_bgt_end          VARCHAR2(1),
  is_gov_pur          VARCHAR2(1)
);
-- Add comments to the table 
comment on table BGT_PM_ANNUAL_ZK
  is '����Ԥ����Ŀ���Ԥ���';
-- Add comments to the columns 
comment on column BGT_PM_ANNUAL_ZK.bz
  is '��ע';
comment on column BGT_PM_ANNUAL_ZK.dataversion
  is '�汾';
comment on column BGT_PM_ANNUAL_ZK.groupkey
  is '�����ʶ';
comment on column BGT_PM_ANNUAL_ZK.isleaf
  is 'Ҷ�ӽڵ�';
comment on column BGT_PM_ANNUAL_ZK.levelno
  is '����';
comment on column BGT_PM_ANNUAL_ZK.ordernum
  is '�����ֶ�';
comment on column BGT_PM_ANNUAL_ZK.stage
  is '�׶�';
comment on column BGT_PM_ANNUAL_ZK.superguid
  is '��GUID';
comment on column BGT_PM_ANNUAL_ZK.taskguid
  is '����guid';
comment on column BGT_PM_ANNUAL_ZK.templateguid
  is 'ģ������';
comment on column BGT_PM_ANNUAL_ZK.vchtypeid
  is 'VCHTYPEID';
comment on column BGT_PM_ANNUAL_ZK.version
  is '�汾';
comment on column BGT_PM_ANNUAL_ZK.fiscal_year
  is 'Ԥ�����';
comment on column BGT_PM_ANNUAL_ZK.agency_code
  is '��λ����';
comment on column BGT_PM_ANNUAL_ZK.pro_kind_code
  is '��Ŀ������';
comment on column BGT_PM_ANNUAL_ZK.pro_code
  is '��Ŀ����';
comment on column BGT_PM_ANNUAL_ZK.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column BGT_PM_ANNUAL_ZK.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column BGT_PM_ANNUAL_ZK.dep_bgt_eco_code
  is '����֧�����÷������';
comment on column BGT_PM_ANNUAL_ZK.fund_type_code
  is '�ʽ����ʴ���';
comment on column BGT_PM_ANNUAL_ZK.apply_up
  is '�걨��';
comment on column BGT_PM_ANNUAL_ZK.fin_audit_money
  is '���������';
comment on column BGT_PM_ANNUAL_ZK.dept_code
  is '���Ŵ���';
comment on column BGT_PM_ANNUAL_ZK.manage_mof_dep_code
  is 'ҵ�����ܴ��Ҵ���';
comment on column BGT_PM_ANNUAL_ZK.update_time
  is '����ʱ��';
comment on column BGT_PM_ANNUAL_ZK.apply_link
  is '�걨����';
comment on column BGT_PM_ANNUAL_ZK.reply_amt
  is '���������';
comment on column BGT_PM_ANNUAL_ZK.adj_amt
  is '�������';
comment on column BGT_PM_ANNUAL_ZK.dis_amt
  is '�������';
comment on column BGT_PM_ANNUAL_ZK.cur_amt
  is '�䶯��Ԥ����';
comment on column BGT_PM_ANNUAL_ZK.is_deleted
  is '�Ƿ�ɾ��';
comment on column BGT_PM_ANNUAL_ZK.budget_level_code
  is 'Ԥ�㼶�δ���';
comment on column BGT_PM_ANNUAL_ZK.found_type_code
  is '�ʽ���Դ����';
comment on column BGT_PM_ANNUAL_ZK.create_time
  is '����ʱ��';
comment on column BGT_PM_ANNUAL_ZK.pro_name
  is '��Ŀ����';
comment on column BGT_PM_ANNUAL_ZK.agency_guid
  is '��λ����';
comment on column BGT_PM_ANNUAL_ZK.pro_kind_name
  is '��Ŀ�������';
comment on column BGT_PM_ANNUAL_ZK.finintorg_guid
  is '�����ڲ�����';
comment on column BGT_PM_ANNUAL_ZK.is_govpurch
  is '�Ƿ������ɹ�';
comment on column BGT_PM_ANNUAL_ZK.is_construction
  is '�Ƿ����';
comment on column BGT_PM_ANNUAL_ZK.busiorg_guid
  is '��ڴ���';
comment on column BGT_PM_ANNUAL_ZK.agency_type
  is '��λ���';
comment on column BGT_PM_ANNUAL_ZK.prodetailinfo
  is '��Ŀ��ϸ��Ϣ';
comment on column BGT_PM_ANNUAL_ZK.mof_div_code
  is '������������';
comment on column BGT_PM_ANNUAL_ZK.bgt_pman_id
  is '��Ŀ���Ԥ������';
comment on column BGT_PM_ANNUAL_ZK.batchno
  is '���κ�';
comment on column BGT_PM_ANNUAL_ZK.exp_func_guid
  is '֧�����ܷ����Ŀ';
comment on column BGT_PM_ANNUAL_ZK.xs
  is 'ϵ��';
comment on column BGT_PM_ANNUAL_ZK.dep_bgt_eco_guid
  is '����֧�����÷���';
comment on column BGT_PM_ANNUAL_ZK.is_govserve
  is '�Ƿ���������';
comment on column BGT_PM_ANNUAL_ZK.agency_name
  is '��λ����';
comment on column BGT_PM_ANNUAL_ZK.budget_level_name
  is 'Ԥ�㼶������';
comment on column BGT_PM_ANNUAL_ZK.dept_name
  is '��������';
comment on column BGT_PM_ANNUAL_ZK.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column BGT_PM_ANNUAL_ZK.found_type_name
  is '�ʽ���Դ����';
comment on column BGT_PM_ANNUAL_ZK.fund_type_name
  is '�ʽ���������';
comment on column BGT_PM_ANNUAL_ZK.gov_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BGT_PM_ANNUAL_ZK.is_assigned
  is '�Ƿ����������֧��';
comment on column BGT_PM_ANNUAL_ZK.manage_mof_dep_name
  is 'ҵ�����������';
comment on column BGT_PM_ANNUAL_ZK.mof_div_name
  is '������������';
comment on column BGT_PM_ANNUAL_ZK.dep_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BGT_PM_ANNUAL_ZK.is_bgt_end
  is '�Ƿ����';
comment on column BGT_PM_ANNUAL_ZK.is_gov_pur
  is '�Ƿ������ɹ�';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BGT_PM_ANNUAL_ZK
  add primary key (BGT_PMAN_ID);
  
  
----19.����ת��֧�����Ԥ������������Ϣ
/
create table BGT_TRA_ZK
(
  batchno             VARCHAR2(32),
  dataversion         VARCHAR2(32),
  taskguid            VARCHAR2(32),
  preset              VARCHAR2(32),
  stage               VARCHAR2(32),
  dpt                 VARCHAR2(32),
  version             NUMBER(12) default 0,
  bgt_pman_id         VARCHAR2(38) not null,
  mof_div_code        VARCHAR2(9),
  fiscal_year         VARCHAR2(4),
  agency_guid         VARCHAR2(32),
  agency_code         VARCHAR2(21),
  pro_kind            VARCHAR2(32),
  pro_kind_code       VARCHAR2(4),
  pro_code            VARCHAR2(21),
  pro_name            VARCHAR2(255),
  exp_func            VARCHAR2(32),
  exp_func_code       VARCHAR2(13),
  tp_func             VARCHAR2(32),
  tp_func_code        VARCHAR2(13),
  sub_mof_div         VARCHAR2(32),
  sub_mof_div_code    VARCHAR2(9),
  gov_bgt_eco         VARCHAR2(32),
  gov_bgt_eco_code    VARCHAR2(11),
  fund_type           VARCHAR2(32),
  fund_type_code      VARCHAR2(4),
  apply_up            NUMBER(20,2) default 0,
  fin_audit_money     NUMBER(20,2) default 0,
  dept_code           VARCHAR2(21),
  manage_mof_dep_code VARCHAR2(6),
  update_time         DATE,
  apply_link          VARCHAR2(1),
  reply_amt           NUMBER(20,2) default 0,
  adj_amt             NUMBER(20,2) default 0,
  dis_amt             NUMBER(20,2) default 0,
  cur_amt             NUMBER(20,2) default 0,
  is_deleted          NUMBER(1) default 2,
  budget_level_code   VARCHAR2(1),
  found_type_code     VARCHAR2(6),
  create_time         DATE,
  agency_type         VARCHAR2(32),
  tra_type            VARCHAR2(32),
  isleaf              NUMBER(9) default 0,
  levelno             NUMBER(9) default 0,
  exp_eco             VARCHAR2(32),
  exp_eco_code        VARCHAR2(255),
  promaininfo         VARCHAR2(32),
  super_tra           VARCHAR2(32),
  templateguid        VARCHAR2(32),
  prodetailinfo       VARCHAR2(32),
  isgovpurch          VARCHAR2(32),
  isconstruction      VARCHAR2(32),
  remark              VARCHAR2(2000),
  ordernum            NUMBER(12) default 0,
  per_release_reason  VARCHAR2(4000),
  get_status          VARCHAR2(1),
  approval_file_no    VARCHAR2(500),
  busi_type_code      VARCHAR2(6) default 2,
  agency_name         VARCHAR2(300),
  budget_level_name   VARCHAR2(30),
  dept_name           VARCHAR2(300),
  exp_func_name       VARCHAR2(360),
  found_type_name     VARCHAR2(30),
  fund_type_name      VARCHAR2(60),
  gov_bgt_eco_name    VARCHAR2(360),
  is_assigned         VARCHAR2(1),
  manage_mof_dep_name VARCHAR2(90),
  mof_div_name        VARCHAR2(100),
  param_1             VARCHAR2(180),
  param_10            NUMBER,
  param_2             VARCHAR2(180),
  param_3             VARCHAR2(12),
  param_4             VARCHAR2(12),
  param_5             VARCHAR2(180),
  param_6             NUMBER,
  param_7             NUMBER,
  param_8             NUMBER,
  param_9             NUMBER,
  sub_mof_div_name    VARCHAR2(100),
  tp_func_name        VARCHAR2(360)
);
-- Add comments to the columns 
comment on column BGT_TRA_ZK.batchno
  is '�汾';
comment on column BGT_TRA_ZK.dataversion
  is '����ʱ��';
comment on column BGT_TRA_ZK.taskguid
  is '����';
comment on column BGT_TRA_ZK.preset
  is 'Ԥ���ֶ�';
comment on column BGT_TRA_ZK.stage
  is '�׶�';
comment on column BGT_TRA_ZK.dpt
  is 'DPT';
comment on column BGT_TRA_ZK.version
  is '�汾';
comment on column BGT_TRA_ZK.bgt_pman_id
  is '��Ŀ���Ԥ������';
comment on column BGT_TRA_ZK.mof_div_code
  is '������������';
comment on column BGT_TRA_ZK.fiscal_year
  is 'Ԥ�����';
comment on column BGT_TRA_ZK.agency_guid
  is '��λ����';
comment on column BGT_TRA_ZK.agency_code
  is '��λ����';
comment on column BGT_TRA_ZK.pro_kind
  is '��Ŀ�������';
comment on column BGT_TRA_ZK.pro_kind_code
  is '��Ŀ������';
comment on column BGT_TRA_ZK.pro_code
  is '��Ŀ����';
comment on column BGT_TRA_ZK.pro_name
  is '��Ŀ����';
comment on column BGT_TRA_ZK.exp_func
  is '���ܿ�Ŀ����';
comment on column BGT_TRA_ZK.exp_func_code
  is '֧�����ܷ����Ŀ����';
comment on column BGT_TRA_ZK.tp_func
  is 'ת��֧�����ܿ�Ŀ����';
comment on column BGT_TRA_ZK.tp_func_code
  is 'ת��֧�����ܷ����Ŀ����';
comment on column BGT_TRA_ZK.sub_mof_div
  is '�´�����';
comment on column BGT_TRA_ZK.sub_mof_div_code
  is '�¼�������������';
comment on column BGT_TRA_ZK.gov_bgt_eco
  is '����֧�����÷�������';
comment on column BGT_TRA_ZK.gov_bgt_eco_code
  is '����֧�����÷������';
comment on column BGT_TRA_ZK.fund_type
  is '�ʽ�����';
comment on column BGT_TRA_ZK.fund_type_code
  is '�ʽ����ʴ���';
comment on column BGT_TRA_ZK.apply_up
  is '�걨��';
comment on column BGT_TRA_ZK.fin_audit_money
  is '���������';
comment on column BGT_TRA_ZK.dept_code
  is '���Ŵ���';
comment on column BGT_TRA_ZK.manage_mof_dep_code
  is 'ҵ�����ܴ��Ҵ���';
comment on column BGT_TRA_ZK.update_time
  is '����ʱ��';
comment on column BGT_TRA_ZK.apply_link
  is '�걨����';
comment on column BGT_TRA_ZK.reply_amt
  is '���������';
comment on column BGT_TRA_ZK.adj_amt
  is '�������';
comment on column BGT_TRA_ZK.dis_amt
  is '�������';
comment on column BGT_TRA_ZK.cur_amt
  is '�䶯��Ԥ����';
comment on column BGT_TRA_ZK.is_deleted
  is '�Ƿ�ɾ��';
comment on column BGT_TRA_ZK.budget_level_code
  is 'Ԥ�㼶�δ���';
comment on column BGT_TRA_ZK.found_type_code
  is '�ʽ���Դ����';
comment on column BGT_TRA_ZK.create_time
  is '����ʱ��';
comment on column BGT_TRA_ZK.agency_type
  is '��λ���';
comment on column BGT_TRA_ZK.tra_type
  is 'ת��֧������';
comment on column BGT_TRA_ZK.isleaf
  is 'Ҷ�ӽڵ�';
comment on column BGT_TRA_ZK.levelno
  is '����';
comment on column BGT_TRA_ZK.exp_eco
  is '���ž��ÿ�Ŀ����';
comment on column BGT_TRA_ZK.exp_eco_code
  is '���ž��ÿ�Ŀ����';
comment on column BGT_TRA_ZK.promaininfo
  is 'һ����Ŀ';
comment on column BGT_TRA_ZK.super_tra
  is '�ϼ�ת��֧����Ŀ';
comment on column BGT_TRA_ZK.templateguid
  is 'ģ������';
comment on column BGT_TRA_ZK.prodetailinfo
  is '�걨��Ŀ';
comment on column BGT_TRA_ZK.isgovpurch
  is '�Ƿ������ɹ�';
comment on column BGT_TRA_ZK.isconstruction
  is '�Ƿ����';
comment on column BGT_TRA_ZK.remark
  is '��ע';
comment on column BGT_TRA_ZK.ordernum
  is '�����ֶ�';
comment on column BGT_TRA_ZK.agency_name
  is '��λ����';
comment on column BGT_TRA_ZK.budget_level_name
  is 'Ԥ�㼶������';
comment on column BGT_TRA_ZK.dept_name
  is '��������';
comment on column BGT_TRA_ZK.exp_func_name
  is '֧�����ܷ����Ŀ����';
comment on column BGT_TRA_ZK.found_type_name
  is '�ʽ���Դ����';
comment on column BGT_TRA_ZK.fund_type_name
  is '�ʽ���������';
comment on column BGT_TRA_ZK.gov_bgt_eco_name
  is '����֧�����÷����Ŀ����';
comment on column BGT_TRA_ZK.is_assigned
  is '�Ƿ����������֧��';
comment on column BGT_TRA_ZK.manage_mof_dep_name
  is 'ҵ�����������';
comment on column BGT_TRA_ZK.mof_div_name
  is '������������';
comment on column BGT_TRA_ZK.sub_mof_div_name
  is '�¼�������������';
comment on column BGT_TRA_ZK.tp_func_name
  is 'ת��֧�����ܷ����Ŀ����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BGT_TRA_ZK
  add constraint PK_BGT_TRA_ZK primary key (BGT_PMAN_ID);
