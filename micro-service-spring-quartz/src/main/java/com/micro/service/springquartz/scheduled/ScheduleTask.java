package com.micro.service.springquartz.scheduled;

import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.syncapi.IFaspClientScheduler;
import com.micro.service.springquartz.utils.FastJsonUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.stream.Collectors;

/**
 * @Description
 * @Author zxl
 * @Date 2019/7/17  17:16
 * @Param
 * @return
 **/
@Component
@Slf4j
public class ScheduleTask {
    //    private SimpMessageSendingOperations messagingTemplate;
    @Autowired
    ExecutorService syncExecutorService;
    @Autowired
    DataSourceMapper dataSourceMapper;
    @Autowired
    DBChangeService dbChangeService;
    @Autowired
    ApplicationContext context;
    @Value("${serverid}")
    private String serverid;
//    /**
//     * 推送日志到/topic/pullLogger
//     */
//    @PostConstruct
//    public void pushLogger() {
//        syncExecutorService.submit(() -> {
//            while (true) {
//                try {
//                    LoggerMessage log = LoggerQueue.getInstance().poll();
//                    if (log != null) {
//                        if (messagingTemplate != null) {
//                            messagingTemplate.convertAndSend("/topic/pullLogger", log);
//                        }
//                    }
//                } catch (Exception e) {
//                    log.error("推送日志出错" + e.getMessage());
//                    ;
//                }
//            }
//        });
//    }

    @Scheduled(cron = "${synccron}")
//    @Scheduled(fixedDelay = 120000)
    public void syncRoleService() {
        List<DataSourceInfo> dataSourcesList = dataSourceMapper.getServerId(serverid);
        if (dataSourcesList == null || CollectionUtils.isEmpty(dataSourcesList)) {
            return;
        }
        dataSourcesList = dataSourcesList.stream().filter(x -> {
            if (x.getDatasourceid().equals("mid")) {
                return false;
            }
            return true;
        }).collect(Collectors.toList());


        log.info("数据源信息: [ " + FastJsonUtils.getBeanToJson(dataSourcesList) + " ]");
        CountDownLatch countDownLatch = new CountDownLatch(dataSourcesList.size());
        for (DataSourceInfo dataSource : dataSourcesList) {
            syncExecutorService.execute(() -> {
                try {
                    dbChangeService.changeDb(dataSource.getDatasourceid());
                    if (context != null) {
                        Map<String, IFaspClientScheduler> m = context.getBeansOfType(
                                IFaspClientScheduler.class);
                        Map<String, IFaspClientScheduler> treeMap = new TreeMap<>(String::compareTo);
                        treeMap.putAll(m);
                        for (IFaspClientScheduler scheduler : treeMap.values()) {
                            try {
                                scheduler.start("mid", dataSource.getDatasourceid());
                            } catch (Exception e) {
                                log.error("IFaspClientScheduler run error " + scheduler.getClass().getName(), e);
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    countDownLatch.countDown();
                }
            });
        }
        try {
            countDownLatch.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
//        log.error("=========================SYNC SUCCESS=========================");
    }
}
