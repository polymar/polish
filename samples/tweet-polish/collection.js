rendering = function render_contact(_obj) {
		user_stack = app.stack( { x : 10, y : 10, width : 300, height : 90, marginY : 5 } );
		user_stack.stroke(white());
		user_stack.fill(darkgray());
		user_stack.strokewidth(5.0);
		user_stack.rect({left:1, top:2, width:296, height:86, curve:14});

		flow1 = user_stack.flow( {width : 270, height : 52, marginX : 3, marginY : 3});
		flow2 = user_stack.flow( {width : 270, height : 20, marginX : 3, marginY : 0});
		flow1.image( { url : anObj.user.profile_image_url, width : 50, height : 50} );
		flow1.para( anObj.text, { width : 218, height : 58, color : darkgray(), textcolor : white()});

		flow2.label( { value : anObj.user.name, font : 12 });
		flow2.label( { value : anObj.created_at, width : 180, font : 12 });
		return user_stack;
};