--1.��Ŀ�ȵ������Ϣ��ѯ
SELECT t.*,t.rowid from PM_HOT_TOPICCATE t;

--2.ָ����Ϣ
SELECT t.*,t.rowid from BA_BGT_INFO t;

--3.���⼯��֧��������Ϣ
SELECT t.*,t.rowid from PAY_VOUCHER t;

--4.���⼯��֧��ƾ֤��Ϣ
SELECT t.*,t.rowid from PAY_VOUCHER_BILL t;

--5.���⼯��֧����ϸ��Ϣ
SELECT t.*,t.rowid from PAY_DETAIL t;

--6.Ԥ�㲦��ƾ֤��Ϣ
SELECT t.*,t.rowid from PAY_ALLOCATION_CERT t;

--7.��λ�ʽ�֧��������Ϣ
SELECT t.*,t.rowid from INC_APPLY t;


--8.��λ�ʽ�֧��ƾ֤��Ϣ
SELECT t.*,t.rowid from INC_CERT t;


--9.��λ�ʽ�֧����ϸ��Ϣ
SELECT t.*,t.rowid from INC_DETAIL t;


--10.�����ʽ��תָ����Ϣ
SELECT t.*,t.rowid from BA_BGT_CARRYOVERS t;

--11.�����ʽ����ָ����Ϣ
SELECT t.*,t.rowid from BA_BGT_BALANCE t;

--12.��λ�ʽ��תָ����Ϣ

SELECT t.*,t.rowid from BA_BGT_CARRYOVERS_AGENCY t;

--13.��λ�ʽ����ָ����Ϣ
SELECT t.*,t.rowid from BA_BGT_BALANCE_AGENCY t;
--14.��˰һ��ɿ���
SELECT t.*,t.rowid from NON_TAX_PAY t;
--15.��˰һ��ɿ�������
SELECT t.*,t.rowid from NON_TAX_PAY_DETAIL t;
--16.��˰�˸�����
SELECT t.*,t.rowid FROM PAY_BACK_INFO t;
--17.�ÿ�ƻ���Ϣ
SELECT t.*,t.rowid from PAY_PLAN_VOUCHER t;


--18.����Ԥ����Ŀ���Ԥ�����Ϣ
SELECT t.*,t.rowid from BGT_PM_ANNUAL_ZK t;

--19.����ת��֧�����Ԥ������������Ϣ
SELECT t.*,t.rowid from BGT_TRA_ZK t;








