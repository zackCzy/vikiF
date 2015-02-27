<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String basePath = request.getContextPath();
	String path=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+basePath; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../meta/indexMeta.jsp"%>
		<title>Viki_头像上传</title>
		<link rel="stylesheet" type="text/css"
			href="csss/imgareaselect-default.css" />
		<script type="text/javascript" src="scripts/jquery-1.10.1.js"></script>
		<script type="text/javascript"
			src="scripts/jquery.imgareaselect.pack.js"></script>
		<script type="text/javascript" src="scripts/jQueryRotate.js"></script>
		<script type="text/javascript" src="<%=path%>/JS/tool/span.js"></script>
		<script type="text/javascript" src="<%=path%>/JS/tool/ajaxfileupload.js"></script>
	</head>
	<body>

		<div class="portrait_left">
			<div id="picture"
				style="border: 1px solid #000000; overflow: hidden; position: relative; height: auto; width: 280px; margin: 0 auto;">
				<img id="avatar" width="280" alt="请上传头像" src="<%=path%>/load/download_downloadPhoto?id=${id}" />
			</div>
			<form name="photoSize" method="post" action="<%=path%>/load/download_uploadUserPhoto" enctype="multipart/form-data"  target="hidden_frame">
				<!--通过生成尺寸和旋转角度 后台获取尺寸和旋转角度再进行裁剪-->
				<input id="id_top" type="hidden" name="top" value="90" />
				<input id="id_left" type="hidden" name="left" value="61" />
				<input id="id_right" type="hidden" name="right" value="201" />
				<input id="id_bottom" type="hidden" name="bottom" value="200" />
				<input id="rotation" type="hidden" value="0" name="rotation" />
			</form>
			<div class="portrait_revolve">
				<div class="revolve_left"></div>
				<a href="javascript:;" class="revol_left_txt"
					onClick="avatarrotateleft();">向左旋转</a>
				<a href="javascript:;" class="revol_right_txt"
					onClick="avatarrotateright();">向右旋转</a>
				<div class="revolve_right"></div>
			</div>
				<label class="btn-choose-file" style="margin:20px 50px 0 0px;">
					选择照片
					<input id="myFile" type="file"  name="myFile" style="width:0px;height:0px;" onchange="box(this);"/>
				</label>
				<input type="button" class="btn-choose-file" onclick="submit_avatar();" value="确定" style="float: left;margin:20px 0 0 50px;"/>
		</div>

		<div class="portrait_right">
			<p class="portrait_right_txt">
				您上传的头像会自动生成小尺寸头像，请注意小尺寸的头像是否清晰
			</p>
			<div class="portrait_right_bottom">
				<div class="portrait1">
					<div id="img_big_preview" class="img_preview">
						<img id="avatar1" alt="头像预览" src="<%=path%>/load/download_downloadPhoto?id=${id}"
							style="width: 360px; height: 360px; margin-left: -117px; margin-top: -44px;"/>
					</div>
					<p>
						大尺寸头像，180×180
					</p>
				</div>
			</div>
			<div class="portrait2">
				<div id="img_small_preview" class="img_preview">
					<img id="avatar2" alt="预览" src="<%=path%>/load/download_downloadPhoto?id=${id}"
						style="width: 98px; height: 98px; margin-left: -32px; margin-top: -12px;"/>
				</div>
				<p>
					中尺寸头像
				</p>
				<p>
					50×50
				</p>
			</div>
		</div>
		<script type="text/javascript">
	function box(node){
		var fileSize=getFileSize(node);
		var fileName=node.value.toUpperCase()
		var isUpload=fileName.endsWith('.JPG')? true:fileName.endsWith('.PNG') ? true :fileName.endsWith('.GIF') ? true:false;	
		if(isUpload){
			if(fileSize>100000){
				alert("不支持");
			}else{
				ajaxFileUpload();
			}
		}else {
			alert("不支持该文件类型");
		}
	}
	 function ajaxFileUpload(){
         $.ajaxFileUpload( {
          url:'<%=path%>/load/download_uploadUserPhoto',            //需要链接到服务器地址
          secureuri:false,
          fileElementId:'myFile',                        //文件选择框的id属性       
          dataType: 'json',
          success: function (data, status)            //相当于java中try语句块的用法
          {
        	var src="<%=path%>/load/download_downloadPhoto?id="+data.id+"&ran?"+Math.random();
        	document.getElementById("avatar").src=src;
      		document.getElementById("avatar1").src=src;
      		document.getElementById("avatar2").src=src;
          },
          error: function (data, status, e)            //相当于java中catch语句块的用法
          	{alert('添加失败');}
      });    
    }	
	$(document).ready(function() {
		function adjust(el, selection) {
			var scaleX = $(el).width() / (selection.width || 1);
			var scaleY = $(el).height() / (selection.width || 1);
			$(el + ' img').css({
				width : Math.round(scaleX * $('#avatar').width()) + 'px',
				height : Math.round(scaleY * $('#avatar').height()) + 'px',
				marginLeft : '-' + Math.round(scaleX * selection.x1) + 'px',
				marginTop : '-' + Math.round(scaleY * selection.y1) + 'px'
			});
		}
		function preview(img, selection) {
			adjust('#img_small_preview', selection);
			adjust('#img_big_preview', selection);
		}
		$('img#avatar').imgAreaSelect({
			aspectRatio : "4:4",
			x1 : 60,
			y1 : 60,
			x2 : 200,
			y2 : 200,
			onSelectEnd : function(img, selection) {
				$('#id_top').val(selection.y1);
				$('#id_left').val(selection.x1);
				$('#id_right').val(selection.x2);
				$('#id_bottom').val(selection.y2);
			},
			onSelectChange : preview
		});
	});

	var value = 0;
	function avatarrotateleft() {
		value -= 90;
		$('#avatar').rotate({
			animateTo : value
		});
		$('#avatar1').rotate({
			animateTo : value
		});
		$('#avatar2').rotate({
			animateTo : value
		});
	}
	function avatarrotateright() {
		value += 90;
		$('#avatar').rotate({
			animateTo : value
		});
		$('#avatar1').rotate({
			animateTo : value
		});
		$('#avatar2').rotate({
			animateTo : value
		});
	}
	function select_avatar() {
		$('#avatar_id').click();
	}
	function uploadavatar() {
		$('#avatar_form').submit();
	}
	function submit_avatar() {
		$('#rotation').val(value);
		$.ajax({
			url:'<%=path%>/load/download_saveUserPhoto',
			type : 'get',
			data : {
				top:document.forms['photoSize']['top'].value,
				left:document.forms['photoSize'].left.value,
				bottom:document.forms['photoSize'].bottom.value,
				right:document.forms['photoSize'].right.value,
				rotation:document.forms['photoSize'].rotation.value
			},
			success:function(text){
			
			}
		});
	}
</script>
	</body>

	
</html>