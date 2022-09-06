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
 * @Date 2022-07-26 15:33
 */
/**
    * 非税一般缴款书
    */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NonTaxPayPO implements Serializable {
    /**
    * 缴款书主键
    */
    private String NT_PAY_VOUCHER_ID;

    /**
    * 政府非税收入缴款识别码
    */
    private String NON_TAX_PAY_CODE;

    /**
    * 财政区划代码
    */
    private String MOF_DIV_CODE;

    /**
    * 财政区划名称
    */
    private String MOF_DIV_NAME;

    /**
    * 执收单位代码
    */
    private String EXEC_AGENCY_CODE;

    /**
    * 执收单位名称
    */
    private String EXEC_AGENCY_NAME;

    /**
    * 政府非税收入一般缴款书票号
    */
    private String NON_TAX_PAY_NO;

    /**
    * 开票人
    */
    private String AUTHOR;

    /**
    * 开票日期
    */
    private Date BILL_DATE;

    /**
    * 缴款书有效期
    */
    private Date EFF_DATE;

    /**
    * 缴款人全称
    */
    private String PAYER_NAME;

    /**
    * 缴款人账号
    */
    private String PAYER_ACC_NO;

    /**
    * 缴款人开户银行
    */
    private String PAYER_OPEN_BANK;

    /**
    * 实际缴款人全称
    */
    private String ACT_PAYER_NAME;

    /**
    * 实际缴款人账号
    */
    private String ACT_PAYER_ACC_NO;

    /**
    * 实际缴款人开户银行
    */
    private String ACT_PAYER_OPEN_BANK;

    /**
    * 应缴金额合计
    */
    private BigDecimal TOTAL_PAY_AMT;

    /**
    * 应缴金额
    */
    private BigDecimal PAY_AMT;

    /**
    * 滞纳金金额
    */
    private BigDecimal DELAY_AMT;

    /**
    * 缴款金额
    */
    private BigDecimal PAID_AMT;

    /**
    * 收款账户类型
    */
    private String REC_ACCTTYPE;

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
    * 收款银行代码
    */
    private String PAYEE_ACCT_BANK_CODE;

    /**
    * 缴款日期
    */
    private Date PAY_DATE;

    /**
    * 缴款渠道代码
    */
    private String PAY_WAY_CODE;

    /**
    * 缴款渠道名称
    */
    private String PAY_WAY_NAME;

    /**
    * 收入归属区划
    */
    private String BELONG_ORG_CODE;

    /**
    * 收入归属区划名称
    */
    private String BELONG_ORG_NAME;

    /**
    * 入账日期
    */
    private Date RECORD_DATE;

    /**
    * 收缴方式代码
    */
    private String PAY_IN_MET_CODE;

    /**
    * 收缴方式名称
    */
    private String PAY_IN_MET_NAME;

    /**
    * 非税数据类型
    */
    private String BUS_TYPE;

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
    * 备用字段1
    */
    private String HOLD1;

    /**
    * 备用字段2
    */
    private String HOLD2;

    private static final long serialVersionUID = 1L;
}