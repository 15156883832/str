function isBlank(number){
	if($.trim(number)=="" || number==null || number==undefined){
		return true;
	}
	return false;
}