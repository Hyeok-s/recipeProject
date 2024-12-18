package com.foodRecipe.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodRecipe.demo.dto.Memo;
import com.foodRecipe.demo.dto.Recipe_Detail;
import com.foodRecipe.demo.dto.Recipe_Ingredient;
import com.foodRecipe.demo.dto.Recipe_Manual;
import com.foodRecipe.demo.service.MemoService;
import com.foodRecipe.demo.service.RecipeInfoService;
import com.foodRecipe.demo.service.RecipeIngredientService;
import com.foodRecipe.demo.service.RecipeManualService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class RecipeViewController {
	private RecipeInfoService recipeInforService;
	private RecipeIngredientService recipeIngredient;
	private RecipeManualService recipeManualService;
	private MemoService memoService;
	
	public RecipeViewController(RecipeInfoService recipeInforService, RecipeIngredientService recipeIngredient, RecipeManualService recipeManualService, MemoService memoService) {
		this.recipeInforService = recipeInforService;
		this.recipeIngredient = recipeIngredient;
		this.recipeManualService = recipeManualService;
		this.memoService = memoService;
	}
    
    @GetMapping("/recipe/detail")
    public String recipeDetailForm(@RequestParam("RCP_SEQ") Integer RCP_SEQ, @RequestParam(value = "isRecognitionActive", defaultValue = "false") boolean isRecognitionActive, 
    		@RequestParam(value = "isVolumeOn", defaultValue = "true") boolean isVolumeOn, 
    		Model model, HttpServletRequest request, HttpServletResponse response) {
    	Recipe_Detail details = recipeInforService.findRecipeDetailByRCP_SEQ(RCP_SEQ);
    	List<Recipe_Ingredient> ingredients = recipeIngredient.findIngredientsByRCP_SEQ(RCP_SEQ);
    	model.addAttribute("details", details);
    	model.addAttribute("ingredients", ingredients);
    	model.addAttribute("isRecognitionActive", isRecognitionActive);
    	model.addAttribute("isVolumeOn", isVolumeOn);
    	Cookie[] cookies = request.getCookies();
	    Cookie lastMainVisitCookie = null;
	    for (Cookie cookie : cookies) {
	    	if (cookie.getName().equals("lastMainVisitTime_" + RCP_SEQ)) {
	    		lastMainVisitCookie = cookie;
	            break;
	        }
	    }
	    
	    long currentTime = System.currentTimeMillis();
	    if (lastMainVisitCookie != null) {
	        long lastVisitTime = Long.parseLong(lastMainVisitCookie.getValue());
	        if (currentTime - lastVisitTime >= 7200000) {
	        	recipeInforService.incrementInfoCount(RCP_SEQ);
	            lastMainVisitCookie.setValue(String.valueOf(currentTime));
	            lastMainVisitCookie.setMaxAge(60 * 60 * 24); // 24시간 동안 유효
	            response.addCookie(lastMainVisitCookie);
	        }
	    } else {
	        // 처음 방문하는 경우
	    	recipeInforService.incrementInfoCount(RCP_SEQ);
	        Cookie newVisitCookie = new Cookie("lastMainVisitTime_" + RCP_SEQ, String.valueOf(currentTime)); // 고유한 쿠키 이름 사용
	        newVisitCookie.setMaxAge(60 * 60 * 24); // 24시간 동안 유효
	        response.addCookie(newVisitCookie);
	    }
    	return "recipe/detail";
    }
    
    @GetMapping("/recipe/manual")
    public String recipeManualForm(@RequestParam("RCP_SEQ") Integer RCP_SEQ, @RequestParam("isRecognitionActive") boolean isRecognitionActive, 
    		@RequestParam("isVolumeOn") boolean isVolumeOn, Model model, @RequestParam(value = "step", defaultValue = "1") int step, HttpSession session) {
    	List<Recipe_Manual> manuals = recipeManualService.findAllRecipeManualByRCP_SEQOrderSTEP_NO(RCP_SEQ);
    	String RCP_NM = recipeInforService.findRCP_NMByRCP_SEQ(RCP_SEQ);
    	int index = step-1;
    	if (manuals != null || !manuals.isEmpty()) {
        	int maxStep = manuals.size();
        	Recipe_Manual manual = manuals.get(index);
        	String manual_text = manual.getMANUAL_TEXT();
        	
        	 if (manual_text.matches("^\\d+\\.\\s.*")) {
                 manual_text = manual_text.substring(manual_text.indexOf(' ') + 1);
             }
        	manual_text = manual_text.replaceAll("[a-zA-Z]", "");
        	manual.setMANUAL_TEXT(manual_text);
        	model.addAttribute("maxStep", maxStep);
        	model.addAttribute("manual", manual);
        	model.addAttribute("RCP_NM", RCP_NM);
        	model.addAttribute("isRecognitionActive", isRecognitionActive);
        	model.addAttribute("isVolumeOn", isVolumeOn);
        	model.addAttribute("step", step);
        	
        	if(session.getAttribute("memberId") != null) {
        		Memo memo = memoService.findMemoBySTEP_NOAndRCP_SEQAndMemberId(step, (int) RCP_SEQ, (int) session.getAttribute("memberId"));
        		if(memo != null) {
        			model.addAttribute("memo", memo);
        		}
        	}
    	}
    	return "recipe/manual";
    }
    
    @PostMapping("/recipe/saveMemo")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> saveMemo(@RequestBody Map<String, String> memoData, HttpSession session) {
    	int memberId = (int) session.getAttribute("memberId");

        // 파라미터 추출
        String text = memoData.get("memo");
        int STEP_NO = Integer.parseInt(memoData.get("step"));
        int RCP_SEQ = Integer.parseInt(memoData.get("RCP_SEQ"));
        
        Memo memo = memoService.findMemoBySTEP_NOAndRCP_SEQAndMemberId(STEP_NO, RCP_SEQ, memberId);
        
        int result = 0;
        if(memo != null) {
        	result = memoService.updateMemo(text, RCP_SEQ, STEP_NO, memberId);
        }
        else {
            result = memoService.insertMemo(text, RCP_SEQ, STEP_NO, memberId);
        }

        boolean isSaved = result > 0;

        // 결과 반환
        Map<String, Object> response = new HashMap<>();
        response.put("success", isSaved);
        return ResponseEntity.ok(response);
    }
    
    @PostMapping("/recipe/deleteMemo")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteMemo(@RequestBody Map<String, String> memoData, HttpSession session) {
    	int memberId = (int) session.getAttribute("memberId");
    	int STEP_NO = Integer.parseInt(memoData.get("step"));
        int RCP_SEQ = Integer.parseInt(memoData.get("RCP_SEQ"));

        Memo memo = memoService.findMemoBySTEP_NOAndRCP_SEQAndMemberId(STEP_NO, RCP_SEQ, memberId);
        boolean isDeleted = false;
        if(memo != null) {
        	memoService.deleteMemo(memo);
        	isDeleted = true;
        }

        // 결과 반환
        Map<String, Object> response = new HashMap<>();
        response.put("success", isDeleted);
        return ResponseEntity.ok(response);
    }

}