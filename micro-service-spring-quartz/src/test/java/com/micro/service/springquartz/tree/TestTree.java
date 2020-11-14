package com.micro.service.springquartz.tree;

import com.alibaba.fastjson.JSON;

import com.micro.service.springquartz.enu.TypeEnum;
import com.micro.service.springquartz.utils.Catalog;
import com.micro.service.springquartz.utils.JsonLogUtils;
import com.micro.service.springquartz.utils.TreeUtils;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


/**
 * @ClassName TestTree
 * @Description TODO
 * @Author zhouxiaole
 * @Date 2020/11/13 23:48
 * @Version 1.0.0
 */
public class TestTree {

    @Test
    public void contextLoads() throws Exception {

        List<Catalog> list = new ArrayList<>();

        Catalog catalog = new Catalog();
        String flowId = randomUUID();
        catalog.setId(flowId);
        catalog.setName("name1");
        list.add(catalog);

        catalog = new Catalog();
        String flowId2 = randomUUID();
        catalog.setId(flowId2);
        catalog.setName("name2");
        catalog.setParentId(flowId);
        list.add(catalog);

        catalog = new Catalog();
        String flowId3 = randomUUID();
        catalog.setId(flowId3);
        catalog.setName("name3");
        catalog.setParentId(flowId);
        list.add(catalog);

        catalog = new Catalog();
        String flowId4 = randomUUID();
        catalog.setId(flowId4);
        catalog.setName("name4");
        catalog.setParentId(flowId);
        list.add(catalog);

        catalog = new Catalog();
        String flowId5 = randomUUID();
        catalog.setId(flowId5);
        catalog.setName("name5");
        catalog.setParentId(flowId2);
        list.add(catalog);

        catalog = new Catalog();
        String flowId6 = randomUUID();
        catalog.setId(flowId6);
        catalog.setName("name6");
        catalog.setParentId(flowId2);
        list.add(catalog);

        catalog = new Catalog();
        String flowId7 = randomUUID();
        catalog.setId(flowId7);
        catalog.setName("name7");
        catalog.setParentId(flowId5);
        list.add(catalog);

        catalog = new Catalog();
        String flowId8 = randomUUID();
        catalog.setId(flowId8);
        catalog.setName("name8");
        catalog.setParentId(flowId7);
        list.add(catalog);


        String flowId9 = randomUUID();
        catalog.setId(flowId9);
        catalog.setName("name9");
        catalog.setParentId(flowId8);
        list.add(catalog);


        List<Catalog> tree = null;
        try {
            tree = TreeUtils.getTree(list, "id");
        } catch (Exception e) {
            e.printStackTrace();
        }
        JsonLogUtils.println(JSON.toJSONString(tree));
    }

    protected String randomUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }


    @Test
    public void contextLoads1() {
        System.err.println(TypeEnum.VARCHAR.getName());
    }
}
