package com.micro.service.springredis.mapper;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeNode;
import cn.hutool.core.lang.tree.TreeUtil;
import com.micro.service.springredis.model.DataBaseOne;
import com.micro.service.springredis.model.DataBaseTwo;
import com.micro.service.tool.until.*;
import com.micro.service.tool.until.api.ResultBuilder;
import com.micro.service.tool.until.beancopy.BeanCopierUtil;
import com.wf.captcha.utils.CaptchaUtil;
import lombok.SneakyThrows;
import org.junit.jupiter.api.Test;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.*;

/**
 * @ClassName BeanCopyTest
 * @Description TODO
 * @Author zhouxiaole
 * @Date 2020/11/28 18:00
 * @Version 1.0.0
 */
public class BeanCopyTest {
    @Test
    public void insertOrUpdate() {
        DataBaseOne dataBaseOne = DataBaseOne.builder().username("joe").password("123").build();
        DataBaseTwo dataBaseTwo = DataBaseTwo.builder().build();
        BeanCopierUtil.copy(dataBaseOne,dataBaseTwo);
        JsonLogUtils.print(FastJsonUtils.getBeanToJson(dataBaseTwo));

        DataBaseTwo dataBaseTwo1 = DataBaseTwo.builder().name("joe").pwd("123").build();
        DataBaseOne dataBaseOne1 = DataBaseOne.builder()
                .username("joe")
                .password("123")
                .list(Arrays.asList("1","3","5"))
                .dataBaseTwos(Arrays.asList(dataBaseTwo1))
                .build();
        JsonLogUtils.print(FastJsonUtils.getBeanToJson(ResultBuilder.success(dataBaseOne1)));

    }


    @Test
    public void test1() {
        String s = "http://localhost:19017/micro-service-spring-redis/testPage";
        String encode = Base64Util.encodeUrlSafe(s);
        System.err.println(encode);
        String decode = Base64Util.decodeUrlSafe(encode);
        System.err.println(decode);
    }

    @Test
    public void test2() {
        String url = "http://10.65.246.202/fasp/restapi/v1/sec/tokenids/CFCEDB24EC5CD782947CE1F6EED2438Eye9XfxPf/userinfo";
        String s = OkHttpUtil.get(url, null);
        JsonLogUtils.print(s);
    }
    @Test
    public void test3() {
        String url = "http://localhost:19017/micro-service-spring-redis/testRedisBeanStore";
        Map<String,String> map = new HashMap<>();
        map.put("id", "1");
        String s = OkHttpUtil.get(url, map);
        JsonLogUtils.print(s);
    }
    @Test
    public void test5() {
        // 构建node列表
        List<TreeNode<String>> nodeList = CollUtil.newArrayList();
        nodeList.add(new TreeNode<>("1", "0", "系统管理", 5));
        nodeList.add(new TreeNode<>("11", "1", "用户管理", 222222));
        nodeList.add(new TreeNode<>("111", "11", "用户添加", 0));
        nodeList.add(new TreeNode<>("2", "0", "店铺管理", 1));
        nodeList.add(new TreeNode<>("21", "2", "商品管理", 44));
        nodeList.add(new TreeNode<>("221", "2", "商品管理2", 2));
        List<Tree<String>> treeList = TreeUtil.build(nodeList, "0");
        JsonLogUtils.print(FastJsonUtils.getBeanToJson(treeList));
    }

    @SneakyThrows
    @Test
    public void test4() {
        String indexName = "PK_VD1000_ELE_ID_ELE_CODE_ELE_NAME";
        String indexNameStr = indexName.toString();
        if(indexName.length()>30){
            indexNameStr= indexNameStr.substring(0,30);
            String suffix = indexNameStr.substring(indexNameStr.length() - 1);
            if ("_".equals(suffix)){
                indexNameStr=indexNameStr.substring(0,indexNameStr.length()-1);
            }

        }
        System.err.println(indexNameStr);

        String tableName = "PM_FG3123_LOG";

        String substring = tableName.substring(tableName.length() - 4);

        System.err.println(substring);
    }
}
