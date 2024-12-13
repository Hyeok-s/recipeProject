package com.foodRecipe.demo.controller;

<<<<<<< HEAD
=======
import java.io.File;
>>>>>>> 9820606 (2024-12-13)
import java.util.HashMap;
import java.util.List;
import java.util.Map;

<<<<<<< HEAD
=======
import org.springframework.http.HttpStatus;
>>>>>>> 9820606 (2024-12-13)
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
<<<<<<< HEAD
=======
import org.springframework.web.multipart.MultipartFile;
>>>>>>> 9820606 (2024-12-13)

import com.foodRecipe.demo.dto.Recipe_Info;
import com.foodRecipe.demo.service.RecipeImageService;
import com.foodRecipe.demo.service.RecipeInfoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	RecipeInfoService recipeInfoService;
	
	public HomeController(RecipeInfoService recipeInfoService, RecipeImageService recipeImageService) {
		this.recipeInfoService = recipeInfoService;
	}
	
	@GetMapping("/")
	public String main() {
		return "redirect:/home/main";
	}
	
	@GetMapping("/home/main")
<<<<<<< HEAD
	public String mainForm(
	        Model model, HttpSession session) {

	    // 세션에 memberId가 있을 경우 추가
	    if (session.getAttribute("memberId") != null) {
	        model.addAttribute("memberId", session.getAttribute("memberId"));
	    }

	    return "recipe/main";
	}
	
    @GetMapping("/recipe/search")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> searchRecipes(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "sort", defaultValue = "latest") String sort) {

        final int pageSize = 20; // 페이지당 항목 수
        int offset = (page - 1) * pageSize;

        // 검색 및 정렬된 데이터를 가져오기
        List<Recipe_Info> recipeInfos = recipeInfoService.searchRecipes(query, sort, pageSize, offset);
        int totalDataCount = recipeInfoService.findTotalRecipeCountByQuery(query);
        int totalPages = (int) Math.ceil((double) totalDataCount / pageSize);

        // 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        response.put("recipeInfos", recipeInfos);
        response.put("page", page);
        response.put("pageCnt", totalPages);

        return ResponseEntity.ok(response);
    }
=======
	public String mainForm(Model model, HttpSession session) {
		if (session.getAttribute("memberId") != null) {
	        model.addAttribute("memberId", session.getAttribute("memberId"));
	    }
	    return "recipe/main";
	}
	
	 @GetMapping("/recipe/search")
	    @ResponseBody
	    public ResponseEntity<Map<String, Object>> searchRecipes(
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            @RequestParam(value = "query", required = false) String query,
	            @RequestParam(value = "sort", defaultValue = "latest") String sort) {
		 		final int pageSize = 20; // 페이지당 항목 수
		 		int offset = (page - 1) * pageSize;
		 	// 검색 및 정렬된 데이터를 가져오기
		        List<Recipe_Info> recipeInfos = recipeInfoService.searchRecipes(query, sort, pageSize, offset);
		        int totalDataCount = recipeInfoService.findTotalRecipeCountByQuery(query);
		        int totalPages = (int) Math.ceil((double) totalDataCount / pageSize);
		     // 응답 데이터 구성
		        Map<String, Object> response = new HashMap<>();
		        response.put("recipeInfos", recipeInfos);
		        response.put("page", page);
		        response.put("pageCnt", totalPages);
		        return ResponseEntity.ok(response);
	    }
	 
		@GetMapping("/test")
		public String test() {
			return "test";
		}
		
		
	    @PostMapping("/upload")
	    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile file) {
	        try {
	            // 업로드된 파일 저장 로직 (임시 저장 경로 설정)
	            String uploadDir = "C:/nsh/test";
	            File uploadFile = new File(uploadDir + file.getOriginalFilename());
	            file.transferTo(uploadFile);
>>>>>>> 9820606 (2024-12-13)

	            // 파일 저장 성공 메시지 반환
	            return ResponseEntity.ok("File uploaded successfully: " + uploadFile.getAbsolutePath());
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("File upload failed.");
	        }
	    }
}
