app.create({"title" : "Polish slideshow.", "width" : 500, "height" : 500, "color" : darkgray() });

images = ['Resources/sample.jpg', 'Resources/sample2.jpg', 'Resources/sample3.jpg']
s = app.image( { width : 480, height : 480, x : 10, y : 10} );
animate( 0.5, function(x) { var img = images[((x * 2) - 1) % images.length]; s.url(img); } , function() { return false } );