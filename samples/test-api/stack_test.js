app = Polish.app({"title" : "CapWaves exps.", "width" : 800, "height" : 580, "color" : red() });

stack = app.stack({"width" : 800, "height" : 500});
//stack.location(10, 10);
stack.color('grayColor');

text = stack.text();
//text.location(100, 50);
text.placeholder('Bank account numbers please');
text.size(200, 30);
var time = new Date();

time_button = stack.button({title : "Date", width : 100.0, height : 20.0, x : 150, y : 50, on_click : function() {alert(time); }});

//time_button.location(100,10);
//time_button.on_click(function() {alert(time); });

confirm_button = stack.button({title : "Confirm", width : 100.0, height : 20.0, x : 220, y : 10});
confirm_button.on_click(function(){
                          c = app.confirm({title : "title", message : "click yes or no"});
                          c.on_yes(function() {console.log('yes')} );
                          c.on_no(function() {console.log('no');} );

                        });

check = stack.check({title : "checkbox"});
check.size(20,20);
//check.location(20,80);

