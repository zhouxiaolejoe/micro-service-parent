-- Create table
create table FASP_T_SYNCDATABASE
(
  datasourceid    VARCHAR2(50) not null,
  businesstype    VARCHAR2(50),
  businessname    VARCHAR2(150),
  url             VARCHAR2(500) not null,
  username        VARCHAR2(50) not null,
  password        VARCHAR2(50) not null,
  driverclassname VARCHAR2(50) not null,
  createtime      TIMESTAMP(6),
  createuser      VARCHAR2(50),
  updatetime      TIMESTAMP(6),
  updateuser      VARCHAR2(50),
  dbversion       TIMESTAMP(6),
  isdelete        NUMBER,
  publickey       VARCHAR2(500),
  databasetype    NUMBER,
  guid            VARCHAR2(32) not null,
  issync          NUMBER,
  province        VARCHAR2(32),
  year            VARCHAR2(32)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table FASP_T_SYNCDATABASE
  add constraint UK_DS_ID unique (DATASOURCEID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
