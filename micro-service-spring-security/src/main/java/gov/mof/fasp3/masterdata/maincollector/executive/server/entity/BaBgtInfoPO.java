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
 * @Date 2022-07-25 15:52
 */

/**
 * 指标信息
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BaBgtInfoPO implements Serializable {
    /**
     * 指标主键
     */
    private String BGT_ID;

    /**
     * 财政区划代码
     */
    private String MOF_DIV_CODE;

    /**
     * 预算年度
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
     * 预算级次代码
     */
    private String BUDGET_LEVEL_CODE;

    /**
     * 上级指标文号
     */
    private String SUP_BGT_DOC_NO;

    /**
     * 项目代码
     */
    private String PRO_CODE;

    /**
     * 指标可执行标志
     */
    private String BGT_EXE_FLAG;

    /**
     * 是否追踪
     */
    private String IS_TRACK;

    /**
     * 需要追踪项目代码
     */
    private String TRACK_PRO_CODE;

    /**
     * 单位代码
     */
    private String AGENCY_CODE;

    /**
     * 资金性质代码
     */
    private String FUND_TYPE_CODE;

    /**
     * 业务主管处室代码
     */
    private String MANAGE_MOF_DEP_CODE;

    /**
     * 转移支付支出功能分类科目代码
     */
    private String TP_FUNC_CODE;

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
     * 指标类型代码
     */
    private String BGT_TYPE_CODE;

    /**
     * 指标金额
     */
    private BigDecimal AMOUNT;

    /**
     * 指标管理处室代码
     */
    private String BGT_MOF_DEP_CODE;

    /**
     * 是否政府采购
     */
    private String IS_GOV_PUR;

    /**
     * 更新时间
     */
    private Date UPDATE_TIME;

    /**
     * 调整批次号
     */
    private String ADJ_BATCH_NO;

    /**
     * 源指标主键
     */
    private String ORI_BGT_ID;

    /**
     * 调减（追减）金额
     */
    private BigDecimal DIS_AMT;

    /**
     * 指标余额
     */
    private BigDecimal CUR_AMT;

    /**
     * 项目年度预算主键
     */
    private String BGT_PMAN_ID;

    /**
     * 是否删除
     */
    private String IS_DELETED;

    /**
     * 指标来源代码
     */
    private String SOURCE_TYPE_CODE;

    /**
     * 创建时间
     */
    private Date CREATE_TIME;

    /**
     * 接收方财政区划代码
     */
    private String REC_DIV_CODE;

    /**
     * 对应配套安排的中央项目代码
     */
    private String COUNT_FUND_PRO_CODE;

    /**
     * 已申请支付金额
     */
    private BigDecimal PAY_APP_AMT;

    /**
     * 任务代码
     */
    private String TASK_NO;

    /**
     * 具体实施项目
     */
    private String SPE_PRO_CODE;

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
     * 项目名称
     */
    private String PRO_NAME;

    /**
     * 单位名称
     */
    private String AGENCY_NAME;

    /**
     * 资金性质名称
     */
    private String FUND_TYPE_NAME;

    /**
     * 业务主管处室名称
     */
    private String MANAGE_MOF_DEP_NAME;

    /**
     * 转移支付功能分类科目名称
     */
    private String TP_FUNC_NAME;

    /**
     * 支出功能分类科目名称
     */
    private String EXP_FUNC_NAME;

    /**
     * 政府支出经济分类科目名称
     */
    private String GOV_BGT_ECO_NAME;

    /**
     * 部门支出经济分类科目名称
     */
    private String DEP_BGT_ECO_NAME;

    /**
     * 指标类型名称
     */
    private String BGT_TYPE_NAME;

    /**
     * 指标管理处室名称
     */
    private String BGT_MOF_DEP_NAME;

    /**
     * 接收方财政区划名称
     */
    private String REC_DIV_NAME;

    /**
     * 任务名称
     */
    private String TASK_NANME;

    /**
     * 支付方式名称
     */
    private String PAY_TYPE_NAME;

    /**
     * 支出级次代码
     */
    private String EXP_LEVEL_CODE;

    /**
     * 支付方式代码
     */
    private String PAY_TYPE_CODE;

    /**
     * 指标来源名称
     */
    private String SOURCE_TYPE_NAME;

    /**
     * 需要追踪项目名称
     */
    private String TRACK_PRO_NAME;

    /**
     * 具体项目名称
     */
    private String SPE_PRO_NAME;

    /**
     * 支出级次名称
     */
    private String EXP_LEVEL_NAME;

    private static final long serialVersionUID = 1L;
}