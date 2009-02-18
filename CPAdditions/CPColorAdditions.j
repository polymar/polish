/*
 * CPColorAdditions.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPColor.j>

@implementation CPColor (Polish) {

//TODO add more stuff here
// colors is global
colors = [CPDictionary dictionaryWithObjects:[[CPColor blackColor], [CPColor redColor], [CPColor blueColor], nil] forKeys:['black', 'red', 'blue', nil]];

+ (CPColor) color:(CPString) colorName {
	cSel = CPSelectorFromString(colorName);
	if([CPColor respondsToSelector:cSel]) {
		return [CPColor performSelector:cSel];
	} else {
		return [colors objectForKey:colorName];
	}
}

@end
