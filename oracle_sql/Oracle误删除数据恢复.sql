select * from tablename as of timestamp to_timestamp('2018-05-04 13:30:00','yyyy-MM-dd hh24:mi:ss')
/**
��ѯ���ʱ��������

���п�����Ϊϵͳʱ������ݿ�ʱ�䲻һ�²鲻������ �����Ȳ�ѯ���ݿ��ʱ��

select  to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual

�������ʱ��Ϊ׼���ҵ�����ɾ��ʱ��֮ǰ�����ݣ�

�ҵ����ݿ��Ե���ΪExcel ����ô�ָ��Ͳ���������

flashback table tablename to timestamp to_timestamp('2018-05-04 13:30:00','yyyy-MM-dd hh24:mi:ss')

ִ�������������ݻָ������ʱ���

---------------------------------------------

���� ORA-08189: ��Ϊδ�������ƶ�����, �������ر�

alter table tablename  enable row movement

�������ƶ�����

*/
