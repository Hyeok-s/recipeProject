package com.foodRecipe.demo.dto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Memo {
	private int id;
	private String text;
	private int RCP_SEQ;
	private int memberId;
	private int STEP_NO;
	private String RCP_NM;
}