/*
 * PHButton.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPButton.j>

@implementation PHButton : CPButton {
	CPView _parent;
}

/*
* Init a cpbutton with hmargin and vmargin = 0;
*/
- (id) button:(CPView) parent {
	self = [super initWithFrame:CGRectMake(10, 10, ([parent frame].size.width < 70) ? [parent frame].size.width : 70, 20.0)];
	if(self) {
		[self parent:parent];
		[self setBezelStyle:CPHUDBezelStyle];
	}
	return self;
}

/*
* Init a cpbutton with the appropriate margin.
*/
- (id) button:(CPView) parent hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, ([parent frame].size.width < 70) ? [parent frame].size.width : 70, 20.0)];
	if(self) {
		[self parent:parent];
		[self setBezelStyle:CPHUDBezelStyle];
	}
	return self;
}

- (void) parent:(CPView) parent {
	_parent = parent;
}

- (id) parent {
	return _parent;
}

@end
