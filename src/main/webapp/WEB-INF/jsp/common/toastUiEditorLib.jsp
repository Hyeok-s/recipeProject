<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.css" />
<script src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	const { Editor } = toastui;
	const { colorSyntax } = Editor.plugin;
	
	let toastEditor = null;
	
	$(document).ready(function() {
		const initialValueEl = $('#toast-ui-editor > script');
		const initialValue = initialValueEl.length == 0 ? '' : initialValueEl.html().trim();
		
		const editor = new Editor({
			el: document.querySelector('#toast-ui-editor'),
			height: '600px',
			initialEditType: 'markdown',
			initialValue: initialValue,
			previewStyle: 'tab',
			plugins: [colorSyntax],
			placeholder: '내용을 입력해 주세요.',
	        hooks: {
	            async addImageBlobHook(blob, callback) {
	                try {
	                    const formData = new FormData();
	                    formData.append('image', blob);

	                    // 2. FileApiController - uploadEditorImage 메서드 호출
	                    const response = await fetch('/community/imageUpload', {
	                        method : 'POST',
	                        body : formData,
	                    });

	                    // 3. 컨트롤러에서 전달받은 디스크에 저장된 파일명
	                    const filename = await response.text();

	                    // 4. addImageBlobHook의 callback 함수를 통해, 디스크에 저장된 이미지를 에디터에 렌더링
	                    const imageUrl = `/community/imagePrint?filename=\${filename}`;
	                    callback(imageUrl, 'image alt attribute');

	                } catch (error) {
	                    console.error('업로드 실패 : ', error);
	                }
	            }
	        }
		});
		toastEditor = editor;
	})
	
	const submitForm = function(form) {
		const markdown = toastEditor.getMarkdown().trim();
		
		form.title.value = form.title.value.trim();
	  
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요');
			form.title.focus();
			return;
		}
	  
		if(markdown.length == 0){
		    alert('내용을 입력해주세요');
		    toastEditor.focus();
	    	return;
	  	}
		
		form.body.value = markdown;
	  
		form.submit();
	}
</script>