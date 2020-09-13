package com.micro.service.mybatisplus.service;

import java.util.List;
import com.micro.service.mybatisplus.model.User100w;
import com.baomidou.mybatisplus.extension.service.IService;
    /**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.service
 * @Author zhouxiaole
 * @Date 2020-09-13 21:16
 */
public interface User100wService extends IService<User100w>{


    int updateBatch(List<User100w> list);

    int batchInsert(List<User100w> list);

    int insertOrUpdate(User100w record);

    int insertOrUpdateSelective(User100w record);

}
