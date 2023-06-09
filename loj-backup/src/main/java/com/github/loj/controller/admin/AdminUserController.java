package com.github.loj.controller.admin;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.AdminEditUserDTO;
import com.github.loj.pojo.vo.UserRolesVO;
import com.github.loj.service.admin.user.AdminUserService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/5/5 0:51
 */
@RestController
@RequestMapping("api/admin/user")
public class AdminUserController {

    @Autowired
    private AdminUserService adminUserService;

    @GetMapping("/get-user-list")
    @RequiresAuthentication
    @RequiresPermissions("user_admin")
    public CommonResult<IPage<UserRolesVO>> getUserList(@RequestParam(value = "limit", required = false) Integer limit,
                                                        @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                        @RequestParam(value = "onlyAdmin", defaultValue = "false") Boolean onlyAdmin,
                                                        @RequestParam(value = "keyword", required = false) String keyword) {
        return adminUserService.getUserList(limit,currentPage, onlyAdmin,keyword);
    }


    @PostMapping("/generate-user")
    @RequiresPermissions("user_admin")
    @RequiresAuthentication
    public CommonResult<Map<Object,Object>> generateUser(@RequestBody Map<String,Object> params) {
        return adminUserService.generateUser(params);
    }

    @PutMapping("/edit-user")
    @RequiresPermissions("user_admin")
    public CommonResult<Void> editUser(@RequestBody AdminEditUserDTO adminEditUserDTO) {
        return adminUserService.editUser(adminEditUserDTO);
    }

    @DeleteMapping("/delete-user")
    @RequiresPermissions("user_admin")
    @RequiresAuthentication
    public CommonResult<Void> deleteUser(@RequestBody Map<String,Object> params) {
        return adminUserService.deleteUser((List<String>) params.get("ids"));
    }

    @PostMapping("/insert-batch-user")
    @RequiresPermissions("user_admin")
    @RequiresAuthentication
    public CommonResult<Void> insertBatchUser(@RequestBody Map<String,Object> params) {
        return adminUserService.insertBatchUser((List<List<String>>) params.get("users"));
    }
}
