<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<title>IO News</title>
<!--첨부파일 스타일  -->
<script>	
	function validateForm(form) {
		if (form.tmptitle.value == "") {
			alert("제목을 입력하세요");
			form.tmptitle.focus();
			return false;
		}
		if (form.caid.value == "null") {
			alert("카테고리를 선택하세요");
			form.caid.focus();
			return false;
		}
		if (form.tmpcontent.value == "") {
			alert("내용을 입력하세요");
			form.tmpcontent.focus();
			return false;
		}
	}
</script>
<style>
			.uploadResult {
				width: 100%;
				height:150px;
				background-color: #4A90E2;
			}
			
			.uploadResult ul {
				display: flex;
				flex-flow: row;
				justify-content: center;
				align-items: center;
			}
			
			.uploadResult ul li {
				list-style: none;
				padding: 10px;
			}
			
			.uploadResult ul li img {
				width: 100px;
			}

			.bigPictureWrapper {
			  position: absolute;
			  display: none;
			  justify-content: center;
			  align-items: center;
			  top:0%;
			  width:100%;
			  height:100%;
			  background-color: gray; 
			  z-index: 100;
			}
			
			.bigPicture {
			  position: relative;
			  display:flex;
			  justify-content: center;
			  align-items: center;
			}
			</style>


<!--첨부파일 스타일  -->
</head>
<body>
		<%@ include file="/resources/heater/header.jsp" %>
	<div class="container mt-3" style="text-align: center;">
		<div class="row">
			<div class="container-fluid">
				<form role="form" action="/board/post" method="post" id="postForm" enctype="multipart/form-data"onsubmit="return validateForm(this);">
					
					<h3   style="text-align: center;">기사작성</h3>
					
					
					
					<div>제목</div>
					<input type="text" name="tmptitle" placeholder="제목" style="width: 100%; height: 40px;">
					
					<div class="form-floating mb-3 mt-3">
						<select class="form-select" name="caid" style="width: auto; height: 50px;">
							<option value="null">카테고리를 입력하시오</option>
							<c:forEach var="cate" items="${cateList}">
								<option value="${cate.caid}">${cate.category}</option>
							</c:forEach>
						</select>
					</div>
					<input type="text" name="uemail" value="${username}" style="width: 100%; height: 40px;">
					<div>
								<label for="content" class="form-label">내용</label>
							</div>
					<div class="list-group-item">
						<textarea cols="100" wrap="hard" name="tmpcontent" style="width: 100%;" rows="20" placeholder="내용" id="content"></textarea>
						
					</div>
					<div style="text-align:left;">
							<span>글자 수: <span
							id="charCount">0 </span>
							<span>/1500</span>
							</div>
			<!-- 첨부파일 ------------------------------------------------------------------------->
            <div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            			<div class="panel-heading">
            				File Attach
            			</div>
            			<div class="panel-body">
            				<div class="form-group uploadDiv">
            					<input type="file" name="uploadFile" multiple>
            				</div>
            				<div class="uploadResult">
            					파일을 여기에 끌어다 놓으세요.
            					<ul>
            					
            					</ul>
            				</div>
            			</div>            			
            		</div>
            	</div>
            </div>            
            <!-- 첨부파일.end --> 
					<button type="submit" value="Submit">작성</button>
					<button type="button" onclick="location.href='/board/list'">목록</button>
				</form>
			</div>
		</div>
	</div>
	<!--script-------------------------------------------------  -->
	<script>
	 $(document).ready(function() {
         updateCharCount();
         

         $('#content').on('input', function() {
             updateCharCount();
             checkCharLimit()
         });

         function updateCharCount() {
             var content = $('#content').val(); 
             var charCount = content.length; 
             $('#charCount').text(charCount); 
         }
         function checkCharLimit() {
             var content = $('#content').val(); 
             var charCount = content.length; 
             if (charCount > 1500) {
                 alert("내용이 1,500자를 초과하였습니다.");
                 $('#content').val(content.substring(0, 1300)); // 내용 잘라내기
                 updateCharCount();
             }
         }
     })
	
	
		/* 파일크기.파일확장자 체크 ****************************************************************************/
		 function checkExtension(fileName, fileSize){	
			 var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			 var maxSize = 5242880; //5MB
			 
		    if(fileSize >= maxSize){
		      alert("파일 사이즈 초과");
		      return false;
		    }
		    
		    if(regex.test(fileName)){
		      alert("해당 종류의 파일은 업로드할 수 없습니다.");
		      return false;
		    }
		    return true;
		  }
		
		/* 첨부파일목록 미리보기  ******************************************************************************/
		function showUploadResult(uploadResultArr){
			//첨부파일목록이 없으면 중지
			if(!uploadResultArr || uploadResultArr.length==0){
				return;
			}
			
			//출력할 ul태그 미리 찾아놓기
			var uploadUL=$(".uploadResult ul");
			
			var str="";
			//첨부파일목록에서 하나씩 처리 
			$(uploadResultArr).each(function(i,obj){
				//이미지인경우
				if(obj.image){
					//썸네일경로
					var fileCallPath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					str+="<li data-path='"+obj.uploadPath+"'";
					str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
					str+="	<div>";
					str+="		<span>"+obj.fileName+"</span>";
					str+="		<button type='button' data-file='"+fileCallPath+"' ";
					str+=" 			data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="		<image src='/display?fileName="+fileCallPath+"'>";
					str+="	</div>";
					str+="</li>";					
				}
			});
			//ul태그에 출력
			uploadUL.append(str);
		}
			    
	
		$(document).ready(function(e){
			/* csrf토큰 처리 *****************************************************************/
//			var csrfHeaderName ="${_csrf.headerName}"; 
//		    var csrfTokenValue="${_csrf.token}";
			
			/* 첨부파일을 선택했을 때 이벤트 처리 ******************************************************************/
			$("input[type='file']").change(function(e){
				//form태그 역할하는 객체
				var formData=new FormData();
				var inputFile=$("input[name='uploadFile']"); // input type='file' 미리 찾아놓기.
				var files=inputFile[0].files; // 첨부파일목록
				for(var i=0;i<files.length;i++){
					//파일확장자,파일사이즈가 안맞으면 중지
					if(!checkExtension(files[i].name,files[i].size)){
						return false;
					}
					//formData에 파일추가
					formData.append("uploadFile",files[i]);
				}
				$.ajax({
					url:'/uploadAjaxAction', //서버주소
					processData: false, // 파일업로드시 설정필요
					contentType: false, // 파일업로드시 설정필요
					//					beforeSend: function(xhr) { // csrf적용
//				          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
//				      },
					data:formData, // 서버로 전송되는 데이터
					type: "post",  //전송방식
					dataType: 'json', //서버에서 넘어오는 데이터의 형식
					success:function(result){ //성공하면 호출되는 함수. result에 서버에서 넘어온 데이터가 저장됨.
						showUploadResult(result); //첨부파일목록 미리보기 출력
					}
				});
			});
			
			/* x버튼 클릭 이벤트처리. 파일삭제 **************************************************************************/
			//부모인 .uploadResult 에 click이벤트를 위임
			$(".uploadResult").on("click","button",function(e){
				var targetFile=$(this).data("file"); //data-file속성값 읽어오기
				var type=$(this).data("type");//data-type속성값 읽어오기
				var targetLi=$(this).closest("li"); //가장가까운 부모태그 li 찾아오기
				$.ajax({
					url:'/deleteFile', //서버주소
					data:{fileName:targetFile,type:type}, //서버로 전송되는 데이터
//				    beforeSend: function(xhr) {
//				        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
//				    },
					dataType:'text', //서버에서 넘어오는 데이터 형식
					type: 'post',//전송방식
					success: function(result){//성공했을 때 호출되는 함수. 서버에서 넘어온 데이터는 result에 저장됨
						alert(result);
						targetLi.remove(); // li태그 삭제.첨부파일목록에서 삭제						
					}
				});
			});
			
			/* 등록버튼 이벤트처리 ***********************************************************************/
			var formObj=$("form[role='form']");// form태그 찾아놓기
			$("button[type='submit']").on("click",function(e){
				
				console.log("form이벤트")
				//전송방지
				e.preventDefault();
				var str="";
				//첨부파일목록에서 하나씩 처리
				$(".uploadResult ul li").each(function(i,obj){
					var jobj=$(obj);// li태그
					//hidden태그 생성
					str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				});
				// formObj(form태그)에 hidden태그 추가. 전송
//				formObj.append(str);
				formObj.append(str).submit();
			});
			
			/* 파일드래그시 새탭으로 열리는 것 방지 *********************************************/
			$(".uploadResult").on("dragenter dragover",function(e){
				e.preventDefault();
			});
			/* 파일을 드롭시 새탭으로 열리는 것 방지. 파일업로드 **********************************/
			$(".uploadResult").on("drop",function(e){
				e.preventDefault();
				
				//form태그 역할하는 객체
				var formData=new FormData();
				//drop했을 때 파일목록 구하기
				var files=e.originalEvent.dataTransfer.files;
				 
				for(var i=0;i<files.length;i++){
					//파일확장자,파일사이즈가 안맞으면 중지
					if(!checkExtension(files[i].name,files[i].size)){
						return false;
					}
					//formData에 파일추가
					formData.append("uploadFile",files[i]);
				}
				$.ajax({
					url:'/uploadAjaxAction', //서버주소
					processData: false, // 파일업로드시 설정필요
					contentType: false, // 파일업로드시 설정필요
//					beforeSend: function(xhr) { //csrf토큰적용
//				        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
//				    },
					data:formData, // 서버로 전송되는 데이터
					type: "post",  //전송방식
					dataType: 'json', //서버에서 넘어오는 데이터의 형식
					success:function(result){ //성공하면 호출되는 함수. result에 서버에서 넘어온 데이터가 저장됨.
						showUploadResult(result); //첨부파일목록 미리보기 출력
					}
				});
			});
			
		});
	</script>
            
	<!--script-------------------------------------------------  -->
	
	
	
	
	<%@ include file="/resources/heater/footer.jsp" %>
</body>
</html>
