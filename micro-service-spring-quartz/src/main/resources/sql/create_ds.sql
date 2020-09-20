create table FASP_T_SYNCDATABASE
(
  datasourceid    VARCHAR2(50) not null,
  businesstype    VARCHAR2(50),
  businessname    VARCHAR2(50),
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
  issync          NUMBER
)