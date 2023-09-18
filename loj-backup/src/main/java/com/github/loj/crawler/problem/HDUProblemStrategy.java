package com.github.loj.crawler.problem;

import cn.hutool.core.util.ReUtil;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.utils.Constants;
import com.github.loj.utils.JsoupUtils;
import org.jsoup.Connection;
import org.jsoup.nodes.Document;
import org.springframework.util.Assert;

public class HDUProblemStrategy extends ProblemStrategy {

    public static final String JUDGE_NAME = "HDU";
    public static final String HOST = "http://acm.hdu.edu.cn";
    public static final String PROBLEM_URL = "/showproblem.php?pid=%s";

    @Override
    public RemoteProblemInfo getProblemInfo(String problemId, String author) throws Exception {
        // 验证题号是否符合规范
        Assert.isTrue(problemId.matches("[1-9]\\d*"), "HDU题号格式错误！");
        Problem info = new Problem();
        String url = HOST + String.format(PROBLEM_URL, problemId);
        Connection connection = JsoupUtils.getConnectionFromUrl(url, null, null);
        Document document = JsoupUtils.getDocument(connection, null);
        String html = document.html();
        info.setProblemId(JUDGE_NAME + "-" + problemId);
        info.setTitle(ReUtil.get("color:#1A5CC8\">([\\s\\S]*?)</h1>", html, 1).trim());
        info.setTimeLimit(Integer.parseInt(ReUtil.get("(\\d*) MS", html, 1)));
        info.setMemoryLimit(Integer.parseInt(ReUtil.get("/(\\d*) K", html, 1)) / 1024);
        info.setDescription(ReUtil.get(">Problem Description</div> <div class=.*?>([\\s\\S]*?)</div>", html, 1)
                .replaceAll("src=\"[../]*", "src=\"" + HOST + "/"));
        info.setInput(ReUtil.get(">Input</div> <div class=.*?>([\\s\\S]*?)</div>", html, 1));
        info.setOutput(ReUtil.get(">Output</div> <div class=.*?>([\\s\\S]*?)</div>", html, 1));
        StringBuilder sb = new StringBuilder("<input>");
        sb.append(ReUtil.get(">Sample Input</div><div .*?,monospace;\">([\\s\\S]*?)</div></pre>", html, 1));
        sb.append("</input><output>");
        sb.append(ReUtil.get(">Sample Output</div><div .*?monospace;\">([\\s\\S]*?)(<div style=.*?</div><i style=.*?</i>)*?</div></pre>", html, 1)).append("</output>");
        info.setExamples(sb.toString());
        info.setHint(ReUtil.get("<i>Hint</i></div>([\\s\\S]*?)</div><i .*?<br><[^<>]*?panel_title[^<>]*?>", html, 1));
        info.setIsRemote(true);
        info.setSource(String.format("<a style='color:#1A5CC8' href='https://acm.hdu.edu.cn/showproblem.php?pid=%s'>%s</a>", problemId, JUDGE_NAME + "-" + problemId));
        info.setType(0)
                .setAuth(1)
                .setAuthor(author)
                .setOpenCaseResult(false)
                .setIsRemoveEndBlank(false)
                .setIsGroup(false)
                .setDifficulty(1); // 默认为简单

        return new RemoteProblemInfo()
                .setProblem(info)
                .setTagList(null)
                .setRemoteOJ(Constants.RemoteOJ.HDU);

    }
}
