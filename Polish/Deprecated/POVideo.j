/*
 * POImage.j
 *
 * Created by Roberto Gamboni on 03/12/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPFlashView.j>
@import <AppKit/CPFlashMovie.j>

@implementation POVideo : CPFlashView {
	CPString 	_name;
}

/*
* Init an editable video with hmargin and vmargin = 0;
*/
- (id) video {
	self = [super create];
	if(self) {
		self.size(64.0, 64.0);
		[self createJSMethods: ['url:']];
	}
	return self;
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

- (void) url:(CPString) path {
	if(path != undefined)
		[self setFlashMovie:[CPFlashMovie flashMovieWithFile:path]];
}

- (void)imageDidLoad:(CPNotification)aNotification {
	[self display];
}

@end 
