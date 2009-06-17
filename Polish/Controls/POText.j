/*
 * POText.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPTextField.j>

@implementation POText : POControl {
  var     _begin_function;
  var     _change_function;
  var     _done_function;
}

/*
* Init an editable text field with hmargin and vmargin = 0;
*/
- (id) text {
  	self = [super init];
	if(self) {
		__delegate = [CPTextField textFieldWithStringValue:@"" placeholder: @"" width:100];
		[self createJSMethods: ['value:', 'placeholder:', 'on_begin:', 'on_change:', 'on_done:']];
		[__delegate setFont:[CPFont systemFontOfSize:14]];
		[__delegate setBezelStyle:CPTextFieldSquareBezel];
		[__delegate setBezeled:YES];
		[__delegate setEditable:YES];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(begin_action:) name: "CPControlTextDidBeginEditingNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(change_action:) name: "CPControlTextDidChangeNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(done_action:) name: "CPControlTextDidEndEditingNotification" object: nil];
	}
  	return self;
}

- (id) password {
	self = [super init];
	if(self) {
		__delegate = [[CPSecureTextField alloc] initWithFrame:CGRectMakeZero()];
		[self createJSMethods: ['value:', 'placeholder:', 'on_begin:', 'on_change:', 'on_done:']];
		[__delegate setFont:[CPFont systemFontOfSize:14]];
		[__delegate setBezelStyle:CPTextFieldSquareBezel];
		[__delegate setBezeled:YES];
		[__delegate setEditable:YES];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(begin_action:) name: "CPControlTextDidBeginEditingNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(change_action:) name: "CPControlTextDidChangeNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(done_action:) name: "CPControlTextDidEndEditingNotification" object: nil];
	}
	return self;
}

- (id) link {
	self = [super init];
	if(self) {
		//TODO
	}
	return self;
}

- (id) caption {
	self = [self label];
	return self;
}

- (id) banner {
	self = [self label];
	if(self) {
		[__delegate setFont:[CPFont systemFontOfSize:48]];
		[__delegate sizeToFit];
	    [__delegate setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([__delegate bounds]), CGRectGetHeight([__delegate bounds]))];
	}
	return self;
}

- (id) title {
	self = [self label];
	if(self) {
		[__delegate setFont:[CPFont systemFontOfSize:34]];
		[__delegate sizeToFit];
	    [__delegate setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([__delegate bounds]), CGRectGetHeight([__delegate bounds]))];
	}
	return self;
}

- (id) subtitle {
	self = [self label];
	if(self) {
		[__delegate setFont:[CPFont systemFontOfSize:26]];
		[__delegate sizeToFit];
	    [__delegate setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([__delegate bounds]), CGRectGetHeight([__delegate bounds]))];
	}
	return self;
}

- (id) para {
	self = [self label];
	if(self) {
		[__delegate setFont:[CPFont systemFontOfSize:12]];
		[__delegate sizeToFit];
	    [__delegate setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([__delegate bounds]), CGRectGetHeight([__delegate bounds]))];
	}
	return self;
}

/*
* Init a label with hmargin and vmargin = 0
*/
- (id) label {
  self = [super init];
  if(self) {
	  __delegate = [CPTextField labelWithTitle:@""];
      [self createJSMethods: ['value:', 'font:', 'textcolor:']];
      [__delegate setFont:[CPFont systemFontOfSize:14]];
      [__delegate setTextColor:[CPColor whiteColor]];
      [__delegate setEditable:NO];
	  [__delegate setSelectable:YES];
      [__delegate sizeToFit];
      [__delegate setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([__delegate bounds]), CGRectGetHeight([__delegate bounds]))];
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
	if([notification object] != __delegate) { return; }
    if(_begin_function != nil)
    	_begin_function();
}

- (void) change_action:(CPNotification) notification {
	if([notification object] != __delegate) { return; }
    if(_change_function != nil)
    	_change_function( objj_msgSend(__delegate, 'stringValue') );
}

- (void) done_action:(CPNotification) notification {
	if([notification object] != __delegate) { return; }
    if(_done_function != nil)
    	_done_function();
}

- (void) placeholder:(CPString)aString {
 	[__delegate setPlaceholderString:aString];
}

- (void) value:(CPString) v {
  if(v != undefined)
    [__delegate setStringValue:v];
  else
    return [__delegate stringValue];
}

- (void) font:(int) f {
	if(f != undefined) {
		[__delegate setFont:[CPFont systemFontOfSize:f]];
	} 
}

- (void) textcolor:(id) colorName {
	var c = [self sintetize_color:colorName];
	if(c != nil) {
		[__delegate setTextColor:c];
	}
}

@end
