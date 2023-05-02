package com.github.loj.judge.entity;

/**
 * @author lxhcaicai
 * @date 2023/5/2 10:17
 */
public class Pair_<T1, T2> {
    private T1 key;
    private T2 value;

    public Pair_(T1 key, T2 value) {
        this.key = key;
        this.value = value;
    }

    public T1 getKey() {
        return key;
    }

    public void setKey(T1 key) {
        this.key = key;
    }

    public T2 getValue() {
        return value;
    }

    public void setValue(T2 value) {
        this.value = value;
    }

    @Override
    public boolean equals(Object obj) {
        if(this == obj) {
            return true;
        }
        if(obj instanceof Pair_<?, ?>) {
            Pair_<?,?> that = (Pair_<?, ?>) obj;
            return this.key.equals(that.key) && this.value.equals(this.value);
        }
        return false;
    }

    @Override
    public int hashCode() {
        return key.hashCode() * 123 + value.hashCode();
    }
}
