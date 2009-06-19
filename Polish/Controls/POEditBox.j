/*
 * POEditBox.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POEditBox : POControl {
  var     _begin_function;
  var     _change_function;
  var     _done_function;
}

- (id) control:(CPString)aControl withArgs: (id)args parent:(id)aParent {
	if(aControl == 'para')
    	var control = [self para: args[0]];
  	else {
    	console.error('Wrong selector sent to POEditBox');
    	return nil;
  	}
	[aParent addChild: self];
  	if(args[1]) {
    	[self applyMethods:args[1] onControl: control];
  	}
  	return control;
}

/*
* Init an editable text field with hmargin and vmargin = 0;
*/
- (id) edit_box {
  	self = [super init];
	if(self) {
		__delegate = [[CPTextView alloc] initWithFrame:CGRectMakeZero()];
		[self createJSMethods: ['value:', 'placeholder:', 'on_begin:', 'on_change:', 'on_done:', 'disable', 'enable']];
		//[__delegate setFont:[CPFont systemFontOfSize:14]];
		//[__delegate setBezelStyle:CPTextFieldSquareBezel];
		//[__delegate setBezeled:YES];
		[__delegate enable];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(begin_action:) name: "CPControlTextDidBeginEditingNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(change_action:) name: "CPControlTextDidChangeNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(done_action:) name: "CPControlTextDidEndEditingNotification" object: nil];
	}
  	return self;
}

- (id) para:(CPString) _text {
	self = [super init];
	if(self) {
		__delegate = [[CPTextView alloc] initWithFrame:CGRectMakeZero()];
		[self createJSMethods: ['value:', 'on_begin:', 'on_change:', 'on_done:','textcolor:']];
		objj_msgSend( __delegate, 'setStringValue:', _text);
		//[__delegate setFont:[CPFont systemFontOfSize:14]];
		//[__delegate setBezelStyle:CPTextFieldSquareBezel];
		//[__delegate setBezeled:YES];
		[__delegate disable];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(begin_action:) name: "CPControlTextDidBeginEditingNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(change_action:) name: "CPControlTextDidChangeNotification" object: nil];
		[[CPNotificationCenter defaultCenter] addObserver: self selector: @selector(done_action:) name: "CPControlTextDidEndEditingNotification" object: nil];
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

- (void) disable {
	[__delegate disable];
}

- (void) enable {
	[__delegate enable];
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
