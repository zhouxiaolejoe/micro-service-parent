--ÖÐÌ¨¿âÖ´ÐÐ
DECLARE
  I INTEGER;
  J INTEGER;
  A INTEGER;
  B INTEGER;
  C INTEGER;
  D INTEGER;
BEGIN
   SELECT COUNT(1) INTO I FROM USER_TABLES WHERE TABLE_NAME='FPMV_PAY'; 
     IF I<=0 THEN
        EXECUTE IMMEDIATE '
        create table FPMV_PAY
        (
          guid                VARCHAR2(38) not null,
          bdgagency           VARCHAR2(256) not null,
          amt                 VARCHAR2(256) not null,
          expecoguid          VARCHAR2(256),
          expfuncguid         VARCHAR2(256) not null,
          govexpecoguid       VARCHAR2(256),
          paytype             VARCHAR2(256) not null,
          accttpye            VARCHAR2(256) not null,
          gatherbankcode      VARCHAR2(256),
          gatherbankname      VARCHAR2(256),
          gatherbankacctcode  VARCHAR2(256) not null,
          gatherbankacctname  VARCHAR2(256) not null,
          paymentbankcode     VARCHAR2(256),
          paymentbankname     VARCHAR2(256),
          paymentbankacctcode VARCHAR2(256) not null,
          paymentbankacctname VARCHAR2(256) not null,
          fundtypeguid        VARCHAR2(256) not null,
          province            VARCHAR2(256) not null,
          year                VARCHAR2(256) not null,
          dbversion           VARCHAR2(256) not null,
          userguid            VARCHAR2(256),
          indiid              VARCHAR2(256),
          finintorgguid       VARCHAR2(256) not null,
          thirdindi           VARCHAR2(256) not null,
          indiguid            VARCHAR2(256),
          bgtdocno            VARCHAR2(256) not null,
          procode             VARCHAR2(256) not null,
          proname             VARCHAR2(256) not null,
          payvchguid          VARCHAR2(256) not null,
          status              VARCHAR2(1),
          payno               VARCHAR2(256),
          opertype            VARCHAR2(256),
          billcode            VARCHAR2(256) not null,
          paydate             VARCHAR2(256) not null,
          usage               VARCHAR2(256) not null,
          setmodecode         VARCHAR2(256) not null,
          ischeck             VARCHAR2(256),
          forpaycode          VARCHAR2(256),
          indiamt             VARCHAR2(256) not null,
          availableamt        VARCHAR2(256),
          verifamt            VARCHAR2(256),
          superguid           VARCHAR2(256),
          ordernum            VARCHAR2(256),
          sysid               VARCHAR2(256) not null,
          qksfbs              VARCHAR2(256) not null,
          directfunds         VARCHAR2(256) not null,
          subsidy             VARCHAR2(256) not null,
          zdzjjqpt            VARCHAR2(256) not null,
          ylzd1               VARCHAR2(32),
          ylzd2               VARCHAR2(32),
          ylzd3               VARCHAR2(32)
        )
        ';
     END IF;
   SELECT COUNT(1) INTO J FROM USER_TABLES WHERE TABLE_NAME='FPMV_PAY_LOG'; 
     IF J<=0 THEN
        EXECUTE IMMEDIATE '
        create table FPMV_PAY_LOG
        (
          guid                VARCHAR2(38) not null,
          bdgagency           VARCHAR2(256) not null,
          amt                 VARCHAR2(256) not null,
          expecoguid          VARCHAR2(256),
          expfuncguid         VARCHAR2(256) not null,
          govexpecoguid       VARCHAR2(256),
          paytype             VARCHAR2(256) not null,
          accttpye            VARCHAR2(256) not null,
          gatherbankcode      VARCHAR2(256),
          gatherbankname      VARCHAR2(256),
          gatherbankacctcode  VARCHAR2(256) not null,
          gatherbankacctname  VARCHAR2(256) not null,
          paymentbankcode     VARCHAR2(256),
          paymentbankname     VARCHAR2(256),
          paymentbankacctcode VARCHAR2(256) not null,
          paymentbankacctname VARCHAR2(256) not null,
          fundtypeguid        VARCHAR2(256) not null,
          province            VARCHAR2(256) not null,
          year                VARCHAR2(256) not null,
          dbversion           VARCHAR2(256) not null,
          userguid            VARCHAR2(256),
          indiid              VARCHAR2(256),
          finintorgguid       VARCHAR2(256) not null,
          thirdindi           VARCHAR2(256) not null,
          indiguid            VARCHAR2(256),
          bgtdocno            VARCHAR2(256) not null,
          procode             VARCHAR2(256) not null,
          proname             VARCHAR2(256) not null,
          payvchguid          VARCHAR2(256) not null,
          status              VARCHAR2(1),
          payno               VARCHAR2(256),
          opertype            VARCHAR2(256),
          billcode            VARCHAR2(256) not null,
          paydate             VARCHAR2(256) not null,
          usage               VARCHAR2(256) not null,
          setmodecode         VARCHAR2(256) not null,
          ischeck             VARCHAR2(256),
          forpaycode          VARCHAR2(256),
          indiamt             VARCHAR2(256) not null,
          availableamt        VARCHAR2(256),
          verifamt            VARCHAR2(256),
          superguid           VARCHAR2(256),
          ordernum            VARCHAR2(256),
          sysid               VARCHAR2(256) not null,
          qksfbs              VARCHAR2(256) not null,
          directfunds         VARCHAR2(256) not null,
          subsidy             VARCHAR2(256) not null,
          zdzjjqpt            VARCHAR2(256) not null,
          action              VARCHAR2(50) not null,
          operatetime         VARCHAR2(50) not null,
          datalogid           NUMBER(11) not null,
          ylzd1               VARCHAR2(32),
          ylzd2               VARCHAR2(32),
          ylzd3               VARCHAR2(32)
        )
        ';
     END IF;
     
     
     SELECT COUNT(1) INTO A FROM USER_TABLES WHERE TABLE_NAME='FPMV_INDI'; 
     IF A<=0 THEN
        EXECUTE IMMEDIATE '
        create table FPMV_INDI
        (
          indiguid        VARCHAR2(32) not null,
          sourceindi      VARCHAR2(256),
          bgtdocno        VARCHAR2(256) not null,
          bdgagency       VARCHAR2(256) not null,
          finintorgguid   VARCHAR2(256) not null,
          expfunc         VARCHAR2(256) not null,
          paytype         VARCHAR2(256) not null,
          fundtype        VARCHAR2(256),
          govexpeconormic VARCHAR2(256) not null,
          procode         VARCHAR2(256) not null,
          proname         VARCHAR2(256) not null,
          amt             VARCHAR2(256) not null,
          province        VARCHAR2(256) not null,
          year            VARCHAR2(256) not null,
          status          VARCHAR2(1) not null,
          ylzd1           VARCHAR2(32),
          ylzd2           VARCHAR2(32),
          ylzd3           VARCHAR2(32)
        )
        ';
     END IF;
     
     SELECT COUNT(1) INTO B FROM USER_TABLES WHERE TABLE_NAME='FPMV_INDI_LOG'; 
     IF B<=0 THEN
        EXECUTE IMMEDIATE '
        create table FPMV_INDI_LOG
        (
          indiguid        VARCHAR2(32) not null,
          sourceindi      VARCHAR2(256),
          bgtdocno        VARCHAR2(256) not null,
          bdgagency       VARCHAR2(256) not null,
          finintorgguid   VARCHAR2(256) not null,
          expfunc         VARCHAR2(256) not null,
          paytype         VARCHAR2(256) not null,
          fundtype        VARCHAR2(256),
          govexpeconormic VARCHAR2(256) not null,
          procode         VARCHAR2(256) not null,
          proname         VARCHAR2(256) not null,
          amt             VARCHAR2(256) not null,
          province        VARCHAR2(256) not null,
          year            VARCHAR2(256) not null,
          status          VARCHAR2(1) not null,
          action          VARCHAR2(50) not null,
          operatetime     VARCHAR2(50) not null,
          datalogid       NUMBER(11) not null,
          ylzd1           VARCHAR2(32),
          ylzd2           VARCHAR2(32),
          ylzd3           VARCHAR2(32)
        )
        ';
     END IF;
     
     
      SELECT COUNT(1) INTO C FROM USER_TABLES WHERE TABLE_NAME='FPMV_INDIAPI'; 
     IF C<=0 THEN
        EXECUTE IMMEDIATE '
        create table FPMV_INDIAPI
        (
          amt           VARCHAR2(32) not null,
          yzbxtguid     VARCHAR2(256) not null,
          status        VARCHAR2(1) not null,
          bgtdocno      VARCHAR2(256) not null,
          agencyguid    VARCHAR2(256) not null,
          procode       VARCHAR2(256) not null,
          proname       VARCHAR2(256) not null,
          expfuncguid   VARCHAR2(256) not null,
          expecoguid    VARCHAR2(256),
          finintorgguid VARCHAR2(256) not null,
          zfysjjflbz    VARCHAR2(256) not null,
          remark        VARCHAR2(256),
          paytypeguid   VARCHAR2(256) not null,
          oldvchtypeid  VARCHAR2(256),
          indiguid      VARCHAR2(256) not null,
          sysid         VARCHAR2(256) not null,
          province      VARCHAR2(256) not null,
          year          VARCHAR2(256) not null,
          dbversion     VARCHAR2(256) not null,
          qksfbs        VARCHAR2(256) not null,
          directfunds   VARCHAR2(256) not null,
          subsidy       VARCHAR2(256) not null,
          zdzjjqpt      VARCHAR2(256) not null,
          ylzd1         VARCHAR2(32),
          ylzd2         VARCHAR2(32),
          ylzd3         VARCHAR2(32)
        )
        ';
     END IF;
     
     
      SELECT COUNT(1) INTO D FROM USER_TABLES WHERE TABLE_NAME='FPMV_INDIAPI_LOG'; 
     IF D<=0 THEN
        EXECUTE IMMEDIATE '
        create table FPMV_INDIAPI_LOG
        (
          amt           VARCHAR2(32) not null,
          yzbxtguid     VARCHAR2(256) not null,
          status        VARCHAR2(1) not null,
          bgtdocno      VARCHAR2(256) not null,
          agencyguid    VARCHAR2(256) not null,
          procode       VARCHAR2(256) not null,
          proname       VARCHAR2(256) not null,
          expfuncguid   VARCHAR2(256) not null,
          expecoguid    VARCHAR2(256),
          finintorgguid VARCHAR2(256) not null,
          zfysjjflbz    VARCHAR2(256) not null,
          remark        VARCHAR2(256),
          paytypeguid   VARCHAR2(256) not null,
          oldvchtypeid  VARCHAR2(256),
          indiguid      VARCHAR2(256) not null,
          sysid         VARCHAR2(256) not null,
          province      VARCHAR2(256) not null,
          year          VARCHAR2(256) not null,
          dbversion     VARCHAR2(256) not null,
          qksfbs        VARCHAR2(256) not null,
          directfunds   VARCHAR2(256) not null,
          subsidy       VARCHAR2(256) not null,
          zdzjjqpt      VARCHAR2(256) not null,
          ylzd1         VARCHAR2(32),
          ylzd2         VARCHAR2(32),
          ylzd3         VARCHAR2(32),
          action        VARCHAR2(50) not null,
          operatetime   VARCHAR2(50) not null,
          datalogid     NUMBER(11) not null
        )
        ';
     END IF;
     
     EXECUTE IMMEDIATE '
       alter table FPMV_PAY
             add constraint FPMV_PAY_PK primary key (GUID)
        ';
        
        EXECUTE IMMEDIATE '
       alter table FPMV_INDI
add constraint UN_FPMV_INDI_INDIGUID unique (INDIGUID)
        ';
        
        
          EXECUTE IMMEDIATE '
     alter table FPMV_INDIAPI
add constraint PK_FPMV_INDIAPI primary key (YZBXTGUID, INDIGUID)
        ';

     
END;
