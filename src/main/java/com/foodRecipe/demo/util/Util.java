package com.foodRecipe.demo.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
	            // 이미지 URL 추가
	            contentList.add(Map.of("type", "image", "value", matcher.group(1)));

	            // 다음 탐색 시작 위치 업데이트
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

}