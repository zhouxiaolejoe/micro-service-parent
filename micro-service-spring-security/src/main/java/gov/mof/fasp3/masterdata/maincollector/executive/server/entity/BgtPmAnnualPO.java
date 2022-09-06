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
 * @Date 2022-07-27 15:08
 */

/**
 * 部门预算项目年度预算表
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BgtPmAnnualPO implements Serializable {
    /**
     * 项目年度预算主键
     */
    private String BGT_PMAN_ID;

    /**
     * 备注
     */
    private String BZ;

    /**
     * 版本
     */
    private String DATAVERSION;

    /**
     * 分组标识
     */
    private String GROUPKEY;

    /**
     * 叶子节点
     */
    private Integer ISLEAF;

    /**
     * 级次
     */
    private Integer LEVELNO;

    /**
     * 排序字段
     */
    private Long ORDERNUM;

    /**
     * 阶段
     */
    private String STAGE;

    /**
     * 父GUID
     */
    private String SUPERGUID;

    /**
     * 任务guid
     */
    private String TASKGUID;

    /**
     * 模板主键
     */
    private String TEMPLATEGUID;

    /**
     * VCHTYPEID
     */
    private String VCHTYPEID;

    /**
     * 版本
     */
    private Long VERSION;

    /**
     * 预算年度
     */
    private String FISCAL_YEAR;

    /**
     * 单位代码
     */
    private String AGENCY_CODE;

    /**
     * 项目类别代码
     */
    private String PRO_KIND_CODE;

    /**
     * 项目代码
     */
    private String PRO_CODE;

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
     * 资金性质代码
     */
    private String FUND_TYPE_CODE;

    /**
     * 申报数
     */
    private BigDecimal APPLY_UP;

    /**
     * 财政审核数
     */
    private BigDecimal FIN_AUDIT_MONEY;

    /**
     * 部门代码
     */
    private String DEPT_CODE;

    /**
     * 业务主管处室代码
     */
    private String MANAGE_MOF_DEP_CODE;

    /**
     * 更新时间
     */
    private Date UPDATE_TIME;

    /**
     * 申报环节
     */
    private String APPLY_LINK;

    /**
     * 年初批复数
     */
    private BigDecimal REPLY_AMT;

    /**
     * 调整金额
     */
    private BigDecimal ADJ_AMT;

    /**
     * 调剂金额
     */
    private BigDecimal DIS_AMT;

    /**
     * 变动后预算数
     */
    private BigDecimal CUR_AMT;

    /**
     * 是否删除
     */
    private Short IS_DELETED;

    /**
     * 预算级次代码
     */
    private String BUDGET_LEVEL_CODE;

    /**
     * 资金来源代码
     */
    private String FOUND_TYPE_CODE;

    /**
     * 创建时间
     */
    private Date CREATE_TIME;

    /**
     * 项目名称
     */
    private String PRO_NAME;

    /**
     * 单位名称
     */
    private String AGENCY_GUID;

    /**
     * 项目类别名称
     */
    private String PRO_KIND_NAME;

    /**
     * 财政内部机构
     */
    private String FININTORG_GUID;

    /**
     * 是否政府采购
     */
    private String IS_GOVPURCH;

    /**
     * 是否基建
     */
    private String IS_CONSTRUCTION;

    /**
     * 归口处室
     */
    private String BUSIORG_GUID;

    /**
     * 单位类别
     */
    private String AGENCY_TYPE;

    /**
     * 项目明细信息
     */
    private String PRODETAILINFO;

    /**
     * 财政区划代码
     */
    private String MOF_DIV_CODE;

    /**
     * 批次号
     */
    private String BATCHNO;

    /**
     * 支出功能分类科目
     */
    private String EXP_FUNC_GUID;

    /**
     * 系数
     */
    private String XS;

    /**
     * 部门支出经济分类
     */
    private String DEP_BGT_ECO_GUID;

    /**
     * 是否政府购买
     */
    private String IS_GOVSERVE;

    private String ISMX;

    private String ZXMC;

    private String AMTCOL;

    private String REMARK;

    private String BGT_PRO_TYPE;

    private String SRCGUID;

    private String PER_RELEASE_REASON;

    private String GET_STATUS;

    private String APPROVAL_FILE_NO;

    private String BUSI_TYPE_CODE;

    private String PARAM_1;

    private BigDecimal PARAM_10;

    private String PARAM_2;

    private String PARAM_3;

    private String PARAM_4;

    private String PARAM_5;

    private BigDecimal PARAM_6;

    private BigDecimal PARAM_7;

    private BigDecimal PARAM_8;

    private BigDecimal PARAM_9;

    /**
     * 单位名称
     */
    private String AGENCY_NAME;

    /**
     * 预算级次名称
     */
    private String BUDGET_LEVEL_NAME;

    /**
     * 部门名称
     */
    private String DEPT_NAME;

    /**
     * 支出功能分类科目名称
     */
    private String EXP_FUNC_NAME;

    /**
     * 资金来源名称
     */
    private String FOUND_TYPE_NAME;

    /**
     * 资金性质名称
     */
    private String FUND_TYPE_NAME;

    /**
     * 政府支出经济分类科目名称
     */
    private String GOV_BGT_ECO_NAME;

    /**
     * 是否财政待分配支出
     */
    private String IS_ASSIGNED;

    /**
     * 业务管理处室名称
     */
    private String MANAGE_MOF_DEP_NAME;

    /**
     * 财政区划名称
     */
    private String MOF_DIV_NAME;

    /**
     * 部门支出经济分类科目名称
     */
    private String DEP_BGT_ECO_NAME;

    /**
     * 是否结束
     */
    private String IS_BGT_END;

    /**
     * 是否政府采购
     */
    private String IS_GOV_PUR;

    private static final long serialVersionUID = 1L;
}