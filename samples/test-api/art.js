KAPPA = 4.0 * ((SQRT2 - 1.0) / 3.0);
app = Polish.app({"title" : "Shoes art", "width" : 500, "height" : 500, "color" : white() });
stack = app.stack({"width" : 400, "height" : 400, marginX: 15, marginY: 15});

stack.fill(rgb(0, 0.6, 0.9, 0.1));
stack.stroke(rgb(0, 0.6, 0.9, 1.0));
stack.strokewidth(0.25);

for(var i=0; i<100; i++){
  var x = Math.floor(Math.random() * (stack.width() + 1));
  var y = Math.floor(Math.random()* (stack.height() + 1));
  stack.oval({'left': x,
              'top':  y,
             'radius':  2 * Math.floor(Math.random()*26)});
};

stack.fill(rgb(0.1, 0.2, 0.85, 0.5));
stack.stroke(rgb(0.2, 0.2, 0.7, 1.0));
stack.strokewidth(0.25);


var _objects = [];
for(var i=0; i<5; i++){
  var x = Math.floor(Math.random() * (stack.width() + 1));
  var y = Math.floor(Math.random()* (stack.height() + 1));
  var o = stack.oval({'left': x,
              'top':  y,
             'radius':  2 * Math.floor(Math.random()*26)});
  _objects.push(o);
};

animate( 10, //fps 10 -> 0.1 seconds
		 function(x) { 
			for(var i = 0; i < _objects.length; i++) {
				move(_objects[i]);
			} 
		 }, //animation function 
		 function() { return false } //stop function
).start_animation();

function move(_obj) {
	_x = _obj.x();
	_y = _obj.y();
	if( _obj._signx != undefined) {
		var signx = _obj._signx;
		var signy = _obj._signy;
		var nextX = eval( _x +" "+signx+" "+ 2 );
		if( signx == '+' && nextX >= (400 - _obj.width())) {
			_obj._signx = '-';
		}
		if( signx == '-' && nextX <= 0) {
			_obj._signx = '+';
		}
		var nextY = eval( _y +" "+signy+" "+ 2 );
		if( signy == '+' && nextY >= (400 - _obj.height())) {
			_obj._signy = '-';
		}
		if( signy == '-' && nextY <= 0) {
			_obj._signy = '+';
		}
		_obj.x(nextX);
		_obj.y(nextY);
	} else {
		_obj._signx = (_x < 200) ? '+' : '-';
		_obj._signy = (_y > 200) ? '+' : '-';
	}
}
