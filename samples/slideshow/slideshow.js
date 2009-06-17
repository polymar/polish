app = Polish.app({"title" : "Polish slideshow.", "width" : 500, "height" : 500, "color" : darkgray() });

images = ['Resources/sample.jpg', 'Resources/sample2.jpg', 'Resources/sample3.jpg']
s = app.image( { url : images[0], width : 480, height : 480, x : 10, y : 10 } );
animate( 0.1, function(x) { s.url(images[((x * 2) - 1) % images.length]); } , function() { return false } );