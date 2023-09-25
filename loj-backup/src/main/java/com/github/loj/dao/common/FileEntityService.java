package com.github.loj.dao.common;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.pojo.vo.ACMContestRankVO;
import com.github.loj.pojo.vo.OIContestRankVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/9 22:18
 */
public interface FileEntityService extends IService<File> {
    List<File> queryDeleteAvatarList();

    List<File> queryCarouselFileList();

    List<List<String>>  getContestRankExcelHead(List<String> contestProblemDisplayIDList, boolean isACM);

    List<List<Object>> changeACMContestRankToExcelRowList(List<ACMContestRankVO> acmContestRankVOList,
                                                          List<String> contestProblemDisplayIDList,
                                                          String rankShowName);

    List<List<Object>> changOIContestRankToExcelRowList(List<OIContestRankVO> oiContestRankVOList,
                                                        List<String> contestProblemDisplayIDList,
                                                        String rankShowName);

    int updateFileToDeleteByUidAndType(String uid, String type);
}
