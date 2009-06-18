/*
 * PODialog.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation PODialog : POControl {
 
}

- (id) init {
  self = [super init];
  if(self) {
    //TODO init something here if needed
  }
  return self;
}

- (void) addSubview:(CPView) v {
	//Empty... no meaning for a dialog
}

- (id) view {
  objj_msgSend(__delegate, 'runModal');
  return nil;
}

- (void) remove {
  	//TODO.. 
}

- (void) hide {
	//TODO..
}

- (void) show {
	//TODO..
}


/*
* forward the missing method to embedded object.
*/
- (id)forward:(SEL)aSelector :(marg_list)args
{
  return [AppBuilder obj_create:aSelector :args :self];
}

@end
