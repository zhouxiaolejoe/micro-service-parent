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
 * @Date 2022-07-13 10:54
 */
/**
    * 指标调整明细信息
    */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BaBgtAdjsubPO implements Serializable {
    /**
    * 指标调整明细主键
    */
    private String ADJ_SUB_ID;

    /**
    * 财政区划代码
    */
    private String MOF_DIV_CODE;

    /**
    * 年度
    */
    private String FISCAL_YEAR;

    /**
    * 本级指标文号
    */
    private String COR_BGT_DOC_NO;

    /**
    * 指标文标题
    */
    private String BGT_DOC_TITLE;

    /**
    * 发文时间
    */
    private Date DOC_DATE;

    /**
    * 指标说明
    */
    private String BGT_DEC;

    /**
    * 项目代码
    */
    private String PRO_CODE;

    /**
    * 调整批次号
    */
    private String BAT_NUM;

    /**
    * 指标来源代码
    */
    private String SOURCE_TYPE_CODE;

    /**
    * 调整日期
    */
    private Date ADJ_DATE;

    /**
    * 调入指标主键
    */
    private String BGT_ID;

    /**
    * 调入金额
    */
    private BigDecimal ADD_AMOUNT;

    /**
    * 源指标主键
    */
    private String ORI_BGT_ID;

    /**
    * 资金性质代码
    */
    private String FUND_TYPE_CODE;

    /**
    * 支出功能分类科目代码
    */
    private String EXP_FUNC_CODE;

    /**
    * 政府支出经济分类科目代码
    */
    private String GOV_BGT_ECO_CODE;

    /**
    * 部门支出经济分类科目代码
    */
    private String DEP_BGT_ECO_CODE;

    /**
    * 更新时间
    */
    private Date UPDATE_TIME;

    /**
    * 接收方财政区划代码
    */
    private String REC_DIV_CODE;

    /**
    * 指标管理处室代码
    */
    private String BGT_MOF_DEP_CODE;

    /**
    * 业务主管处室代码
    */
    private String MANAGE_MOF_DEP_CODE;

    /**
    * 是否追踪
    */
    private String IS_TRACK;

    /**
    * 预算级次代码
    */
    private String BUDGET_LEVEL_CODE;

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

    private static final long serialVersionUID = 1L;
}