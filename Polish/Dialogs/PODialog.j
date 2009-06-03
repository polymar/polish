/*
 * PODialog.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation PODialog : CPObject {
  	id      __delegate;
  	CPString  _name;
}

- (id) init {
  self = [super init];
  if(self) {
    //TODO init something here if needed
  }
  return self;
}

- (void) name:(CPString) n {
  if(n != undefined)
    _name = n;
  else
    return _name;
}

- (CPString) name {
  return _name;
}

- (void) addSubview:(CPView) v {

}

- (id) view {
  objj_msgSend(__delegate, 'runModal');
  return nil;
}

/*
* forward the missing method to embedded object.
*/
- (id)forward:(SEL)aSelector :(marg_list)args
{
  return [AppBuilder obj_create:aSelector :args :self];
}

@end
