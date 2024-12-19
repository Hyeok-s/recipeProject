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
    private String HASH_TAG;
    private String ATT_FILE_NO_MAIN;
    private boolean like = false;
    
    public Recipe_Info(Integer RCP_SEQ, String RCP_NM, String RCP_WAY2, String RCP_PAT2, String HASH_TAG) {
        this.RCP_SEQ = RCP_SEQ;
        this.RCP_NM = RCP_NM;
        this.RCP_WAY2 = RCP_WAY2;
        this.RCP_PAT2 = RCP_PAT2;
        this.HASH_TAG = HASH_TAG;
    }
}
