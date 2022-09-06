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
 * @Date 2022-07-26 15:02
 */

/**
 * 单位资金支付凭证信息
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class IncCertPO implements Serializable {
    /**
     * 支付凭证主键
     */
    private String PAY_CERT_ID;

    /**
     * 资金性质代码
     */
    private String FUND_TYPE_CODE;

    /**
     * 凭证日期
     */
    private Date VOU_DATE;

    /**
     * 预算年度
     */
    private String FISCAL_YEAR;

    /**
     * 支付凭证号
     */
    private String PAY_CERT_NO;

    /**
     * 付款人
     */
    private String PAY_ACCT_NAME;

    /**
     * 付款人账号
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
     * 支付金额
     */
    private BigDecimal PAY_AMT;

    /**
     * 支出功能分类科目代码
     */
    private String EXP_FUNC_CODE;

    /**
     * 政府支出经济分类代码
     */
    private String GOV_BGT_ECO_CODE;

    /**
     * 部门支出经济分类代码
     */
    private String DEP_BGT_ECO_CODE;

    /**
     * 项目代码
     */
    private String PRO_CODE;

    /**
     * 银行交易流水号
     */
    private String AGENT_BUSINESS_NO;

    /**
     * 实际支付金额
     */
    private BigDecimal XPAY_AMT;

    /**
     * 实际支付日期
     */
    private Date XPAY_DATE;

    /**
     * 单位代码
     */
    private String AGENCY_CODE;

    /**
     * 用途
     */
    private String USE_DES;

    /**
     * 结算方式代码
     */
    private String SET_MODE_CODE;

    /**
     * 财政区划代码
     */
    private String MOF_DIV_CODE;

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
     * 收款人代码
     */
    private String RECEIVER_CODE;

    /**
     * 回单附言
     */
    private String RECEIPT_ADD_WORD;

    /**
     * 实际收款人全称
     */
    private String XPAYEE_ACCT_NAME;

    /**
     * 实际收款人账号
     */
    private String XPAYEE_ACCT_NO;

    /**
     * 实际收款人开户银行名称
     */
    private String XPAYEE_ACCT_BANK_NAME;

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
     * 部门代码
     */
    private String DEPT_CODE;

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
     * 部门名称
     */
    private String DEPT_NAME;

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
     * 部门支出经济分类名称
     */
    private String DEP_BGT_ECO_NAME;

    /**
     * 项目名称
     */
    private String PRO_NAME;

    /**
     * 结算方式名称
     */
    private String SET_MODE_NAME;

    /**
     * 凭证摘要
     */
    private String ABSTRACT;

    /**
     * 币种名称
     */
    private String CURRENCY_NAME;

    private static final long serialVersionUID = 1L;
}