/*
 * PHStack.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "../CPAdditions/CPViewAdditions.j"

@implementation PHStack : CPView {
	CPView _parent;
}

/*
* Init a stack with hmargin and vmargin = 0;
*/
- (id) stack:(CPView) parent {
	self = [super initWithFrame:[parent frame]];
	if(self) {
		[self parent:parent];
	}
	return self;
}

/*
* Init the internal stack with the appropriate margin.
*/
- (id) stack:(CPView) parent hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, [parent frame].size.width, [parent frame].size.height)];
	if(self) {
		[self parent:parent];
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
