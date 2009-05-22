/*
 * AppBuilder.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POControl : CPObject {
	id __delegate;
}

/*
* forward the missing method to embedded object.
*/
- (id)forward:(SEL)aSelector :(marg_list)args
{
  //TODO - debugging this.
  return objj_msgSend( __delegate, aSelector, args);
}

@end