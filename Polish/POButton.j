/*
 * POButton.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPButton.j>
@import "CPViewAdditions.j"

@implementation POButton : CPButton {
  CPString    	_name;
  var       	_function;
}

/*
* Init a cpbutton with hmargin and vmargin = 0;
*/
- (id) button {
  self = [super init];
  if(self) {
	[self createJSMethods: ['title:', 'on_click:']];
    [self setBezelStyle:CPHUDBezelStyle];
    [self setTarget:self];
    [self setAction:@selector(exec)];
  }
  return self;
}

- (void) title:(CPString) t {
  [self setTitle:t];
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
