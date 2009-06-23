app = Polish.app({"title" : "CapWaves exps.", "width" : 800, "height" : 580, "color" : red() });

stack = app.flow({"width" : 420, "height" : 500, marginX: 15, marginY: 15});
stack.stroke(red());
stack.fill(yellow());
stack.strokewidth(5.0);
stack.rect({left:1, top:2, width:400, height:400, curve:14});
stack.stroke(green());
stack.fill(blue());
stack.strokewidth(3.0);
stack.oval({left:400, top:2, width:200, height:200});
//stack.location(10, 10);
stack.color('grayColor');


text = stack.text();
//text.location(100, 50);
text.placeholder('Bank account numbers please');
text.size(200, 30);
var time = new Date();

time_button = stack.button({title : "Date", on_click : function() {alert(time); }});

//time_button.location(100,10);
//time_button.on_click(function() {alert(time); });

confirm_button = stack.button({title : "Confirm", width : 100.0});
confirm_button.on_click(function(){
                          c = app.confirm({title : "title", message : "click yes or no"});
                          c.on_yes(function() {console.log('yes')} );
                          c.on_no(function() {console.log('no');} );

                        });

check2 = stack.check({title : "checkbox"});
check2.size(20,20);
//check.location(20,80);

text2 = stack.text();
//text.location(100, 50);
text2.placeholder('Bank account numbers please');
text2.size(200, 30);
var time = new Date();

time_button2 = stack.button({title : "Date", width : 100.0, height : 20.0, on_click : function() {alert(time); }});

//time_button.location(100,10);
//time_button.on_click(function() {alert(time); });

confirm_button2 = stack.button({title : "Confirm", width : 100.0, height : 20.0});
confirm_button2.on_click(function(){
                          c = app.confirm({title : "title", message : "click yes or no"});
                          c.on_yes(function() {console.log('yes')} );
                          c.on_no(function() {console.log('no');} );

                        });

check2 = stack.check({title : "checkbox"});
check2.size(20,20);
