--1.项目热点分类信息查询
SELECT t.*,t.rowid from PM_HOT_TOPICCATE t;

--2.指标信息
SELECT t.*,t.rowid from BA_BGT_INFO t;

--3.国库集中支付申请信息
SELECT t.*,t.rowid from PAY_VOUCHER t;

--4.国库集中支付凭证信息
SELECT t.*,t.rowid from PAY_VOUCHER_BILL t;

--5.国库集中支付明细信息
SELECT t.*,t.rowid from PAY_DETAIL t;

--6.预算拨款凭证信息
SELECT t.*,t.rowid from PAY_ALLOCATION_CERT t;

--7.单位资金支付申请信息
SELECT t.*,t.rowid from INC_APPLY t;


--8.单位资金支付凭证信息
SELECT t.*,t.rowid from INC_CERT t;


--9.单位资金支付明细信息
SELECT t.*,t.rowid from INC_DETAIL t;


--10.财政资金结转指标信息
SELECT t.*,t.rowid from BA_BGT_CARRYOVERS t;

--11.财政资金结余指标信息
SELECT t.*,t.rowid from BA_BGT_BALANCE t;

--12.单位资金结转指标信息

SELECT t.*,t.rowid from BA_BGT_CARRYOVERS_AGENCY t;

--13.单位资金结余指标信息
SELECT t.*,t.rowid from BA_BGT_BALANCE_AGENCY t;
--14.非税一般缴款书
SELECT t.*,t.rowid from NON_TAX_PAY t;
--15.非税一般缴款书详情
SELECT t.*,t.rowid from NON_TAX_PAY_DETAIL t;
--16.非税退付申请
SELECT t.*,t.rowid FROM PAY_BACK_INFO t;
--17.用款计划信息
SELECT t.*,t.rowid from PAY_PLAN_VOUCHER t;


--18.部门预算项目年度预算表信息
SELECT t.*,t.rowid from BGT_PM_ANNUAL_ZK t;

--19.对下转移支付年度预算表调整调剂信息
SELECT t.*,t.rowid from BGT_TRA_ZK t;








