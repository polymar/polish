app = Cappuccino.app('height': 150, 'width': 250);
app.background rgb(240, 250, 208);
stack = app.stack (margin:10);
start_button = stack.button("Start");
var time = Time();
start_button.on_click(function(event){ label.replace("Stop watch started at " + time);});
stop_button = stack.button("Stop");
stop_button.on_click(label.replace("Stopped, " + strong(Time() - time) + " seconds elapsed."));
stack.label(para("Press " + strong("Start") + " to begin timing."));
