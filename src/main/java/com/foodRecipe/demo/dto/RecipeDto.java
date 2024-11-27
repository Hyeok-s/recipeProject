package com.foodRecipe.demo.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecipeDto {
	@JsonProperty("RCP_SEQ")
    private String RCP_SEQ;
	
	@JsonProperty("RCP_NM")
    private String RCP_NM;
	
    @JsonProperty("RCP_WAY2")
    private String RCP_WAY2;
	
	
	@JsonProperty("RCP_PAT2")
    private String RCP_PAT2;
	
	@JsonProperty("INFO_WGT")
    private String INFO_WGT;
	
	
	@JsonProperty("INFO_ENG")
    private String INFO_ENG;
	
	@JsonProperty("INFO_CAR")
    private String INFO_CAR;
	
	@JsonProperty("INFO_PRO")
    private String INFO_PRO;
	
	@JsonProperty("INFO_FAT")
    private String INFO_FAT;
	
	
	@JsonProperty("INFO_NA")
    private String INFO_NA;
	

	@JsonProperty("HASH_TAG")
    private String HASH_TAG;

    @JsonProperty("ATT_FILE_NO_MAIN")
    private String ATT_FILE_NO_MAIN;
    
    @JsonProperty("ATT_FILE_NO_MK")
    private String ATT_FILE_NO_MK;
    
    @JsonProperty("RCP_PARTS_DTLS")
    private String RCP_PARTS_DTLS;
    
    @JsonProperty("MANUAL01")
    private String MANUAL01;
    @JsonProperty("MANUAL_IMG01")
    private String MANUAL_IMG01;
    
    @JsonProperty("MANUAL02")
    private String MANUAL02;
    @JsonProperty("MANUAL_IMG02")
    private String MANUAL_IMG02;
    
    @JsonProperty("MANUAL03")
    private String MANUAL03;
    @JsonProperty("MANUAL_IMG03")
    private String MANUAL_IMG03;
    
    @JsonProperty("MANUAL04")
    private String MANUAL04;
    @JsonProperty("MANUAL_IMG04")
    private String MANUAL_IMG04;
    
    @JsonProperty("MANUAL05")
    private String MANUAL05;
    @JsonProperty("MANUAL_IMG05")
    private String MANUAL_IMG05;
    
    @JsonProperty("MANUAL06")
    private String MANUAL06;
    @JsonProperty("MANUAL_IMG06")
    private String MANUAL_IMG06;
    
    @JsonProperty("MANUAL07")
    private String MANUAL07;
    @JsonProperty("MANUAL_IMG07")
    private String MANUAL_IMG07;
    
    @JsonProperty("MANUAL08")
    private String MANUAL08;
    @JsonProperty("MANUAL_IMG08")
    private String MANUAL_IMG08;
    
    @JsonProperty("MANUAL09")
    private String MANUAL09;
    @JsonProperty("MANUAL_IMG09")
    private String MANUAL_IMG09;
    
    @JsonProperty("MANUAL10")
    private String MANUAL10;
    @JsonProperty("MANUAL_IMG10")
    private String MANUAL_IMG10;
    
    @JsonProperty("MANUAL11")
    private String MANUAL11;
    @JsonProperty("MANUAL_IMG11")
    private String MANUAL_IMG11;
    
    @JsonProperty("MANUAL12")
    private String MANUAL12;
    @JsonProperty("MANUAL_IMG12")
    private String MANUAL_IMG12;
    
    @JsonProperty("MANUAL13")
    private String MANUAL13;
    @JsonProperty("MANUAL_IMG13")
    private String MANUAL_IMG13;
    
    @JsonProperty("MANUAL14")
    private String MANUAL14;
    @JsonProperty("MANUAL_IMG14")
    private String MANUAL_IMG14;
    
    @JsonProperty("MANUAL15")
    private String MANUAL15;
    @JsonProperty("MANUAL_IMG15")
    private String MANUAL_IMG15;
    
    @JsonProperty("MANUAL16")
    private String MANUAL16;
    @JsonProperty("MANUAL_IMG16")
    private String MANUAL_IMG16;
    
    @JsonProperty("MANUAL17")
    private String MANUAL17;
    @JsonProperty("MANUAL_IMG17")
    private String MANUAL_IMG17;
    
    @JsonProperty("MANUAL18")
    private String MANUAL18;
    @JsonProperty("MANUAL_IMG18")
    private String MANUAL_IMG18;
    
    @JsonProperty("MANUAL19")
    private String MANUAL19;
    @JsonProperty("MANUAL_IMG19")
    private String MANUAL_IMG19;
    
    @JsonProperty("MANUAL20")
    private String MANUAL20;
    @JsonProperty("MANUAL_IMG20")
    private String MANUAL_IMG20;
    
    @JsonProperty("RCP_NA_TIP")
    private String RCP_NA_TIP;
}
