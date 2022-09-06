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
 * @Date 2022-07-26 14:43
 */

/**
 * 预算拨款凭证信息
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PayAllocationCertPO implements Serializable {
    /**
     * 拨款凭证主键
     */
    private String PAY_ALLOC_CERT_ID;

    /**
     * 凭证日期
     */
    private Date VOU_DATE;

    /**
     * 财政区划代码
     */
    private String MOF_DIV_CODE;

    /**
     * 预算年度
     */
    private String FISCAL_YEAR;

    /**
     * 单位代码
     */
    private String AGENCY_CODE;

    /**
     * 拨款凭证号
     */
    private String PAY_ALLOC_CERT_NO;

    /**
     * 付款人全称
     */
    private String PAY_ACCT_NAME;

    /**
     * 付款人
     */
    private String PAY_ACCT_NO;

    /**
     * 付款人开户银行
     */
    private String PAY_ACCT_BANK_NAME;

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
     * 外币金额
     */
    private BigDecimal FOREIGN_AMT;

    /**
     * 币种代码
     */
    private String CURRENCY_CODE;

    /**
     * 汇率
     */
    private BigDecimal EST_RAT;

    /**
     * 用途
     */
    private String USE_DES;

    /**
     * 支出功能分类科目代码
     */
    private String EXP_FUNC_CODE;

    /**
     * 政府支出经济分类代码
     */
    private String GOV_BGT_ECO_CODE;

    /**
     * 项目代码
     */
    private String PRO_CODE;

    /**
     * 指标主键
     */
    private String BGT_ID;

    /**
     * 资金性质代码
     */
    private String FUND_TYPE_CODE;

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

    /**
     * 拨款类型代码
     */
    private String PAY_ALLOC_TYPE;

    /**
     * 实际拨款日期
     */
    private Date ACC_DATE;

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

    /**
     * 资金性质名称
     */
    private String FUND_TYPE_NAME;

    /**
     * 支出功能分类科目名称
     */
    private String EXP_FUNC_NAME;

    /**
     * 政府支出经济分类名称
     */
    private String GOV_BGT_ECO_NAME;

    /**
     * 项目名称
     */
    private String PRO_NAME;

    /**
     * 币种名称
     */
    private String CURRENCY_NAME;

    /**
     * 拨款类型名称
     */
    private String PAY_ALLOC_TYPE_NAME;

    /**
     * 拨款金额
     */
    private BigDecimal PAY_AMT;

    private static final long serialVersionUID = 1L;
}