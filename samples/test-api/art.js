KAPPA = 4.0 * ((SQRT2 - 1.0) / 3.0);
app = Polish.app({"title" : "Shoes art", "width" : 300, "height" : 400, "color" : white() });
awindow = Polish.window({x: 5, y: 5, "width" : 300, "height" : 400});
stack = awindow.stack({"width" : 300, "height" : 400, marginX: 15, marginY: 15});
stack.fill(rgb(0, 0.6, 0.9, 0.1));
stack.stroke(rgb(0, 0.6, 0.9, 1.0));
stack.strokewidth(0.25);
for(var i=0; i<100; i++){
  var x = Math.floor(Math.random() * ( stack.width() + 6)) - 5;
  var y = Math.floor(Math.random() * ( stack.height() + 6)) - 5;
  stack.oval({'left': x,
              'top':  y,
             'radius':  2 * Math.floor(Math.random()*26)});

};

