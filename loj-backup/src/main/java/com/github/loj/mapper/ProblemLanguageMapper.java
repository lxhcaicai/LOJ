package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.problem.ProblemLanguage;
import com.sun.org.glassfish.gmbal.ManagedObject;
import org.springframework.stereotype.Repository;

@ManagedObject
@Repository
public interface ProblemLanguageMapper extends BaseMapper<ProblemLanguage> {
}
