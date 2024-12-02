package com.foodRecipe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_Detail {
    private Integer RCP_SEQ;
    private String RCP_NM;
    private String RCP_WAY2;
    private String RCP_PAT2;
    private String RCP_PARTS_DTLS;
    private String ATT_FILE_NO_MAIN;
    private Integer INFO_WGT;
    private Integer INFO_ENG;
    private Integer INFO_CAR;
    private Integer INFO_PRO;
    private Integer INFO_FAT;
    private Integer INFO_NA;
    private String RCP_NA_TIP;
}
