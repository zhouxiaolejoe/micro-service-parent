package com.micro.service.mybatisplus.service.impl;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.micro.service.mybatisplus.mapper.User100wMapper;
import java.util.List;
import com.micro.service.mybatisplus.model.User100w;
import com.micro.service.mybatisplus.service.User100wService;
/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.service.impl
 * @Author zhouxiaole
 * @Date 2020-09-13 21:16
 */
@Service
public class User100wServiceImpl extends ServiceImpl<User100wMapper, User100w> implements User100wService{

    @Override
    public int updateBatch(List<User100w> list) {
        return baseMapper.updateBatch(list);
    }
    @Override
    public int batchInsert(List<User100w> list) {
        return baseMapper.batchInsert(list);
    }
    @Override
    public int insertOrUpdate(User100w record) {
        return baseMapper.insertOrUpdate(record);
    }
    @Override
    public int insertOrUpdateSelective(User100w record) {
        return baseMapper.insertOrUpdateSelective(record);
    }
}
