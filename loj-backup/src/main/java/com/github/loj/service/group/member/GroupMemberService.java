package com.github.loj.service.group.member;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.group.GroupMember;
import com.github.loj.pojo.vo.GroupMemberVO;

public interface GroupMemberService {
    public CommonResult<IPage<GroupMemberVO>> getMemberList(Integer limit, Integer currentPage, String keyword, Integer auth, Long gid);

    public CommonResult<IPage<GroupMemberVO>> getApplyList(Integer limit, Integer currentPage, String keyword, Integer auth, Long gid);

    public CommonResult<Void> addMember(Long gid, String code, String reason);

    public CommonResult<Void> updateMember(GroupMember groupMember);

    public CommonResult<Void> deleteMember(String uid, Long gid);

    public CommonResult<Void> exitGroup(Long gid);
}
