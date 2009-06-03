app.create({title : "Tweet Polish.", color : darkgray() });

login_stack = app.login({login_type : 'horizontal', x : 55, y : 15, width : 910, height : 65, color : black()});
//TODO
//login_stack.action('ciao');
login_stack.post(function() { alert('authenticated') } );

status_stack = app.stack({x : 55, y : 85, width : 910, height : 130, color : black()});
status_text = status_stack.text({x : 10, y : 15, width : 630, height : 40});
char_label = status_stack.label( {x : 647, y : 21, width : 40, height : 25, value : 140, color : black(), textcolor : red(), font : 20} );

status_text.on_change( function(x) {
	char_label.value( (140 - x.length).toString() );
});

public_stack = app.stack({x : 55, y : 220, width : 300, height : 400, color : lightgray()});

friend_stack = app.stack({x : 360, y : 220, width : 300, height : 400, color : lightgray()});

search_form = app.form({x : 665, y : 220, width : 300, height : 80, color : lightgray(), action : 'http://search.twitter.com/search.json'});
search_form.text({name : 'q', x : 5, y : 5, width : 210, height : 40});
search_form.submit({x : 222, y : 14, width : 70, height : 24});

search_res = app.stack({x : 665, y : 300, width : 300, height : 320, color : lightgray()});

test = public_stack.photo_collection( { photos : [ 'Resources/sample.jpg', 'Resources/sample2.jpg', 'Resources/sample3.jpg', 'Resources/sample4.jpg'] , color : red() } );