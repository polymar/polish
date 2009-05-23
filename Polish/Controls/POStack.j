/*
 * POStack.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POStack : POControl {
	CPString	_name;
}

/*
* Init a stack with hmargin and vmargin = 0;
*/
- (id) stack {
	self = [super init];
	if(self) {
		__delegate = [[CPView alloc] initWithFrame:CGRectMakeZero()];
		[self createForwardJSMethods: polish_components];
	}
	//console.debug(self);
	return self;
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

@end
