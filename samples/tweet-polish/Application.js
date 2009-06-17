//main app
app = Polish.app({title : "Tweet Polish.", color : darkgray() });

//search window
search_app = Polish.window({"title" : "Search", "width" : 400, "height" : 480, "color" : black(), x: 850, y: 50 });
search_coll = search_app.friend_collection( { color : darkgray() , x : 2, y : 42, width : 396, height : 410} );
search_form = search_app.form({x : 2, y : 2, width : 396, height : 38, color : lightgray(), action : 'http://search.twitter.com/search.json'});
search_form.text({name : 'q', x : 2, y : 2, width : 200, height : 36});
search_form.submit({x : 222, y : 10, width : 70, height : 24});

search_form.post( function(x) { 
	search_coll.populate(x) 
} );

//top stack
//login
top_stack = app.stack( { x : 50, y : 15, width : 910, height : 200, color : black() } );
login = top_stack.login({x : 125, y : 15, height : 65, color : black(), action : 'http://localhost:9001?request_uri=http://twitter.com/statuses/friends_timeline.json'});
//status after login
status = top_stack.stack( { x : 30, y : 20, width : 850, height : 165, color : black() } );
status_text = status.text({x : 10, y : 15, width : 730, height : 40});
char_label = status.label( {x : 757, y : 21, width : 40, height : 25, value : 140, color : black(), textcolor : red(), font : 20} );

status_text.on_change( function(x) {
  char_label.value( (140 - x.length).toString() );
});

status_value = status.para('this is my status', { x : 14, y : 75, width : 660, height : 70} );
status_update = status.button( {x : 720, y : 95, width : 100, height : 24, title : 'Update Status'} );
var toggle = 1;
status_update.on_click( function() { 
	if(toggle == 1) {
		toggle = 0;
		status_value.hide(); 
	} else {
		toggle = 1;
		status_value.show(); 
	}
} );

//center stack
center_stack = app.stack( {x : 50, y : 220, width : 910, height : 450, color : lightgray() } );
//left side - public timeline
public_info_stack = center_stack.stack( { x : 2, y : 2, height : 36, width : 450, color : darkgray() } );
public_refresh_button = public_info_stack.button( { x : 165, y : 6, width : 120, height : 24, title : 'Refresh'} );
public_refresh_button.on_click( function() {
	public_info_coll.clear();
	download_public();
});
public_info_coll = center_stack.friend_collection( {color : darkgray() , x : 2, y : 40, width : 450, height : 408} );

//right side - personal friends
personal_stack = center_stack.stack( { x : 454, y : 2, height : 36, width : 452, color : darkgray() } );
personal_refresh_button = personal_stack.button( { x : 166, y : 6, width : 120, height : 24, title : 'Refresh'} );
personal_refresh_button.on_click( function() {
	personal_info_coll.clear();
});
personal_info_coll = center_stack.friend_collection( {color : darkgray() , x : 454, y : 40, width : 452, height : 408} );

//download function for public timeline
function download_public() {
	download( 'http://www.twitter.com/statuses/public_timeline.json' , function(x) { public_info_coll.populate(x) }, function(x) {console.log(x)} );
}
download_public();
/*
login_stack = app.login({x : 55, y : 15, width : 910, height : 65, color : black(), action : 'http://localhost:9001?request_uri=http://twitter.com/statuses/friends_timeline.json'});
login_stack.on_precondition_failed( function() { alert('please insert username and password') } );
login_stack.on_error( function(x) { alert('wrong username or password'); } );
login_stack.post(function(x) { 
	console.log(x);
	//todo
} );

status_stack = app.stack({x : 55, y : 85, width : 910, height : 130, color : black()});
status_text = status_stack.text({x : 10, y : 15, width : 630, height : 40});
char_label = status_stack.label( {x : 647, y : 21, width : 40, height : 25, value : 140, color : black(), textcolor : red(), font : 20} );

status_text.on_change( function(x) {
  char_label.value( (140 - x.length).toString() );
});

status_value = status_stack.para('this is my status', { x : 14, y : 55, width : 623, height : 70} );

public_stack = app.stack({x : 55, y : 220, width : 300, height : 400, color : lightgray()});
public_coll = public_stack.friend_collection( {color : darkgray() , x : 2, y : 2, width : 296, height : 396} );

friend_stack = app.stack({x : 360, y : 220, width : 300, height : 400, color : lightgray()});

search_res = app.stack({x : 665, y : 300, width : 300, height : 320, color : lightgray()});
search_coll = search_res.friend_collection( { color : darkgray() , x : 2, y : 2, width : 296, height : 316} );

search_form = app.form({x : 665, y : 220, width : 300, height : 80, color : lightgray(), action : 'http://search.twitter.com/search.json'});
search_form.text({name : 'q', x : 5, y : 5, width : 210, height : 40});
search_form.submit({x : 222, y : 14, width : 70, height : 24});

search_form.post( function(x) { 
	search_coll.populate(x) 
} );
*/

//test = public_stack.photo_collection( { photos : [ 'Resources/sample.jpg', 'Resources/sample2.jpg', 'Resources/sample3.jpg', 'Resources/sample4.jpg'] , color : red() } );
//test = public_stack.friend_collection( { color : red() , x : 2, y : 2, width : 296, height : 396} );

/*
f = function() {
  var login_y = login_stack.y();
  login_stack.location(login_stack.x(), login_y - 5);
};

*/
/*
b = status_stack.button( {title : 'this is fun', x : 25, y : 70, height : 24, width : 70} );
bf = function(x) {
	b.x( b.x() + (x * 50) / 10 );
}
b.on_click( function() {
	animate(30, bf, 1 );
});
*/
//download( 'http://www.twitter.com/statuses/public_timeline.json' , function(x) { public_coll.populate(x) }, function(x) {console.log(x)} );
