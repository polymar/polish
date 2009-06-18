app = Polish.app({title : "Polish slideshow.", width : 500, height : 530, color : darkgray() });

images = ['Resources/sample.jpg', 'Resources/sample2.jpg', 'Resources/sample3.jpg']

stack = app.stack({ width : 500, height : 530, color : red() });
image_view = stack.image( { url : images[0], fade : 3, width : 480, height : 480 } );
var play = 0;
var animation = nil;
handle_button = stack.button( { title : 'start' } );

animation = animate( 0.1, //fps 0.1 -> 10 seconds
		 function(x) { image_view.url(images[(x / 10) % images.length]); }, //animation function 
		 function() { return false } //stop function
);

handle_button.on_click( function() {
	if(play == 1) {
		play = 0;
		this.title('start');
		animation.cancel_animation();
	} else {
		play = 1;
		this.title('stop');
		animation.start_animation();
	}
});