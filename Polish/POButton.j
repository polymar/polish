/*
 * POButton.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPButton.j>
@import "CPViewAdditions.j"

@implementation POButton : CPButton {
	CPString	_name;
}

/*
* Init a cpbutton with hmargin and vmargin = 0;
*/
- (id) button {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
		[self setBezelStyle:CPHUDBezelStyle];
	}
	return self;
}

/*
* Init a cpbutton with the appropriate margin.
*/
- (id) button_with_hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, 70.0 , 20.0)];
	if(self) {
		[self setBezelStyle:CPHUDBezelStyle];
	}
	return self;
}

- (void) title:(CPString) t {
	[self setTitle:t];
}

@end
