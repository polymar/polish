public_w = nil;
search_w = nil;
login_w = nil;
friends_w = nil;
detail_w = nil;
function public_window() {
	if(public_w == nil) {
		public_w = Polish.window({title : "Public Timeline", width : 322, height : 490, color : black(), x: 50, y: 200 });
		center_stack = public_w.stack( {x : 2, y : 2, width : 320, height : 476, color : lightgray() } );
		public_info_coll = center_stack.friend_collection( {color : darkgray() , x : 2, y : 2, width : 316, height : 472 } );
		download( 'http://www.twitter.com/statuses/public_timeline.json' , function(x) { public_info_coll.populate(x) }, function(x) {console.log(x)} );
	} else {
		public_w.remove();
		public_w = nil;
	}
}

function search_window() {
	if(search_w == nil) {
		search_w = Polish.window({title : "Search", width : 322, height : 480, color : black(), x: 200, y: 200 });
		search_coll = search_w.friend_collection( { color : darkgray() , x : 2, y : 42, width : 316, height : 410} );
		search_form = search_w.form({x : 2, y : 2, width : 316, height : 38, color : lightgray(), action : 'http://search.twitter.com/search.json'});
		search_form.text({name : 'q', x : 2, y : 2, width : 200, height : 36});
		search_form.submit({title : 'Search', x : 222, y : 10, width : 70, height : 24});	
		search_form.post( function(x) { 
			search_coll.clear();
			search_coll.populate(x.results) 
		} );
	} else {
		search_w.remove();
		search_w = nil;
	}
}

function login_window() {
	if(login_w == nil) {
		//TODO would be nice if x and y are automatically (randomly) set
		login_w = Polish.window( { title : 'Login', x : 400, y : 160, width : 400, height : 180, color : black()} );
		login = login_w.login( { action : 'http://localhost:4000?request_uri=http://twitter.com/statuses/friends_timeline.json'} );
		login.on_precondition_failed( function() { alert('please insert username and password') } );
		login.on_error( function(x) { alert('wrong username or password'); } );
		login.post( function(x) { 
			login_completed( eval(x), login.username() );
		} );
	} else {
		login_w.remove();
		login_w = nil;
	}
}

function friends_window( _timeline) {
	if(friends_w == nil) {
		friends_w = Polish.window({title : "Friends", width : 322, height : 480, color : black(), x: 350, y: 200 });
		center_stack = friends_w.stack( {x : 2, y : 2, width : 320, height : 476, color : lightgray() } );
		friends_coll = center_stack.friend_collection( {color : darkgray() , x : 2, y : 2, width : 316, height : 472} );
		/*
		friends_coll.on_double_click( function( _obj) {
			if(detail_w != nil) {
				detail_w.remove();
				detail_w = nil;
			}
			detail_w = Polish.window( { title : 'Details' , x : 700, y : 30, width : 300, height : 300 } );
		});
		*/
		if(_timeline != undefined) {
			friends_coll.populate(_timeline);
		} else {
			download( 'http://localhost:4000?request_uri=http://twitter.com/statuses/friends_timeline.json', function(x) { friends_coll.populate(eval(x)) }, function(x) {console.log(x)})
		}
	} else {
		friends_w.remove();
		friends_w = nil;
	}
}