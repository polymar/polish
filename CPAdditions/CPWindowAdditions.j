/*
 * CPWindowAdditions.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPWindow.j>
@import "CPColorAdditions.j"

@implementation CPWindow (Polish) 

/*
* Set the dimension of the main window.
*/
- (void) width:(CGFloat) width height:(CGFloat) height {
	[self setFrame:CGRectMake(0.0,0.0,width, height) display:YES animate:NO];
}

/*
* Set the title of the window.
*/
- (void) title:(CPString) title {
	[self setTitle:title];
}

/*
* Set YES and the the contentView will automatically resize based on the externale frame size.
*/
- (void) resizable:(BOOL) flag {
	[self setShowsResizeIndicator:flag];
}

/*
* Change the background color of the main window.
*/
- (void) color:(CPString) colorName {
	c = [CPColor color:colorName];
	if(c != nil)
		[self setBackgroundColor:c];
	else
		console.log(color + ' is not a supported color.');
}

@end
