package com.foodRecipe.demo.util;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Value;

public class Util {
	
	public static String jsReturn(String msg, String uri) {
		if (msg == null) {
			msg = "";
		}
		if (uri == null) {
			uri = "";
		}
		return String.format("""
				<script>
					const msg = '%s'.trim();
					if (msg) {
						alert(msg);
					}
					const uri = '%s'.trim();
					if (uri.length > 0) {
						location.replace(uri);
					} else {
						history.back();
					}
				</script>
				""", msg, uri);
	}
	 public static List<Map<String, String>> parseContent(String markdown) {
	        List<Map<String, String>> contentList = new ArrayList<>();
	        // 이미지 태그와 텍스트 구분 정규식
	        String regex = "!\\[.*?\\]\\((.*?)\\)";
	        Pattern pattern = Pattern.compile(regex);
	        Matcher matcher = pattern.matcher(markdown);

	        int lastIndex = 0;

	        while (matcher.find()) {
	            // 이미지 태그 이전의 텍스트 추출
	            if (lastIndex < matcher.start()) {
	                String text = markdown.substring(lastIndex, matcher.start()).trim();
	                if (!text.isEmpty()) {
	                	text = text.replaceAll("\n", "<br />");
	                    contentList.add(Map.of("type", "text", "value", text));
	                }
	            }
	            contentList.add(Map.of("type", "image", "value", matcher.group(1)));

	            lastIndex = matcher.end();
	        }
	        // 마지막 남은 텍스트 처리
	        if (lastIndex < markdown.length()) {
	            String text = markdown.substring(lastIndex).trim();
	            if (!text.isEmpty()) {
	            	text = text.replaceAll("\n", "<br />");
	                contentList.add(Map.of("type", "text", "value", text));
	            }
	        }
	        return contentList;
	  }
	 
	 public static void deleteImageFile(String imageUrl, String uploadDir) {
		    String filename = extractFilenameFromUrl(imageUrl);
		    String filePath = uploadDir + "/" + filename;
		    File file = new File(filePath);
		    
		    if (file.exists() && file.isFile()) {
		        file.delete();
		    }
		}
	 
	 private static String extractFilenameFromUrl(String imageUrl) {
		    try {
		        // URL에서 Query 파라미터 분석
		        String query = new URL("http://localhost" + imageUrl).getQuery(); // Base URL 필요 없음
		        if (query != null) {
		            for (String param : query.split("&")) {
		                String[] keyValue = param.split("=");
		                if (keyValue.length == 2 && "filename".equals(keyValue[0])) {
		                    return keyValue[1];
		                }
		            }
		        }
		    } catch (MalformedURLException e) {
		        System.err.println("URL 형식 오류: " + e.getMessage());
		    }
		    return null;
		}

}