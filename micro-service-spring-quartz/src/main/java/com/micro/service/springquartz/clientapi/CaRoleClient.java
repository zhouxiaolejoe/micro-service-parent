package com.micro.service.springquartz.clientapi;

import com.micro.service.springquartz.config.fasp3client.FaspClientSetting;
import com.micro.service.springquartz.model.ClientApiRoleMenuRestDTO;
import com.micro.service.springquartz.model.ClientApiRoleUserRestDTO;
import com.micro.service.springquartz.model.RestClientResultDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
* @Description  用户菜单关联表数据接口
* @Author zxl
* @Date  2020-10-28  16:04:20
**/
@FeignClient(name = "fasp3-common", url = FaspClientSetting.faspServer)
@RequestMapping("/fasp/restapi/v1/ca/roles")
public interface CaRoleClient {
    /**
    * @Description 根据用户ID获取用户角色关系数据
    * @Method getRoleUserMapping
    * @Param userguid
    * @return com.micro.service.springquartz.model.RestClientResultDTO<java.util.List<com.micro.service.springquartz.model.ClientApiRoleUserRestDTO>>
    * @throws
    * @Author zxl
    * @Date  2020-10-28  16:07:10
    **/
    @GetMapping("/usermapping/users/{userguid}")
    RestClientResultDTO<List<ClientApiRoleUserRestDTO>> getRoleUserMapping(
            @PathVariable("userguid") String userguid
    );

    /**
    * @Description
    * @Method getRoleMenuMapping
    * @Param menuguid
    * @return com.micro.service.springquartz.model.RestClientResultDTO<java.util.List<com.micro.service.springquartz.model.ClientApiRoleMenuRestDTO>>
    * @throws
    * @Author zxl
    * @Date  2020-10-28  16:07:43
    **/
    @GetMapping("/menumapping/menus/{menuguid}")
    RestClientResultDTO<List<ClientApiRoleMenuRestDTO>> getRoleMenuMapping(
            @PathVariable("menuguid") String menuguid
    );
}
