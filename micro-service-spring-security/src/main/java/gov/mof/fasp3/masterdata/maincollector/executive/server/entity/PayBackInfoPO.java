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
 * @Date 2022-07-26 16:16
 */
/**
    * 非税退付申请
    */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PayBackInfoPO implements Serializable {
    /**
    * 退付申请书主键
    */
    private String REF_ID;

    /**
    * 退付类型代码
    */
    private String PAYBACK_TYPE_CODE;

    /**
    * 财政区划代码
    */
    private String MOF_DIV_CODE;

    /**
    * 预算年度
    */
    private String FISCAL_YEAR;

    /**
    * 执收单位代码
    */
    private String EXEC_AGENCY_CODE;

    /**
    * 退付原因
    */
    private String REF_REASON;

    /**
    * 原非税收入一般缴款书票号
    */
    private String NON_TAX_PAY_NO;

    /**
    * 原非税收入一般缴款书缴款识别码
    */
    private String NON_TAX_PAY_CODE;

    /**
    * 退付金额
    */
    private BigDecimal REF_AMT;

    /**
    * 退付收款人全称
    */
    private String PAYBACK_RECEIVER_NAME;

    /**
    * 退付收款人账号
    */
    private String PAYBACK_RECEIVER_ACC_NO;

    /**
    * 退付收款人开户银行
    */
    private String PAYBACK_RECBANK_NAME;

    /**
    * 退款收款账户银行行号
    */
    private String PAYBACK_BANK_NO;

    /**
    * 退付账户全称
    */
    private String PAYBACK_ACC_NAME;

    /**
    * 退付账户账号
    */
    private String PAYBACK_ACC_NO;

    /**
    * 退付账户开户银行名称
    */
    private String PAYBACK_ACCBANK_NAME;

    /**
    * 退付申请书单号
    */
    private String REF_NO;

    /**
    * 退付日期
    */
    private Date REF_DATE;

    /**
    * 更新时间
    */
    private Date UPDATE_TIME;

    /**
    * 创建时间
    */
    private Date CREATE_TIME;

    /**
    * 政府非税收入执收项目代码
    */
    private String NON_TAX_CODE;

    /**
    * 政府非税收入执收项目名称
    */
    private String NON_TAX_NAME;

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