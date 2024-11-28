package com.foodRecipe.demo.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_Image {
	private Integer IMAGE_ID;
    private String ATT_FILE_NO_MAIN;
    private String ATT_FILE_NO_MK;
    private Integer RCP_SEQ;
}
