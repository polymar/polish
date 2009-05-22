/*
 * POStack.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "POControl.j"

@implementation POStack : POControl {
	CPString	_name;
}

/*
* Init a stack with hmargin and vmargin = 0;
*/
- (id) stack {
	self = [super init];
	if(self) {
		__delegate = [[CPView alloc] createWithFrame:CGRectMakeZero()];
		//TODO maybe we can set a default stack size here;
	}
	console.debug(self);
	return self;
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	console.debug(__delegate);
	return _name;
}

- (id) test {
	return __delegate;
}

@end
