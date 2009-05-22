/*
 * POButton.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPButton.j>
@import "POControl.j"

@implementation POButton : POControl {
  CPString    	_name;
  var       	_function;
}

/*
* Init a cpbutton with hmargin and vmargin = 0;
*/
- (id) button {
  self = [super init];
  if(self) {
	__delegate = [[CPButton alloc] create];
	[self createJSMethods: ['title:', 'on_click:']];
    [__delegate setBezelStyle:CPHUDBezelStyle];
    [__delegate setTarget:self];
    [__delegate setAction:@selector(exec)];
  }
  return self;
}

- (void) title:(CPString) t {
	if(t != undefined)
  		[__delegate setTitle:t];
	else
		return [__delegate title];
}

- (void) on_click:(Function)aFunction {
  _function = aFunction;
}

- (void) exec {
  if(_function != nil)
    _function.call();
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

@end
