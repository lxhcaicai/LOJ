package com.github.loj.shiro;

import com.github.loj.utils.RedisUtils;
import lombok.Data;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;

/**
 * @author lxhcaicai
 * @date 2023/4/23 22:03
 */
@Data
public class ShiroCacheManager implements CacheManager {

    private long cacheLive; // cache 存活时间 秒

    private String cacheKeyPrefix; // cache前缀

    private RedisUtils redisUtils; // redis 工具类


    @Override
    public <K, V> Cache<K, V> getCache(String s) throws CacheException {
        return new ShiroCache<K,V>(cacheLive, cacheKeyPrefix, redisUtils);
    }
}
