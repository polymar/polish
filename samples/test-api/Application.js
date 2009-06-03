  app.create({"title" : "CapWaves exps.", "width" : 800, "height" : 580, "color" : red() });

  stack = app.stack({"width" : 800, "height" : 500});
  stack.location(10, 10);
  stack.color('grayColor');
  
  text = stack.text();
  text.location(100, 50);
  text.placeholder('Bank account numbers please');
  text.size(200, 30);
  
  var time = new Date();

  time_button = stack.button({title : "Date", width : 100.0, height : 20.0, x : 150, y : 50, on_click : function() {alert(time); }});
  
  time_button.location(100,10);
  //time_button.on_click(function() {alert(time); });

  confirm_button = stack.button({title : "Confirm", width : 100.0, height : 20.0, x : 220, y : 10});
  confirm_button.on_click(function(){ 
	c = app.confirm({title : "title", message : "click yes or no"});
	  c.on_yes(function() {console.log('yes')} );
	  c.on_no(function() {console.log('no');} );
	
  });

  check = stack.check({title : "checkbox"});
  check.size(20,20);
  check.location(20,80);

  //col = stack.ask_color();
  ask_color().on_choose(function(x) {stack.color(x)});

  rad1 = stack.radio({title : "radio button", width : 20.0, height : 20.0, x : 20, y : 120, group : 'sample'});
  rad2 = stack.radio({title : "radio button", width : 20.0, height : 20.0, x : 20, y : 145, group : 'sample'});

  label = stack.label();
  label.location(200, 50);
  label.value('Bank account numbers please');
  label.size(200, 30);

  t = stack.text({x : 100, y: 255, width : 100, height : 30});
  p = stack.password( { x : 100, y: 330, width : 200, height : 30 } );
  p.on_change( function(x) { t.value(x); } );
  
  s = stack.slider();
  s.location(100,300);
  s.on_change(function(x) {t.value(x);} );

  list = stack.list_box({items : ['1', '2', '3']});
  list.location(100,150);
  list.size(200,22);
  list.on_select( function(x) {alert(x);} );

  //stack.login({x : 300, y : 350}).color(darkgray());

  form = app.form({"width" : 350, "height" : 350, action : 'http://search.twitter.com/search.json'});
  form.location(400,10);
  form.color(green());

  form.submit().location(20,100);
  form.text({name : 'q', width : 150, height : 30}).location(20,40);

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

  

  
  

