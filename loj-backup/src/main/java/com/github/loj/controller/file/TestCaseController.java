package com.github.loj.controller.file;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.service.file.TestCaseService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
@RequestMapping("/api/file")
public class TestCaseController {

    @Autowired
    private TestCaseService testCaseService;

    @PostMapping("upload-testcase-zip")
    @ResponseBody
    @RequiresAuthentication
    public CommonResult<Map<Object,Object>> uploadTestcaseZip(@RequestParam("file")MultipartFile file,
                                                              @RequestParam(value = "mode", defaultValue = "default") String mode,
                                                              @RequestParam(value = "gid", required = false) Long gid) {
        return testCaseService.uploadTestcaseZip(file, gid, mode);
    }

    @GetMapping("/download-testcase")
    @RequiresAuthentication
    public void downloadTestcase(@RequestParam("pid") Long pid, HttpServletResponse response) throws StatusForbiddenException, StatusFailException {
        testCaseService.downloadTestcase(pid, response);
    }

}
