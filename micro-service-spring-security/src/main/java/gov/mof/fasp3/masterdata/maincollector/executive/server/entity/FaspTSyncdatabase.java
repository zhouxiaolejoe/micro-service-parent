package gov.mof.fasp3.masterdata.maincollector.executive.server.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.entity
 * @Author zxl
 * @Date 2022-08-25 11:26
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FaspTSyncdatabase implements Serializable {
    private String DATASOURCEID;

    private String BUSINESSTYPE;

    private String BUSINESSNAME;

    private String URL;

    private String USERNAME;

    private String PASSWORD;

    private String DRIVERCLASSNAME;

    private Date CREATETIME;

    private String CREATEUSER;

    private Date UPDATETIME;

    private String UPDATEUSER;

    private Date DBVERSION;

    private BigDecimal ISDELETE;

    private String PUBLICKEY;

    private BigDecimal DATABASETYPE;

    private String GUID;

    private BigDecimal ISSYNC;

    private String PROVINCE;

    private String YEAR;

    private String SERVERID;

    private String SRCPROVINCE;

    private String SRCYEAR;

    private static final long serialVersionUID = 1L;
}