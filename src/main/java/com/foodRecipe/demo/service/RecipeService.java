package com.foodRecipe.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodRecipe.demo.dto.RecipeDto;

@Service
public class RecipeService {

    public List<RecipeDto> fetchAllRecipes() {
        String keyId = "9bcfd71bc94d44cc88d2";
        String serviceId = "COOKRCP01";
        String dataType = "json";
        int pageSize = 100; // 한 번의 호출에서 가져올 데이터 수
        int startIdx = 1;
        List<RecipeDto> allRecipes = new ArrayList<>();

        RestTemplate restTemplate = new RestTemplate();
        ObjectMapper objectMapper = new ObjectMapper();

        while (true) {
            int endIdx = startIdx + pageSize - 1;

            // 요청 URL 구성
            String url = String.format(
                "http://openapi.foodsafetykorea.go.kr/api/%s/%s/%s/%d/%d",
                keyId, serviceId, dataType, startIdx, endIdx
            );

            try {
                // API 호출 및 응답 처리
                String response = restTemplate.getForObject(url, String.class);
                JsonNode root = objectMapper.readTree(response);
                JsonNode row = root.path(serviceId).path("row");

                // row가 비어있으면 모든 데이터를 가져온 것으로 간주
                if (row.isEmpty()) {
                    break;
                }

                // 데이터를 리스트에 추가
                for (JsonNode node : row) {
                    RecipeDto recipe = objectMapper.treeToValue(node, RecipeDto.class);
                    allRecipes.add(recipe);
                }

                // 다음 페이지로 이동
                startIdx += pageSize;

            } catch (Exception e) {
                e.printStackTrace();
                break;
            }
        }

        System.out.println("총 레시피 개수: " + allRecipes.size());
        return allRecipes;
    }
}
