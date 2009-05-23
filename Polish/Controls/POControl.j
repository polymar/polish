/*
 * AppBuilder.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

polish_methods 		=	[ 'color:', 'width:', 'height:', 'x:', 'y:', 'size:xy:', 'location:xy:'];

@implementation POControl : CPObject {
	id 			__delegate;
	CPString	_name;
}

- (id) init {
	self = [super init];
	if(self) {
		[self createJSMethods: polish_methods];
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
	[__delegate addSubview:v];
}

- (id) view {
	return __delegate;
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
		return [__delegate frame].origin.x;
	}
}

- (void) y:(CGFloat) f {
	if(f != undefined) {
		[self vmargin:f];
	} else {
		return [__delegate frame].origin.y;
	}
}

/*
* Forces the content of the view to redraw.
*/
- (void) display {
  [__delegate setNeedsDisplayInRect:[__delegate frame]];
}

- (void) color:(CPString) colorName {
  c = [POColor color:colorName];
  if(c != nil)
    [__delegate setBackgroundColor:c];
  else
    console.log(color + ' is not a supported color.');
}

- (void) width:(CGFloat) xxx height:(CGFloat) yyy {
	var f = [__delegate frame];
	[__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, yyy)];
}

- (void) hmargin:(CGFloat) xxx vmargin:(CGFloat) yyy {
  	var f = [__delegate frame];
	[__delegate setFrame:CGRectMake(xxx, yyy, f.size.width, f.size.height)];
}

/*
* this are boring but they get handy when performing selectors created from parameters list.
*/
- (void) width:(float) xxx {
  	var f = [__delegate frame];
	if(xxx != undefined) {
  		[__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, f.size.height)];
	} else {
		return f.size.width;
	}
}

- (void) height:(CGFloat) xxx {
  	var f = [__delegate frame];
	if(xxx != undefined) {
  		[__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, xxx)];
	} else {
		return f.size.height;
	}
}

- (void) hmargin:(CGFloat) xxx {
  	f = [__delegate frame];
  	[__delegate setFrame:CGRectMake(xxx, f.origin.y, f.size.width, f.size.height)];
}

- (void) vmargin:(CGFloat) xxx {
  	f = [__delegate frame];
  	[__delegate setFrame:CGRectMake(f.origin.x, xxx, f.size.width, f.size.height)];
}

/*
* forward the missing method to embedded object.
*/
- (id)forward:(SEL)aSelector :(marg_list)args
{
	return [AppBuilder obj_create:aSelector :args :self];
}

@end