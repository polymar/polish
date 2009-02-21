/*
 * CPViewAdditions.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPView.j>
@import "POColor.j"
@import "../AppBuilder.j"

@implementation CPView (Polish)

- (id) init {
 	self =  [self initWithFrame:CGRectMakeZero()];
 	var polish_methods =  [ 'color:', 'width:', 'height:', 'x:', 'y:', 'size:xy:', 'location:xy:'];
 	[self createJSMethods: polish_methods];
 	return self;
}

- (void) createJSMethods:(CPArray) methods {
  	for(var i=0; i < methods.length ; i++){
    	method_call = [self constructJSMethod:methods[i]];
    	eval(method_call);
  	}
}

- (String) constructJSMethod: (String)method{
  	var method_frags = method.split(':');
  	var method_sig = method_frags.shift();
  	var parameters = new Array();
  	for(var i=0; i < method_frags.length; i++){
    	parameters[i] = 'yyyyyy' + i;
  	}
  	var joined_params = parameters.join(",");
  	var objj_params = (joined_params == '')?'':(', ' + joined_params);
  	return "self." + method_sig + " = " + "function( " + joined_params +" ){ objj_msgSend( self,  '" + method + "' " + objj_params + ");}";
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
	}
}

- (void) y:(CGFloat) f {
	if(f != undefined) {
		[self vmargin:f];
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
  	f = [self frame];
  	[self setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, yyy)];
}

- (void) hmargin:(CGFloat) xxx vmargin:(CGFloat) yyy {
  	f = [self frame];
  	[self setFrame:CGRectMake(xxx, yyy, f.size.width, f.size.height)];
}

/*
* this are boring but they get handy when performing selectors created from parameters list.
*/
- (void) width:(float) xxx {
  	var f = [self frame];
  	[self setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, f.size.height)];
}

- (void) height:(CGFloat) xxx {
  	var f = [self frame];
  	[self setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, xxx)];
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
