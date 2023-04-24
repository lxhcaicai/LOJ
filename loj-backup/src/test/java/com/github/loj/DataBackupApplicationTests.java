package com.github.loj;

import com.github.loj.mapper.UserRoleMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * @author lxhcaicai
 * @date 2023/4/25 1:05
 */
@SpringBootTest
public class DataBackupApplicationTests {
    @Autowired
    private UserRoleMapper userRoleMapper;

    @Test
    public void testUserRoleMapper() {
        System.out.println(userRoleMapper.getRolesByUid("1"));
    }
}
