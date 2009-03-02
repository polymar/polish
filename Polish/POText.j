/*
 * POText.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPTextField.j>
@import "CPViewAdditions.j"

@implementation POText : CPTextField {
	CPString 	_name;
	var			_begin_function;
	var 		_change_function;
	var			_done_function;
}

/*
* Init an editable text field with hmargin and vmargin = 0;
*/
- (id) text {
	self = [super init];
	if(self) {
		[self createJSMethods: ['value:', 'name:']];
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setBezelStyle:CPTextFieldSquareBezel];
	    [self setBezeled:YES];
	    [self setEditable:YES];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(begin_action:) name: "CPControlTextDidBeginEditingNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(change_action:) name: "CPControlTextDidChangeNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(done_action:) name: "CPControlTextDidEndEditingNotification" object: nil];
	}
	return self;
}

/*
* Init a label with hmargin and vmargin = 0
*/
- (id) label {
	self = [super init];
	if(self) {
		[self createJSMethods: ['para:', 'name:']];
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setTextColor:[CPColor whiteColor]];
	    [self sizeToFit];
		[self setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]))];
	}
	return self;
}

- (void) on_begin:(Function)aFunction {
	_begin_function = aFunction;
}

- (void) on_change:(Function)aFunction {
	_change_function = aFunction;
}

- (void) on_done:(Function)aFunction {
	_done_function = aFunction;
}

- (void) begin_action:(CPNotification) notification {
	if(_begin_function != nil)
		_begin_function.call();
}

- (void) change_action:(CPNotification) notification {
	if(_change_function != nil)
		_change_function.call();
}

- (void) done_action:(CPNotification) notification {
	if(_done_function != nil)
		_done_function.call();
}

- (CPString) name:(CPString) n {
	if(n != undefined)
		_name = n;
	else 
		return _name;
}

- (void) value:(CPString) v {
	if(v != undefined)
		[self setStringValue:v];
	else
		return [self stringValue];
}

- (void) para:(CPString) v {
	if(v != undefined)
		[self setStringValue:v];
	else
		return [self stringValue];
}

@end
