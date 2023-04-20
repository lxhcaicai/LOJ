package com.github.loj.shiro;

import org.apache.shiro.authc.AuthenticationToken;

/**
 * @author lxhcaicai
 * @date 2023/4/21 1:09
 */
public class JwtToken implements AuthenticationToken {

    private String token;

    public JwtToken(String token) {
        this.token = token;
    }

    @Override
    public Object getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
