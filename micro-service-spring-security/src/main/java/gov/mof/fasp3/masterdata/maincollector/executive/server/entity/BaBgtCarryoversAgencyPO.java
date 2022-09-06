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
 * @Date 2022-07-25 15:21
 */
/**
    * 单位资金结转指标信息
    */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BaBgtCarryoversAgencyPO implements Serializable {
    /**
    * 主键
    */
    private String CARRYOVERS_BGT_ID;

    /**
    * 预算年度
    */
    private String FISCAL_YEAR;

    /**
    * 批复数
    */
    private BigDecimal APPROVE_AMT;

    /**
    * 结转数
    */
    private BigDecimal CARRYOVERS_AMT;

    /**
    * 指标类型代码
    */
    private String BGT_TYPE_CODE;

    /**
    * 指标类型名称
    */
    private String BGT_TYPE_NAME;

    /**
    * 指标管理处室代码
    */
    private String BGT_MOF_DEP_CODE;

    /**
    * 指标管理处室名称
    */
    private String BGT_MOF_DEP_NAME;

    /**
    * 业务主管处室代码
    */
    private String MANAGE_MOF_DEP_CODE;

    /**
    * 业务主管处室名称
    */
    private String MANAGE_MOF_DEP_NAME;

    /**
    * 指标文号
    */
    private String COR_BGT_DOC_NO;

    /**
    * 指标说明
    */
    private String BGT_DEC;

    /**
    * 支出功能分类科目代码
    */
    private String EXP_FUNC_CODE;

    /**
    * 支出功能分类科目名称
    */
    private String EXP_FUNC_NAME;

    /**
    * 政府支出经济分类科目代码
    */
    private String GOV_BGT_ECO_CODE;

    /**
    * 政府支出经济分类科目名称
    */
    private String GOV_BGT_ECO_NAME;

    /**
    * 资金性质代码
    */
    private String FUND_TYPE_CODE;

    /**
    * 资金性质名称
    */
    private String FUND_TYPE_NAME;

    /**
    * 单位代码
    */
    private String AGENCY_CODE;

    /**
    * 单位名称
    */
    private String AGENCY_NAME;

    /**
    * 项目代码
    */
    private String PRO_CODE;

    /**
    * 项目名称
    */
    private String PRO_NAME;

    /**
    * 预算级次代码
    */
    private String BUDGET_LEVEL_CODE;

    /**
    * 预算级次名称
    */
    private String BUDGET_LEVEL_NAME;

    /**
    * 指标可执行标志
    */
    private String BGT_EXE_FLAG;

    /**
    * 源指标主键
    */
    private String ORI_BGT_ID;

    /**
    * 财政区划代码
    */
    private String MOF_DIV_CODE;

    /**
    * 财政区划名称
    */
    private String MOF_DIV_NAME;

    /**
    * 是否政府采购
    */
    private String IS_GOV_PUR;

    /**
    * 是否追踪
    */
    private String IS_TRACK;

    /**
    * 是否删除
    */
    private String IS_DELETED;

    /**
    * 更新时间
    */
    private Date UPDATE_TIME;

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

    private static final long serialVersionUID = 1L;
}