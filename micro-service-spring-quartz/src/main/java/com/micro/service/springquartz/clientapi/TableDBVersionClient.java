package com.micro.service.springquartz.clientapi;

import com.micro.service.springquartz.config.fasp3client.FaspClientSetting;
import com.micro.service.springquartz.model.RestClientResultDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
* @Description  远程获取数据
* @Author zxl
* @Date  2020-10-28  16:06:21
**/
@FeignClient(name = "fasp3-common", url = FaspClientSetting.faspServer)
@RequestMapping("/fasp/restapi/v1/dic/table/dbversion")
public interface TableDBVersionClient {

    @RequestMapping(value = "/{tablename}/{dbversion}/", method = RequestMethod.GET)
    RestClientResultDTO<List<Map<String, Object>>> queryTableDataByDBVersion(
            @PathVariable("tablename") String tablename,
            @PathVariable("dbversion") String dbversion,
            @RequestHeader(name = "fasp2-token", required = true) String token
    );
    /**
    * @Description  根据不分区划年度查询表数据
    * @Method queryTableData1KByDBVersion
    * @Param tablename
    * @Param dbversion
    * @Param page
    * @Param token
    * @return com.micro.service.springquartz.model.RestClientResultDTO<java.util.List<java.util.Map<java.lang.String,java.lang.Object>>>
    * @throws
    * @Author Administrator
    * @Date  2020-10-28  16:09:06
    **/
    @RequestMapping(value = "/{tablename}/{dbversion}/1k", method = RequestMethod.GET)
    RestClientResultDTO<List<Map<String, Object>>> queryTableData1KByDBVersion(
            @PathVariable("tablename") String tablename,
            @PathVariable("dbversion") String dbversion,
            @RequestParam("page") int page,
            @RequestHeader(name = "fasp2-token", required = true) String token
    );

    @RequestMapping(value = "/{province}/{year}/{tablename}/{dbversion}/", method = RequestMethod.GET)
    RestClientResultDTO<List<Map<String, Object>>> queryTableDataByProvinceYearDBVersion(
            @PathVariable("province") String province,
            @PathVariable("year") String year,
            @PathVariable("tablename") String tablename,
            @PathVariable("dbversion") String dbversion,
            @RequestHeader(name = "fasp2-token", required = true) String token
    );
    /**
    * @Description  根据区划年度查询表数据
    * @Method queryTableData1KByProvinceYearDBVersion
    * @Param province
    * @Param year
    * @Param tablename
    * @Param dbversion
    * @Param page
    * @Param token
    * @return com.micro.service.springquartz.model.RestClientResultDTO<java.util.List<java.util.Map<java.lang.String,java.lang.Object>>>
    * @throws
    * @Author Administrator
    * @Date  2020-10-28  16:08:41
    **/
    @RequestMapping(value = "/{province}/{year}/{tablename}/{dbversion}/1k", method = RequestMethod.GET)
    RestClientResultDTO<List<Map<String, Object>>> queryTableData1KByProvinceYearDBVersion(
            @PathVariable("province") String province,
            @PathVariable("year") String year,
            @PathVariable("tablename") String tablename,
            @PathVariable("dbversion") String dbversion,
            @RequestParam("page") int page,
            @RequestHeader(name = "fasp2-token", required = true) String token
    );
}
