
  load_file('samples/loaded_javascript.js');
  app.create({"title" : "CapWaves exps.", "width" : 620, "height" : 580, "color" : "blackColor"});

  stack = app.stack({"width" : 550, "height" : 500});
  stack.location(10, 10);
  stack.color('grayColor');
  text = stack.text();
  text.location(100, 50);
  text.placeholder('Bank account numbers please');
  //     text.size(200, 30);
  button = stack.button({"title" : "Click", "width" : 170.0, "height" : 18.0, "x" : 150, "y" : 50});
  button.size(100,18);
  button.location(100,10);
  //button.title('yesss');
  var time = new Date();
  button.on_click(function(){ alert(time); });

