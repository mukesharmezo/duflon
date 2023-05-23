$(document).ready(function() {

	getToggle();
	var str = "";
	if (!str) {
		//alert("Empty");
	} else {
		//	alert("Not Empty");
	}

	$('em').click(function() {
		var module = document.getElementById('header').innerHTML;
		var columnName = $(this).html();
		var status = '0';
		if ($(this).parent('a').parent('li').hasClass('active')) {
			status = '1';
		}
		$.ajax({
			url: 'saveToggle',
			type: 'post',
			data: 'module=' + module + '&columnName=' + columnName + '&status=' + status,
			success: function(res) {
				console.log('Success' + res);
			},
			error: function(res) {
			}
		});
	});
});
function getToggle() {
	console.log("Page is called");
	var module = document.getElementById('header').innerHTML;
	$.ajax({
		url: 'getToggle',
		type: 'get',
		data: 'module=' + module,
		success: function(res) {
			console.log("Get Toggle Success : " + res);
			if (!res) {

			} else {
				var resArray = res.split(',');
					var allToggle = document.querySelectorAll("li.active");
				for (var i = 0; i < resArray.length; i++) {
					for (var j = 0; j < allToggle.length; j++) {
						if(resArray[i]===allToggle[j]){
						(allToggle).parent('a').parent('li').addClass("active");	
						}
					}


					//alert(resArray[i]);
				}
			}

		},
		error: function(res) {
			console.log("Error Message : " + res);
		}
	});
}




function saveToggle() {
	var module = document.getElementById('header').innerHTML;
	var allToggle = document.querySelectorAll("li.active");
	var toggleArray = [];
	toggleArray.length = allToggle.length;
	for (var i = 0; i < allToggle.length; i++) {
		toggleArray[i] = allToggle[i].textContent;
	}

	var toggleData = JSON.stringify(toggleArray);
	toggleData = toggleData.replace('[', '');
	toggleData = toggleData.replace(']', '');

	$.ajax({
		url: 'saveToggle',
		type: 'post',
		data: 'toggleData=' + toggleData + '&module=' + module,
		success: function(res) {
			console.log('Success' + res);
		},
		error: function(res) {
			console.log('Error' + res);
		}
	});

}
