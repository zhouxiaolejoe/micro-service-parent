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
 * @Date 2022-07-26 15:19
 */

/**
 * 单位资金支付明细信息
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class IncDetailPO implements Serializable {
    /**
     * 支付明细表主键
     */
    private String PAY_DETAIL_ID;

    /**
     * 单位代码
     */
    private String AGENCY_CODE;

    /**
     * 收款人全称
     */
    private String PAYEE_ACCT_NAME;

    /**
     * 收款人账号
     */
    private String PAYEE_ACCT_NO;

    /**
     * 收款人开户银行
     */
    private String PAYEE_ACCT_BANK_NAME;

    /**
     * 支付金额
     */
    private BigDecimal PAY_AMT;

    /**
     * 实际支付金额
     */
    private BigDecimal XPAY_AMT;

    /**
     * 附言
     */
    private String ADD_WORD;

    /**
     * 支付凭证号
     */
    private String PAY_CERT_NO;

    /**
     * 支付申请主键
     */
    private String PAY_APPLY_ID;

    /**
     * 业务追溯识别码
     */
    private String TRACKING_ID;

    /**
     * 预算年度
     */
    private String FISCAL_YEAR;

    /**
     * 财政区划代码
     */
    private String MOF_DIV_CODE;

    /**
     * 收款人代码
     */
    private String RECEIVER_CODE;

    /**
     * 更新时间
     */
    private Date UPDATE_TIME;

    /**
     * 是否删除
     */
    private String IS_DELETED;

    /**
     * 创建时间
     */
    private Date CREATE_TIME;

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

    /**
     * 财政区划名称
     */
    private String MOF_DIV_NAME;

    /**
     * 单位名称
     */
    private String AGENCY_NAME;

    private static final long serialVersionUID = 1L;
}