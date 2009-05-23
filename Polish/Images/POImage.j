/*
 * POImage.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPImageView.j>

@implementation POImage : POControl {
	CPString 	_name;
	CPImage		_img;
}

/*
* Init an image with hmargin and vmargin = 0;
*/
- (id) image {
	self = [super init];
	if(self) {
		__delegate = [[CPImageView alloc] initWithFrame:CGRectMake(0,0,50,50)];
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
	if(path != undefined) {
		_img = [[CPImage alloc] initWithContentsOfFile:path size:CGSizeMake([__delegate frame].size.width, [__delegate frame].size.height)];
		[_img setDelegate:self];
		[__delegate setImage:_img];
	} else {
		return [_img filename];
	}
}

- (void)imageDidLoad:(CPNotification)aNotification {
	[__delegate display];
}


@end
