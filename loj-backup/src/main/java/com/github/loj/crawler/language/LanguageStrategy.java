package com.github.loj.crawler.language;

import com.github.loj.pojo.entity.problem.Language;

import java.util.List;

public abstract class LanguageStrategy {

    public abstract List<Language> buildLanguageListByIds(List<Language> allLanguageList, List<String> langIdList);
}
