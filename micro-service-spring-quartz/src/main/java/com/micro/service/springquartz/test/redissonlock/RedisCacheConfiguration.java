package com.micro.service.springquartz.test.redissonlock;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.ClusterServersConfig;
import org.redisson.config.Config;
import org.redisson.config.ReadMode;
import org.redisson.config.SingleServerConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@ConditionalOnClass(Config.class)
@Configuration
@EnableConfigurationProperties(RedissonProperties.class)
public class RedisCacheConfiguration {
    @Autowired
    RedissonProperties redissonProperties;

    @Configuration
    @ConditionalOnClass({Redisson.class})
    @ConditionalOnExpression("'${redisson.lock.mode}'=='single' or '${redisson.lock.mode}'=='cluster' or '${redisson.lock.mode}'=='sentinel'")
    public class RedissonSingleClientConfiguration {
        @Bean
        @ConditionalOnProperty(name = "redisson.lock.mode", havingValue = "single")
        public RedissonClient redissonSingle() {
            Config config = new Config();
            String address = redissonProperties.getSingle().getAddress();
            address = ((address.startsWith("redis://")) ? address : "redis://" + address);
            SingleServerConfig serverConfig = config.useSingleServer().setAddress(address).setClientName("Single")
                    .setConnectionPoolSize(redissonProperties.getPool().getSize())
                    .setConnectionMinimumIdleSize(redissonProperties.getPool().getMinIdle())
                    .setConnectTimeout(redissonProperties.getPool().getConnTimeout())
                    .setDatabase(redissonProperties.getDatabase());
            if (StringUtils.isNotBlank(redissonProperties.getPassword())) {
                serverConfig.setPassword(redissonProperties.getPassword());
            }
            return Redisson.create(config);
        }
    }

    @Bean
    @ConditionalOnProperty(name = "redisson.lock.mode", havingValue = "sentinel")
    public RedissonClient redissonSentinel() {
        Config config = new Config();
        String[] nodes = redissonProperties.getSentinel().getNodes().split(",");
        List<String> newNodes = new ArrayList<>(nodes.length);
        Arrays.stream(nodes).forEach((index) -> newNodes.add(index.startsWith("redis://") ? index : "redis://" + index));
        config.useSentinelServers()
                .addSentinelAddress(newNodes.toArray(new String[0]))
                .setMasterConnectionPoolSize(redissonProperties.getPool().getSize())
                .setSlaveConnectionPoolSize(redissonProperties.getPool().getSize())
                .setClientName("Sentinel")
                .setReadMode(ReadMode.SLAVE)
                .setMasterName(redissonProperties.getSentinel().getMaster())
                .setDatabase(redissonProperties.getDatabase())
                .setFailedSlaveCheckInterval(redissonProperties.getFailedSlaveCheckInterval())
                .setFailedSlaveReconnectionInterval(redissonProperties.getFailedSlaveReconnectionInterval())
                .setTimeout(redissonProperties.getTimeout());


        return Redisson.create(config);
    }

    @Bean
    @ConditionalOnProperty(name = "redisson.lock.mode", havingValue = "cluster")
    public RedissonClient redissonCluster() {
        Config config = new Config();
        String[] nodes = redissonProperties.getCluster().getNodes().split(",");
        ArrayList<String> addresses = new ArrayList<>(nodes.length);
        Arrays.stream(nodes).forEach((index) -> addresses.add(index.startsWith("redis://") ? index : "redis://" + index));
        ClusterServersConfig clusterServersConfig = config.useClusterServers().addNodeAddress(addresses.toArray(new String[0]))
                .setClientName("Cluster")
                .setConnectTimeout(redissonProperties.getTimeout())
                .setRetryInterval(redissonProperties.getCluster().getRetryInterval())
                .setIdleConnectionTimeout(redissonProperties.getPool().getSoTimeout())
                .setScanInterval(redissonProperties.getCluster().getRetryInterval())
                .setMasterConnectionPoolSize(redissonProperties.getCluster().getMasterConnectionPoolSize())
                .setSlaveConnectionPoolSize(redissonProperties.getCluster().getSlaveConnectionPoolSize())
                .setFailedSlaveCheckInterval(redissonProperties.getFailedSlaveCheckInterval())
                .setFailedSlaveReconnectionInterval(redissonProperties.getFailedSlaveReconnectionInterval());
        if (StringUtils.isNotBlank(redissonProperties.getPassword())) {
            clusterServersConfig.setPassword(redissonProperties.getPassword());
        }
        return Redisson.create(config);
    }
}