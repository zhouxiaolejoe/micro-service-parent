package com.micro.service.mybatisplus.service;

import java.util.List;
import com.micro.service.mybatisplus.model.DataBaseinfo;
import com.baomidou.mybatisplus.extension.service.IService;
    /**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.service
 * @Author zhouxiaole
 * @Date 2020-09-13 20:46
 */
public interface DataBaseinfoService extends IService<DataBaseinfo>{


    int updateBatch(List<DataBaseinfo> list);

    int batchInsert(List<DataBaseinfo> list);

    int insertOrUpdate(DataBaseinfo record);

    int insertOrUpdateSelective(DataBaseinfo record);

}
