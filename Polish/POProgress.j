/*
 * POSlider.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPProgressIndicator.j>
@import "CPViewAdditions.j"

@implementation POProgress : CPProgressIndicator {
	CPString	_name;
}

/*
* Init a progress with hmargin and vmargin = 0;
*/
- (id) progress {
	self = [super init];
	if(self) {
		[self createJSMethods: ['min:', 'max:', 'value:']];
	}
	return self;
}

//setter for the min value
- (void) min:(double) v {
	if(v != undefined)
		[self setMinValue:v];
	else
		return [self minValue];
}

//setter for the max value
- (void) max:(double) v {
	if(v != undefined)
		[self setMaxValue:v];
	else 
		return [self maxValue];
}

//setter for the slider value
- (void) value:(double) v {
	if(v != undefined)
		[self setDoubleValue:v];
	else
		return [self doubleValue];
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

@end
