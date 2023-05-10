package com.github.loj.pojo.entity.contest;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * @author lxhcaicai
 * @date 2023/5/10 23:05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@ApiModel(value="ContestProblem对象", description="")
public class ContestProblem {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty(value = "该题目在比赛中的顺序id")
    private String displayId;

    @ApiModelProperty(value = "比赛id")
    private Long cid;

    @ApiModelProperty(value = "题目id")
    private Long pid;

    @ApiModelProperty(value = "该题目在比赛中的标题，默认为原名字")
    private String displayTitle;

    @ApiModelProperty(value = "气球的颜色")
    private String color;

    @TableField(fill = FieldFill.INSERT)
    private Date gmtCreate;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date gmtModified;

}
