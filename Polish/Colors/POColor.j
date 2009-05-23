/*
 * CPColorAdditions.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPColor.j>

@implementation POColor : CPColor {
//	CPDictionary _colors;
}

//TODO add more stuff here
//+ (CPDictionary) colors {
//	if(_colors == nil) {
//		_colors = [CPDictionary dictionaryWithObjects:[[CPColor blackColor], [CPColor redColor], [CPColor blueColor], nil] forKeys:['black', 'red', 'blue', nil]];
//	}
//	return _colors;
//}

+ (CPColor) color:(CPString) colorName {
	cSel = CPSelectorFromString(colorName);
	if([CPColor respondsToSelector:cSel]) {
		return [CPColor performSelector:cSel];
	} //else {
	//	return [[POColor colors] objectForKey:colorName];
	//}
}

@end
