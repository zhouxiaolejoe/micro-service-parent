package gov.mof.fasp3.masterdata.maincollector.executive.server.entity;

import java.io.Serializable;
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
 * @Date 2022-07-25 10:47
 */

/**
 * 项目热点分类信息查询
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PmHotTopiccatePO implements Serializable {
    /**
     * 项目热点分类主键
     */
    private String PRO_HOT_TOPIC_ID;

    /**
     * 财政区划代码
     */
    private String MOF_DIV_CODE;

    /**
     * 设立年度
     */
    private String SETUP_YEAR;

    /**
     * 项目代码
     */
    private String PRO_CODE;

    /**
     * 热点分类代码
     */
    private String HOT_TOPIC_CATE_CODE;

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

    private String PARAM_1;

    private String PARAM_2;

    private String PARAM_3;

    private String PARAM_4;

    private String PARAM_5;

    /**
     * 财政区划名称
     */
    private String MOF_DIV_NAME;

    /**
     * 项目名称
     */
    private String PRO_NAME;

    /**
     * 热点分类名称
     */
    private String HOT_TOPIC_CATE_NAME;

    private static final long serialVersionUID = 1L;
}