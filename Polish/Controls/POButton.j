/*
 * POButton.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPButton.j>

@implementation POButton : POControl {
  var       	_function;
}

/*
* Init a cpbutton with hmargin and vmargin = 0;
*/
- (id) button {
  self = [super init];
  if(self) {
	__delegate = [CPButton buttonWithTitle:@""];
	[self createJSMethods: ['title:', 'on_click:', 'enabled:']];
	self.size(80,24);
    [__delegate setBezelStyle:CPHUDBezelStyle];
    [__delegate setTarget:self];
    [__delegate setAction:@selector(exec)];
  }
  return self;
}

- (void) enabled:(boolean) _status {
	if(_status != undefined) {
		if(_status == false) {
			[__delegate setAlphaValue:0.5];
		} else {
			[__delegate setAlphaValue:1.0];
		}
		[__delegate setEnabled:_status];
	} else {
		return [__delegate isEnabled];
	}
}

- (void) title:(CPString) t {
	if(t != undefined) {
  		[__delegate setTitle:t];
		[self sizeToFit];
	}
	else
		return [__delegate title];
}

- (void) on_click:(Function)aFunction {
  _function = aFunction;
}

- (void) exec {
  if(_function != nil)
    _function();
}


- (void)sizeToFit {
	var size = [([__delegate title] || " ") sizeWithFont:[__delegate currentValueForThemeAttribute:@"font"]],
	contentInset = [self currentValueForThemeAttribute:@"content-inset"],
	minSize = [self currentValueForThemeAttribute:@"min-size"],
    maxSize = [self currentValueForThemeAttribute:@"max-size"];

	size.width = MAX(size.width + contentInset.left + contentInset.right, minSize.width);
	size.height = MAX(size.height + contentInset.top + contentInset.bottom, minSize.height);

	if (maxSize.width >= 0.0)
		size.width = MIN(size.width, maxSize.width);
	if (maxSize.height >= 0.0)
		size.height = MIN(size.height, maxSize.height);

	size.width = (size.width < 80) ? 80 : size.width;
	[__delegate setFrameSize:size];
}


@end
