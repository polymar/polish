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

/*
* Forces the content of the view to redraw.
*/
- (void) display {
	[self setNeedsDisplayInRect:[self frame]];
}

- (void) bkg_color:(CPColor) color {
	[self setBackgroundColor:color];
}

- (void) color:(CPString) colorName {
	c = [POColor color:colorName];
	if(c != nil)
		[self setBackgroundColor:c];
	else
		console.log(color + ' is not a supported color.');
}

- (void) width:(CGFloat) w height:(CGFloat) h {
 	f = [self frame];
	[self setFrame:CGRectMake(f.origin.x, f.origin.y, w, h)];
}

- (void) hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	f = [self frame];
	[self setFrame:CGRectMake(hmargin, vmargin, f.size.width, f.size.height)];
}

- (void) frame:(CGRect) frame {
	[self setFrame:frame];
}

/*
* this are boring but they get handy when performing selectors created from parameters list.
*/
- (void) width:(CGFloat) width {
	var f = [self frame];
	[self setFrame:CGRectMake(f.origin.x, f.origin.y, width, f.size.height)];
}

- (void) height:(CGFloat) height {
	var f = [self frame];
	[self setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, height)];
}

- (void) hmargin:(CGFloat) hmargin {
	f = [self frame];
	[self setFrame:CGRectMake(hmargin, f.origin.y, f.size.width, f.size.height)];
}

- (void) vmargin:(CGFloat) vmargin {
	f = [self frame];
	[self setFrame:CGRectMake(f.origin.x, vmargin, f.size.width, f.size.height)];
}

//TODO this almost duplicated the AppBuilder forward method.
//Need a better design.
- (id)forward:(SEL)aSelector :(marg_list)args
{
	//just sanity check... not coming here coz of a wrong create message.
	if ((arguments[2] == 'create:') || (arguments[2] == 'create')) {
		console.error('@#!Polish Error - Valid Syntax: [parent_view [stack|button|text|label|...]:{json_params}]; ');
		return;
	}
	polish_selector = objj_msgSend(AppBuilder, 'sanitize_selector:' , aSelector);
	if(polish_selector.indexOf(':') != -1) {
		console.error('@#!Polish Error '+aSelector+' is an invalid message.');
		return;
	}
	var s = objj_msgSend(POFactory, polish_selector);
	if(s != nil) {
		if(args.length >= 3) {
			var p_list = args[2];
			for( var memb in p_list) {
				objj_msgSend(AppBuilder , 'apply_method:to:with:', memb, s, eval('p_list.'+memb) );
			}
			if(args.length > 3) {
				console.warn('@#!Polish Warning - Variable parameters list not supported yet.');
			}
		}
		[self addSubview:s];
	}
	return s;
}

@end
