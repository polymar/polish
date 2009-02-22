/*
 * POForm.j
 *
 * Created by Roberto Gamboni on 02/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "CPViewAdditions.j"

@implementation POForm : POStack {
	CPString 	_url;
	CPString 	_method;
}

/*
* Init a form with hmargin and vmargin = 0;
*/
- (id) form {
	self = [super init];
	if(self) {
	
	}
	return self;
}

- (void) method:(CPString) m {
	_method = m;
}

- (void) url:(CPString) u {
	_url = u;
}

- (CPString) method {
	return _method;
}

- (CPString) url {
	return _url;
}

- (CPString) serialize {
	return 'form';
}

@end