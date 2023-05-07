package com.github.loj.dao.group.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.mapper.GroupMapper;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.GroupVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 21:48
 */
@Service
public class GroupEntityServiceImpl extends ServiceImpl<GroupMapper, Group> implements GroupEntityService {

    @Autowired
    private GroupMapper groupMapper;

    @Override
    public IPage<GroupVO> getGroupList(int limit, int currentPage, String keyword, Integer auth, String uid, Boolean onlyMine, Boolean isRoot) {
        IPage<GroupVO> iPage = new Page<>(currentPage, limit);
        List<GroupVO> groupList = groupMapper.getGroupList(iPage, keyword, auth, uid, onlyMine, isRoot);

        return iPage.setRecords(groupList);
    }
}
