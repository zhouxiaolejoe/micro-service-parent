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
public class PayPlanVoucherPO implements Serializable {
    /**
    * 用款计划主键
    */
    private String PLAN_ID;

    /**
    * 预算年度
    */
    private String FISCAL_YEAR;

    /**
    * 财政区划代码
    */
    private String MOF_DIV_CODE;

    /**
    * 财政区划名称
    */
    private String MOF_DIV_NAME;

    /**
    * 计划明细编号
    */
    private String PLAN_VOUCHER_NO;

    /**
    * 计划月份
    */
    private String PLAN_MONTH;

    /**
    * 单位代码
    */
    private String AGENCY_CODE;

    /**
    * 单位名称
    */
    private String AGENCY_NAME;

    /**
    * 资金性质代码
    */
    private String FUND_TYPE_CODE;

    /**
    * 资金性质名称
    */
    private String FUND_TYPE_NAME;

    /**
    * 计划申请金额
    */
    private BigDecimal PLAN_APP_AMT;

    /**
    * 计划审批金额
    */
    private BigDecimal PLAN_AMT;

    /**
    * 债券代码
    */
    private String BOND_CODE;

    /**
    * 债券名称
    */
    private String BOND_NAME;

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
    * 指标主键
    */
    private String BGT_ID;

    /**
    * 预算部门代码
    */
    private String BGT_DEPT_CODE;

    /**
    * 预算部门名称
    */
    private String BGT_DEPT_NAME;

    /**
    * 指标管理处
    */
    private String BGT_MOF_DEP_CODE;

    /**
    * 指标管理处名称
    */
    private String BGT_MOF_DEP_NAME;

    /**
    * 业务主管处
    */
    private String MANAGE_MOF_DEP_CODE;

    /**
    * 业务主管处名称
    */
    private String MANAGE_MOF_DEP_NAME;

    /**
    * 指标类型代码
    */
    private String BGT_TYPE_CODE;

    /**
    * 指标类型名称
    */
    private String BGT_TYPE_NAME;

    /**
    * 支出功能分类科目代码
    */
    private String EXP_FUNC_CODE;

    /**
    * 支出功能分类科目名称
    */
    private String EXP_FUNC_NAME;

    /**
    * 政府支出经济分类代码
    */
    private String GOV_BGT_ECO_CODE;

    /**
    * 政府支出经济分类名称
    */
    private String GOV_BGT_ECO_NAME;

    /**
    * 部门支出经济分类代码
    */
    private String DEP_BGT_ECO_CODE;

    /**
    * 部门支出经济分类名称
    */
    private String DEP_BGT_ECO_NAME;

    /**
    * 项目代码
    */
    private String PRO_CODE;

    /**
    * 项目名称
    */
    private String PRO_NAME;

    /**
    * 支付方式代码
    */
    private String PAY_TYPE_CODE;

    /**
    * 支付方式名称
    */
    private String PAY_TYPE_NAME;

    /**
    * 用途
    */
    private String USE_DES;

    private static final long serialVersionUID = 1L;
}