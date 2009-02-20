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
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
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
* Init an editable text field with the appropriate margin.
*/
- (id) text_with_hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, 150.0 , 23.0)];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setBezelStyle:CPTextFieldSquareBezel];
	    [self setBezeled:YES];
	    [self setEditable:YES];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(begin_action:) name: "CPControlTextDidBeginEditingNotification" object: _begin_function];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(change_action:) name: "CPControlTextDidChangeNotification" object: _change_function];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(done_action:) name: "CPControlTextDidEndEditingNotification" object: _done_function];
	}
	return self;
}

/*
* Init a label with hmargin and vmargin = 0
*/
- (id) label {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setStringValue:"Email Address:"];
	    [self setTextColor:[CPColor whiteColor]];
	    [self sizeToFit];
		[self setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]))];
	}
	return self;
}

/*
* Init a label with the appropriate margin.
*/
- (id) label_with_hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setStringValue:"Email Address:"];
	    [self setTextColor:[CPColor whiteColor]];
	    [self sizeToFit];
		[self setFrame:CGRectMake(hmargin, vmargin, CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]))];
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

/*
- (void) exec:(CPNotification) notification {
	console.log(notification);
	aFunction = [notification userInfo];
	if(aFunction != nil)
		aFunction.call();
}
*/


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


- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

- (void) value:(CPString) v {
	[self setStringValue:v];
}

- (CPString) value {
	return [self stringValue];
}

@end
