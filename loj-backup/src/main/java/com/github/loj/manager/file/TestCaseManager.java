package com.github.loj.manager.file;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.file.FileWriter;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ZipUtil;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.dao.problem.ProblemCaseEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.GroupValidator;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Component
@Slf4j(topic = "loj")
public class TestCaseManager {

    @Autowired
    private ProblemCaseEntityService problemCaseEntityService;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private GroupValidator groupValidator;

    public Map<Object, Object> uploadTestcaseZip(MultipartFile file, Long gid, String mode) throws StatusForbiddenException, StatusFailException, StatusSystemErrorException{
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        if (!isRoot && !isProblemAdmin && !isAdmin
                && !(gid != null && groupValidator.isGroupAdmin(userRolesVo.getUid(), gid))){
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        //获取文件后缀
        String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
        if (!"zip".toUpperCase().contains(suffix.toUpperCase())){
            throw new StatusFailException("请上传zip格式的测试数据压缩包！");
        }
        String fileDirId = IdUtil.simpleUUID();
        String fileDir = Constants.File.TESTCASE_TMP_FOLDER.getPath() + "/" + fileDirId;
        String filePath = fileDir + "/" + file.getOriginalFilename();

        // 文件夹不存在就新建
        FileUtil.mkdir(fileDir);
        try {
            file.transferTo(new File(filePath));
        }  catch (IOException e) {
            log.error("评测数据文件上传异常-------------->{}", e.getMessage());
            throw new StatusSystemErrorException("服务器异常：评测数据上传失败！");
        }

        // 将压缩包压缩到指定文件夹
        ZipUtil.unzip(filePath, fileDir);
        // 删除zip文件
        FileUtil.del(filePath);
        // 检查文件是否存在
        File testCaseFileList = new File(fileDir);
        File[] files = testCaseFileList.listFiles();
        if (files == null || files.length == 0) {
            FileUtil.del(fileDir);
            throw new StatusFailException("评测数据压缩包里文件不能为空！");
        }

        HashMap<String,String> inputData = new HashMap<>();
        HashMap<String,String> outputData = new HashMap<>();

        // 遍历读取与检查是否in和out文件一一对应，否则报错
        for (File tmp: files) {
            String tmpPreName = null;
            if (tmp.getName().equals(".in")) {
                tmpPreName = tmp.getName().substring(0,tmp.getName().lastIndexOf(".in"));
                inputData.put(tmpPreName, tmp.getName());
            } else if (tmp.getName().endsWith(".out")) {
                tmpPreName = tmp.getName().substring(0,tmp.getName().lastIndexOf(".out"));
                outputData.put(tmpPreName, tmp.getName());
            } else if (tmp.getName().endsWith(".ans")) {
                tmpPreName = tmp.getName().substring(0,tmp.getName().lastIndexOf(".ans"));
                outputData.put(tmpPreName, tmp.getName());
            }  else if (tmp.getName().endsWith(".txt")) {
                tmpPreName = tmp.getName().substring(0,tmp.getName().lastIndexOf(".txt"));
                if (tmpPreName.contains("input")) {
                    inputData.put(tmpPreName.replaceAll("input","$*$"), tmp.getName());
                } else if (tmpPreName.contains("output")) {
                    outputData.put(tmpPreName.replaceAll("output","$*$"), tmp.getName());
                }
            }
        }

        // 进行数据对应检查,同时生成返回数据
        List<HashMap<String,Object>> problemCaseList = new LinkedList<>();
        for (String key: inputData.keySet()) {
            HashMap<String,Object> testcaseMap = new HashMap<>();
            String inputFileName = inputData.get(key);
            testcaseMap.put("input", inputFileName);

            // 若有名字对应的out文件不存在的，直接生成对应的out文件
            String oriOutputFileName = outputData.getOrDefault(key, null);
            if (oriOutputFileName == null) {
                oriOutputFileName = key + ".out";
                if (inputFileName.endsWith(".txt")) {
                    oriOutputFileName = inputFileName.replaceAll("input","output" );
                }
                FileWriter fileWriter = new FileWriter(fileDir + "/" + oriOutputFileName);
                fileWriter.write("");
            }

            testcaseMap.put("output", oriOutputFileName);
            if (Objects.equals(Constants.JudgeCaseMode.SUBTASK_LOWEST.getMode(),mode)
                    || Objects.equals(Constants.JudgeCaseMode.SUBTASK_AVERAGE.getMode(), mode)) {
                testcaseMap.put("groupNum", 1);
            }
            problemCaseList.add(testcaseMap);
        }

        List<HashMap<String,Object>> fileList = fileList = problemCaseList.stream()
                .sorted((o1,o2)-> {
                    String input1 = (String) o1.get("input");
                    String input2 = (String) o2.get("input");
                    String a = input1.split("\\.")[0];
                    String b = input2.split("\\.")[0];

                    if (a.length() > b.length()) {
                        return 1;
                    } else if (a.length() < b.length()) {
                        return -1;
                    }
                    return a.compareTo(b);
                })
                .collect(Collectors.toList());

        return MapUtil.builder()
                .put("fileList", fileList)
                .put("fileListDir", fileDir)
                .map();
    }
}
