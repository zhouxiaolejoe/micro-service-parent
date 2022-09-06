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
 * @Date 2022-07-26 15:49
 */
/**
    * 非税一般缴款书详情
    */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NonTaxPayDetail implements Serializable {
    /**
    * 序号
    */
    private String SORT_NO;

    /**
    * 缴款书主键
    */
    private String NT_PAY_VOUCHER_ID;

    /**
    * 政府非税收入执收项目识别码
    */
    private String NON_TAX_PROJ_CODE;

    /**
    * 政府非税收入执收项目代码
    */
    private String NON_TAX_CODE;

    /**
    * 政府非税收入执收项目名称
    */
    private String NON_TAX_NAME;

    /**
    * 收缴标准名称
    */
    private String CHARGE_STAND_NAME;

    /**
    * 资金性质代码
    */
    private String FUND_TYPE_CODE;

    /**
    * 资金性质名称
    */
    private String FUND_TYPE_NAME;

    /**
    * 收缴标准计量单位
    */
    private String CHARGE_STAND_UNIT;

    /**
    * 执收数量
    */
    private String PAY_NUMBER;

    /**
    * 缴款金额
    */
    private BigDecimal PAY_AMT;

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

    /**
    * 备用字段3
    */
    private String HOLD3;

    /**
    * 备用字段4
    */
    private String HOLD4;

    private static final long serialVersionUID = 1L;
}