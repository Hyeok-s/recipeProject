package com.foodRecipe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_Manual {
	private Integer MANUAL_ID;
	private Integer STEP_NO;
    private String MANUAL_TEXT;
    private String MANUAL_IMG;
    private Integer RCP_SEQ;
}
