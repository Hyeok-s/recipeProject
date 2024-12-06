package com.foodRecipe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
	private int id;
	private String body;
	private String updateDate;
	private int memberId;
	private int communityId;
	private String nickName;
}
