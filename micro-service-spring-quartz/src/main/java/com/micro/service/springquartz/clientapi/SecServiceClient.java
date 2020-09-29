package com.micro.service.springquartz.clientapi;


import com.micro.service.springquartz.config.fasp3client.FaspClientSetting;
import com.micro.service.springquartz.model.ClientUserAuthenticateDTO;
import com.micro.service.springquartz.model.RestClientResultDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by wengy on 2019/1/10.
 */
@FeignClient(name = "fasp3-common", url = FaspClientSetting.faspServer)
@RequestMapping("/fasp/restapi/v1/sec")
@Component
public interface SecServiceClient {

    @RequestMapping(method = RequestMethod.POST, value = "/user/authenticate",
        headers = {"Content-Type=application/json"}, consumes = MediaType.APPLICATION_JSON_VALUE)
    public RestClientResultDTO<String> authenticate(
        @RequestBody ClientUserAuthenticateDTO userAuthenticateDTO);

    @RequestMapping(value = "/tokenids/{tokenid}/exist", method = RequestMethod.GET)
    public RestClientResultDTO<Boolean> checkTokenID(
        @PathVariable("tokenid") String tokenid
    );

}
