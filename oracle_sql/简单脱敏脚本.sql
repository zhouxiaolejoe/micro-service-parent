CREATE OR REPLACE FUNCTION F_GET_SENSITIVE(IN_STR VARCHAR, IN_TYPE NUMBER)
 RETURN VARCHAR2 IS
 V_STR_LENGTH NUMBER;
 V_NAME    VARCHAR2(1000);
 V_N     NUMBER;
 V_HID    VARCHAR2(200);
 V_SQL    VARCHAR2(200);
 V_NUM_FLAG  NUMBER;
 /****
 N_TYPE 脱敏字段类型
 1 ：名称
 11:地址
 2 ：证件
 3 ：银行账号
 4 ：联系电话
 5 ：接入号码
 ***/
BEGIN
 V_STR_LENGTH := LENGTH(IN_STR);
 V_N     := 0;
 IF V_STR_LENGTH=0 THEN
   RETURN(NULL);
 END IF;
 /**********名称和地址脱敏规则**********/
 IF IN_TYPE = 1 OR IN_TYPE=11 THEN
  IF V_STR_LENGTH = 2 OR V_STR_LENGTH = 3 THEN
   V_NAME := REGEXP_REPLACE(IN_STR, '(.)', '*', 2, 1);
  ELSIF V_STR_LENGTH < 2 THEN
   V_NAME :=IN_STR;
  ELSE
   WHILE V_N < V_STR_LENGTH / 2 LOOP
    V_N  := V_N + 1;
    V_HID := V_HID || '*';
   END LOOP;
   V_NAME := SUBSTR(IN_STR, 0, V_STR_LENGTH / 2) || V_HID;
  END IF;
  RETURN(V_NAME);
 END IF;
 /**********证件脱敏规则**********/
 IF IN_TYPE = 2 THEN
  IF V_STR_LENGTH = 15 THEN
   V_NAME := SUBSTR(IN_STR, 0, 6) || '******' || SUBSTR(IN_STR, -3, 3);
  ELSIF V_STR_LENGTH = 18 THEN
   V_NAME := SUBSTR(IN_STR, 0, 6) || '********' || SUBSTR(IN_STR, -4, 4);
  ELSE
   WHILE V_N < V_STR_LENGTH / 3 LOOP
    V_N  := V_N + 1;
    V_HID := V_HID || '*';
   END LOOP;
   V_NAME := SUBSTR(IN_STR, 0, V_STR_LENGTH / 3) || V_HID ||
        SUBSTR(IN_STR, -V_STR_LENGTH / 3, V_STR_LENGTH / 3);
  END IF;
  RETURN(V_NAME);
 END IF;
 /**********银行账号脱敏规则**********/
 IF IN_TYPE = 3 THEN
  IF V_STR_LENGTH > 15 THEN
   V_NAME := SUBSTR(IN_STR, 0, 4) || '********' || SUBSTR(IN_STR, -4, 4);
  ELSE
   V_NAME :=IN_STR;
  END IF;
   RETURN(V_NAME);
 END IF;
 /**********联系电话脱敏规则**********/
 IF IN_TYPE = 4 THEN
  V_NAME := SUBSTR(IN_STR, 0, V_STR_LENGTH - 4) || '****';
  RETURN(V_NAME);
 END IF;
 /**********接入号码脱敏规则**********/
 IF IN_TYPE = 5 THEN
  V_SQL := 'SELECT COUNT(1) FROM DUAL WHERE LENGTH(''' || IN_STR ||
       ''') = LENGTH(REGEXP_REPLACE(''' || IN_STR || ''', ''[^0-9]''))';
  EXECUTE IMMEDIATE V_SQL
   INTO V_NUM_FLAG;
  IF V_NUM_FLAG = 1 AND (V_STR_LENGTH = 7 OR V_STR_LENGTH = 8) THEN
   V_NAME := SUBSTR(IN_STR, 0, 2) || '****' || SUBSTR(IN_STR, -2, 2);
  ELSIF V_NUM_FLAG = 1 AND V_STR_LENGTH = 11 THEN
   V_NAME := SUBSTR(IN_STR, 0, 3) || '*****' || SUBSTR(IN_STR, -3, 3);
  ELSE
   V_NAME := IN_STR;
  END IF;
   RETURN(V_NAME);
 END IF;
 RETURN(IN_STR);
EXCEPTION
 WHEN OTHERS THEN
  -- DBMS_OUTPUT.PUT_LINE('1'||V_SQL);
  V_NAME := '-1';
  RETURN V_NAME;
END F_GET_SENSITIVE;
/*
首先执行这个存储过程
创建完上面的存储过程之后 将下面用户单位处室脚本依次执行

--用户表脱敏
update fasp_t_causer
 set name        = F_GET_SENSITIVE(name, 2),
 phonenumber = F_GET_SENSITIVE(phonenumber, 2),
 idcode      = F_GET_SENSITIVE(idcode, 2),
 email       = F_GET_SENSITIVE(email, 2),
 ak          = F_GET_SENSITIVE(ak, 2);


--单位表脱敏
update ele_vd00010
set ele_name            = F_GET_SENSITIVE(ele_name, 2),
 agency_abbreviation = F_GET_SENSITIVE(agency_abbreviation, 2),
 ind_code            = F_GET_SENSITIVE(ind_code, 2),
 ind                 = F_GET_SENSITIVE(ind, 2),
 address             = F_GET_SENSITIVE(address, 2),
 alias               = F_GET_SENSITIVE(alias, 2),
 unifsoccredcode     = F_GET_SENSITIVE(unifsoccredcode, 2),
 leadername          = F_GET_SENSITIVE(leadername, 2),
 tel                 = F_GET_SENSITIVE(tel, 2),
 zip                 = F_GET_SENSITIVE(zip, 2),
 location            = F_GET_SENSITIVE(location, 2);


--处室表脱敏
update ele_vc01004 set ele_name =F_GET_SENSITIVE(ele_name,2);

update ele_vd08001 set ele_name =F_GET_SENSITIVE(ele_name,2);

*/


