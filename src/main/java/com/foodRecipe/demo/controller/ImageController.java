package com.foodRecipe.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.Map;

@Controller
public class ImageController {

	@Value("${flask.server.url}") // Python 서버의 URL
	private String pythonServerUrl;

	@PostMapping("/upload")
	@ResponseBody
	public Map<String, Object> uploadFile(MultipartFile file) throws IOException {
		// RestTemplate 사용
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);

		// 이미지 파일 데이터 생성
		ByteArrayResource resource = new ByteArrayResource(file.getBytes()) {
			@Override
			public String getFilename() {
				return file.getOriginalFilename(); // 파일 이름 설정
			}
		};
		// MultiPart 데이터 생성
		MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
		body.add("image", resource); // Python 서버가 요구하는 키에 파일 추가
		// HTTP 요청 엔티티 생성
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

		String url = "http://127.0.0.1:5000/detect";

		// 요청 전송
		try {
			ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, Map.class);
			return response.getBody(); // Python 서버 응답 반환

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error sending file to Python server: " + e.getMessage());
		}
	}
}
