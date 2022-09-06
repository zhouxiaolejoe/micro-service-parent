package gov.mof.fasp3.masterdata.maincollector.executive.server.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.entity
 * @Author zxl
 * @Date 2022-07-19 09:22
 */
/**
    * 往年非税收入信息
    */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FormerNontaxPO implements Serializable {
    /**
    * 预算年度
    */
    private String FISCAL_YEAR;

    /**
    * 单位代码
    */
    private String AGENCY_CODE;

    /**
    * 收费项目代码
    */
    private String NONTAX_PRO_CODE;

    /**
    * 收费项目名称
    */
    private String NONTAX_PRO_NAME;

    /**
    * 征收金额
    */
    private BigDecimal PAY_AMT;

    private String PARAM_1;

    private String PARAM_2;

    private String PARAM_3;

    private String PARAM_4;

    private String PARAM_5;

    private BigDecimal PARAM_6;

    private BigDecimal PARAM_7;

    private BigDecimal PARAM_8;

    private BigDecimal PARAM_9;

    private BigDecimal PARAM_10;

    private static final long serialVersionUID = 1L;
}