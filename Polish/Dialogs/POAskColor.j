/*
 * POColorPicker.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

function ask_color() {
	var a = [[POAskColor alloc] ask_color];
	objj_msgSend(a, 'view');
	return a;
}

@implementation POAskColor : PODialog {
	var			_choose_function;
}

- (id) ask_color {
	self = [super init];
	if(self) {	
		__delegate = [CPColorPanel sharedColorPanel];
		[self createJSMethods: ['on_choose:']];
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