package com.github.loj.service.admin.user;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.AdminEditUserDTO;
import com.github.loj.pojo.vo.UserRolesVO;

import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/5/5 0:53
 */
public interface AdminUserService {
    public CommonResult<IPage<UserRolesVO>> getUserList(Integer limit, Integer currentPage, Boolean onlyAdmin, String keyword);

    public CommonResult<Map<Object,Object>> generateUser(Map<String,Object> params);

    public CommonResult<Void> editUser(AdminEditUserDTO adminEditUserDTO);
}
