package com.foodRecipe.demo.util;

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

}