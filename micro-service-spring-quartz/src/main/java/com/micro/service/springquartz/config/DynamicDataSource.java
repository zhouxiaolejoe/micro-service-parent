package com.micro.service.springquartz.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.stat.DruidDataSourceStatManager;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.model.ThreadLocalDSInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;
import org.springframework.util.StringUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Map;
import java.util.Set;


/**
 * @author zxl
 */
public class DynamicDataSource extends AbstractRoutingDataSource {
    private boolean debug = true;
    private final Logger log = LoggerFactory.getLogger(getClass());
    private Map<Object, Object> dynamicTargetDataSources;
    private Object dynamicDefaultTargetDataSource;


    @Override
    protected Object determineCurrentLookupKey() {
        String datasource = null;
        ThreadLocalDSInfo dataSourceInfo = DBContextHolder.getDataSource();
        if (!StringUtils.isEmpty(dataSourceInfo)) {
            datasource = dataSourceInfo.getDatasourceId();
        }
        if (!StringUtils.isEmpty(datasource)) {
            Map<Object, Object> dynamicTargetDataSources2 = this.dynamicTargetDataSources;
            if (dynamicTargetDataSources2.containsKey(datasource)) {
//                log.debug("---当前数据源：" + datasource + "---");
            } else {
                log.debug("不存在的数据源：");
                return null;
//                    throw new ADIException("不存在的数据源："+datasource,500);
            }
        } else {
            log.debug("---当前数据源：默认数据源---");
        }

        return datasource;
    }

    @Override
    public void setTargetDataSources(Map<Object, Object> targetDataSources) {

        super.setTargetDataSources(targetDataSources);

        this.dynamicTargetDataSources = targetDataSources;

    }


    /**
     * 创建数据源
     */
    public boolean createDataSource(String key, String driveClass, String url, String username, String password, String databasetype) {
        try {
            try {
                /**
                 * 排除连接不上的错误
                 */
                Class.forName(driveClass);
                DriverManager.getConnection(url, username, password);

            } catch (Exception e) {

                return false;
            }
            @SuppressWarnings("resource")
//            HikariDataSource druidDataSource = new HikariDataSource();
                    DruidDataSource druidDataSource = new DruidDataSource();
            druidDataSource.setName(key);
            druidDataSource.setDriverClassName(driveClass);
            druidDataSource.setUrl(url);
            druidDataSource.setUsername(username);
            druidDataSource.setPassword(password);
            druidDataSource.setInitialSize(1);
            druidDataSource.setMinIdle(1);
            druidDataSource.setMaxActive(1);
            druidDataSource.setMaxWait(60000);
//            String validationQuery = "select 1 from dual";
//            if("mysql".equalsIgnoreCase(databasetype)) {
//                driveClass = DBUtil.mysqldriver;
//                validationQuery = "select 1";
//            } else if("oracle".equalsIgnoreCase(databasetype)){
//                driveClass = DBUtil.oracledriver;
//                druidDataSource.setPoolPreparedStatements(true); //是否缓存preparedStatement，也就是PSCache。PSCache对支持游标的数据库性能提升巨大，比如说oracle。在mysql下建议关闭。
//                druidDataSource.setMaxPoolPreparedStatementPerConnectionSize(50);
//                int sqlQueryTimeout = ADIPropUtil.sqlQueryTimeOut();
//                druidDataSource.setConnectionProperties("oracle.net.CONNECT_TIMEOUT=6000;oracle.jdbc.ReadTimeout="+sqlQueryTimeout);//对于耗时长的查询sql，会受限于ReadTimeout的控制，单位毫秒
//            } else if("sqlserver2000".equalsIgnoreCase(databasetype)){
//                driveClass = DBUtil.sql2000driver;
//                validationQuery = "select 1";
//            } else if("sqlserver".equalsIgnoreCase(databasetype)){
//                driveClass = DBUtil.sql2005driver;
//                validationQuery = "select 1";
//            }
//            druidDataSource.setTestOnBorrow(true);
//            druidDataSource.setTestWhileIdle(true);
//            druidDataSource.setValidationQuery(validationQuery);
            druidDataSource.setFilters("stat");
            druidDataSource.setTimeBetweenEvictionRunsMillis(60000);
            druidDataSource.setMinEvictableIdleTimeMillis(180000);
            druidDataSource.setKeepAlive(true);
            druidDataSource.setRemoveAbandoned(true);
            druidDataSource.setRemoveAbandonedTimeout(3600);
            druidDataSource.setLogAbandoned(true);
            druidDataSource.init();
            this.dynamicTargetDataSources.put(key, druidDataSource);
            setTargetDataSources(this.dynamicTargetDataSources);
            super.afterPropertiesSet();
            log.debug(key + "数据源初始化成功");
            //log.debug(key+"数据源的概况："+druidDataSource.dump());
            return true;
        } catch (Exception e) {
            log.error(e + "");
            return false;
        }
    }

    /**
     * 删除数据源
     */
    public boolean delDatasources(String datasourceid) {
        Map<Object, Object> dynamicTargetDataSources2 = this.dynamicTargetDataSources;
        if (dynamicTargetDataSources2.containsKey(datasourceid)) {
            Set<DruidDataSource> druidDataSourceInstances = DruidDataSourceStatManager.getDruidDataSourceInstances();
            for (DruidDataSource l : druidDataSourceInstances) {
                if (datasourceid.equals(l.getName())) {
                    dynamicTargetDataSources2.remove(datasourceid);
                    DruidDataSourceStatManager.removeDataSource(l);
                    setTargetDataSources(dynamicTargetDataSources2);
                    super.afterPropertiesSet();
                    return true;
                }
            }
            return false;
        } else {
            return false;
        }
    }

    /**
     * 测试数据源连接是否有效
     */
    public boolean testDatasource(String key, String driveClass, String url, String username, String password) {
        try {
            Class.forName(driveClass);
            DriverManager.getConnection(url, username, password);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public void setDefaultTargetDataSource(Object defaultTargetDataSource) {
        super.setDefaultTargetDataSource(defaultTargetDataSource);
        this.dynamicDefaultTargetDataSource = defaultTargetDataSource;
    }

    /**
     * @param debug the debug to set
     */
    public void setDebug(boolean debug) {
        this.debug = debug;
    }

    /**
     * @return the debug
     */
    public boolean isDebug() {
        return debug;
    }

    /**
     * @return the dynamicTargetDataSources
     */
    public Map<Object, Object> getDynamicTargetDataSources() {
        return dynamicTargetDataSources;
    }

    /**
     * @param dynamicTargetDataSources the dynamicTargetDataSources to set
     */
    public void setDynamicTargetDataSources(Map<Object, Object> dynamicTargetDataSources) {
        this.dynamicTargetDataSources = dynamicTargetDataSources;
    }

    /**
     * @return the dynamicDefaultTargetDataSource
     */
    public Object getDynamicDefaultTargetDataSource() {
        return dynamicDefaultTargetDataSource;
    }

    /**
     * @param dynamicDefaultTargetDataSource the dynamicDefaultTargetDataSource to set
     */
    public void setDynamicDefaultTargetDataSource(Object dynamicDefaultTargetDataSource) {
        this.dynamicDefaultTargetDataSource = dynamicDefaultTargetDataSource;
    }

    public void createDataSourceWithCheck(DataSourceInfo dataSource) throws Exception {
        String datasourceId = dataSource.getDatasourceId();
        log.debug("正在检查数据源：" + datasourceId);
        Map<Object, Object> dynamicTargetDataSources2 = this.dynamicTargetDataSources;
        if (dynamicTargetDataSources2.containsKey(datasourceId)) {
            log.debug("数据源" + datasourceId + "已初始化，准备测试数据源是否正常...");
            //DataSource druidDataSource = (DataSource) dynamicTargetDataSources2.get(datasourceId);
            DruidDataSource druidDataSource = (DruidDataSource) dynamicTargetDataSources2.get(datasourceId);
            boolean rightFlag = true;
            Connection connection = null;
            try {
                log.debug(datasourceId + "数据源的概况->当前闲置连接数：" + druidDataSource.getPoolingCount());
                long activeCount = druidDataSource.getActiveCount();
                log.debug(datasourceId + "数据源的概况->当前活动连接数：" + activeCount);
                if (activeCount > 0) {
                    log.debug(datasourceId + "数据源的概况->活跃连接堆栈信息：" + druidDataSource.getActiveConnectionStackTrace());
                }
                log.debug("准备获取数据库连接...");
                connection = druidDataSource.getConnection();
                log.debug("数据源" + datasourceId + "正常");
            } catch (Exception e) {
                log.error(e.getMessage(), e);
                rightFlag = false;
                log.debug("缓存数据源" + datasourceId + "已失效，准备删除...");
                if (delDatasources(datasourceId)) {
                    log.debug("缓存数据源删除成功");
                } else {
                    log.debug("缓存数据源删除失败");
                }
            } finally {
                if (null != connection) {
                    connection.close();
                }
            }
            if (rightFlag) {
                log.debug("不需要重新创建数据源");
                return;
            } else {
                log.debug("准备重新创建数据源...");
                createDataSource(dataSource);
                log.debug("重新创建数据源完成");
            }
        } else {
            createDataSource(dataSource);
        }

    }

    private void createDataSource(DataSourceInfo dataSource) throws Exception {
        String datasourceId = dataSource.getDatasourceId();
        log.debug("准备创建数据源" + datasourceId);
        String databasetype = dataSource.getDatabasetype();
        String username = dataSource.getUserName();
        String password = dataSource.getPassWord();
        String url = dataSource.getUrl();
        String driveClass = dataSource.getDriverclassname();
//        String driveClass = "oracle.jdbc.OracleDriver";
//        if("mysql".equalsIgnoreCase(databasetype)) {
//            driveClass = DBUtil.mysqldriver;
//        } else if("oracle".equalsIgnoreCase(databasetype)){
//            driveClass = DBUtil.oracledriver;
//        }  else if("sqlserver2000".equalsIgnoreCase(databasetype)){
//            driveClass = DBUtil.sql2000driver;
//        } else if("sqlserver".equalsIgnoreCase(databasetype)){
//            driveClass = DBUtil.sql2005driver;
//        }
        if (testDatasource(datasourceId, driveClass, url, username, password)) {
            boolean result = this.createDataSource(datasourceId, driveClass, url, username, password, databasetype);
            if (!result) {
                log.error("数据源" + datasourceId + "配置正确，但是创建失败");
//                throw new ADIException("数据源"+datasourceId+"配置正确，但是创建失败",500);
            }
        } else {
            log.error("数据源配置有错误");
//            throw new ADIException("数据源配置有错误",500);
        }
    }

}
 