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
 * Created by wengy on 2019/11/21.
 */
@FeignClient(name = "fasp3-common", url = FaspClientSetting.faspServer)
@RequestMapping("/fasp/restapi/v1/ca/roles")
public interface CaRoleClient {

    @GetMapping("/usermapping/users/{userguid}")
    RestClientResultDTO<List<ClientApiRoleUserRestDTO>> getRoleUserMapping(
            @PathVariable("userguid") String userguid
    );


    @GetMapping("/menumapping/menus/{menuguid}")
    RestClientResultDTO<List<ClientApiRoleMenuRestDTO>> getRoleMenuMapping(
            @PathVariable("menuguid") String menuguid
    );
}
