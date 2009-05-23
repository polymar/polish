/*
 * POSlider.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPProgressIndicator.j>

@implementation POProgress : POControl {
	CPString	_name;
}

/*
* Init a progress with hmargin and vmargin = 0;
*/
- (id) progress {
	self = [super init];
	if(self) {
		__delegate = [[CPProgressIndicator alloc] initWithFrame:CGRectMakeZero()];
		[__delegate setStyle:CPProgressIndicatorBarStyle];
		[self createJSMethods: ['min:', 'max:', 'value:']];
	}
	return self;
}

/*
- (void) text:(CPString) t {
	if(t != undefined)
		[__delegate setText:t];
	else
		return [__delegate text];
}
*/

//setter for the min value
- (void) min:(double) v {
	if(v != undefined)
		[__delegate setMinValue:v];
	else
		return [__delegate minValue];
}

//setter for the max value
- (void) max:(double) v {
	if(v != undefined)
		[__delegate setMaxValue:v];
	else 
		return [__delegate maxValue];
}

//setter for the slider value
- (void) value:(double) v {
	if(v != undefined)
		[__delegate setDoubleValue:v];
	else
		return [__delegate doubleValue];
}

@end
