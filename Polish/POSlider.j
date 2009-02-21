/*
 * POSlider.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPSlider.j>
@import "CPViewAdditions.j"

@implementation POSlider : CPSlider {
	CPString	_name;
}

/*
* Init a slider with hmargin and vmargin = 0;
*/
- (id) slider {
	//looks like it's not possible to create a slider with size 0 or too small.
	self = [super initWithFrame:CGRectMake(0,0,200,20)];
	if(self) {
		
	}
	return self;
}

/*
* Init a slider with the appropriate margin.
*/
- (id) slider_with_hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, 200.0 , 20.0)];
	if(self) {
		
	}
	return self;
}

//setter for the min value
- (void) min:(double) v {
	[self setMinValue:v];
}

//setter for the max value
- (void) max:(double) v {
	[self setMaxValue:v];
}

//setter for the slider value
- (void) value:(double) v {
	[self setValue:v];
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

@end
