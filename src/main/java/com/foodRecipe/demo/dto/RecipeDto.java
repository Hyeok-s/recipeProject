package com.foodRecipe.demo.dto;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
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
    
    @JsonProperty("RCP_NA_TIP")
    private String RCP_NA_TIP;
    
    // 동적으로 조리 방법 데이터를 저장할 맵
    private Map<Integer, String> manualTextMap = new HashMap<>();
    private Map<Integer, String> manualImgMap = new HashMap<>();

    @JsonAnySetter
    public void setDynamicProperty(String key, String value) {
        	int stepNo = Integer.parseInt(key.substring(key.length() - 2));
            if (key.contains("IMG")) {
            	manualImgMap.put(stepNo, value);
            } else {
            	manualTextMap.put(stepNo, value);
            }
    }

    @JsonAnyGetter
    public Map<Integer, String> getManualTextMap() {
        return manualTextMap;
    }

    @JsonAnyGetter
    public Map<Integer, String> getManualImgMap() {
        return manualImgMap;
    }
}
