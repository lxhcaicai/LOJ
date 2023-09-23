package com.github.loj.service.file;

import com.github.loj.common.result.CommonResult;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface ProblemFileService {
    public void exportProblem(List<Long> pidList, HttpServletResponse response);

    public CommonResult<Void> importProblem(MultipartFile file);
}
