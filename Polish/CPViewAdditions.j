/*
 * CPViewAdditions.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPView.j>

@implementation CPView (Polish)

- (void) width:(float) xxx {
  __width = xxx;
  var f = [self frame];
  if(xxx != undefined) {
      [self setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, f.size.height)];
  } else {
    return f.size.width;
  }
}

- (void) height:(CGFloat) xxx {
  __height = xxx;
    var f = [self frame];
  if(xxx != undefined) {
      [self setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, xxx)];
  } else {
    return f.size.height;
  }
}

- (void) x:(CGFloat) f {
  if(f != undefined) {
    [self hmargin:f];
  } else {
    return [self frame].origin.x;
  }
}

- (void) y:(CGFloat) f {
  if(f != undefined) {
    [self vmargin:f];
  } else {
    return [self frame].origin.y;
  }
}

- (void) hmargin:(CGFloat) xxx {
    f = [self frame];
    [self setFrame:CGRectMake(xxx, f.origin.y, f.size.width, f.size.height)];
}

- (void) vmargin:(CGFloat) xxx {
    f = [self frame];
    [self setFrame:CGRectMake(f.origin.x, xxx, f.size.width, f.size.height)];
}

- (BOOL)acceptsFirstResponder
{
	return YES;
}

/*
* forward the missing method to polish core.
* any view can create any object and add it to itself!!
*/
/*
- (id)forward:(SEL)aSelector :(marg_list)args
{
  return [AppBuilder obj_create:aSelector :args :self];
}
*/

@end
