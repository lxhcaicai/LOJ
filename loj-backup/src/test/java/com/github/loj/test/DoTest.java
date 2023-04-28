package com.github.loj.test;

import cn.hutool.crypto.SecureUtil;
import org.junit.jupiter.api.Test;

/**
 * @author lxhcaicai
 * @date 2023/4/25 20:56
 */
public class DoTest {
    @Test
    public void test() {
        System.out.println(SecureUtil.md5("lxhcaicai"));
    }
}
