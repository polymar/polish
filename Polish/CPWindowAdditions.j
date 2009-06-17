/*
 * CPWindowAdditions.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPWindow.j>

@implementation CPWindow (Polish)

/*
- (id) initWithContentRect:(CGRect) aContentRect styleMask:(unsigned int) aStyleMask {
  self = [super initWithContentRect:aContentRect styleMask:aStyleMask];
  if(self) {
    [self createJSMethods:['title']];
  }
  return self;
}
*/

- (void) size:xxx xy:yyy {
  [self width:xxx height:yyy];
}

- (void) location:xxx xy:yyy {
  [self hmargin:xxx vmargin:yyy];
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

/*
* Forces the content of the view to redraw.
*/
- (void) display {
  [[self contentView] setNeedsDisplayInRect:[[self contentView]  frame]];
}

- (void) color:(id) colorName {
  var c = [self sintetize_color:colorName];
  if(c != nil)
    [[self contentView] setBackgroundColor:c];
  else
    console.log(color + ' is not a supported color.');
}

- (CPColor) sintetize_color:(id) colorName {
  if (colorName.isa.name == 'CPColor') {
    return colorName;
  }
  if (colorName.isa.name == 'POColor') {
    return [colorName color];
  }
  return [POColor colorWithName:colorName];
}

- (void) hmargin:(CGFloat) xxx vmargin:(CGFloat) yyy {
    var f = [self frame];
  [self setFrame:CGRectMake(xxx, yyy, f.size.width, f.size.height)];
}

- (void) hmargin:(CGFloat) xxx {
    f = [self frame];
    [self setFrame:CGRectMake(xxx, f.origin.y, f.size.width, f.size.height)];
}

- (void) vmargin:(CGFloat) xxx {
    f = [self frame];
    [self setFrame:CGRectMake(f.origin.x, xxx, f.size.width, f.size.height)];
}


/*
* Set the dimension of the main window.
*/
- (void) width:(CGFloat) width height:(CGFloat) height {
  var f = [self frame];
  [self setFrame:CGRectMake(f.origin.x, f.origin.y, width, height) display:YES animate:NO];
}

/*
* this are boring but they get handy when performing selectors created from parameters list.
*/
- (void) width:(CGFloat) width {
  var f = [self frame];
  [self setFrame:CGRectMake(f.origin.x, f.origin.y, width, f.size.height) display:NO animate:NO];
}

- (void) height:(CGFloat) height {
  var f = [self frame];
  [self setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, height) display:NO animate:NO];
}

/*
* Set the title of the window.
*/
- (void) title:(CPString) title {
  [self setTitle:title];
}

/*
* Set YES and the the window will show the resizable indicator on the right-bottom.
*/
- (void) resizable:(BOOL) flag {
  [self setShowsResizeIndicator:flag];
}

/*
* !!!Debugging - Error handling
*/
- (void)forward:(SEL)aSelector :(marg_list)args
{
  console.warn('@#!Polish Warning - app does not support '+aSelector);
}

@end
