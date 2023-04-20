package com.github.loj.shiro;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.utils.JwtUtils;
import com.github.loj.utils.RedisUtils;
import com.github.loj.utils.ServiceContextUtils;
import io.jsonwebtoken.Claims;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExecutionChain;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author lxhcaicai
 * @date 2023/4/20 22:58
 */
@Component
@Slf4j(topic = "loj")
public class JwtFilter extends AuthenticatingFilter {
    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private RedisUtils redisUtils;

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        HttpServletRequest httpRequest = WebUtils.toHttp(request);
        WebUtils.saveRequest(httpRequest);
        WebApplicationContext context = RequestContextUtils.findWebApplicationContext(httpRequest);
        RequestMappingHandlerMapping mapping = context.getBean("requestMappingHandlerMapping", RequestMappingHandlerMapping.class);

        try {
            HandlerExecutionChain handler = mapping.getHandler(httpRequest);
            HandlerMethod handlerClazz = (HandlerMethod) handler.getHandler();
            // 判断请求是否访问的是公共接口，如果拥有@AnonApi注解则不再走登录认证，直接访问controller对应的方法
            AnonApi anonApi = ServiceContextUtils.getAnnotation(handlerClazz.getMethod(),
                    handlerClazz.getBeanType(),
                    AnonApi.class);

            if(anonApi != null) {
                String jwt = httpRequest.getHeader("Authorization");
                if(StrUtil.isNotBlank(jwt)) {
                    try {
                        Claims claims = jwtUtils.getClaimByToken(jwt);
                        if(claims == null || jwtUtils.isTokenExpired(claims.getExpiration())) {
                            // 如果已经过期，则不进行登录尝试
                            return true;
                        }

                        String userId= claims.getSubject();
                        boolean hasToken = jwtUtils.hasToken(userId);
                        // 缓存中不存在，说明了token失效，则不进行登录尝试
                        if(!hasToken) {
                            return true;
                        }
                        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
                        if(userRolesVo == null) {
                            // 尝试手动登录
                            JwtToken jwtToken = new JwtToken(jwt);
                            SecurityUtils.getSubject().login(jwtToken);
                        }

                    } catch (Exception ignored) {
                        // 即使出错，也不影响正常访问无鉴权接口
                    }
                }
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
           return true;
        }
    }

    @Override
    protected AuthenticationToken createToken(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String jwt = request.getHeader("Authorization");
        if(StrUtil.isBlank(jwt)) {
            return null;
        }
        return new JwtToken(jwt);
    }

    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String token = request.getHeader("Authorization");
        if(StrUtil.isBlank(token)) {
            return true;
        } else {
            Claims claims = jwtUtils.getClaimByToken(token);
            if(claims == null || jwtUtils.isTokenExpired(claims.getExpiration())) {
                return this.onLoginFailure(null, new AccountException("登录状态已失效，请重新登录!"), servletRequest, servletResponse);
            }
            String userId = claims.getSubject();

            // 如果校验请求携带的token 与 redis缓存对应的token
            // 那就会造成一个地方登录，另一个地方老的token就直接失效。
            // 对于OJ来说，允许多地方登录在线。
            boolean hasToken = jwtUtils.hasToken(userId);
            if(!hasToken) {
                return this.onLoginFailure(null, new AccountException("登录状态已失效，请重新登录!"), servletRequest, servletResponse);
            }
            if(!redisUtils.hasKey(ShiroConstant.SHIRO_TOKEN_REFRESH + userId)) {
                //过了需更新token时间，但是还未过期，则进行token刷新
                HttpServletResponse httpResponse = (HttpServletResponse) servletResponse;
                HttpServletRequest httpRequest = (HttpServletRequest) servletRequest;
                this.refreshToken(httpRequest, httpResponse, userId);
            }
        }
        return executeLogin(servletRequest, servletResponse);
    }

    private void refreshToken(HttpServletRequest request, HttpServletResponse response, String userId) {
        boolean lock = redisUtils.getLock(ShiroConstant.SHIRO_TOKEN_LOCK + userId, 20); // 获取锁 20s
        if(lock) {
            String newToken = jwtUtils.generateToken(userId);
            response.setHeader("Access-Control-Allow-Credentials", "true");
            response.setHeader("Authorization", newToken); //放到信息头部
            response.setHeader("Access-Control-Expose-Headers", "Refresh-Token,Authorization,Url-Type"); //让前端可用访问
            response.setHeader("Url-Type", request.getHeader("Url-Type")); // 为了前端能区别请求来源
            response.setHeader("Refresh-Token", "true"); //告知前端需要刷新token
        }
        redisUtils.releaseLock(ShiroConstant.SHIRO_TOKEN_LOCK + userId);
    }

    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        returnErrorResponse(request, response, e, ResultStatus.ACCESS_DENIED);
        return false;
    }

    private void returnErrorResponse(ServletRequest request, ServletResponse response, Exception e, ResultStatus resultStatus) {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        try {
            Throwable throwable = e.getCause() == null? e: e.getCause();
            CommonResult<Void> result = CommonResult.errorResponse(throwable.getMessage(), resultStatus);
            String json = JSONUtil.toJsonStr(result);
            httpResponse.setContentType("application/json;charset=utf-8");
            httpResponse.setHeader("Access-Control-Expose-Headers", "Refresh-Token,Authorization,Url-Type"); //让前端可用访问
            httpResponse.setHeader("Access-Control-Allow-Credentials", "true");
            httpResponse.setHeader("Url-Type", httpRequest.getHeader("Url-Type")); // 为了前端能区别请求来源
            httpResponse.setStatus(resultStatus.getStatus());
            httpResponse.getWriter().println(json);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * 对跨域提供支持
     */
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
        httpServletResponse.setHeader("Access-control-Allow-Origin", httpServletRequest.getHeader("Origin"));
        httpServletResponse.setHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS,PUT,DELETE");
        httpServletResponse.setHeader("Access-Control-Allow-Headers", httpServletRequest.getHeader("Access-Control-Request-Headers"));
        httpServletResponse.setHeader("Access-Control-Expose-Headers",
                "Refresh-Token,Authorization,Url-Type,Content-disposition,Content-Type"); //让前端可用访问

        //  跨域时会首先发送一个OPTIONS请求，这里我们给OPTIONS请求直接返回正常状态
        if(httpServletRequest.getMethod().equals(RequestMethod.OPTIONS.name())) {
            httpServletResponse.setStatus(org.springframework.http.HttpStatus.OK.value());
            return false;
        }
        return super.preHandle(request, response);
    }
}
