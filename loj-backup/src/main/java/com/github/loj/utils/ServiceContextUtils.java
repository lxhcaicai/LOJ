package com.github.loj.utils;

import org.springframework.core.annotation.AnnotationUtils;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

/**
 * @author lxhcaicai
 * @date 2023/4/21 1:33
 */
public class ServiceContextUtils {
    public static <T extends Annotation> T getAnnotation(Method method, Class<?> clazz, Class<T> annotationClass) {
        T annotation = AnnotationUtils.getAnnotation(clazz, annotationClass);
        if(annotation == null) {
            annotation = AnnotationUtils.findAnnotation(clazz, annotationClass);
        }
        return annotation;
    }
}
