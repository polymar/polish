function get_friends_from_search(search_results, objects) {
	var data = search_results.results;
	if (data == undefined) return;
	for(var i=0; i<data.length; i++) {
		var json = data[i];
		var a = { img : json.profile_image_url, name : json.from_user, status : json.text };
	    objects.push(a);
	}
}

function get_friends_from_public_timeline(public_results, objects) {
	for(var i=0; i<public_results.length; i++) {
		var json = data[i];
		var a = { img : json.profile_image_url, name : json.from_user, status : json.text };
	    objects.push(a);
	}
}