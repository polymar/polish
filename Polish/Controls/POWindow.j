/*
 * POStack.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POStack : POControl {
	
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
	return self;
}

@end
