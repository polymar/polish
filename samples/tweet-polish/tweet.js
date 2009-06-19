//importing some extra file
load_file('./samples/tweet-polish/window_function.js');

//main app
app = Polish.app({title : "Tweet Polish.", color : darkgray() });

//TODO do we have auto-resizing of stack and flow?
toolbar = app.flow( { x : 20, y : 20, width : 800, height : 42, marginX : 20 });

toolbar.stroke(blue());
toolbar.fill(lightgray());
toolbar.strokewidth(8.0);
toolbar.rect({left:1, top:2, width:800, height:40, curve:14});

//toolbar's button
toolbar.button({ title : 'Public'}).on_click( function() { public_window(); } );
toolbar.button({ title : 'Search'}).on_click( function() { search_window(); } );
toolbar.button({ title : 'Friends', enabled : false});
toolbar.button({ title : 'Replies', enabled : false});
toolbar.button({ title : 'Direct', enabled : false});

//image
//center = app.stack( {x : 25, y : 62, width : 790, height : 560} );
//center.image( { url : 'Resources/failwhale.png', width : 770, height : 540} );

//TODO would be nice if x and y are automatically (randomly) set
login_window = newWindow.create( { x : 25, y : 60, width : 400, height : 180, color : black()} );
login = login_window.login( { action : 'http://localhost:9010?request_uri=http://twitter.com/statuses/friends_timeline.json'} );
login.on_precondition_failed( function() { alert('please insert username and password') } );
login.on_error( function(x) { alert('wrong username or password'); } );
login.post( function(x) { 
	login_window.hide();
	//personal_info_coll.populate(eval(x));
	download( 'http://twitter.com/users/show.json?id='+login.username(), function(x) { console.log(x);/*status_value.value(x.status.text)*/ }, function(x) { console.log(x); } );
} );