package com.github.loj.pojo.dto;

import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingCategory;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class TrainingDTO {

    private Training training;

    private TrainingCategory trainingCategory;

}
