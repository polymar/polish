app = Polish.app({title : "Polish slideshow.", width : 500, height : 500, color : darkgray() });

images = ['Resources/sample.jpg', 'Resources/sample2.jpg', 'Resources/sample3.jpg']

stack = app.stack({ width : 500, height : 500, color : red() });
image_view = stack.image( { url : images[0], width : 480, height : 480 } );

animate( 0.1, //fps 0.1 -> 10 seconds
		 function(x) { image_view.url(images[(x / 10) % images.length]); }, //animation function 
		 function() { return false } //stop function
);