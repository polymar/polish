/*
 * POSlider.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPSlider.j>

@implementation POSlider : POControl {
	var _on_change_function;
}

/*
* Init a slider with hmargin and vmargin = 0;
*/
- (id) slider {
	self = [super init];
	if(self) {
		__delegate = [[CPSlider alloc] initWithFrame:CGRectMake(0,0,100,20)];
		[self createJSMethods: ['min:', 'max:', 'value:', 'on_change:']];
		[__delegate setSliderType:CPLinearSlider];
		[__delegate setTarget:self];
		[__delegate setAction:@selector(action:)];
	}
	return self;
}

- (void) action:(id) sender {
	if(sender != __delegate) {return;}
	if(_on_change_function != nil) {
		_on_change_function( objj_msgSend(sender, 'doubleValue') );
	}
}

- (void) on_change:(Function)aFunction {
	_on_change_function = aFunction;
}

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

/* TODO: understand the circular slider before exposing this method. right now is only linear slider. */
- (void) type:(CPString) t {
	if(t != undefined) {
		if(t == 'linear') {
			[__delegate setSliderType:CPLinearSlider];
		} else {
			[__delegate setSliderType:CPCircularSlider];
		}
	} else {
		var tp = [__delegate sliderType];
		if(tp == CPLinearSlider) {
			return 'linear';
		} else {
			return 'circular';
		}
	}
}

@end
