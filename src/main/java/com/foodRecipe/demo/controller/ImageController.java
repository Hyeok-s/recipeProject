package com.foodRecipe.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Map;

@Controller
public class ImageController {

    @Value("${flask.server.url}") // application.properties에 플라스크 서버 URL 추가
    private String flaskServerUrl;

    @PostMapping("/uploadImage")
    public String uploadImage(MultipartFile image, Model model) {
        if (image.isEmpty()) {
            model.addAttribute("error", "이미지를 선택해주세요!");
            return "test";
        }

        try {
            // RestTemplate 생성 및 Multipart 지원 설정
            RestTemplate restTemplate = new RestTemplate();

            // 요청 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            // 요청 바디 생성
            ByteArrayResource resource = new ByteArrayResource(image.getBytes()) {
                @Override
                public String getFilename() {
                    return image.getOriginalFilename();
                }
            };

            // 멀티파트 요청 생성
            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
            body.add("image", resource);

            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

            // Flask 서버의 /predict 엔드포인트 호출
            String flaskUrl = flaskServerUrl + "/predict";
            ResponseEntity<byte[]> response = restTemplate.postForEntity(flaskUrl, requestEntity, byte[].class);

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                // 이미지를 저장하거나 클라이언트로 반환
                String outputPath = "C:/nsh/test/output_image.jpg";
                Files.write(Paths.get(outputPath), response.getBody());
                model.addAttribute("success", "이미지가 성공적으로 처리되었습니다: " + outputPath);
            } else {
                model.addAttribute("error", "서버에서 유효하지 않은 응답을 받았습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();  // Exception의 자세한 정보를 출력
            model.addAttribute("error", "서버 처리 중 오류가 발생했습니다: " + e.getMessage());
        }

        return "test"; // JSP 파일 이름
    }
}
