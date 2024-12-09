package com.foodRecipe.demo.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodRecipe.demo.dto.Category;
import com.foodRecipe.demo.dto.Comment;
import com.foodRecipe.demo.dto.Community;
import com.foodRecipe.demo.service.CommunityService;
import com.foodRecipe.demo.util.Util;

import jakarta.servlet.http.HttpSession;

@Controller
public class CommunityController {
	private CommunityService communityService;
	
	@Value("${custom.file.dir}")
    private String uploadDir;
	
	public CommunityController(CommunityService communityService) {
		this.communityService = communityService;
	}
	
	
	@GetMapping("/community/communityForm")
	public String coummunityForm(@RequestParam(value = "categoryId", defaultValue = "0") int categoryId,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		Map<String, List<Category>> categories = communityService.findAllCategory();
		model.addAttribute("categories", categories);
		
		List<Community> cmuLists = new ArrayList<>();
		
		if(categoryId == 0) {
			cmuLists = communityService.findAllCommunity();
		}
		else {
			cmuLists = communityService.findCommunityByCategoryId(categoryId);
		}
		
		if (cmuLists != null || !cmuLists.isEmpty()) {
			int pageSize = 18;
			int start = (page - 1) * pageSize;
			int end = Math.min(start + pageSize, cmuLists.size());

			List<Community> pagedCommunity = cmuLists.subList(start, end);
			model.addAttribute("cmuLists", pagedCommunity);
			
			int pageCnt = (int) Math.ceil((double) cmuLists.size() / pageSize);
			model.addAttribute("page", page);
		    model.addAttribute("pageCnt", pageCnt);
		}
		return "community/community";
	}
	
	@GetMapping("/community/detail")
	public String detailForm(@RequestParam("id") int communityId, Model model, HttpSession session) {
		Map<String, List<Category>> categories = communityService.findAllCategory();
		Community cmu = communityService.findCommunityById(communityId);
		List<Map<String, String>> contentList = Util.parseContent(cmu.getBody());
		
		List<Comment> comments = communityService.findCommentByCommunityId(communityId);
		model.addAttribute("categories", categories);
		model.addAttribute("cmu", cmu);
		model.addAttribute("contentList", contentList);
		model.addAttribute("comments", comments);
		int memberId = -1;
		if(session.getAttribute("memberId") != null) {
			memberId = (int) session.getAttribute("memberId");
		}
		model.addAttribute("memberId" , memberId);
		return "community/detail";
	}
	
	@GetMapping("/community/checkLogin")
	@ResponseBody
	public ResponseEntity<Map<String, Boolean>> checkLogin(HttpSession session) {
	    boolean isLoggedIn = session.getAttribute("memberId") != null;
	    Map<String, Boolean> response = new HashMap<>();
	    response.put("loggedIn", isLoggedIn);
	    return ResponseEntity.ok(response);
	}
	
	 // 댓글 추가
	@PostMapping("/community/addComment")
	@ResponseBody
	public ResponseEntity<Comment> addComment(@RequestBody Comment request, HttpSession session) {
	    try {
			int loginId = (int) session.getAttribute("memberId");
			request.setMemberId(loginId);
	    	communityService.insertComment(request);
	    	Comment insertedComment = communityService.findCommentById(request.getId());
	        return ResponseEntity.ok(insertedComment);
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
	@PostMapping("/community/editComment")
	@ResponseBody
	public ResponseEntity<Comment> editComment(@RequestBody Comment request) {
	    try {
	    	communityService.updateComment(request);
	    	Comment updateComment = communityService.findCommentById(request.getId());
	        return ResponseEntity.ok(updateComment);
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
	 @PostMapping("/community/deleteComment")
	 @ResponseBody
	    public ResponseEntity<Map<String, Object>> deleteComment(@RequestBody Comment request) {
		 	Map<String, Object> response = new HashMap<>();
	        try {
	            boolean deleted = communityService.deleteCommentById(request.getId());
	            if (deleted) {
		            response.put("success", true);
		            response.put("message", "댓글이 삭제되었습니다.");
		            return ResponseEntity.ok(response);
	            } else {
		            response.put("success", false);
		            response.put("message", "댓글을 찾을 수 없습니다.");
		            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
	            }
	        } catch (Exception e) {
		        response.put("success", false);
		        response.put("message", "댓글 삭제 실패");
		        System.err.println("댓글 삭제 오류: " + e.getMessage());
		        e.printStackTrace();
		        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
	    }
	 
	 @GetMapping("/community/writeForm")
	 public String writeForm(Model model) throws JsonProcessingException {
		 Map<String, List<Category>> categories = communityService.findAllCategory();
		 model.addAttribute("categories", categories);
		 ObjectMapper objectMapper = new ObjectMapper();
		 String categoriesJson = objectMapper.writeValueAsString(categories);
		 model.addAttribute("categoriesJson", categoriesJson);
	 	return "community/write";
	 }
	 
	 @PostMapping("/community/write")
	 public String postMethodName(@RequestParam("title") String title,
             @RequestParam("mainCategory") String mainCategory,
             @RequestParam(value = "subCategory", required = false) String subCategory,
             @RequestParam("body") String body, HttpSession session) {
	 	
		 int categoryId = Integer.parseInt(subCategory);
		 
		 int memberId = (int) session.getAttribute("memberId");
		 if(subCategory == null || subCategory.equals("")) {
			 categoryId = communityService.findCategoryIdByMainCategory(mainCategory);
	 	}
		Community newCommunity = new Community();
		newCommunity.setTitle(title);
		newCommunity.setBody(body);
		newCommunity.setMemberId(memberId);
		newCommunity.setCategoryId(categoryId);
		communityService.insertCommunity(newCommunity);
	 	return "redirect:/community/detail?id=" + newCommunity.getId();
	 	
	 }
	 
	 
	 @PostMapping("/community/imageUpload")
	 @ResponseBody
    public String uploadEditorImage(@RequestParam final MultipartFile image) {
        if (image.isEmpty()) {
            return "";
        }

        String orgFilename = image.getOriginalFilename();
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        String extension = orgFilename.substring(orgFilename.lastIndexOf(".") + 1);
        String saveFilename = uuid + "." + extension;
        String fileFullPath = Paths.get(uploadDir, saveFilename).toString();
        File dir = new File(uploadDir);
        if (dir.exists() == false) {
            dir.mkdirs();
        }

        try {
            File uploadFile = new File(fileFullPath);
            image.transferTo(uploadFile);
            return saveFilename;

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

	 @GetMapping(value = "/community/imagePrint", produces = { MediaType.IMAGE_GIF_VALUE, MediaType.IMAGE_JPEG_VALUE, MediaType.IMAGE_PNG_VALUE })
	 @ResponseBody
	 public byte[] printEditorImage(@RequestParam final String filename) {
	     String fileFullPath = Paths.get(uploadDir, filename).toString();
	     
	     File uploadedFile = new File(fileFullPath);
	     if (!uploadedFile.exists()) {
	         throw new RuntimeException("File not found");
	     }

	     try {
	         byte[] imageBytes = Files.readAllBytes(uploadedFile.toPath());
	         return imageBytes;

	     } catch (IOException e) {
	         throw new RuntimeException("Error reading file", e);
	     }
	 }
	 
	 @GetMapping("/community/editCommunity")
	 public String getMethodName(@RequestParam("id") int communityId) {
		 
	 	return new String();
	 }
	 
	
}
