
;(function( $ ){

	$.fn.doT = function(it, c, def) {
//		var res = "";
//		$(this).each(function() {
			var tempFn = $(this).data("doT") || $(this).ddoT(c, def).data("doT");
			return tempFn(it);
//			res += tempFn(it);
//		});
//		return res;
	};

	$.fn.ddoT = function(c, def) {
		return $(this).each(function() {
			var tempFn = doT.template($(this).html().replace(/\t+/g, " ").trim(), c, def);
			$(this).data("doT", tempFn);
		});
	};

})( jQuery );
