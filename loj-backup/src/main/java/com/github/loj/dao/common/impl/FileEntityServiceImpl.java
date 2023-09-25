package com.github.loj.dao.common.impl;

import cn.hutool.core.lang.hash.Hash;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.mapper.FileMapper;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.pojo.vo.ACMContestRankVO;
import com.github.loj.pojo.vo.OIContestRankVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/9 22:20
 */
@Service
public class FileEntityServiceImpl extends ServiceImpl<FileMapper, File> implements FileEntityService {

    @Autowired
    private FileMapper fileMapper;

    @Override
    public List<File> queryDeleteAvatarList() {
        return fileMapper.queryDeleteAvatarList();
    }

    @Override
    public List<File> queryCarouselFileList() {
        return fileMapper.queryCarouselFileList();
    }

    @Override
    public List<List<String>> getContestRankExcelHead(List<String> contestProblemDisplayIDList, boolean isACM) {
        List<List<String>> headList = new LinkedList<>();

        List<String> head0 = new LinkedList<>();
        head0.add("Rank");

        List<String> head1 = new LinkedList<>();
        head1.add("Username");
        List<String> head2 = new LinkedList<>();
        head2.add("ShowName");
        List<String> head3 = new LinkedList<>();
        head3.add("Real Name");
        List<String> head4 = new LinkedList<>();
        head4.add("School");

        headList.add(head0);
        headList.add(head1);
        headList.add(head2);
        headList.add(head3);
        headList.add(head4);

        List<String> head5 = new LinkedList<>();
        if(isACM) {
            head5.add("AC");
            List<String> head6 = new LinkedList<>();
            head6.add("total Submission");
            List<String> head7 = new LinkedList<>();
            head7.add("Total Penalty Time");
            headList.add(head5);
            headList.add(head6);
            headList.add(head7);
        } else {
            head5.add("Total Score");
            headList.add(head5);
        }

        // 添加题目头
        for(String displayID: contestProblemDisplayIDList) {
            List<String> tmp = new LinkedList<>();
            tmp.add(displayID);
            headList.add(tmp);
        }
        return headList;
    }

    @Override
    public List<List<Object>> changeACMContestRankToExcelRowList(List<ACMContestRankVO> acmContestRankVOList, List<String> contestProblemDisplayIDList, String rankShowName) {
        List<List<Object>> allRowDataList = new LinkedList<>();
        for(ACMContestRankVO acmContestRankVO: acmContestRankVOList) {
            List<Object> rowData = new LinkedList<>();
            rowData.add(acmContestRankVO.getRank() == -1 ? "*": acmContestRankVO.getRank().toString());
            rowData.add(acmContestRankVO.getUsername());
            if("username".equals(rankShowName)) {
                rowData.add(acmContestRankVO.getUsername());
            } else if("realname".equals(rankShowName)) {
                rowData.add(acmContestRankVO.getRealname());
            } else if("nickname".equals(rankShowName)) {
                rowData.add(acmContestRankVO.getNickname());
            } else {
                rowData.add("");
            }
            rowData.add(acmContestRankVO.getRealname());
            rowData.add(acmContestRankVO.getSchool());
            rowData.add(acmContestRankVO.getAc());
            rowData.add(acmContestRankVO.getTotal());
            rowData.add(acmContestRankVO.getTotalTime());
            HashMap<String, HashMap<String,Object>> submissionInfo = acmContestRankVO.getSubmissionInfo();
            for(String displayId: contestProblemDisplayIDList) {
                HashMap<String,Object> problemInfo = submissionInfo.getOrDefault(displayId, null);
                if (problemInfo != null) { // 如果是有提交记录的
                    boolean isAc = (boolean) problemInfo.getOrDefault("isAC", false);
                    String info = "";
                    int errorNum = (int) problemInfo.getOrDefault("errorNum", 0);
                    int tryNum = (int) problemInfo.getOrDefault("tryNum", 0);
                    if(isAc) {
                        if (errorNum == 0) {
                            info = "+(1)";
                        } else {
                            info = "-(" + (errorNum + 1) + ")";
                        }
                    } else {
                        if(tryNum != 0 && errorNum != 0) {
                            info = "-(" + errorNum + "+" + tryNum + ")";
                        } else if(errorNum != 0) {
                            info = "-(" + errorNum + ")";
                        } else if(tryNum != 0) {
                            info = "?(" + tryNum + ")";
                        }
                    }
                    rowData.add(info);
                } else {
                    rowData.add("");
                }
            }
            allRowDataList.add(rowData);
        }
        return allRowDataList;
    }

    @Override
    public List<List<Object>> changOIContestRankToExcelRowList(List<OIContestRankVO> oiContestRankVOList,
                                                               List<String> contestProblemDisplayIDList,
                                                               String rankShowName) {
        List<List<Object>> allRowDataList = new LinkedList<>();
        for(OIContestRankVO oiContestRankVO: oiContestRankVOList) {
            List<Object> rowData = new LinkedList<>();
            rowData.add(oiContestRankVO.getRank() == -1? "*": oiContestRankVO.getRank().toString());
            rowData.add(oiContestRankVO.getUsername());
            if ("username".equals(rankShowName)) {
                rowData.add(oiContestRankVO.getUsername());
            } else if ("realname".equals(rankShowName)) {
                rowData.add(oiContestRankVO.getRealname());
            } else if ("nickname".equals(rankShowName)) {
                rowData.add(oiContestRankVO.getNickname());
            } else {
                rowData.add("");
            }
            rowData.add(oiContestRankVO.getRealname());
            rowData.add(oiContestRankVO.getSchool());
            rowData.add(oiContestRankVO.getTotalScore());
            HashMap<String,Integer> submissionInfo = oiContestRankVO.getSubmissionInfo();
            for(String displayID: contestProblemDisplayIDList) {
                Integer score = submissionInfo.getOrDefault(displayID, null);
                if(score != null) {
                    rowData.add(score);
                } else {
                    rowData.add("");
                }
            }
            allRowDataList.add(rowData);
        }
        return allRowDataList;
    }

    @Override
    public int updateFileToDeleteByUidAndType(String uid, String type) {
        return fileMapper.updateFileToDeleteByUidAndType(uid,type);
    }

    @Override
    public int updateFileToDeleteByGidAndType(Long gid, String type) {
        return fileMapper.updateFileToDeleteByGidAndType(gid, type);
    }
}
