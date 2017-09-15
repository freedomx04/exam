<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<head>

	<style type="text/css">
	.pw-strength {
		clear: both;
		position: relative;
		top: 8px;
		/* width: 180px; */
	}
	.pw-bar {
		background: url(img/pwd-1.png) no-repeat;
		height: 14px;
		overflow: hidden;
		width: 179px;
	}
	.pw-bar-on {
		background: url(img/pwd-2.png) no-repeat;
		width: 0px;
		height: 14px;
		position: absolute;
		top: 1px;
		left: 2px;
		transition: width .5s ease-in;
		-moz-transition: width .5s ease-in;
		-webkit-transition: width .5s ease-in;
		-o-transition: width .5s ease-in;
	}
	.pw-weak .pw-defule {
		width: 0px;
	}
	.pw-weak .pw-bar-on {
		width: 60px;
	}
	.pw-medium .pw-bar-on {
		width: 120px;
	}
	.pw-strong .pw-bar-on {
		width: 179px;
	}
	.pw-txt {
		padding-top: 2px;
		width: 180px;
		overflow: hidden;
	}
	.pw-txt span {
		color: #999;
		float: left;
		font-size: 12px;
		text-align: center;
		width: 58px;
	}
	</style>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>

	<script type="text/javascript">
		
	function strength($input, $level) {
		$input.keyup(function () { 
			var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
			var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
			var enoughRegex = new RegExp("(?=.{6,}).*", "g"); 
		
			if (false == enoughRegex.test($(this).val())) { 
				$level.removeClass('pw-weak'); 
				$level.removeClass('pw-medium'); 
				$level.removeClass('pw-strong'); 
				$level.addClass(' pw-defule'); 
				//密码小于六位的时候，密码强度图片都为灰色 
			} 
			else if (strongRegex.test($(this).val())) { 
				$level.removeClass('pw-weak'); 
				$level.removeClass('pw-medium'); 
				$level.removeClass('pw-strong'); 
				$level.addClass(' pw-strong'); 
				//密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
			} 
			else if (mediumRegex.test($(this).val())) { 
				$level.removeClass('pw-weak'); 
				$level.removeClass('pw-medium'); 
				$level.removeClass('pw-strong'); 
				$level.addClass(' pw-medium'); 
				//密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
			} 
			else { 
				$level.removeClass('pw-weak'); 
				$level.removeClass('pw-medium'); 
				$level.removeClass('pw-strong'); 
				$level.addClass('pw-weak'); 
				//如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
			} 
			return true; 
		}); 
	}
	
	</script>

</head>
