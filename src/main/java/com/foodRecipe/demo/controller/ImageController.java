package com.foodRecipe.demo.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.foodRecipe.demo.dto.Recipe_Info;
import com.foodRecipe.demo.service.RecipeImageService;
import com.foodRecipe.demo.service.RecipeInfoService;

import org.springframework.core.io.Resource;

@Controller
public class ImageController {

	RecipeInfoService recipeInfoService;
	
	public ImageController(RecipeInfoService recipeInfoService) {
		this.recipeInfoService = recipeInfoService;
	}

    @PostMapping("/image/upload")
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile file) throws IOException {
        RestTemplate restTemplate = new RestTemplate();

        // HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        String uuidFilename = UUID.randomUUID().toString() + getFileExtension(file.getOriginalFilename());
        // 파일 데이터를 ByteArrayResource로 변환
        ByteArrayResource resource = new ByteArrayResource(file.getBytes()) {
            @Override
            public String getFilename() {
                return uuidFilename;
            }
        };

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("image", resource);

        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
        String url = "http://127.0.0.1:5000/detect";

        try {
            ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, Map.class);
            Map<String, Object> responseBody = response.getBody();

            String resultImageUrl = "/image/showImage?pic=" + responseBody.get("image_url");
            List<String> detectedLabels = (List<String>) responseBody.get("labels");
            Map<String, Object> result = new HashMap<>();
            if(detectedLabels == null || detectedLabels.isEmpty()) {
            	result.put("result", 0);
            	result.put("message", "사진 내 인식된 재료가 없습니다.");
            }
            else {
            	List<Recipe_Info> recipeInfos = recipeInfoService.findRecipesByIngredients(detectedLabels);
            	if (recipeInfos.isEmpty()) {
                	result.put("result", 1);
                    result.put("message", "해당 재료로 검색된 레시피가 없습니다.");
                    result.put("detectedLabels", detectedLabels);
                }
            	else {
                	result.put("result", 2);
                    result.put("recipes", recipeInfos);
                }
            }
            result.put("resultImageUrl", resultImageUrl);
            result.put("detectedLabels", detectedLabels);
            return result;

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error sending file to Python server: " + e.getMessage());
        }
    }
    
    @GetMapping("/image/showImage")
    @ResponseBody
    public Resource showImage(String pic) throws IOException{
    	return new UrlResource("file:" + pic);
    }

    private String getFileExtension(String originalFilename) {
        int lastIndexOfDot = originalFilename.lastIndexOf(".");
        if (lastIndexOfDot == -1) {
            return ""; // 확장자가 없을 경우
        }
        return originalFilename.substring(lastIndexOfDot);
    }
}