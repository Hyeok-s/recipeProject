package com.foodRecipe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_Ingredient {
	private Integer INGREDIENT_ID;
	private String RCP_PARTS_DTLS;
	private Integer RCP_SEQ;
}
