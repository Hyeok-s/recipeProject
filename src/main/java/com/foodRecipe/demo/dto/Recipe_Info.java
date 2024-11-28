package com.foodRecipe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_Info {
    private Integer RCP_SEQ;
    private String RCP_NM;
    private String RCP_WAY2;
    private String RCP_PAT2;
    private String RCP_PARTS_DTLS;
    private String HASH_TAG;
}
