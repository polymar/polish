/*
 * POSubmit.j
 *
 * Created by Roberto Gamboni on 02/27/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POSubmit : POButton {
 
}

/*
* Init a cpbutton with hmargin and vmargin = 0;
*/
- (id) submit {
  	self = [super init];
	if(self) {
		__delegate = [CPButton buttonWithTitle:@"Submit"];
		self.size(80,24);
	    [__delegate setBezelStyle:CPHUDBezelStyle];
	    [__delegate setTarget:self];
	    [__delegate setAction:@selector(submit_form)];
	}
	return self;
}

- (void) submit_form {
	var parent = [__delegate superview];
	if([parent class] == [CPForm class]) {
		objj_msgSend(parent, 'submit_form');
	}
}

@end
