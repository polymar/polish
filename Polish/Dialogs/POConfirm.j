/*
 * POConfirm.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POConfirm : PODialog {
	id 			__delegate;
	var			_on_yes_function;
	var			_on_no_function;
}

- (id) confirm {
	self = [super init];
	if(self) {
		__delegate = [[CPAlert alloc] init];
		[self createJSMethods: ['message:', 'title:', 'on_yes:', 'on_no:']];
		objj_msgSend(__delegate, 'setAlertStyle:', CPInformationalAlertStyle);
		objj_msgSend(__delegate, 'addButtonWithTitle:', 'Ok');
		objj_msgSend(__delegate, 'addButtonWithTitle:', 'Cancel');
		objj_msgSend(__delegate, 'setDelegate:', self);
	}
	return self;
}

- (void) on_yes:(Function)aFunction {
  _on_yes_function = aFunction;
}

- (void) on_no:(Function)aFunction {
  _on_no_function = aFunction;
}

- (void) exec:(Function) aFunction {
	if(aFunction != nil)
		aFunction();
}

-(void)alertDidEnd:(CPAlert) theAlert returnCode:(int)returnCode {
	if(returnCode == 0) {
		objj_msgSend(self, 'exec:', _on_yes_function);
	} else {
		objj_msgSend(self, 'exec:', _on_no_function);
	}
}

- (void) message:(CPString) t {
	if(t != undefined) {
		objj_msgSend(__delegate, 'setMessageText:', t);
	} else {
		return objj_msgSend(__delegate, 'messageText');
	}
}

- (void) title:(CPString) t {
	if(t != undefined) {
		objj_msgSend(__delegate, 'setTitle:', t);
	} else {
		return objj_msgSend(__delegate, 'title');
	}
}

@end