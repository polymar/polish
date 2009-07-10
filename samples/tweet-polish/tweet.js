//importing some extra files
load_file('./samples/tweet-polish/window_function.js');

//main app
app = Polish.app({title : "Tweet Polish.", color : rgb( 0.1, 0.1, 0.1, 0.9 ) });

//TODO do we have auto-resizing of stack and flow?
toolbar = app.flow( { x : 20, y : 20, width : 800, height : 42, marginX : 20 });

toolbar.stroke(blue());
toolbar.fill(lightgray());
toolbar.strokewidth(8.0);
toolbar.rect({left:1, top:2, width:798, height:40, curve:14});

//toolbar's button
toolbar.button({ title : 'Public'}).on_click( function() { public_window(); } );
toolbar.button({ title : 'Search'}).on_click( function() { search_window(); } );

fr_button = toolbar.button({ title : 'Friends', enabled : false, on_click : function() {friends_window();} });
r_button = toolbar.button({ title : 'Replies', enabled : false});
d_button = toolbar.button({ title : 'Direct', enabled : false});

login_button = toolbar.button({ title : 'Login', on_click : function() { login_window(); } });

//toolbar's label
user_label = toolbar.label( {width : 120, y : 12, textcolor : red()} );

//image
center = app.stack( {x : 25, y : 62, width : 790, height : 560} );
center.image( { url : 'Resources/failwhale.png', width : 770, height : 540} );

function login_completed(_friends, username) {
	login_button.title('Logout'); //TODO implement the logout function
	download( 'http://twitter.com/users/show.json?id='+username,
	 			function(x) {
							  user_label.value('Hi '+ x.screen_name);
							  create_status_stack(x.status.text); 
							  friends_window(_friends);
							}, 
				function(x) { console.log(x); } );
	fr_button.enabled(true);
	//TODO Enable these when ready to fetch from API
	//r_button.enabled(true);
	//d_button.enabled(true);
	login_w.hide();
	login_w = nil;
}

function create_status_stack(_status) {
	status_stack = app.stack( {x : 20, y : 70, width : 800, height : 180} );
	status_stack.stroke(blue());
 	status_stack.fill(lightgray());
	status_stack.strokewidth(8.0);
	status_stack.rect({left:1, top:2, width:798, height:178, curve:14});
	
	flow1 = status_stack.flow( {width : 770, height : 50, marginX : 16, marginY : 5} );
	flow2 = status_stack.flow( {width : 770, height : 100, marginX : 20, marginY : 8} );
	
	st_text = flow1.text( { width : 590, height : 40, placeholder : 'What are you doing?'} );
	st_label = flow1.label( {y : 13,height : 25, width : 40, value : 140, color : lightgray(), textcolor : red(), font : 20} );
	st_text.on_change( function(x) {
	  st_label.value( (140 - x.length).toString() );
	});
	flow1.button( {title : 'Update', y : 14} ).on_click( function() { 
		do_post( 'http://localhost:4000?request_uri=http://twitter.com/statuses/update.json', //the uri
				'status='+st_text.value(), //the body
				//TODO fix this... x is not parsable!!
				function(x) { var t = (objj_msgSend(x, 'objectFromJSON')); status_para.value(t.text); }, //the success function
				function(x) {console.log(x)} ); //the error function
	});
	
	//FIXME - para and editbox dimension is fixed
	nice_stack = flow2.stack( { width : 590, height : 90} );
	nice_stack.stroke(lightgray());
 	nice_stack.fill(darkgray());
	nice_stack.strokewidth(8.0);
	nice_stack.rect({left:1, top:2, width:586, height:86, curve:14});
	status_para = nice_stack.para( _status, { font : 16, width : 560, height : 70, textcolor : rgb(1.0, 1.0, 0.2, 1.0), color : darkgray() } );
}