package com.github.loj.controller.file;

import com.github.loj.common.result.CommonResult;
import com.github.loj.service.file.ProblemFileService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/api/file")
public class ProblemFileController {

    @Autowired
    private ProblemFileService problemFileService;

    /**
     * 导出指定题目包括测试数据生成的ZIP
     * @param pidList
     * @param response
     */
    @GetMapping("/export-problem")
    @RequiresAuthentication
    @RequiresRoles("root")
    public void exportProblem(@RequestParam("pid")List<Long> pidList, HttpServletResponse response) {
        problemFileService.exportProblem(pidList, response);
    }

    /**
     * zip文件导入题目
     * @param file
     * @return
     */
    @RequiresRoles("root")
    @RequiresAuthentication
    @ResponseBody
    @PostMapping("/import-problem")
    public CommonResult<Void> importProblem(@RequestParam("file")MultipartFile file) {
        return problemFileService.importProblem(file);
    }
}
