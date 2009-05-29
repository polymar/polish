/*
 * POList.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPButton.j>
@import "POControl.j"

@implementation POList : POControl {
    var       	_select_function;
}

/*
* Init a cpcheckbox with hmargin and vmargin = 0;
*/
- (id) list_box {
  self = [super init];
  if(self) {
	__delegate = [[CPPopUpButton alloc] initWithFrame:CGRectMakeZero() pullsDown:NO];
	[self createJSMethods: ['title:', 'on_select:', 'items:']];
    [__delegate setBezelStyle:CPHUDBezelStyle];
    [__delegate setTarget:self];
    [__delegate setAction:@selector(exec:)];
  }
  return self;
}

- (void) items:(CPArray) its {
	for(var x in its) {
		if(its.hasOwnProperty(x)) {
			objj_msgSend( __delegate, 'addItemWithTitle:', its[x]);
		}
	}
}

- (void) title:(CPString) t {
	if(t != undefined)
  		[__delegate setTitle:t];
	else
		return [__delegate title];
}

- (void) on_select:(Function)aFunction {
    _select_function = aFunction;
}

- (void) exec:(id) sender {	
	var v = objj_msgSend( __delegate, 'titleOfSelectedItem');
	if(_select_function != nil) {
		_select_function(v);
	}  
}

@end
