package com.foodRecipe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_Nutrition {
	private int NUTRITION_ID;
    private Integer INFO_WGT;
    private Integer INFO_ENG;
    private Integer INFO_CAR;
    private Integer INFO_PRO;
    private Integer INFO_FAT;
    private Integer INFO_NA;
    private Integer RCP_SEQ;
	
}
