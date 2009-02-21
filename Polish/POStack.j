/*
 * POStack.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "CPViewAdditions.j"

@implementation POStack : CPView {
	CPString	_name;
}

/*
* Init a stack with hmargin and vmargin = 0;
*/
- (id) stack {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
	
	}
	return self;
}

/*
* Init the internal stack with the appropriate margin.
*/
- (id) stack_with_hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, 100.0, 100.0)];
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

@end
