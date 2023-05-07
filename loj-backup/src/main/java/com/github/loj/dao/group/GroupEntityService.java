package com.github.loj.dao.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.GroupVO;

/**
 * @author lxhcaicai
 * @date 2023/5/7 21:35
 */
public interface GroupEntityService extends IService<Group> {
    IPage<GroupVO> getGroupList(int limit,
                                int currentPage,
                                String keyword,
                                Integer auth,
                                String uid,
                                Boolean onlyMine,
                                Boolean isRoot);
}
