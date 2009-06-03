/*
 * POCheck.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPButton.j>

@implementation POCheck : POControl {
    var       	_select_function;
	var			_unselect_function;
}

/*
* Init a cpcheckbox with hmargin and vmargin = 0;
*/
- (id) check {
  self = [super init];
  if(self) {
	__delegate = [CPCheckBox checkBoxWithTitle:@""];
	[self createJSMethods: ['title:', 'on_select:', 'on_deselect', 'enabled:', 'value']];
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

- (CPString) value {
	var st = objj_msgSend(__delegate, 'state');
	if(st == 1) {
		return 'true';
	} else {
		return 'false';
	}
}

- (void) enabled:(BOOL) state {
	if(state != undefined) {
		var st = (state == true) ? 1 : 0;
		objj_msgSend(__delegate, 'setState:', st);
		[self stateChanged:st];
	} else {
		return objj_msgSend(__delegate, 'state');
	}
}

- (void) on_select:(Function)aFunction {
    _select_function = aFunction;
}

- (void) on_deselect:(Function)aFunction {
	_unselect_function = aFunction;
}

- (void) exec {
	var st = objj_msgSend(__delegate, 'state');
	[self stateChanged:st];
}

- (void) stateChanged:(int) st {
	if(st == 1) {
		if(_select_function != nil) {
			_select_function();
		}
	} else {
		if(_unselect_function != nil) {
			_unselect_function();
		}
	}
}

@end
