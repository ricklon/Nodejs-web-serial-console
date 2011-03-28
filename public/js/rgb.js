	function refreshSwatch() {
		var red = $("#red").slider("value")
			,green = $("#green").slider("value")
			,blue = $("#blue").slider("value");
		$("#swatch").css("background-color", "rgb(" + red + "," +  green + "," + blue + ")";
	}
	$(function() {
		$("#red, #green, #blue").slider({
			orientation: 'horizontal',
			range: "min",
			max: 255,
			value: 127,
			slide: refreshSwatch,
			change: refreshSwatch
		});
		$("#red").slider("value", 255);
		$("#green").slider("value", 140);
		$("#blue").slider("value", 60);
	});

