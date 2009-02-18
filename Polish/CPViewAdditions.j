/*
 * CPViewAdditions.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPView.j>
@import "POColor.j"

@implementation CPView (Polish) 

- (void) finalize:(CPView) child {
	[self addSubview:child];
	[self setNeedsDisplayInRect:[child frame]];
}

- (void) complete {
	[[self parent] finalize:self];
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

//- (void)forward:(SEL)aSelector :(marg_list)args
//{
//	s = [PHFactory performSelector:aSelector];
//	if(s != nil) {
//		//TODO verify args.. if there are parameters, convert them into 'SEL:obj' and apply to s
//		[self addSubview:s];
//	}
//}

@end
