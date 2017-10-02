function popUp(url,name,width,height){
	var top = (screen.height - height)/2;
	var left = (screen.width - width)/2;
	var popUpWindow=window.open(url, name,'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left + ',resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no');
	popUpWindow.focus();
	window.popUpWidth = width - 18;
	window.popUpHeight = height - 18;
	return popUpWindow;			
}
