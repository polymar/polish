/*
 * POImage.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPImageView.j>

@implementation POImage : CPImageView {
	CPString 	_name;
}

/*
var image = [[CPImageView alloc] initWithFrame:CGRectMake(10,200,60,60)];
var img = [[CPImage alloc] initWithContentsOfFile:@"Resources/img1.png" size:CGSizeMake(60,60)];
[img setDelegate:self];
[image setImage:img];
*/
/*
* Init an image with hmargin and vmargin = 0;
*/
- (id) imageview {
	self = [super createWithFrame:CGRectMake(10,200,60,60)];
	if(self) {
		//self.size(64.0, 64.0);
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
		var img = [[CPImage alloc] initWithContentsOfFile:path size:CGSizeMake([self frame].size.width, [self frame].size.height)];
		[img setDelegate:self];
		[self setImage:img];
	}
}

- (void)imageDidLoad:(CPNotification)aNotification {
	[self display];
}


@end
