--1.项目热点分类信息查询
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
  is '项目热点分类信息查询';
-- Add comments to the columns 
comment on column PM_HOT_TOPICCATE.pro_hot_topic_id
  is '项目热点分类主键';
comment on column PM_HOT_TOPICCATE.mof_div_code
  is '财政区划代码';
comment on column PM_HOT_TOPICCATE.setup_year
  is '设立年度';
comment on column PM_HOT_TOPICCATE.pro_code
  is '项目代码';
comment on column PM_HOT_TOPICCATE.hot_topic_cate_code
  is '热点分类代码';
comment on column PM_HOT_TOPICCATE.update_time
  is '更新时间';
comment on column PM_HOT_TOPICCATE.is_deleted
  is '是否删除';
comment on column PM_HOT_TOPICCATE.create_time
  is '创建时间';
comment on column PM_HOT_TOPICCATE.bgt_id
  is '指标主键';
comment on column PM_HOT_TOPICCATE.mof_div_name
  is '财政区划名称';
comment on column PM_HOT_TOPICCATE.pro_name
  is '项目名称';
comment on column PM_HOT_TOPICCATE.hot_topic_cate_name
  is '热点分类名称';

alter table PM_HOT_TOPICCATE
  add constraint PK_PM_HOT_TOPICCATE_ID primary key (PRO_HOT_TOPIC_ID);
--alter table PM_HOT_TOPICCATE
--  add constraint UN_PM_HOT_TOPICCATE_ID unique (MOF_DIV_CODE, SETUP_YEAR, PRO_CODE, HOT_TOPIC_CATE_CODE);
--目前联调已经去掉联合主键 与财政部规范不一致
  
/
--2.指标信息
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
  is '指标信息';
-- Add comments to the columns 
comment on column BA_BGT_INFO.bgt_id
  is '指标主键';
comment on column BA_BGT_INFO.mof_div_code
  is '财政区划代码';
comment on column BA_BGT_INFO.fiscal_year
  is '预算年度';
comment on column BA_BGT_INFO.cor_bgt_doc_no
  is '本级指标文号';
comment on column BA_BGT_INFO.bgt_doc_title
  is '指标文标题';
comment on column BA_BGT_INFO.doc_date
  is '发文时间';
comment on column BA_BGT_INFO.bgt_dec
  is '指标说明';
comment on column BA_BGT_INFO.budget_level_code
  is '预算级次代码';
comment on column BA_BGT_INFO.sup_bgt_doc_no
  is '上级指标文号';
comment on column BA_BGT_INFO.pro_code
  is '项目代码';
comment on column BA_BGT_INFO.bgt_exe_flag
  is '指标可执行标志';
comment on column BA_BGT_INFO.is_track
  is '是否追踪';
comment on column BA_BGT_INFO.track_pro_code
  is '需要追踪项目代码';
comment on column BA_BGT_INFO.agency_code
  is '单位代码';
comment on column BA_BGT_INFO.fund_type_code
  is '资金性质代码';
comment on column BA_BGT_INFO.manage_mof_dep_code
  is '业务主管处室代码';
comment on column BA_BGT_INFO.tp_func_code
  is '转移支付支出功能分类科目代码';
comment on column BA_BGT_INFO.exp_func_code
  is '支出功能分类科目代码';
comment on column BA_BGT_INFO.gov_bgt_eco_code
  is '政府支出经济分类科目代码';
comment on column BA_BGT_INFO.dep_bgt_eco_code
  is '部门支出经济分类科目代码';
comment on column BA_BGT_INFO.bgt_type_code
  is '指标类型代码';
comment on column BA_BGT_INFO.amount
  is '指标金额';
comment on column BA_BGT_INFO.bgt_mof_dep_code
  is '指标管理处室代码';
comment on column BA_BGT_INFO.is_gov_pur
  is '是否政府采购';
comment on column BA_BGT_INFO.update_time
  is '更新时间';
comment on column BA_BGT_INFO.adj_batch_no
  is '调整批次号';
comment on column BA_BGT_INFO.ori_bgt_id
  is '源指标主键';
comment on column BA_BGT_INFO.dis_amt
  is '调减（追减）金额';
comment on column BA_BGT_INFO.cur_amt
  is '指标余额';
comment on column BA_BGT_INFO.bgt_pman_id
  is '项目年度预算主键';
comment on column BA_BGT_INFO.is_deleted
  is '是否删除';
comment on column BA_BGT_INFO.source_type_code
  is '指标来源代码';
comment on column BA_BGT_INFO.create_time
  is '创建时间';
comment on column BA_BGT_INFO.rec_div_code
  is '接收方财政区划代码';
comment on column BA_BGT_INFO.count_fund_pro_code
  is '对应配套安排的中央项目代码';
comment on column BA_BGT_INFO.pay_app_amt
  is '已申请支付金额';
comment on column BA_BGT_INFO.task_no
  is '任务代码';
comment on column BA_BGT_INFO.spe_pro_code
  is '具体实施项目';
comment on column BA_BGT_INFO.mof_div_name
  is '财政区划名称';
comment on column BA_BGT_INFO.pro_name
  is '项目名称';
comment on column BA_BGT_INFO.agency_name
  is '单位名称';
comment on column BA_BGT_INFO.fund_type_name
  is '资金性质名称';
comment on column BA_BGT_INFO.manage_mof_dep_name
  is '业务主管处室名称';
comment on column BA_BGT_INFO.tp_func_name
  is '转移支付功能分类科目名称';
comment on column BA_BGT_INFO.exp_func_name
  is '支出功能分类科目名称';
comment on column BA_BGT_INFO.gov_bgt_eco_name
  is '政府支出经济分类科目名称';
comment on column BA_BGT_INFO.dep_bgt_eco_name
  is '部门支出经济分类科目名称';
comment on column BA_BGT_INFO.bgt_type_name
  is '指标类型名称';
comment on column BA_BGT_INFO.bgt_mof_dep_name
  is '指标管理处室名称';
comment on column BA_BGT_INFO.rec_div_name
  is '接收方财政区划名称';
comment on column BA_BGT_INFO.task_nanme
  is '任务名称';
comment on column BA_BGT_INFO.pay_type_name
  is '支付方式名称';
comment on column BA_BGT_INFO.exp_level_code
  is '支出级次代码';
comment on column BA_BGT_INFO.pay_type_code
  is '支付方式代码';
comment on column BA_BGT_INFO.source_type_name
  is '指标来源名称';
comment on column BA_BGT_INFO.track_pro_name
  is '需要追踪项目名称';
comment on column BA_BGT_INFO.spe_pro_name
  is '具体项目名称';
comment on column BA_BGT_INFO.exp_level_name
  is '支出级次名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_INFO
  add constraint PK_BA_BGT_INFO_ID primary key (BGT_ID);
  
/
--3.国库集中支付申请信息
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
  is '国库集中支付申请信息';
-- Add comments to the columns 
comment on column PAY_VOUCHER.pay_cert_id
  is '支付凭证主键';
comment on column PAY_VOUCHER.fund_type_code
  is '资金性质代码';
comment on column PAY_VOUCHER.fiscal_year
  is '预算年度';
comment on column PAY_VOUCHER.pay_acct_name
  is '付款人全称';
comment on column PAY_VOUCHER.pay_acct_no
  is '付款人账号';
comment on column PAY_VOUCHER.pay_acct_bank_name
  is '付款人开户银行';
comment on column PAY_VOUCHER.payee_acct_name
  is '收款人全称';
comment on column PAY_VOUCHER.payee_acct_no
  is '收款人账号';
comment on column PAY_VOUCHER.payee_acct_bank_name
  is '收款人开户银行';
comment on column PAY_VOUCHER.exp_func_code
  is '支出功能分类科目代码';
comment on column PAY_VOUCHER.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column PAY_VOUCHER.dep_bgt_eco_code
  is '部门支出经济分类代码';
comment on column PAY_VOUCHER.xpay_amt
  is '实际支付金额';
comment on column PAY_VOUCHER.agency_code
  is '单位代码';
comment on column PAY_VOUCHER.use_des
  is '用途';
comment on column PAY_VOUCHER.set_mode_code
  is '结算方式代码';
comment on column PAY_VOUCHER.pro_code
  is '项目代码';
comment on column PAY_VOUCHER.mof_div_code
  is '财政区划代码';
comment on column PAY_VOUCHER.foreign_amt
  is '外币金额';
comment on column PAY_VOUCHER.currency_code
  is '币种代码';
comment on column PAY_VOUCHER.est_rat
  is '汇率';
comment on column PAY_VOUCHER.receiver_code
  is '收款人代码';
comment on column PAY_VOUCHER.update_time
  is '更新时间';
comment on column PAY_VOUCHER.is_deleted
  is '是否删除';
comment on column PAY_VOUCHER.create_time
  is '创建时间';
comment on column PAY_VOUCHER.dept_code
  is '部门代码';
comment on column PAY_VOUCHER.pay_bus_type_code
  is '支付业务类型代码';
comment on column PAY_VOUCHER.param_10
  is '';
comment on column PAY_VOUCHER.bgt_id
  is '指标主键';
comment on column PAY_VOUCHER.mof_div_name
  is '财政区划名称';
comment on column PAY_VOUCHER.agency_name
  is '单位名称';
comment on column PAY_VOUCHER.dept_name
  is '部门名称';
comment on column PAY_VOUCHER.bgt_type_name
  is '指标类型名称';
comment on column PAY_VOUCHER.fund_type_name
  is '资金性质名称';
comment on column PAY_VOUCHER.exp_func_name
  is '支出功能分类科目名称';
comment on column PAY_VOUCHER.gov_bgt_eco_name
  is '政府支出经济分类名称';
comment on column PAY_VOUCHER.dep_bgt_eco_name
  is '部门支出经济分类名称';
comment on column PAY_VOUCHER.pro_name
  is '项目名称';
comment on column PAY_VOUCHER.pro_kind_name
  is '项目类别名称';
comment on column PAY_VOUCHER.pay_type_name
  is '支付方式名称';
comment on column PAY_VOUCHER.set_mode_name
  is '结算方式名称';
comment on column PAY_VOUCHER.fund_traobj_type_name
  is '资金往来对象类别名称';
comment on column PAY_VOUCHER.currency_name
  is '币种名称';
comment on column PAY_VOUCHER.bond_name
  is '债券名称';
comment on column PAY_VOUCHER.bgt_type_code
  is '指标类型代码';
comment on column PAY_VOUCHER.bond_code
  is '债券代码';
comment on column PAY_VOUCHER.contract_no
  is '采购合同编号';
comment on column PAY_VOUCHER.create_date
  is '申请日期';
comment on column PAY_VOUCHER.entpay_app_no
  is '托收申请编号';
comment on column PAY_VOUCHER.fund_traobj_type_code
  is '资金往来对象类别代码';
comment on column PAY_VOUCHER.internal_dep_code
  is '单位内部机构代码';
comment on column PAY_VOUCHER.internal_dep_name
  is '单位内部机构名称';
comment on column PAY_VOUCHER.pay_app_amt
  is '支付申请金额';
comment on column PAY_VOUCHER.pay_app_id
  is '支付申请主键';
comment on column PAY_VOUCHER.pay_app_no
  is '支付申请编号';
comment on column PAY_VOUCHER.pay_bus_type_name
  is '支付业务类型名称';
comment on column PAY_VOUCHER.pay_type_code
  is '支付方式代码';
comment on column PAY_VOUCHER.pro_cat_code
  is '项目类别';
comment on column PAY_VOUCHER.pro_loangrant_num
  is '国外贷款赠款协议号';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_VOUCHER
  add constraint PK_PAY_VOUCHER_ID primary key (PAY_APP_ID);
alter table PAY_VOUCHER
  add constraint UN_PAY_VOUCHER_ID unique (FISCAL_YEAR, MOF_DIV_CODE, PAY_APP_NO);

  
/
--4.国库集中支付凭证信息
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
  is '国库集中支付凭证信息';
-- Add comments to the columns 
comment on column PAY_VOUCHER_BILL.pay_cert_id
  is '支付凭证主键';
comment on column PAY_VOUCHER_BILL.fund_type_code
  is '资金性质代码';
comment on column PAY_VOUCHER_BILL.fiscal_year
  is '年度';
comment on column PAY_VOUCHER_BILL.vou_date
  is '凭证日期';
comment on column PAY_VOUCHER_BILL.pay_cert_no
  is '支付凭证号';
comment on column PAY_VOUCHER_BILL.pay_acct_name
  is '付款人全称';
comment on column PAY_VOUCHER_BILL.pay_acct_no
  is '付款人账号';
comment on column PAY_VOUCHER_BILL.pay_acct_bank_name
  is '付款人开户银行';
comment on column PAY_VOUCHER_BILL.payee_acct_name
  is '收款人全称';
comment on column PAY_VOUCHER_BILL.payee_acct_no
  is '收款人账号';
comment on column PAY_VOUCHER_BILL.payee_acct_bank_name
  is '收款人开户银行';
comment on column PAY_VOUCHER_BILL.pay_amt
  is '支付金额';
comment on column PAY_VOUCHER_BILL.lqd_quota_notice_no
  is '清算额度通知单号';
comment on column PAY_VOUCHER_BILL.pay_cert_sum_no
  is '支付凭证汇总清单号';
comment on column PAY_VOUCHER_BILL.lqd_cert_no
  is '划款凭证单号';
comment on column PAY_VOUCHER_BILL.exp_func_code
  is '支出功能分类科目代码';
comment on column PAY_VOUCHER_BILL.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column PAY_VOUCHER_BILL.dep_bgt_eco_code
  is '部门支出经济分类代码';
comment on column PAY_VOUCHER_BILL.agent_business_no
  is '银行交易流水号';
comment on column PAY_VOUCHER_BILL.xpay_amt
  is '实际支付金额';
comment on column PAY_VOUCHER_BILL.xpay_date
  is '实际支付日期';
comment on column PAY_VOUCHER_BILL.agency_code
  is '单位代码';
comment on column PAY_VOUCHER_BILL.use_des
  is '用途';
comment on column PAY_VOUCHER_BILL.set_mode_code
  is '结算方式代码';
comment on column PAY_VOUCHER_BILL.pro_code
  is '项目代码';
comment on column PAY_VOUCHER_BILL.mof_div_code
  is '财政区划代码';
comment on column PAY_VOUCHER_BILL.foreign_amt
  is '外币金额';
comment on column PAY_VOUCHER_BILL.currency_code
  is '币种代码';
comment on column PAY_VOUCHER_BILL.est_rat
  is '汇率';
comment on column PAY_VOUCHER_BILL.receiver_code
  is '收款人代码';
comment on column PAY_VOUCHER_BILL.receipt_add_word
  is '回单附言';
comment on column PAY_VOUCHER_BILL.xpayee_acct_name
  is '实际收款人全称';
comment on column PAY_VOUCHER_BILL.xpayee_acct_no
  is '实际收款人账号';
comment on column PAY_VOUCHER_BILL.xpayee_acct_bank_name
  is '实际收款人开户银行名称';
comment on column PAY_VOUCHER_BILL.update_time
  is '更新时间';
comment on column PAY_VOUCHER_BILL.is_deleted
  is '是否删除';
comment on column PAY_VOUCHER_BILL.create_time
  is '创建时间';
comment on column PAY_VOUCHER_BILL.dept_code
  is '部门代码';
comment on column PAY_VOUCHER_BILL.pay_bus_type_code
  is '支付业务类型代码';
comment on column PAY_VOUCHER_BILL.act_lqd_date
  is '实际清算日期';
comment on column PAY_VOUCHER_BILL.mof_div_name
  is '财政区划名称';
comment on column PAY_VOUCHER_BILL.agency_name
  is '单位名称';
comment on column PAY_VOUCHER_BILL.dept_name
  is '部门名称';
comment on column PAY_VOUCHER_BILL.fund_type_name
  is '资金性质名称';
comment on column PAY_VOUCHER_BILL.exp_func_name
  is '支出功能分类科目名称';
comment on column PAY_VOUCHER_BILL.gov_bgt_eco_name
  is '政府支出经济分类名称';
comment on column PAY_VOUCHER_BILL.dep_bgt_eco_name
  is '部门支出经济分类名称';
comment on column PAY_VOUCHER_BILL.pro_name
  is '项目名称';
comment on column PAY_VOUCHER_BILL.pay_bus_type_name
  is '支付业务类型名称';
comment on column PAY_VOUCHER_BILL.set_mode_name
  is '结算方式名称';
comment on column PAY_VOUCHER_BILL.abstract
  is '凭证摘要';
comment on column PAY_VOUCHER_BILL.check_no
  is '支票号';
comment on column PAY_VOUCHER_BILL.currency_name
  is '币种名称';
comment on column PAY_VOUCHER_BILL.pay_code
  is '缴款识别码';
comment on column PAY_VOUCHER_BILL.taxayer_id
  is '纳税人识别号';
comment on column PAY_VOUCHER_BILL.tax_org_code
  is '税务征收机关代码';
comment on column PAY_VOUCHER_BILL.tax_bill_no
  is '申报税凭证号';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_VOUCHER_BILL
  add constraint PK_PAY_VOUCHER_BILL_ID primary key (PAY_CERT_ID);
alter table PAY_VOUCHER_BILL
  add constraint UN_PAY_VOUCHER_BILL_ID unique (PAY_CERT_NO, MOF_DIV_CODE, PAYEE_ACCT_NO);


/

--5.国库集中支付明细信息
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
  is '国库集中支付明细信息';
-- Add comments to the columns 
comment on column PAY_DETAIL.pay_detail_id
  is '支付明细表主键';
comment on column PAY_DETAIL.agency_code
  is '单位代码';
comment on column PAY_DETAIL.payee_acct_name
  is '收款人全称';
comment on column PAY_DETAIL.payee_acct_no
  is '收款人账号';
comment on column PAY_DETAIL.payee_acct_bank_name
  is '收款人开户银行';
comment on column PAY_DETAIL.pay_amt
  is '支付金额';
comment on column PAY_DETAIL.xpay_amt
  is '实际支付金额';
comment on column PAY_DETAIL.add_word
  is '附言';
comment on column PAY_DETAIL.pay_cert_no
  is '支付凭证号';
comment on column PAY_DETAIL.pay_apply_id
  is '支付申请主键';
comment on column PAY_DETAIL.tracking_id
  is '业务追溯识别码';
comment on column PAY_DETAIL.mof_div_code
  is '财政区划代码';
comment on column PAY_DETAIL.receiver_code
  is '收款人代码';
comment on column PAY_DETAIL.fiscal_year
  is '预算年度';
comment on column PAY_DETAIL.update_time
  is '更新时间';
comment on column PAY_DETAIL.is_deleted
  is '是否删除';
comment on column PAY_DETAIL.create_time
  is '创建时间';
comment on column PAY_DETAIL.is_to_peop_enterp
  is '项目是否惠企利民';
comment on column PAY_DETAIL.per_name
  is '姓名';
comment on column PAY_DETAIL.iden_no
  is '证件号码';
comment on column PAY_DETAIL.corp_name
  is '企业名称';
comment on column PAY_DETAIL.unifsoc_cred_code
  is '统一社会信用代码';
comment on column PAY_DETAIL.pay_month
  is '发放月份';
comment on column PAY_DETAIL.to_peop_enterp
  is '惠企利民标识';
comment on column PAY_DETAIL.town_code
  is '街道(乡镇)编码';
comment on column PAY_DETAIL.town_name
  is '街道(乡镇)名称';
comment on column PAY_DETAIL.village_code
  is '村编码';
comment on column PAY_DETAIL.village_name
  is '村名称';
comment on column PAY_DETAIL.to_peop_family
  is '按户按人补助标识';
comment on column PAY_DETAIL.mof_div_name
  is '财政区划名称';
comment on column PAY_DETAIL.agency_name
  is '单位名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_DETAIL
  add constraint PK_PAY_DETAIL_ID primary key (PAY_DETAIL_ID);
alter table PAY_DETAIL
  add constraint UN_PAY_DETAIL_ID unique (MOF_DIV_CODE, AGENCY_CODE, PAYEE_ACCT_NO);

  
/

--6.预算拨款凭证信息
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
  is '预算拨款凭证信息';
-- Add comments to the columns 
comment on column PAY_ALLOCATION_CERT.pay_alloc_cert_id
  is '拨款凭证主键';
comment on column PAY_ALLOCATION_CERT.vou_date
  is '凭证日期';
comment on column PAY_ALLOCATION_CERT.mof_div_code
  is '财政区划代码';
comment on column PAY_ALLOCATION_CERT.fiscal_year
  is '预算年度';
comment on column PAY_ALLOCATION_CERT.agency_code
  is '单位代码';
comment on column PAY_ALLOCATION_CERT.pay_alloc_cert_no
  is '拨款凭证号';
comment on column PAY_ALLOCATION_CERT.pay_acct_name
  is '付款人全称';
comment on column PAY_ALLOCATION_CERT.pay_acct_no
  is '付款人';
comment on column PAY_ALLOCATION_CERT.pay_acct_bank_name
  is '付款人开户银行';
comment on column PAY_ALLOCATION_CERT.payee_acct_name
  is '收款人全称';
comment on column PAY_ALLOCATION_CERT.payee_acct_no
  is '收款人账号';
comment on column PAY_ALLOCATION_CERT.payee_acct_bank_name
  is '收款人开户银行';
comment on column PAY_ALLOCATION_CERT.foreign_amt
  is '外币金额';
comment on column PAY_ALLOCATION_CERT.currency_code
  is '币种代码';
comment on column PAY_ALLOCATION_CERT.est_rat
  is '汇率';
comment on column PAY_ALLOCATION_CERT.use_des
  is '用途';
comment on column PAY_ALLOCATION_CERT.exp_func_code
  is '支出功能分类科目代码';
comment on column PAY_ALLOCATION_CERT.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column PAY_ALLOCATION_CERT.pro_code
  is '项目代码';
comment on column PAY_ALLOCATION_CERT.bgt_id
  is '指标主键';
comment on column PAY_ALLOCATION_CERT.fund_type_code
  is '资金性质代码';
comment on column PAY_ALLOCATION_CERT.receiver_code
  is '收款人代码';
comment on column PAY_ALLOCATION_CERT.update_time
  is '更新时间';
comment on column PAY_ALLOCATION_CERT.is_deleted
  is '是否删除';
comment on column PAY_ALLOCATION_CERT.create_time
  is '创建时间';
comment on column PAY_ALLOCATION_CERT.pay_alloc_type
  is '拨款类型代码';
comment on column PAY_ALLOCATION_CERT.acc_date
  is '实际拨款日期';
comment on column PAY_ALLOCATION_CERT.mof_div_name
  is '财政区划名称';
comment on column PAY_ALLOCATION_CERT.agency_name
  is '单位名称';
comment on column PAY_ALLOCATION_CERT.fund_type_name
  is '资金性质名称';
comment on column PAY_ALLOCATION_CERT.exp_func_name
  is '支出功能分类科目名称';
comment on column PAY_ALLOCATION_CERT.gov_bgt_eco_name
  is '政府支出经济分类名称';
comment on column PAY_ALLOCATION_CERT.pro_name
  is '项目名称';
comment on column PAY_ALLOCATION_CERT.currency_name
  is '币种名称';
comment on column PAY_ALLOCATION_CERT.pay_alloc_type_name
  is '拨款类型名称';
comment on column PAY_ALLOCATION_CERT.pay_amt
  is '拨款金额';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_ALLOCATION_CERT
  add constraint PK_PAY_ALLOCATION_CERT_ID primary key (PAY_ALLOC_CERT_ID);

  
/
--7.单位资金支付申请信息
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
  is '单位资金支付申请信息';
-- Add comments to the columns 
comment on column INC_APPLY.pay_app_id
  is '';
comment on column INC_APPLY.pay_app_no
  is '支付申请编号';
comment on column INC_APPLY.create_date
  is '申请日期';
comment on column INC_APPLY.agency_code
  is '单位代码';
comment on column INC_APPLY.bgt_type_code
  is '指标类型代码';
comment on column INC_APPLY.fund_type_code
  is '资金性质代码';
comment on column INC_APPLY.exp_func_code
  is '支出功能分类科目代码';
comment on column INC_APPLY.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column INC_APPLY.dep_bgt_eco_code
  is '部门支出经济分类代码';
comment on column INC_APPLY.pro_code
  is '项目代码';
comment on column INC_APPLY.bgt_id
  is '指标主键';
comment on column INC_APPLY.set_mode_code
  is '结算方式代码';
comment on column INC_APPLY.pay_type_code
  is '支付方式代码';
comment on column INC_APPLY.use_des
  is '用途';
comment on column INC_APPLY.pay_bus_type_code
  is '支付业务类型代码';
comment on column INC_APPLY.pay_app_amt
  is '支付申请金额';
comment on column INC_APPLY.pay_cert_id
  is '支付凭证主键';
comment on column INC_APPLY.pay_acct_name
  is '付款人全称';
comment on column INC_APPLY.pay_acct_no
  is '付款人';
comment on column INC_APPLY.pay_acct_bank_name
  is '付款人开户银行';
comment on column INC_APPLY.payee_acct_name
  is '收款人全称';
comment on column INC_APPLY.payee_acct_no
  is '收款人账号';
comment on column INC_APPLY.payee_acct_bank_name
  is '收款人开户银行';
comment on column INC_APPLY.fund_traobj_type_code
  is '资金往来对象类别代码';
comment on column INC_APPLY.internal_dep_code
  is '单位内部机构代码';
comment on column INC_APPLY.fiscal_year
  is '预算年度';
comment on column INC_APPLY.mof_div_code
  is '财政区划代码';
comment on column INC_APPLY.foreign_amt
  is '外币金额';
comment on column INC_APPLY.currency_code
  is '币种代码';
comment on column INC_APPLY.est_rat
  is '汇率';
comment on column INC_APPLY.receiver_code
  is '收款人代码';
comment on column INC_APPLY.contract_no
  is '采购合同编号';
comment on column INC_APPLY.update_time
  is '更新时间';
comment on column INC_APPLY.is_deleted
  is '是否删除';
comment on column INC_APPLY.create_time
  is '创建时间';
comment on column INC_APPLY.pro_cat_code
  is '项目类别';
comment on column INC_APPLY.dept_code
  is '部门代码';
comment on column INC_APPLY.mof_div_name
  is '财政区划名称';
comment on column INC_APPLY.agency_name
  is '单位名称';
comment on column INC_APPLY.dept_name
  is '部门名称';
comment on column INC_APPLY.bgt_type_name
  is '指标类型名称';
comment on column INC_APPLY.fund_type_name
  is '资金性质名称';
comment on column INC_APPLY.exp_func_name
  is '支出功能分类科目名称';
comment on column INC_APPLY.gov_bgt_eco_name
  is '政府支出经济分类名称';
comment on column INC_APPLY.dep_bgt_eco_name
  is '部门支出经济分类名称';
comment on column INC_APPLY.pro_name
  is '项目名称';
comment on column INC_APPLY.pro_kind_name
  is '项目类别名称';
comment on column INC_APPLY.pay_bus_type_name
  is '支付业务类型名称';
comment on column INC_APPLY.pay_type_name
  is '支付方式名称';
comment on column INC_APPLY.set_mode_name
  is '结算方式名称';
comment on column INC_APPLY.internal_dep_name
  is '单位内部机构名称';
comment on column INC_APPLY.currency_name
  is '币种名称';
comment on column INC_APPLY.fund_traobj_type_name
  is '资金往来对象类别名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table INC_APPLY
  add constraint PK_INC_APPLY_ID primary key (PAY_APP_ID);
alter table INC_APPLY
  add constraint UN_INC_APPLY_ID unique (MOF_DIV_CODE, PAY_APP_NO);


/

--8.单位资金支付凭证信息
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
  is '单位资金支付凭证信息';
-- Add comments to the columns 
comment on column INC_CERT.pay_cert_id
  is '支付凭证主键';
comment on column INC_CERT.fund_type_code
  is '资金性质代码';
comment on column INC_CERT.vou_date
  is '凭证日期';
comment on column INC_CERT.fiscal_year
  is '预算年度';
comment on column INC_CERT.pay_cert_no
  is '支付凭证号';
comment on column INC_CERT.pay_acct_name
  is '付款人';
comment on column INC_CERT.pay_acct_no
  is '付款人账号';
comment on column INC_CERT.pay_acct_bank_name
  is '付款人开户银行';
comment on column INC_CERT.payee_acct_name
  is '收款人全称';
comment on column INC_CERT.payee_acct_no
  is '收款人账号';
comment on column INC_CERT.payee_acct_bank_name
  is '收款人开户银行';
comment on column INC_CERT.pay_amt
  is '支付金额';
comment on column INC_CERT.exp_func_code
  is '支出功能分类科目代码';
comment on column INC_CERT.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column INC_CERT.dep_bgt_eco_code
  is '部门支出经济分类代码';
comment on column INC_CERT.pro_code
  is '项目代码';
comment on column INC_CERT.agent_business_no
  is '银行交易流水号';
comment on column INC_CERT.xpay_amt
  is '实际支付金额';
comment on column INC_CERT.xpay_date
  is '实际支付日期';
comment on column INC_CERT.agency_code
  is '单位代码';
comment on column INC_CERT.use_des
  is '用途';
comment on column INC_CERT.set_mode_code
  is '结算方式代码';
comment on column INC_CERT.mof_div_code
  is '财政区划代码';
comment on column INC_CERT.foreign_amt
  is '外币金额';
comment on column INC_CERT.currency_code
  is '币种代码';
comment on column INC_CERT.est_rat
  is '汇率';
comment on column INC_CERT.receiver_code
  is '收款人代码';
comment on column INC_CERT.receipt_add_word
  is '回单附言';
comment on column INC_CERT.xpayee_acct_name
  is '实际收款人全称';
comment on column INC_CERT.xpayee_acct_no
  is '实际收款人账号';
comment on column INC_CERT.xpayee_acct_bank_name
  is '实际收款人开户银行名称';
comment on column INC_CERT.update_time
  is '更新时间';
comment on column INC_CERT.is_deleted
  is '是否删除';
comment on column INC_CERT.create_time
  is '创建时间';
comment on column INC_CERT.dept_code
  is '部门代码';
comment on column INC_CERT.mof_div_name
  is '财政区划名称';
comment on column INC_CERT.agency_name
  is '单位名称';
comment on column INC_CERT.dept_name
  is '部门名称';
comment on column INC_CERT.fund_type_name
  is '资金性质名称';
comment on column INC_CERT.exp_func_name
  is '支出功能分类科目名称';
comment on column INC_CERT.gov_bgt_eco_name
  is '政府支出经济分类名称';
comment on column INC_CERT.dep_bgt_eco_name
  is '部门支出经济分类名称';
comment on column INC_CERT.pro_name
  is '项目名称';
comment on column INC_CERT.set_mode_name
  is '结算方式名称';
comment on column INC_CERT.abstract
  is '凭证摘要';
comment on column INC_CERT.currency_name
  is '币种名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table INC_CERT
  add constraint PK_INC_CERT_ID primary key (PAY_CERT_ID);
alter table INC_CERT
  add constraint UN_INC_CERT_ID unique (PAY_CERT_NO, MOF_DIV_CODE);

  
/

--9.单位资金支付明细信息
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
  is '单位资金支付明细信息';
-- Add comments to the columns 
comment on column INC_DETAIL.pay_detail_id
  is '支付明细表主键';
comment on column INC_DETAIL.agency_code
  is '单位代码';
comment on column INC_DETAIL.payee_acct_name
  is '收款人全称';
comment on column INC_DETAIL.payee_acct_no
  is '收款人账号';
comment on column INC_DETAIL.payee_acct_bank_name
  is '收款人开户银行';
comment on column INC_DETAIL.pay_amt
  is '支付金额';
comment on column INC_DETAIL.xpay_amt
  is '实际支付金额';
comment on column INC_DETAIL.add_word
  is '附言';
comment on column INC_DETAIL.pay_cert_no
  is '支付凭证号';
comment on column INC_DETAIL.pay_apply_id
  is '支付申请主键';
comment on column INC_DETAIL.tracking_id
  is '业务追溯识别码';
comment on column INC_DETAIL.fiscal_year
  is '预算年度';
comment on column INC_DETAIL.mof_div_code
  is '财政区划代码';
comment on column INC_DETAIL.receiver_code
  is '收款人代码';
comment on column INC_DETAIL.update_time
  is '更新时间';
comment on column INC_DETAIL.is_deleted
  is '是否删除';
comment on column INC_DETAIL.create_time
  is '创建时间';
comment on column INC_DETAIL.mof_div_name
  is '财政区划名称';
comment on column INC_DETAIL.agency_name
  is '单位名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table INC_DETAIL
  add constraint PK_INC_DETAIL_ID primary key (PAY_DETAIL_ID);
alter table INC_DETAIL
  add constraint UN_INC_DETAIL_ID unique (MOF_DIV_CODE, AGENCY_CODE, PAYEE_ACCT_NO);

  
/

--10.财政资金结转指标信息

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
  is '财政资金结转指标信息';
-- Add comments to the columns 
comment on column BA_BGT_CARRYOVERS.fiscal_year
  is '预算年度';
comment on column BA_BGT_CARRYOVERS.approve_amt
  is '批复数';
comment on column BA_BGT_CARRYOVERS.carryovers_amt
  is '结转数';
comment on column BA_BGT_CARRYOVERS.bgt_type_code
  is '指标类型代码';
comment on column BA_BGT_CARRYOVERS.bgt_mof_dep_code
  is '指标管理处室代码';
comment on column BA_BGT_CARRYOVERS.manage_mof_dep_code
  is '业务主管处室代码';
comment on column BA_BGT_CARRYOVERS.cor_bgt_doc_no
  is '本级指标文号';
comment on column BA_BGT_CARRYOVERS.bgt_dec
  is '指标说明';
comment on column BA_BGT_CARRYOVERS.exp_func_code
  is '支出功能分类科目代码';
comment on column BA_BGT_CARRYOVERS.gov_bgt_eco_code
  is '政府支出经济分类科目代码';
comment on column BA_BGT_CARRYOVERS.fund_type_code
  is '资金性质代码';
comment on column BA_BGT_CARRYOVERS.agency_code
  is '代码';
comment on column BA_BGT_CARRYOVERS.pro_code
  is '项目代码';
comment on column BA_BGT_CARRYOVERS.budget_level_code
  is '预算级次代码';
comment on column BA_BGT_CARRYOVERS.bgt_exe_flag
  is '指标可执行标志';
comment on column BA_BGT_CARRYOVERS.ori_bgt_id
  is '源指标主键';
comment on column BA_BGT_CARRYOVERS.mof_div_code
  is '财政区划代码';
comment on column BA_BGT_CARRYOVERS.carryovers_bgt_id
  is '主键';
comment on column BA_BGT_CARRYOVERS.update_time
  is '更新时间';
comment on column BA_BGT_CARRYOVERS.is_deleted
  is '是否删除';
comment on column BA_BGT_CARRYOVERS.is_gov_pur
  is '是否政府采购';
comment on column BA_BGT_CARRYOVERS.is_track
  is '是否追踪';
comment on column BA_BGT_CARRYOVERS.create_time
  is '创建时间';
comment on column BA_BGT_CARRYOVERS.mof_div_name
  is '财政区划名称';
comment on column BA_BGT_CARRYOVERS.fund_type_name
  is '资金性质名称';
comment on column BA_BGT_CARRYOVERS.bgt_type_name
  is '指标类型名称';
comment on column BA_BGT_CARRYOVERS.bgt_mof_dep_name
  is '指标管理处室名称';
comment on column BA_BGT_CARRYOVERS.manage_mof_dep_name
  is '业务主管处室名称';
comment on column BA_BGT_CARRYOVERS.exp_func_name
  is '支出功能分类科目名称';
comment on column BA_BGT_CARRYOVERS.gov_bgt_eco_name
  is '政府支出经济分类科目名称';
comment on column BA_BGT_CARRYOVERS.agency_name
  is '单位名称';
comment on column BA_BGT_CARRYOVERS.pro_name
  is '项目名称';
comment on column BA_BGT_CARRYOVERS.budget_level_name
  is '预算级次名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_CARRYOVERS
  add constraint PK_BA_BGT_CARRYOVERS_ID primary key (CARRYOVERS_BGT_ID);
alter table BA_BGT_CARRYOVERS
  add constraint UN_BA_BGT_CARRYOVERS_ID unique (PRO_CODE, AGENCY_CODE, EXP_FUNC_CODE, GOV_BGT_ECO_CODE, FUND_TYPE_CODE);



/
--11.财政资金结余指标信息
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
  is '财政资金结余指标信息';
-- Add comments to the columns 
comment on column BA_BGT_BALANCE.fiscal_year
  is '预算年度';
comment on column BA_BGT_BALANCE.approve_amt
  is '批复数';
comment on column BA_BGT_BALANCE.balance
  is '结余数';
comment on column BA_BGT_BALANCE.bgt_type_code
  is '指标类型代码';
comment on column BA_BGT_BALANCE.bgt_mof_dep_code
  is '指标管理处室代码';
comment on column BA_BGT_BALANCE.manage_mof_dep_code
  is '业务主管处室代码';
comment on column BA_BGT_BALANCE.cor_bgt_doc_no
  is '指标文号';
comment on column BA_BGT_BALANCE.bgt_dec
  is '指标说明';
comment on column BA_BGT_BALANCE.agency_code
  is '单位代码';
comment on column BA_BGT_BALANCE.exp_func_code
  is '支出功能分类科目代码';
comment on column BA_BGT_BALANCE.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column BA_BGT_BALANCE.fund_type_code
  is '资金性质代码';
comment on column BA_BGT_BALANCE.bgt_exe_flag
  is '指标可执行标志';
comment on column BA_BGT_BALANCE.pro_code
  is '项目代码';
comment on column BA_BGT_BALANCE.budget_level_code
  is '预算级次代码';
comment on column BA_BGT_BALANCE.ori_bgt_id
  is '源指标主键';
comment on column BA_BGT_BALANCE.mof_div_code
  is '财政区划代码';
comment on column BA_BGT_BALANCE.update_time
  is '更新时间';
comment on column BA_BGT_BALANCE.is_deleted
  is '是否删除';
comment on column BA_BGT_BALANCE.create_time
  is '创建时间';
comment on column BA_BGT_BALANCE.is_rec_exp
  is '是否列支';
comment on column BA_BGT_BALANCE.back_balance
  is '收回数';
comment on column BA_BGT_BALANCE.mof_div_name
  is '财政区划名称';
comment on column BA_BGT_BALANCE.fund_type_name
  is '资金性质名称';
comment on column BA_BGT_BALANCE.bgt_type_name
  is '指标类型名称';
comment on column BA_BGT_BALANCE.bgt_mof_dep_name
  is '指标管理处室名称';
comment on column BA_BGT_BALANCE.manage_mof_dep_name
  is '业务主管处室名称';
comment on column BA_BGT_BALANCE.agency_name
  is '单位名称';
comment on column BA_BGT_BALANCE.exp_func_name
  is '支出功能分类科目名称';
comment on column BA_BGT_BALANCE.gov_bgt_eco_name
  is '政府支出经济分类科目名称';
comment on column BA_BGT_BALANCE.pro_name
  is '项目名称';
comment on column BA_BGT_BALANCE.budget_level_name
  is '预算级次名称';
comment on column BA_BGT_BALANCE.carryovers_bgt_id
  is '主键';
comment on column BA_BGT_BALANCE.is_gov_pur
  is '是否政府采购';
comment on column BA_BGT_BALANCE.is_track
  is '是否追踪';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_BALANCE
  add constraint PK_BA_BGT_BALANCE_ID primary key (CARRYOVERS_BGT_ID);
alter table BA_BGT_BALANCE
  add constraint UN_BA_BGT_BALANCE_ID unique (PRO_CODE, AGENCY_CODE, EXP_FUNC_CODE, GOV_BGT_ECO_CODE, FUND_TYPE_CODE);


/


--12.单位资金结转指标信息
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
  is '单位资金结转指标信息';
-- Add comments to the columns 
comment on column BA_BGT_CARRYOVERS_AGENCY.carryovers_bgt_id
  is '主键';
comment on column BA_BGT_CARRYOVERS_AGENCY.fiscal_year
  is '预算年度';
comment on column BA_BGT_CARRYOVERS_AGENCY.approve_amt
  is '批复数';
comment on column BA_BGT_CARRYOVERS_AGENCY.carryovers_amt
  is '结转数';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_type_code
  is '指标类型代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_type_name
  is '指标类型名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_mof_dep_code
  is '指标管理处室代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_mof_dep_name
  is '指标管理处室名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.manage_mof_dep_code
  is '业务主管处室代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.manage_mof_dep_name
  is '业务主管处室名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.cor_bgt_doc_no
  is '指标文号';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_dec
  is '指标说明';
comment on column BA_BGT_CARRYOVERS_AGENCY.exp_func_code
  is '支出功能分类科目代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.exp_func_name
  is '支出功能分类科目名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.gov_bgt_eco_code
  is '政府支出经济分类科目代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.gov_bgt_eco_name
  is '政府支出经济分类科目名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.fund_type_code
  is '资金性质代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.fund_type_name
  is '资金性质名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.agency_code
  is '单位代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.agency_name
  is '单位名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.pro_code
  is '项目代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.pro_name
  is '项目名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.budget_level_code
  is '预算级次代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.budget_level_name
  is '预算级次名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.bgt_exe_flag
  is '指标可执行标志';
comment on column BA_BGT_CARRYOVERS_AGENCY.ori_bgt_id
  is '源指标主键';
comment on column BA_BGT_CARRYOVERS_AGENCY.mof_div_code
  is '财政区划代码';
comment on column BA_BGT_CARRYOVERS_AGENCY.mof_div_name
  is '财政区划名称';
comment on column BA_BGT_CARRYOVERS_AGENCY.is_gov_pur
  is '是否政府采购';
comment on column BA_BGT_CARRYOVERS_AGENCY.is_track
  is '是否追踪';
comment on column BA_BGT_CARRYOVERS_AGENCY.is_deleted
  is '是否删除';
comment on column BA_BGT_CARRYOVERS_AGENCY.update_time
  is '更新时间';
comment on column BA_BGT_CARRYOVERS_AGENCY.create_time
  is '创建时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_CARRYOVERS_AGENCY
  add constraint PK_BA_BGT_CARRYOVERS_AGENCY_ID primary key (CARRYOVERS_BGT_ID);
alter table BA_BGT_CARRYOVERS_AGENCY
  add constraint UN_BA_BGT_CARRYOVERS_AGENCY_ID unique (PRO_CODE, AGENCY_CODE, EXP_FUNC_CODE, GOV_BGT_ECO_CODE, FUND_TYPE_CODE);


--13.单位资金结余指标信息


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
  is '单位资金结余指标信息';
-- Add comments to the columns 
comment on column BA_BGT_BALANCE_AGENCY.balance_bgt_id
  is '主键';
comment on column BA_BGT_BALANCE_AGENCY.fiscal_year
  is '预算年度';
comment on column BA_BGT_BALANCE_AGENCY.approve_amt
  is '批复数';
comment on column BA_BGT_BALANCE_AGENCY.carryovers_amt
  is '结余数';
comment on column BA_BGT_BALANCE_AGENCY.bgt_type_code
  is '指标类型代码';
comment on column BA_BGT_BALANCE_AGENCY.bgt_type_name
  is '指标类型名称';
comment on column BA_BGT_BALANCE_AGENCY.bgt_mof_dep_code
  is '指标管理处室代码';
comment on column BA_BGT_BALANCE_AGENCY.bgt_mof_dep_name
  is '指标管理处室名称';
comment on column BA_BGT_BALANCE_AGENCY.manage_mof_dep_code
  is '业务主管处室代码';
comment on column BA_BGT_BALANCE_AGENCY.manage_mof_dep_name
  is '业务主管处室名称';
comment on column BA_BGT_BALANCE_AGENCY.cor_bgt_doc_no
  is '指标文号';
comment on column BA_BGT_BALANCE_AGENCY.bgt_dec
  is '指标说明';
comment on column BA_BGT_BALANCE_AGENCY.agency_code
  is '单位代码';
comment on column BA_BGT_BALANCE_AGENCY.agency_name
  is '单位名称';
comment on column BA_BGT_BALANCE_AGENCY.exp_func_code
  is '支出功能分类科目代码';
comment on column BA_BGT_BALANCE_AGENCY.exp_func_name
  is '支出功能分类科目名称';
comment on column BA_BGT_BALANCE_AGENCY.gov_bgt_eco_code
  is '政府支出经济分类科目代码';
comment on column BA_BGT_BALANCE_AGENCY.gov_bgt_eco_name
  is '政府支出经济分类科目名称';
comment on column BA_BGT_BALANCE_AGENCY.fund_type_code
  is '资金性质代码';
comment on column BA_BGT_BALANCE_AGENCY.fund_type_name
  is '资金性质名称';
comment on column BA_BGT_BALANCE_AGENCY.bgt_exe_flag
  is '指标可执行标志';
comment on column BA_BGT_BALANCE_AGENCY.pro_code
  is '项目代码';
comment on column BA_BGT_BALANCE_AGENCY.pro_name
  is '项目名称';
comment on column BA_BGT_BALANCE_AGENCY.budget_level_code
  is '预算级次代码';
comment on column BA_BGT_BALANCE_AGENCY.budget_level_name
  is '预算级次名称';
comment on column BA_BGT_BALANCE_AGENCY.ori_bgt_id
  is '源指标主键';
comment on column BA_BGT_BALANCE_AGENCY.mof_div_code
  is '财政区划代码';
comment on column BA_BGT_BALANCE_AGENCY.mof_div_name
  is '财政区划名称';
comment on column BA_BGT_BALANCE_AGENCY.update_time
  is '更新时间';
comment on column BA_BGT_BALANCE_AGENCY.is_deleted
  is '是否删除';
comment on column BA_BGT_BALANCE_AGENCY.create_time
  is '创建时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BA_BGT_BALANCE_AGENCY
  add constraint PK_BA_BGT_BALANCE_AGENCY_ID primary key (BALANCE_BGT_ID);
alter table BA_BGT_BALANCE_AGENCY
  add constraint UN_BA_BGT_BALANCE_AGENCY_ID unique (PRO_CODE, AGENCY_CODE, EXP_FUNC_CODE, GOV_BGT_ECO_CODE, FUND_TYPE_CODE);

/

--14.非税一般缴款书
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
  is '非税一般缴款书';
-- Add comments to the columns 
comment on column NON_TAX_PAY.nt_pay_voucher_id
  is '缴款书主键';
comment on column NON_TAX_PAY.non_tax_pay_code
  is '政府非税收入缴款识别码';
comment on column NON_TAX_PAY.mof_div_code
  is '财政区划代码';
comment on column NON_TAX_PAY.mof_div_name
  is '财政区划名称';
comment on column NON_TAX_PAY.exec_agency_code
  is '执收单位代码';
comment on column NON_TAX_PAY.exec_agency_name
  is '执收单位名称';
comment on column NON_TAX_PAY.non_tax_pay_no
  is '政府非税收入一般缴款书票号';
comment on column NON_TAX_PAY.author
  is '开票人';
comment on column NON_TAX_PAY.bill_date
  is '开票日期';
comment on column NON_TAX_PAY.eff_date
  is '缴款书有效期';
comment on column NON_TAX_PAY.payer_name
  is '缴款人全称';
comment on column NON_TAX_PAY.payer_acc_no
  is '缴款人账号';
comment on column NON_TAX_PAY.payer_open_bank
  is '缴款人开户银行';
comment on column NON_TAX_PAY.act_payer_name
  is '实际缴款人全称';
comment on column NON_TAX_PAY.act_payer_acc_no
  is '实际缴款人账号';
comment on column NON_TAX_PAY.act_payer_open_bank
  is '实际缴款人开户银行';
comment on column NON_TAX_PAY.total_pay_amt
  is '应缴金额合计';
comment on column NON_TAX_PAY.pay_amt
  is '应缴金额';
comment on column NON_TAX_PAY.delay_amt
  is '滞纳金金额';
comment on column NON_TAX_PAY.paid_amt
  is '缴款金额';
comment on column NON_TAX_PAY.rec_accttype
  is '收款账户类型';
comment on column NON_TAX_PAY.payee_acct_name
  is '收款人全称';
comment on column NON_TAX_PAY.payee_acct_no
  is '收款人账号';
comment on column NON_TAX_PAY.payee_acct_bank_name
  is '收款人开户银行';
comment on column NON_TAX_PAY.payee_acct_bank_code
  is '收款银行代码';
comment on column NON_TAX_PAY.pay_date
  is '缴款日期';
comment on column NON_TAX_PAY.pay_way_code
  is '缴款渠道代码';
comment on column NON_TAX_PAY.pay_way_name
  is '缴款渠道名称';
comment on column NON_TAX_PAY.belong_org_code
  is '收入归属区划';
comment on column NON_TAX_PAY.belong_org_name
  is '收入归属区划名称';
comment on column NON_TAX_PAY.record_date
  is '入账日期';
comment on column NON_TAX_PAY.pay_in_met_code
  is '收缴方式代码';
comment on column NON_TAX_PAY.pay_in_met_name
  is '收缴方式名称';
comment on column NON_TAX_PAY.bus_type
  is '非税数据类型';
comment on column NON_TAX_PAY.update_time
  is '更新时间';
comment on column NON_TAX_PAY.is_deleted
  is '是否删除';
comment on column NON_TAX_PAY.create_time
  is '创建时间 ';
comment on column NON_TAX_PAY.hold1
  is '备用字段1';
comment on column NON_TAX_PAY.hold2
  is '备用字段2';
-- Create/Recreate primary, unique and foreign key constraints 
alter table NON_TAX_PAY
  add constraint PK_NON_TAX_PAY_ID primary key (NT_PAY_VOUCHER_ID);


/

--15.非税一般缴款书详情
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
  is '非税一般缴款书详情';
-- Add comments to the columns 
comment on column NON_TAX_PAY_DETAIL.sort_no
  is '序号';
comment on column NON_TAX_PAY_DETAIL.nt_pay_voucher_id
  is '缴款书主键';
comment on column NON_TAX_PAY_DETAIL.non_tax_proj_code
  is '政府非税收入执收项目识别码';
comment on column NON_TAX_PAY_DETAIL.non_tax_code
  is '政府非税收入执收项目代码';
comment on column NON_TAX_PAY_DETAIL.non_tax_name
  is '政府非税收入执收项目名称';
comment on column NON_TAX_PAY_DETAIL.charge_stand_name
  is '收缴标准名称';
comment on column NON_TAX_PAY_DETAIL.fund_type_code
  is '资金性质代码';
comment on column NON_TAX_PAY_DETAIL.fund_type_name
  is '资金性质名称';
comment on column NON_TAX_PAY_DETAIL.charge_stand_unit
  is '收缴标准计量单位';
comment on column NON_TAX_PAY_DETAIL.pay_number
  is '执收数量';
comment on column NON_TAX_PAY_DETAIL.pay_amt
  is '缴款金额';
comment on column NON_TAX_PAY_DETAIL.update_time
  is '更新时间';
comment on column NON_TAX_PAY_DETAIL.is_deleted
  is '是否删除';
comment on column NON_TAX_PAY_DETAIL.create_time
  is '创建时间 ';
comment on column NON_TAX_PAY_DETAIL.hold1
  is '备用字段1';
comment on column NON_TAX_PAY_DETAIL.hold2
  is '备用字段2';
comment on column NON_TAX_PAY_DETAIL.hold3
  is '备用字段3';
comment on column NON_TAX_PAY_DETAIL.hold4
  is '备用字段4';
-- Create/Recreate primary, unique and foreign key constraints 
alter table NON_TAX_PAY_DETAIL
  add constraint PK_NON_TAX_PAY_DETAIL_ID primary key (SORT_NO);

/

--16.非税退付申请
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
  is '非税退付申请';
-- Add comments to the columns 
comment on column PAY_BACK_INFO.ref_id
  is '退付申请书主键';
comment on column PAY_BACK_INFO.payback_type_code
  is '退付类型代码';
comment on column PAY_BACK_INFO.mof_div_code
  is '财政区划代码';
comment on column PAY_BACK_INFO.fiscal_year
  is '预算年度';
comment on column PAY_BACK_INFO.exec_agency_code
  is '执收单位代码';
comment on column PAY_BACK_INFO.ref_reason
  is '退付原因';
comment on column PAY_BACK_INFO.non_tax_pay_no
  is '原非税收入一般缴款书票号';
comment on column PAY_BACK_INFO.non_tax_pay_code
  is '原非税收入一般缴款书缴款识别码';
comment on column PAY_BACK_INFO.ref_amt
  is '退付金额';
comment on column PAY_BACK_INFO.payback_receiver_name
  is '退付收款人全称';
comment on column PAY_BACK_INFO.payback_receiver_acc_no
  is '退付收款人账号';
comment on column PAY_BACK_INFO.payback_recbank_name
  is '退付收款人开户银行';
comment on column PAY_BACK_INFO.payback_bank_no
  is '退款收款账户银行行号';
comment on column PAY_BACK_INFO.payback_acc_name
  is '退付账户全称';
comment on column PAY_BACK_INFO.payback_acc_no
  is '退付账户账号';
comment on column PAY_BACK_INFO.payback_accbank_name
  is '退付账户开户银行名称';
comment on column PAY_BACK_INFO.ref_no
  is '退付申请书单号';
comment on column PAY_BACK_INFO.ref_date
  is '退付日期';
comment on column PAY_BACK_INFO.update_time
  is '更新时间';
comment on column PAY_BACK_INFO.create_time
  is '创建时间';
comment on column PAY_BACK_INFO.non_tax_code
  is '政府非税收入执收项目代码';
comment on column PAY_BACK_INFO.non_tax_name
  is '政府非税收入执收项目名称';
comment on column PAY_BACK_INFO.hold1
  is '备用字段1';
comment on column PAY_BACK_INFO.hold2
  is '备用字段2';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_BACK_INFO
  add constraint PK_PAY_BACK_INFO_ID primary key (REF_ID);

/

--17.用款计划信息

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
  is '非税退付申请';
-- Add comments to the columns 
comment on column PAY_PLAN_VOUCHER.plan_id
  is '用款计划主键';
comment on column PAY_PLAN_VOUCHER.fiscal_year
  is '预算年度';
comment on column PAY_PLAN_VOUCHER.mof_div_code
  is '财政区划代码';
comment on column PAY_PLAN_VOUCHER.mof_div_name
  is '财政区划名称';
comment on column PAY_PLAN_VOUCHER.plan_voucher_no
  is '计划明细编号';
comment on column PAY_PLAN_VOUCHER.plan_month
  is '计划月份';
comment on column PAY_PLAN_VOUCHER.agency_code
  is '单位代码';
comment on column PAY_PLAN_VOUCHER.agency_name
  is '单位名称';
comment on column PAY_PLAN_VOUCHER.fund_type_code
  is '资金性质代码';
comment on column PAY_PLAN_VOUCHER.fund_type_name
  is '资金性质名称';
comment on column PAY_PLAN_VOUCHER.plan_app_amt
  is '计划申请金额';
comment on column PAY_PLAN_VOUCHER.plan_amt
  is '计划审批金额';
comment on column PAY_PLAN_VOUCHER.bond_code
  is '债券代码';
comment on column PAY_PLAN_VOUCHER.bond_name
  is '债券名称';
comment on column PAY_PLAN_VOUCHER.update_time
  is '更新时间';
comment on column PAY_PLAN_VOUCHER.is_deleted
  is '是否删除';
comment on column PAY_PLAN_VOUCHER.create_time
  is '创建时间 ';
comment on column PAY_PLAN_VOUCHER.bgt_id
  is '指标主键';
comment on column PAY_PLAN_VOUCHER.bgt_dept_code
  is '预算部门代码';
comment on column PAY_PLAN_VOUCHER.bgt_dept_name
  is '预算部门名称';
comment on column PAY_PLAN_VOUCHER.bgt_mof_dep_code
  is '指标管理处';
comment on column PAY_PLAN_VOUCHER.bgt_mof_dep_name
  is '指标管理处名称';
comment on column PAY_PLAN_VOUCHER.manage_mof_dep_code
  is '业务主管处';
comment on column PAY_PLAN_VOUCHER.manage_mof_dep_name
  is '业务主管处名称';
comment on column PAY_PLAN_VOUCHER.bgt_type_code
  is '指标类型代码';
comment on column PAY_PLAN_VOUCHER.bgt_type_name
  is '指标类型名称';
comment on column PAY_PLAN_VOUCHER.exp_func_code
  is '支出功能分类科目代码';
comment on column PAY_PLAN_VOUCHER.exp_func_name
  is '支出功能分类科目名称';
comment on column PAY_PLAN_VOUCHER.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column PAY_PLAN_VOUCHER.gov_bgt_eco_name
  is '政府支出经济分类名称';
comment on column PAY_PLAN_VOUCHER.dep_bgt_eco_code
  is '部门支出经济分类代码';
comment on column PAY_PLAN_VOUCHER.dep_bgt_eco_name
  is '部门支出经济分类名称';
comment on column PAY_PLAN_VOUCHER.pro_code
  is '项目代码';
comment on column PAY_PLAN_VOUCHER.pro_name
  is '项目名称';
comment on column PAY_PLAN_VOUCHER.pay_type_code
  is '支付方式代码';
comment on column PAY_PLAN_VOUCHER.pay_type_name
  is '支付方式名称';
comment on column PAY_PLAN_VOUCHER.use_des
  is '用途';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAY_PLAN_VOUCHER
  add constraint PK_PAY_PLAN_VOUCHER_ID primary key (PLAN_ID);
/

--18.部门预算项目年度预算表信息
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
  is '部门预算项目年度预算表';
-- Add comments to the columns 
comment on column BGT_PM_ANNUAL_ZK.bz
  is '备注';
comment on column BGT_PM_ANNUAL_ZK.dataversion
  is '版本';
comment on column BGT_PM_ANNUAL_ZK.groupkey
  is '分组标识';
comment on column BGT_PM_ANNUAL_ZK.isleaf
  is '叶子节点';
comment on column BGT_PM_ANNUAL_ZK.levelno
  is '级次';
comment on column BGT_PM_ANNUAL_ZK.ordernum
  is '排序字段';
comment on column BGT_PM_ANNUAL_ZK.stage
  is '阶段';
comment on column BGT_PM_ANNUAL_ZK.superguid
  is '父GUID';
comment on column BGT_PM_ANNUAL_ZK.taskguid
  is '任务guid';
comment on column BGT_PM_ANNUAL_ZK.templateguid
  is '模板主键';
comment on column BGT_PM_ANNUAL_ZK.vchtypeid
  is 'VCHTYPEID';
comment on column BGT_PM_ANNUAL_ZK.version
  is '版本';
comment on column BGT_PM_ANNUAL_ZK.fiscal_year
  is '预算年度';
comment on column BGT_PM_ANNUAL_ZK.agency_code
  is '单位代码';
comment on column BGT_PM_ANNUAL_ZK.pro_kind_code
  is '项目类别代码';
comment on column BGT_PM_ANNUAL_ZK.pro_code
  is '项目代码';
comment on column BGT_PM_ANNUAL_ZK.exp_func_code
  is '支出功能分类科目代码';
comment on column BGT_PM_ANNUAL_ZK.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column BGT_PM_ANNUAL_ZK.dep_bgt_eco_code
  is '部门支出经济分类代码';
comment on column BGT_PM_ANNUAL_ZK.fund_type_code
  is '资金性质代码';
comment on column BGT_PM_ANNUAL_ZK.apply_up
  is '申报数';
comment on column BGT_PM_ANNUAL_ZK.fin_audit_money
  is '财政审核数';
comment on column BGT_PM_ANNUAL_ZK.dept_code
  is '部门代码';
comment on column BGT_PM_ANNUAL_ZK.manage_mof_dep_code
  is '业务主管处室代码';
comment on column BGT_PM_ANNUAL_ZK.update_time
  is '更新时间';
comment on column BGT_PM_ANNUAL_ZK.apply_link
  is '申报环节';
comment on column BGT_PM_ANNUAL_ZK.reply_amt
  is '年初批复数';
comment on column BGT_PM_ANNUAL_ZK.adj_amt
  is '调整金额';
comment on column BGT_PM_ANNUAL_ZK.dis_amt
  is '调剂金额';
comment on column BGT_PM_ANNUAL_ZK.cur_amt
  is '变动后预算数';
comment on column BGT_PM_ANNUAL_ZK.is_deleted
  is '是否删除';
comment on column BGT_PM_ANNUAL_ZK.budget_level_code
  is '预算级次代码';
comment on column BGT_PM_ANNUAL_ZK.found_type_code
  is '资金来源代码';
comment on column BGT_PM_ANNUAL_ZK.create_time
  is '创建时间';
comment on column BGT_PM_ANNUAL_ZK.pro_name
  is '项目名称';
comment on column BGT_PM_ANNUAL_ZK.agency_guid
  is '单位名称';
comment on column BGT_PM_ANNUAL_ZK.pro_kind_name
  is '项目类别名称';
comment on column BGT_PM_ANNUAL_ZK.finintorg_guid
  is '财政内部机构';
comment on column BGT_PM_ANNUAL_ZK.is_govpurch
  is '是否政府采购';
comment on column BGT_PM_ANNUAL_ZK.is_construction
  is '是否基建';
comment on column BGT_PM_ANNUAL_ZK.busiorg_guid
  is '归口处室';
comment on column BGT_PM_ANNUAL_ZK.agency_type
  is '单位类别';
comment on column BGT_PM_ANNUAL_ZK.prodetailinfo
  is '项目明细信息';
comment on column BGT_PM_ANNUAL_ZK.mof_div_code
  is '财政区划代码';
comment on column BGT_PM_ANNUAL_ZK.bgt_pman_id
  is '项目年度预算主键';
comment on column BGT_PM_ANNUAL_ZK.batchno
  is '批次号';
comment on column BGT_PM_ANNUAL_ZK.exp_func_guid
  is '支出功能分类科目';
comment on column BGT_PM_ANNUAL_ZK.xs
  is '系数';
comment on column BGT_PM_ANNUAL_ZK.dep_bgt_eco_guid
  is '部门支出经济分类';
comment on column BGT_PM_ANNUAL_ZK.is_govserve
  is '是否政府购买';
comment on column BGT_PM_ANNUAL_ZK.agency_name
  is '单位名称';
comment on column BGT_PM_ANNUAL_ZK.budget_level_name
  is '预算级次名称';
comment on column BGT_PM_ANNUAL_ZK.dept_name
  is '部门名称';
comment on column BGT_PM_ANNUAL_ZK.exp_func_name
  is '支出功能分类科目名称';
comment on column BGT_PM_ANNUAL_ZK.found_type_name
  is '资金来源名称';
comment on column BGT_PM_ANNUAL_ZK.fund_type_name
  is '资金性质名称';
comment on column BGT_PM_ANNUAL_ZK.gov_bgt_eco_name
  is '政府支出经济分类科目名称';
comment on column BGT_PM_ANNUAL_ZK.is_assigned
  is '是否财政待分配支出';
comment on column BGT_PM_ANNUAL_ZK.manage_mof_dep_name
  is '业务管理处室名称';
comment on column BGT_PM_ANNUAL_ZK.mof_div_name
  is '财政区划名称';
comment on column BGT_PM_ANNUAL_ZK.dep_bgt_eco_name
  is '部门支出经济分类科目名称';
comment on column BGT_PM_ANNUAL_ZK.is_bgt_end
  is '是否结束';
comment on column BGT_PM_ANNUAL_ZK.is_gov_pur
  is '是否政府采购';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BGT_PM_ANNUAL_ZK
  add primary key (BGT_PMAN_ID);
  
  
----19.对下转移支付年度预算表调整调剂信息
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
  is '版本';
comment on column BGT_TRA_ZK.dataversion
  is '操作时间';
comment on column BGT_TRA_ZK.taskguid
  is '任务';
comment on column BGT_TRA_ZK.preset
  is '预留字段';
comment on column BGT_TRA_ZK.stage
  is '阶段';
comment on column BGT_TRA_ZK.dpt
  is 'DPT';
comment on column BGT_TRA_ZK.version
  is '版本';
comment on column BGT_TRA_ZK.bgt_pman_id
  is '项目年度预算主键';
comment on column BGT_TRA_ZK.mof_div_code
  is '财政区划代码';
comment on column BGT_TRA_ZK.fiscal_year
  is '预算年度';
comment on column BGT_TRA_ZK.agency_guid
  is '单位名称';
comment on column BGT_TRA_ZK.agency_code
  is '单位代码';
comment on column BGT_TRA_ZK.pro_kind
  is '项目类别名称';
comment on column BGT_TRA_ZK.pro_kind_code
  is '项目类别代码';
comment on column BGT_TRA_ZK.pro_code
  is '项目代码';
comment on column BGT_TRA_ZK.pro_name
  is '项目名称';
comment on column BGT_TRA_ZK.exp_func
  is '功能科目名称';
comment on column BGT_TRA_ZK.exp_func_code
  is '支出功能分类科目代码';
comment on column BGT_TRA_ZK.tp_func
  is '转移支付功能科目名称';
comment on column BGT_TRA_ZK.tp_func_code
  is '转移支付功能分类科目代码';
comment on column BGT_TRA_ZK.sub_mof_div
  is '下达区划';
comment on column BGT_TRA_ZK.sub_mof_div_code
  is '下级财政区划代码';
comment on column BGT_TRA_ZK.gov_bgt_eco
  is '政府支出经济分类名称';
comment on column BGT_TRA_ZK.gov_bgt_eco_code
  is '政府支出经济分类代码';
comment on column BGT_TRA_ZK.fund_type
  is '资金性质';
comment on column BGT_TRA_ZK.fund_type_code
  is '资金性质代码';
comment on column BGT_TRA_ZK.apply_up
  is '申报数';
comment on column BGT_TRA_ZK.fin_audit_money
  is '财政审核数';
comment on column BGT_TRA_ZK.dept_code
  is '部门代码';
comment on column BGT_TRA_ZK.manage_mof_dep_code
  is '业务主管处室代码';
comment on column BGT_TRA_ZK.update_time
  is '更新时间';
comment on column BGT_TRA_ZK.apply_link
  is '申报环节';
comment on column BGT_TRA_ZK.reply_amt
  is '年初批复数';
comment on column BGT_TRA_ZK.adj_amt
  is '调整金额';
comment on column BGT_TRA_ZK.dis_amt
  is '调剂金额';
comment on column BGT_TRA_ZK.cur_amt
  is '变动后预算数';
comment on column BGT_TRA_ZK.is_deleted
  is '是否删除';
comment on column BGT_TRA_ZK.budget_level_code
  is '预算级次代码';
comment on column BGT_TRA_ZK.found_type_code
  is '资金来源代码';
comment on column BGT_TRA_ZK.create_time
  is '创建时间';
comment on column BGT_TRA_ZK.agency_type
  is '单位类别';
comment on column BGT_TRA_ZK.tra_type
  is '转移支付类型';
comment on column BGT_TRA_ZK.isleaf
  is '叶子节点';
comment on column BGT_TRA_ZK.levelno
  is '级次';
comment on column BGT_TRA_ZK.exp_eco
  is '部门经济科目名称';
comment on column BGT_TRA_ZK.exp_eco_code
  is '部门经济科目代码';
comment on column BGT_TRA_ZK.promaininfo
  is '一级项目';
comment on column BGT_TRA_ZK.super_tra
  is '上级转移支付项目';
comment on column BGT_TRA_ZK.templateguid
  is '模板主键';
comment on column BGT_TRA_ZK.prodetailinfo
  is '申报项目';
comment on column BGT_TRA_ZK.isgovpurch
  is '是否政府采购';
comment on column BGT_TRA_ZK.isconstruction
  is '是否基建';
comment on column BGT_TRA_ZK.remark
  is '备注';
comment on column BGT_TRA_ZK.ordernum
  is '排序字段';
comment on column BGT_TRA_ZK.agency_name
  is '单位名称';
comment on column BGT_TRA_ZK.budget_level_name
  is '预算级次名称';
comment on column BGT_TRA_ZK.dept_name
  is '部门名称';
comment on column BGT_TRA_ZK.exp_func_name
  is '支出功能分类科目名称';
comment on column BGT_TRA_ZK.found_type_name
  is '资金来源名称';
comment on column BGT_TRA_ZK.fund_type_name
  is '资金性质名称';
comment on column BGT_TRA_ZK.gov_bgt_eco_name
  is '政府支出经济分类科目名称';
comment on column BGT_TRA_ZK.is_assigned
  is '是否财政待分配支出';
comment on column BGT_TRA_ZK.manage_mof_dep_name
  is '业务管理处室名称';
comment on column BGT_TRA_ZK.mof_div_name
  is '财政区划名称';
comment on column BGT_TRA_ZK.sub_mof_div_name
  is '下级财政区划名称';
comment on column BGT_TRA_ZK.tp_func_name
  is '转移支付功能分类科目名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BGT_TRA_ZK
  add constraint PK_BGT_TRA_ZK primary key (BGT_PMAN_ID);
