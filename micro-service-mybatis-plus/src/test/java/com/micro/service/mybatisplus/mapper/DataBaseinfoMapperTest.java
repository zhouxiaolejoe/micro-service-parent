package com.micro.service.mybatisplus.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.additional.query.impl.LambdaQueryChainWrapper;
import com.github.pagehelper.PageHelper;
import com.micro.service.mybatisplus.MicroServiceMybatisPlusApplicationTests;
import com.micro.service.mybatisplus.model.DataBaseinfo;
import com.micro.service.mybatisplus.model.User100w;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.mapper
 * @Author zhouxiaole
 * @Date 2020-09-13 20:46
 */
public class DataBaseinfoMapperTest extends MicroServiceMybatisPlusApplicationTests {
    @Autowired
    DataBaseinfoMapper dataBaseinfoMapper;
    @Autowired
    User100wMapper user100wMapper;
    public void updateBatch() {
        DataBaseinfo dataBaseinfo = dataBaseinfoMapper.selectById("1");
        System.err.println(dataBaseinfo);
    }

    public void batchInsert() {
    }

    public void insertOrUpdate() {
    }

    public void insertOrUpdateSelective() {
    }

    public void test01(){
        Map<String, Object> map = new HashMap<>();
        map.put("first_name", "李");
        QueryWrapper<User100w> queryWrapper = new QueryWrapper<>();
        queryWrapper.allEq(map);
        PageHelper.startPage(2,10);
        List<User100w> user100ws = user100wMapper.selectList(queryWrapper);
        System.err.println(user100ws);
        QueryWrapper<User100w> queryWrapperMap = new QueryWrapper<>();
        queryWrapperMap.eq("first_name","江");
        List<Map<String, Object>> maps = user100wMapper.selectMaps(queryWrapperMap);
        System.err.println(maps);
    }
    /**
     * 分页
     */
    @Test
    public void test02(){
        /**
         *  查询信息
         */
        Map<String, Object> map = new HashMap<>();
        map.put("first_name", "李");
        QueryWrapper<User100w> queryWrapper = new QueryWrapper<>();
        queryWrapper.allEq(map);
        /**
         *  分页信息
         */
        Page<User100w> page = new Page(1,5);

        IPage<User100w> user100wIPage = user100wMapper.selectPage(page,queryWrapper);
        System.err.println(user100wIPage.getRecords());
    }
    @Test
    public void test03(){
        /**
         *  查询信息
         */
        QueryWrapper<User100w> queryWrapper = new QueryWrapper<>();

        /**
         *  条件匹配记录数
         */

        Integer integer = user100wMapper.selectCount(queryWrapper);
        System.err.println(integer);
        /**
         *  id查询
         */
        User100w user100w = user100wMapper.selectById(12238102);
        System.err.println(user100w);
        /**
         * 批量id
         */
        List<User100w> user100ws = user100wMapper.selectBatchIds(Arrays.asList("12238100", "12238101", "12238103"));
        System.err.println(user100ws);
        /**
         * map多条件
         */
        Map<String, Object> map = new HashMap<>();
        map.put("first_name","李");
        map.put("last_name","莉二");
        List<User100w> user100ws1 = user100wMapper.selectByMap(map);
        System.err.println(user100ws1);

    }
    @Test
    public void test04(){
        LambdaQueryWrapper<User100w> lambdaQueryWrapper = Wrappers.<User100w>lambdaQuery().orderByDesc(User100w::getId);
        List<User100w> user100ws2 = user100wMapper.selectList(lambdaQueryWrapper);
        System.err.println(user100ws2);
        LambdaQueryWrapper<User100w> lambdaQueryWrapper1 = Wrappers.<User100w>lambdaQuery().eq(User100w::getFirstName, "李");
        List<User100w> user100ws = user100wMapper.selectList(lambdaQueryWrapper1);
        System.err.println(user100ws);


        QueryWrapper<User100w> queryWrapper = new QueryWrapper<>();
        // 条件构造器使用
        Map<String,Object> map = new HashMap<>(16);
        map.put("first_name","江");
        map.put("last_name","十乙");
        queryWrapper.allEq((k, v) -> k.equals("first_name") || k.equals("last_name"), map);
        List<User100w> user100ws1 = user100wMapper.selectList(queryWrapper);
        System.err.println(user100ws1);

    }
    @Test
    public void test05(){
        LambdaQueryWrapper<User100w> lambdaQueryWrapper = Wrappers.<User100w>lambdaQuery().like(User100w::getLastName, "乙");
        List<User100w> user100ws = user100wMapper.selectList(lambdaQueryWrapper);
        System.err.println(user100ws);
        List<User100w> user100ws1 = new LambdaQueryChainWrapper<>(user100wMapper).like(User100w::getLastName, "乙").list();
        System.err.println(user100ws1);
    }

    @Test
    public void test06(){
        User100w user = new User100w();
        user.setFirstName("彭");
        user.setLastName("十乙");
        Map<SFunction<User100w, ?>, Object> map = new HashMap<>(16);
        map.put(User100w::getFirstName,user.getFirstName());
        map.put(User100w::getLastName,user.getLastName());
        LambdaQueryWrapper<User100w> queryWrapper = Wrappers.<User100w>lambdaQuery().allEq(true,
                (k, v) -> k.apply(user).equals(user.getLastName()), map, true);
        user100wMapper.selectList(queryWrapper).forEach(System.err::println);

    }
//    @Test
//    public void add01(){
//        User100w user100w = User100w.builder().firstName("周").lastName("小乐").copyId(1).isDelete(0).score(92).sex("1").build();
//        int insert = user100wMapper.insert(user100w);
//        System.err.println(insert);
//    }
    @Test
    public void delete01(){
        int i = user100wMapper.deleteById(12238099);
    }

    @Test
    public void delete02(){
        user100wMapper.deleteBatchIds(Arrays.asList(12238101,12238100));
    }
    @Test
    public void delete03(){
        int i = user100wMapper.delete(Wrappers.<User100w>lambdaQuery().eq(User100w::getId,"12238102"));
    }
    @Test
    public void delete04(){
        Map<String, Object> hashMap = new HashMap<String, Object>() {
            {
                put("first_name", "江");
                put("last_name", "七田");
            }
        };
        user100wMapper.deleteByMap(hashMap);
    }
    @Test
    public void update01(){
        User100w user100w = User100w.builder().score(99).sex("1").id(12239104).build();
        user100wMapper.updateById(user100w);
    }
    @Test
    public void update02(){
        User100w user100w = User100w.builder().firstName("周").lastName("小乐").score(98).build();
        user100wMapper.update(user100w, Wrappers.<User100w>lambdaUpdate().eq(User100w::getFirstName,"周1").eq(User100w::getLastName,"小乐1"));
    }
    @Test
    public void update03(){
        Map<SFunction<User100w,?>, Object> map = new HashMap<>();
        map.put(User100w::getFirstName,"周");
        map.put(User100w::getLastName,"小乐");
        User100w user100w = User100w.builder().firstName("周1").lastName("小乐1").score(99).build();
        user100wMapper.update(user100w,Wrappers.<User100w>lambdaUpdate().allEq(map));
    }

}