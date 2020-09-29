package com.micro.service.springquartz.clientapi;

import com.micro.service.springquartz.config.fasp3client.FaspClientSetting;
import com.micro.service.springquartz.model.RestClientResultDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Created by wengy on 2019/11/21.
 */
@FeignClient(name = "fasp3-common", url = FaspClientSetting.faspServer)
@RequestMapping("/fasp/restapi/v1/dic/table/dbversion")
public interface TableDBVersionClient {

    @RequestMapping(value = "/{tablename}/{dbversion}/", method = RequestMethod.GET)
    public RestClientResultDTO<List<Map<String, Object>>> queryTableDataByDBVersion(
        @PathVariable("tablename") String tablename,
        @PathVariable("dbversion") String dbversion,
        @RequestHeader(name = "fasp2-token", required = true) String token
    );

    @RequestMapping(value = "/{tablename}/{dbversion}/1k", method = RequestMethod.GET)
    public RestClientResultDTO<List<Map<String, Object>>> queryTableData1KByDBVersion(
        @PathVariable("tablename") String tablename,
        @PathVariable("dbversion") String dbversion,
        @RequestParam("page") int page,
        @RequestHeader(name = "fasp2-token", required = true) String token
    );

    @RequestMapping(value = "/{province}/{year}/{tablename}/{dbversion}/", method = RequestMethod.GET)
    public RestClientResultDTO<List<Map<String, Object>>> queryTableDataByProvinceYearDBVersion(
        @PathVariable("province") String province,
        @PathVariable("year") String year,
        @PathVariable("tablename") String tablename,
        @PathVariable("dbversion") String dbversion,
        @RequestHeader(name = "fasp2-token", required = true) String token
    );

    @RequestMapping(value = "/{province}/{year}/{tablename}/{dbversion}/1k", method = RequestMethod.GET)
    public RestClientResultDTO<List<Map<String, Object>>> queryTableData1KByProvinceYearDBVersion(
        @PathVariable("province") String province,
        @PathVariable("year") String year,
        @PathVariable("tablename") String tablename,
        @PathVariable("dbversion") String dbversion,
        @RequestParam("page") int page,
        @RequestHeader(name = "fasp2-token", required = true) String token
    );
}
