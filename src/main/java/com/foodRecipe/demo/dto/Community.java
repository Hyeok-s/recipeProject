package com.foodRecipe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Community {
	private int id;
	private String title;
	private String body;
	private String category;
	private String regDate;
	private String updateDate;
	private int count;
	private int memberId;
	private int categoryId;
	private String nickName;
}
