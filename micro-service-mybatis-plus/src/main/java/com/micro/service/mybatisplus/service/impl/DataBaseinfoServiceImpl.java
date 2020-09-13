package com.micro.service.mybatisplus.service.impl;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.List;
import com.micro.service.mybatisplus.mapper.DataBaseinfoMapper;
import com.micro.service.mybatisplus.model.DataBaseinfo;
import com.micro.service.mybatisplus.service.DataBaseinfoService;
/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.service.impl
 * @Author zhouxiaole
 * @Date 2020-09-13 20:46
 */
@Service
public class DataBaseinfoServiceImpl extends ServiceImpl<DataBaseinfoMapper, DataBaseinfo> implements DataBaseinfoService{

    @Override
    public int updateBatch(List<DataBaseinfo> list) {
        return baseMapper.updateBatch(list);
    }
    @Override
    public int batchInsert(List<DataBaseinfo> list) {
        return baseMapper.batchInsert(list);
    }
    @Override
    public int insertOrUpdate(DataBaseinfo record) {
        return baseMapper.insertOrUpdate(record);
    }
    @Override
    public int insertOrUpdateSelective(DataBaseinfo record) {
        return baseMapper.insertOrUpdateSelective(record);
    }
}
