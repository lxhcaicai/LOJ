package com.github.loj.shiro;

import cn.hutool.extra.spring.SpringUtil;
import com.github.loj.utils.RedisUtils;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.util.CollectionUtils;

import java.util.*;

/**
 * @author lxhcaicai
 * @date 2023/4/23 22:06
 */
public class ShiroCache<K,V> implements Cache<K,V> {

    private Long cacheLiveTime;

    private String cacheKeyPrefix;

    private RedisUtils redisUtils;

    public ShiroCache(Long cacheLiveTime, String cacheKeyPrefix, RedisUtils redisUtils) {
        this.cacheLiveTime = cacheLiveTime;
        this.cacheKeyPrefix = cacheKeyPrefix;
        this.redisUtils = redisUtils;
    }

    /**
     * 缓存的key名称获取为shiro:cache:account
     *
     * @param key
     */
    private String getKey(K key) {
        String userId;
        if(key instanceof PrincipalCollection) {
            AccountProfile accountProfile = (AccountProfile) ((PrincipalCollection) key).getPrimaryPrincipal();
            userId = accountProfile.getUid();
        } else {
            userId = key.toString();
        }
        return this.cacheKeyPrefix + userId;
    }

    /**
     * 获取缓存
     * @param key
     * @return
     * @throws CacheException
     */
    @Override
    public V get(K key) throws CacheException {
        if(!this.redisUtils.hasKey(this.getKey(key))) {
            return null;
        }
        Object o = this.redisUtils.get(this.getKey(key));
        V v = (V) o;
        return v;
    }

    /**
     * 保存缓存
     * @param key
     * @param value
     * @return
     * @throws CacheException
     */
    @Override
    public V put(K key, V value) throws CacheException {
        this.redisUtils.set(this.getKey(key),value, this.cacheLiveTime);
        return value;
    }

    /**
     * 清楚缓存
     * @param key
     * @return
     * @throws CacheException
     */
    @Override
    public V remove(K key) throws CacheException {
        if(!this.redisUtils.hasKey(this.getKey(key))) {
            return null;
        }
        this.redisUtils.del(this.getKey(key));
        return null;
    }

    /**
     * 清空所有缓存
     * @throws CacheException
     */
    @Override
    public void clear() throws CacheException {
        RedisUtils redisUtils = SpringUtil.getBean(RedisUtils.class);
        Set<String> keys = redisUtils.keys(this.cacheKeyPrefix + "*");
        if(null != keys && keys.size() > 0) {
            redisUtils.del(keys);
        }
    }

    /**
     * 缓存个数
     * @return
     */
    @Override
    public int size() {
        Set<String> keys = redisUtils.keys(this.cacheKeyPrefix + "*");
        return keys.size();
    }

    /**
     * 获取所有的key
     * @return
     */
    @Override
    public Set<K> keys() {
        return (Set<K>) redisUtils.keys(this.cacheKeyPrefix + "*");
    }

    /**
     * 获取所有的value
     * @return
     */
    @Override
    public Collection<V> values() {
        Set<String> keys = this.redisUtils.keys(this.cacheKeyPrefix + "*");
        if(CollectionUtils.isEmpty(keys)) {
            return Collections.emptySet();
        } else {
            List<Object> values = new ArrayList<>(keys.size());
            Iterator<String> iterator = keys.iterator();
            while(iterator.hasNext()) {
                String key = iterator.next();
                Object value = null;
                value = this.redisUtils.get(key);
                if(value != null) {
                    values.add(value);
                }
            }
            return (Collection<V>) values;
        }
    }
}
