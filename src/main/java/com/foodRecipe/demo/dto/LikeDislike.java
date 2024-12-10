package com.foodRecipe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LikeDislike {
	private int id;
	private boolean likeStatus;
	private int memberId;
	private int communityId;
	private int likeCount;
	private int dislikeCount;
}
