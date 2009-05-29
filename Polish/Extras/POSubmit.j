/*
 * POSubmit.j
 *
 * Created by Roberto Gamboni on 02/27/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "POButton.j"

@implementation POSubmit : POButton {
 
}

/*
* Init a cpbutton with hmargin and vmargin = 0;
*/
- (id) submit {
  self = [super create];
  if(self) {
    [self setBezelStyle:CPHUDBezelStyle];
	[self setTitle:'Submit'];
    [self setTarget:self];
    [self setAction:@selector(submit_form)];
  }
  return self;
}

- (void) submit_form {
	var parent = [self superview];
	if([parent class] == [POForm class]) {
		[parent submit_form];
	}
}

@end
