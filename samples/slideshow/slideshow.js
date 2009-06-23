//adding some utils for dealing with canvas
function rounded_border( _anObj ) {
	_anObj.stroke(yellow());
	_anObj.fill(red());
	_anObj.strokewidth(3.0);
	_anObj.rect({left:1, top:2, width:_anObj.width()-2, height:_anObj.height()-4, curve:14});
}

//a panel for displaying an image
var _panel = nil;

app = Polish.app({title : "Polish slideshow.", width : 900, height : 600, color : darkgray() });
//some resources
images = ['Resources/img3.jpg', 'Resources/img4.jpg', 'Resources/img6.jpg']

//the main flow
flow = app.flow( {width : 850, height : 455, color : red()} );

//slideshow stack with a nice rounded border
slideshow_stack = flow.stack({ width : 400, height : 430 });
rounded_border(slideshow_stack);

image_view = slideshow_stack.image( { url : images[0], fade : 3, width : 380, height : 380 } );
handle_button = slideshow_stack.button( { title : 'start' } );

//separator stack
separator_stack = flow.stack( { width : 5, height : 430, color : rgb(0, 0.6, 0.9, 1.0) } );

//gallery stack with a nice rounded border
gallery_stack = flow.stack({ width : 400, height : 430 });
rounded_border(gallery_stack);

row_size = { width : 400, height : 85 };
row1 = gallery_stack.flow( row_size );
row2 = gallery_stack.flow( row_size );
row3 = gallery_stack.flow( row_size );
row4 = gallery_stack.flow( row_size );

download( 'http://www.flickr.com/services/rest/?method=flickr.interestingness.getList&per_page=20&format=json&api_key=ca4dd89d3dfaeaf075144c3fdec76756',
 			function(x) {
				var ph = x.photos.photo;
				var _parent;
				for(var i = 0; i < (ph.length < 16 ? ph.length : 16); i++) {
					if(i < 4) {
						_parent = row1;
					} else if(i < 8) {
						_parent = row2;
					} else if(i < 12) {
						_parent = row3;
					} else {
						_parent = row4;
					}
					_parent.bimage( { width : 75, height : 75, url : flickr_url(ph[i]) } ).on_double_click(
						function(_x, _y) {
							if(_panel != nil) {
								_panel.remove();
								_panel = nil;
							}
							_panel = Polish.window( { title : 'Your Photo' , x : _x, y : _y, width : 300, height : 320 } );
							_panel.image( {url : this.url(), width : 300, height : 300 } );
						}
					);
				}
			}, 
			function(x) { console.log(x); } 
);

//utils for dealing with fancy flickr image retrieval
function flickr_url( _anObj ) {
	return "http://farm"+_anObj.farm+".static.flickr.com/"+_anObj.server+"/"+_anObj.id+"_"+_anObj.secret+"_m.jpg";
}

var animation = animate( 0.2, //fps 0.1 -> 5 seconds
		 			 function(x) { image_view.url(images[(x / 5) % images.length]); }, //animation function 
		 			 function() { return false } //stop function or number of seconds
);

handle_button.on_click( function() {
	if(this.title() == 'stop') {
		this.title('start');
		animation.cancel_animation();
	} else {
		this.title('stop');
		animation.start_animation();
	}
});


//photo_collection is a nice widget in cappuccino which provides scroll bar
//and auto-layout of row and column based on the number of items.
/*
photo_coll = flow.photo_collection( { width : 300, height : 488, color : red() } );

var _objects = [];
var _panel = nil;
download( 'http://www.flickr.com/services/rest/?method=flickr.interestingness.getList&per_page=20&format=json&api_key=ca4dd89d3dfaeaf075144c3fdec76756',
 			function(x) {
						var ph = x.photos.photo;
						for(var i = 0; i < ph.length; i++) {
							var obj = ph[i];
							_objects.push( "http://farm"+obj.farm+".static.flickr.com/"+obj.server+"/"+obj.id+"_"+obj.secret+"_m.jpg" );
						}
						photo_coll.photos( _objects );
						}, 
			function(x) { console.log(x); } );
photo_coll.on_double_click( function(_obj) {
	if(_panel != nil) {
		_panel.remove();
		_panel = nil;
	}
	_panel = Polish.window( { title : 'Your Photo' , x : 200, y : 30, width : 300, height : 300 } );
	_panel.image( {url : _obj, width : 300, height : 300 } );
});
*/
