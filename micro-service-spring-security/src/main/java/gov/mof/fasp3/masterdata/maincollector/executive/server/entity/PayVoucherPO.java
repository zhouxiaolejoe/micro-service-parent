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
 * @Date 2022-07-26 14:18
 */

/**
 * 国库集中支付申请信息
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PayVoucherPO implements Serializable {
    /**
     * 支付申请主键
     */
    private String PAY_APP_ID;

    /**
     * 支付凭证主键
     */
    private String PAY_CERT_ID;

    /**
     * 资金性质代码
     */
    private String FUND_TYPE_CODE;

    /**
     * 预算年度
     */
    private String FISCAL_YEAR;

    /**
     * 付款人全称
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
     * 实际支付金额
     */
    private BigDecimal XPAY_AMT;

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
     * 项目代码
     */
    private String PRO_CODE;

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

    /**
     * 支付业务类型代码
     */
    private String PAY_BUS_TYPE_CODE;

    private String PARAM_1;

    private String PARAM_2;

    private String PARAM_3;

    private String PARAM_4;

    private String PARAM_5;

    private BigDecimal PARAM_6;

    private BigDecimal PARAM_7;

    private BigDecimal PARAM_8;

    private BigDecimal PARAM_9;

    /**
     *
     */
    private BigDecimal PARAM_10;

    /**
     * 指标主键
     */
    private String BGT_ID;

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
     * 指标类型名称
     */
    private String BGT_TYPE_NAME;

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
     * 项目类别名称
     */
    private String PRO_KIND_NAME;

    /**
     * 支付方式名称
     */
    private String PAY_TYPE_NAME;

    /**
     * 结算方式名称
     */
    private String SET_MODE_NAME;

    /**
     * 资金往来对象类别名称
     */
    private String FUND_TRAOBJ_TYPE_NAME;

    /**
     * 币种名称
     */
    private String CURRENCY_NAME;

    /**
     * 债券名称
     */
    private String BOND_NAME;

    /**
     * 指标类型代码
     */
    private String BGT_TYPE_CODE;

    /**
     * 债券代码
     */
    private String BOND_CODE;

    /**
     * 采购合同编号
     */
    private String CONTRACT_NO;

    /**
     * 申请日期
     */
    private Date CREATE_DATE;

    /**
     * 托收申请编号
     */
    private String ENTPAY_APP_NO;

    /**
     * 资金往来对象类别代码
     */
    private String FUND_TRAOBJ_TYPE_CODE;

    /**
     * 单位内部机构代码
     */
    private String INTERNAL_DEP_CODE;

    /**
     * 单位内部机构名称
     */
    private String INTERNAL_DEP_NAME;

    /**
     * 支付申请金额
     */
    private BigDecimal PAY_APP_AMT;

    /**
     * 支付申请编号
     */
    private String PAY_APP_NO;

    /**
     * 支付业务类型名称
     */
    private String PAY_BUS_TYPE_NAME;

    /**
     * 支付方式代码
     */
    private String PAY_TYPE_CODE;

    /**
     * 项目类别
     */
    private String PRO_CAT_CODE;

    /**
     * 国外贷款赠款协议号
     */
    private String PRO_LOANGRANT_NUM;

    private static final long serialVersionUID = 1L;
}