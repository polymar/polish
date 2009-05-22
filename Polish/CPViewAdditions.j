/*
 * CPViewAdditions.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPView.j>
@import "CPObjectAdditions.j"
@import "POColor.j"

@implementation CPView (Polish)

- (id) init {
 	self =  [self initWithFrame:CGRectMakeZero()];
 	//var polish_methods =  [ 'color:', 'width:', 'height:', 'x:', 'y:', 'size:xy:', 'location:xy:'];
 	[self createJSMethods: polish_methods];
	//var polish_components = ['button', 'text', 'progress', 'image', 'label', 'login', 'form', 'submit', 'friend', 'friend_collection'];
	[self createForwardJSMethods: polish_components];
 	return self;
}

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
  [self setNeedsDisplayInRect:[self frame]];
}

- (void) color:(CPString) colorName {
  c = [POColor color:colorName];
  if(c != nil)
    [self setBackgroundColor:c];
  else
    console.log(color + ' is not a supported color.');
}

- (void) width:(CGFloat) xxx height:(CGFloat) yyy {
	var f = [self frame];
	[self setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, yyy)];
}

- (void) hmargin:(CGFloat) xxx vmargin:(CGFloat) yyy {
  	var f = [self frame];
	[self setFrame:CGRectMake(xxx, yyy, f.size.width, f.size.height)];
}

/*
* this are boring but they get handy when performing selectors created from parameters list.
*/
- (void) width:(float) xxx {
  	var f = [self frame];
	if(xxx != undefined) {
  		[self setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, f.size.height)];
	} else {
		return f.size.width;
	}
}

- (void) height:(CGFloat) xxx {
  	var f = [self frame];
	if(xxx != undefined) {
  		[self setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, xxx)];
	} else {
		return f.size.height;
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

/*
* forward the missing method to polish core.
* any view can create any object and add it to itself!!
*/
- (id)forward:(SEL)aSelector :(marg_list)args
{
  return [AppBuilder obj_create:aSelector :args :self];
}

@end
