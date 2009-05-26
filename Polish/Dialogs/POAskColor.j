/*
 * POColorPicker.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POAskColor : PODialog {
	id 			__delegate;
	var			_choose_function;
}

- (id) ask_color {
	self = [super init];
	if(self) {	
		__delegate = [CPColorPanel sharedColorPanel];
		[self createJSMethods: ['on_choose:']];
		//objj_msgSend(__delegate, 'setTarget:', self);
		//[__delegate setAction:@selector(exec)];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(didSelectColor:) name: "CPColorPanelColorDidChangeNotification" object: nil];
	}
	return self;
}

- (void) on_choose:(Function) aFunction {
	_choose_function = aFunction;
}

- (void) didSelectColor:(NSNotification) notification {
	if(_choose_function) {
		var c = [[notification object] color];
		_choose_function(c);
	}
}

- (id) view {
	objj_msgSend(__delegate, 'orderFront:', self);
	return nil;
}

@end