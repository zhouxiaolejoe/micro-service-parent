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
 * @Date 2022-09-01 14:18
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BgtTraZkPO implements Serializable {
    /**
    * 项目年度预算主键
    */
    private String BGT_PMAN_ID;

    /**
    * 版本
    */
    private String BATCHNO;

    /**
    * 操作时间
    */
    private String DATAVERSION;

    /**
    * 任务
    */
    private String TASKGUID;

    /**
    * 预留字段
    */
    private String PRESET;

    /**
    * 阶段
    */
    private String STAGE;

    /**
    * DPT
    */
    private String DPT;

    /**
    * 版本
    */
    private Long VERSION;

    /**
    * 财政区划代码
    */
    private String MOF_DIV_CODE;

    /**
    * 预算年度
    */
    private String FISCAL_YEAR;

    /**
    * 单位名称
    */
    private String AGENCY_GUID;

    /**
    * 单位代码
    */
    private String AGENCY_CODE;

    /**
    * 项目类别名称
    */
    private String PRO_KIND;

    /**
    * 项目类别代码
    */
    private String PRO_KIND_CODE;

    /**
    * 项目代码
    */
    private String PRO_CODE;

    /**
    * 项目名称
    */
    private String PRO_NAME;

    /**
    * 功能科目名称
    */
    private String EXP_FUNC;

    /**
    * 支出功能分类科目代码
    */
    private String EXP_FUNC_CODE;

    /**
    * 转移支付功能科目名称
    */
    private String TP_FUNC;

    /**
    * 转移支付功能分类科目代码
    */
    private String TP_FUNC_CODE;

    /**
    * 下达区划
    */
    private String SUB_MOF_DIV;

    /**
    * 下级财政区划代码
    */
    private String SUB_MOF_DIV_CODE;

    /**
    * 政府支出经济分类名称
    */
    private String GOV_BGT_ECO;

    /**
    * 政府支出经济分类代码
    */
    private String GOV_BGT_ECO_CODE;

    /**
    * 资金性质
    */
    private String FUND_TYPE;

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
    * 单位类别
    */
    private String AGENCY_TYPE;

    /**
    * 转移支付类型
    */
    private String TRA_TYPE;

    /**
    * 叶子节点
    */
    private Integer ISLEAF;

    /**
    * 级次
    */
    private Integer LEVELNO;

    /**
    * 部门经济科目名称
    */
    private String EXP_ECO;

    /**
    * 部门经济科目代码
    */
    private String EXP_ECO_CODE;

    /**
    * 一级项目
    */
    private String PROMAININFO;

    /**
    * 上级转移支付项目
    */
    private String SUPER_TRA;

    /**
    * 模板主键
    */
    private String TEMPLATEGUID;

    /**
    * 申报项目
    */
    private String PRODETAILINFO;

    /**
    * 是否政府采购
    */
    private String ISGOVPURCH;

    /**
    * 是否基建
    */
    private String ISCONSTRUCTION;

    /**
    * 备注
    */
    private String REMARK;

    /**
    * 排序字段
    */
    private Long ORDERNUM;

    private String PER_RELEASE_REASON;

    private String GET_STATUS;

    private String APPROVAL_FILE_NO;

    private String BUSI_TYPE_CODE;

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
    * 下级财政区划名称
    */
    private String SUB_MOF_DIV_NAME;

    /**
    * 转移支付功能分类科目名称
    */
    private String TP_FUNC_NAME;

    private String PRO_KIND_NAME;

    private static final long serialVersionUID = 1L;
}