  app.create({"title" : "CapWaves exps.", "width" : 620, "height" : 580, "color" : red()} , function(){ alert('inside'); });

  stack = app.stack({"width" : 550, "height" : 500});
  stack.location(10, 10);
  stack.color('grayColor');

  text = stack.text();
  text.location(100, 50);
  text.placeholder('Bank account numbers please');
  text.size(200, 30);

  var time = new Date();

  time_button = stack.button({title : "Date", width : 100.0, height : 18.0, x : 150, y : 50, on_click : function() {alert(time); }});

  time_button.location(100,10);
  //time_button.on_click(function() {alert(time); });

  confirm_button = stack.button({title : "Confirm", width : 100.0, height : 18.0, x : 220, y : 10});
  confirm_button.on_click(function(){
    c = app.confirm({title : "title", message : "click yes or no"});
    c.on_yes(function() {console.log('yes')} );
    c.on_no(function() {console.log('no');} );

  });

  check = stack.check({title : "checkbox"});
  check.size(20,20);
  check.location(20,80);

  col = stack.ask_color();
  col.on_choose(function(x) {stack.color(x)});

  rad = stack.radio({title : "radio button", width : 20.0, height : 20.0, x : 20, y : 120});
  label = stack.label();
  label.location(200, 50);
  label.value('Bank account numbers please');
  label.size(200, 30);
link = stack.link('http://github.com/polymar/polish/tree/master', {text: 'Polish'});
//link.size(250, 25);
link.location(200, 100);
  /*
  app {
  title: "CapWaves", width: 620, height: 580, color: red, load: alert { text: 'inside' }
  stack {
    name: Main Window
    width: 550, height: 500, x: 10, y: 10, color: gray
    text {
      x: 10, y: 10, height: 200, width: 30,
      placeholder: Bank account numbers please
    }
    ask-color {
      choose: invoke {
        object: Main Window, method: color
      }
    }
  }
  }
*/






//wd = newWindow.create({"title" : "New window", "width" : 220, "height" : 280, x: 200, y:200 });
