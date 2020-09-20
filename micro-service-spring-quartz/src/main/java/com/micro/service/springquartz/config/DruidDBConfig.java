package com.micro.service.springquartz.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

/**
 * @Author : zxl
 * @CreateTime : 2019/10/22
 * @Description :
 **/
@Configuration
@EnableTransactionManagement
public class DruidDBConfig {
    private final Logger log = LoggerFactory.getLogger(getClass());

    /**
     * adi数据库连接信息
     */
    @Value("${spring.datasource.url}")
    private String dbUrl;
    @Value("${spring.datasource.username}")
    private String username;
    @Value("${spring.datasource.password}")
    private String password;
    @Value("${spring.datasource.driverClassName}")
    private String driverClassName;
    /**
     * 连接池连接信息
     */
    @Value("${spring.datasource.initialSize}")
    private int initialSize;
    @Value("${spring.datasource.minIdle}")
    private int minIdle;
    @Value("${spring.datasource.maxActive}")
    private int maxActive;
    @Value("${spring.datasource.maxWait}")
    private int maxWait;

    @Bean 
    @Primary 
    @Qualifier("mainDataSource")
    public DataSource dataSource() throws SQLException {
        DruidDataSource datasource = new DruidDataSource();
        /**
         * 基础连接信息
         */
        datasource.setUrl(this.dbUrl);
        datasource.setUsername(username);
        datasource.setPassword(password);
        datasource.setDriverClassName(driverClassName);
        datasource.setInitialSize(initialSize);
        datasource.setMinIdle(minIdle);
        datasource.setMaxActive(maxActive);
        datasource.setMaxWait(maxWait);
        datasource.setPoolPreparedStatements(true);
        datasource.setMaxPoolPreparedStatementPerConnectionSize(20);
        datasource.setConnectionProperties("druid.stat.mergeSql=true;druid.stat.slowSqlMillis=5000");
        datasource.setTestOnBorrow(true);
        datasource.setTestWhileIdle(true);
        String validationQuery = "select 1 from dual";
        datasource.setValidationQuery(validationQuery);
        datasource.setFilters("stat,wall");
        datasource.setTimeBetweenEvictionRunsMillis(60000);
        datasource.setMinEvictableIdleTimeMillis(180000);
        datasource.setKeepAlive(true);
        datasource.setRemoveAbandoned(true);
        datasource.setRemoveAbandonedTimeout(3600);
        datasource.setLogAbandoned(true);
        return datasource;


    }


    /**
     * druid监控页面配置1-帐号密码配置
     *
     * @return servlet registration bean
     */
    @Bean
    public ServletRegistrationBean druidStatViewServlet() {
        ServletRegistrationBean servletRegistrationBean = new ServletRegistrationBean(
                new StatViewServlet(), "/druid/*");
        servletRegistrationBean.addInitParameter("loginUsername", "admin");
        servletRegistrationBean.addInitParameter("loginPassword", "123456");
        servletRegistrationBean.addInitParameter("resetEnable", "false");
        return servletRegistrationBean;
    }

    /**
     * 注册一个：filterRegistrationBean   druid监控页面配置2-允许页面正常浏览
     *
     * @return filter registration bean
     */
    @Bean
    public FilterRegistrationBean druidStatFilter() {
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean(
                new WebStatFilter());
        // 添加过滤规则.
        filterRegistrationBean.addUrlPatterns("/*");
        // 添加不需要忽略的格式信息.
        filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");
        return filterRegistrationBean;
    }
    /**
     * 注册动态数据源
     */
    @Bean(name = "dynamicDataSource")
    @Qualifier("dynamicDataSource")
    public DynamicDataSource dynamicDataSource() throws SQLException {
        DynamicDataSource dynamicDataSource = new DynamicDataSource();
        dynamicDataSource.setDebug(false);
        /**
         * 默认数据源配置 DefaultTargetDataSource
         */
        dynamicDataSource.setDefaultTargetDataSource(dataSource());
        Map<Object, Object> targetDataSources = new HashMap<Object, Object>(10);

        /**
         * 额外数据源配置 TargetDataSources
         * 默认数据源不注册
         */
//        targetDataSources.put("mainDataSource", dataSource());
        dynamicDataSource.setTargetDataSources(targetDataSources);
        return dynamicDataSource;
    }

    @Bean
    @Primary
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dynamicDataSource());
        //解决手动创建数据源后字段到bean属性名驼峰命名转换失效的问题
        sqlSessionFactoryBean.setConfiguration(configuration());

        // 设置mybatis的主配置文件
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        // Resource mybatisConfigXml = resolver.getResource("classpath:mybatis/mybatis-config.xml");
        //  sqlSessionFactoryBean.setConfigLocation(mybatisConfigXml);
        // 设置别名包
        //  sqlSessionFactoryBean.setTypeAliasesPackage("com.testdb.dbsource.pojo");
        //手动配置mybatis的mapper.xml资源路径,如果单纯使用注解方式,不需要配置该行
//        sqlSessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapper/faspclient/**/*.xml"));
        sqlSessionFactoryBean.setMapperLocations(resolveMapperLocations());
        return sqlSessionFactoryBean.getObject();
    }

    /**
     * 加载多个mapper路径
     * @return
     */
    static final String MAPPER_LOCATION_1 = "classpath:mapper/*.xml";
    public Resource[] resolveMapperLocations() {
        ResourcePatternResolver resourceResolver = new PathMatchingResourcePatternResolver();
        List<String> mapperLocations = new ArrayList<>();
        mapperLocations.add(MAPPER_LOCATION_1);
        List<Resource> resources = new ArrayList<>();
        if (mapperLocations != null) {
            for (String mapperLocation : mapperLocations) {
                try {
                    Resource[] mappers = resourceResolver.getResources(mapperLocation);
                    resources.addAll(Arrays.asList(mappers));
                } catch (IOException e) {
                }
            }
        }
        return resources.toArray(new Resource[resources.size()]);
    }

    /**
     * 读取驼峰命名设置
     *
     * @return
     */
    @Bean
    @ConfigurationProperties(prefix = "mybatis.configuration")
    public org.apache.ibatis.session.Configuration configuration() {
        return new org.apache.ibatis.session.Configuration();
    }
    @Bean
    @Primary
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
        return new SqlSessionTemplate(sqlSessionFactory);
    }

}
 