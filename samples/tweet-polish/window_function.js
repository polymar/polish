var public_w = nil;
var search_w = nil;
function public_window() {
	if(public_w == nil) {
		public_w = newWindow.create({title : "Public Timeline", width : 400, height : 480, color : black(), x: 50, y: 200 });
		center_stack = public_w.stack( {x : 2, y : 2, width : 396, height : 476, color : lightgray() } );
		public_info_coll = center_stack.friend_collection( {color : darkgray() , x : 2, y : 2, width : 392, height : 472} );
		download( 'http://www.twitter.com/statuses/public_timeline.json' , function(x) { public_info_coll.populate(x) }, function(x) {console.log(x)} );
	} else {
		public_w.hide();
	}
}

function search_window() {
	if(search_w == nil) {
		search_w = newWindow.create({"title" : "Search", "width" : 400, "height" : 480, "color" : black(), x: 50, y: 200 });
		search_coll = search_w.friend_collection( { color : darkgray() , x : 2, y : 42, width : 396, height : 410} );
		search_form = search_w.form({x : 2, y : 2, width : 396, height : 38, color : lightgray(), action : 'http://search.twitter.com/search.json'});
		search_form.text({name : 'q', x : 2, y : 2, width : 200, height : 36});
		search_form.submit({x : 222, y : 10, width : 70, height : 24});	
		search_form.post( function(x) { 
			//search_coll.clear();
			search_coll.populate(x) 
		} );
	} else {
		search_w.hide();
	}
}