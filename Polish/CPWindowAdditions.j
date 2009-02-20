/*
 * CPWindowAdditions.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPWindow.j>
@import "POColor.j"

@implementation CPWindow (Polish) 

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
* Forces the content of the window to redraw.
*/
- (void) display {
	cv = [self contentView];
	[cv setNeedsDisplayInRect:[cv frame]];
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
* Change the background color of the main window.
*/
- (void) color:(CPString) colorName {
	c = [POColor color:colorName];
	if(c != nil)
		[self setBackgroundColor:c];
	else
		console.log(color + ' is not a supported color.');
}

/*
* !!!Debugging - Error handling
*/
- (void)forward:(SEL)aSelector :(marg_list)args
{
	console.warn('@#!Polish Warning - app does not support '+aSelector);
}

@end
