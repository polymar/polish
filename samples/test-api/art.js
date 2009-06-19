KAPPA = 4.0 * ((SQRT2 - 1.0) / 3.0);
app = Polish.app({"title" : "Shoes art", "width" : 300, "height" : 400, "color" : white() });
stack = app.stack({"width" : 300, "height" : 400, marginX: 15, marginY: 15});

stack.fill(rgb(0, 0.6, 0.9, 0.1));
stack.stroke(rgb(0, 0.6, 0.9, 1.0));
stack.strokewidth(0.25);
console.log(stack.width());
console.log(stack.height());
for(var i=0; i<100; i++){
  var x = Math.floor(Math.random() * (stack.width() + 1));
  var y = Math.floor(Math.random()* (stack.height() + 1));
  console.log(x);
  console.log(y);
  stack.oval({'left': x,
              'top':  y,
             'radius':  2 * Math.floor(Math.random()*26)});

};

