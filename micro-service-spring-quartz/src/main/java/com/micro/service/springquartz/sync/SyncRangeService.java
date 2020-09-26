package com.micro.service.springquartz.sync;


import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
import com.micro.service.springquartz.service.DBChangeService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 *
 * @author zxl
 * @date 2019/11/20
 */
@Service
@Slf4j
@AllArgsConstructor
public class SyncRangeService implements IFaspClientScheduler {

    DBChangeService changeService;
    OriginMapper originMapper;
    SyncRangeMapper syncRangeMapper;

    @Override
    public void start(String origin, String target) {

    }


}
