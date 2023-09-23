package com.github.loj.service.file;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface ProblemFileService {
    public void exportProblem(List<Long> pidList, HttpServletResponse response);
}
