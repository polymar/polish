/*
 * POImage.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPImageView.j>
@import "CPViewAdditions.j"

@implementation POImage : CPImageView {
	CPString 	_name;
}

/*
* Init an editable text field with hmargin and vmargin = 0;
*/
- (id) image {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
		
	}
	return self;
}

/*
* Init an editable text field with the appropriate margin.
*/
- (id) image_with_hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, 64.0 , 64.0)];
	if(self) {
		
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
	[self setImage:[[CPImage alloc] initWithContentsOfFile:path size:CGSizeMake([self frame].width, [self frame].height)]];
}

- (void) url:(CPString) path hsize:(CGFloat) hsize vsize:(CGFloat) vsize { 
	[self setImage:[[CPImage alloc] initWithContentsOfFile:path size:CGSizeMake(hsize, vsize)]];
}

- (void)imageDidLoad:(CPNotification)aNotification {
	[self display];
}

@end
