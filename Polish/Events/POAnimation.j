/*
 * POAnimation.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

function animate(fps, f, stop) {
	var an = [[POAnimation alloc] animate];
	[an setFPS:fps];
	[an animation_function:f];
	if(typeof stop == 'function') {
		[an stop_function:stop];
	} else {
		[an setDuration:stop];
	}
	[an startAnimation];
}

DEFAULT_FPS = 4;
DEFAULT_DURATION = 5;

@implementation POAnimation : CPObject {
	var			_stop_condition;
	var			_animation_function;
	
	CPTimer                 _timer;
	float					_duration;
	float					_fps;
	float 					_progress;
}

- (id) animate {
	self = [super init];
	if(self) {	
		//do basic init here
		_fps = DEFAULT_FPS;
		_duration = DEFAULT_DURATION;
		_progress = 0;
	}
	return self;
}

- (void) setFPS:(float) fps {
	_fps = fps;
}

- (void) setDuration:(float) dur {
	_duration = dur;
	_stop_condition = nil;
}

- (void) animation_function:(Function) aFunction {
	_animation_function = aFunction;
}

- (void) stop_function:(Function) aFunction {
	_stop_condition = aFunction;
	_duration = -1;
}

- (void) startAnimation {
	if(_timer)
		return;
	_progress = 0;
	_timer = [CPTimer scheduledTimerWithTimeInterval:(1.0 / _fps) target:self selector:@selector(animationTimerDidFire:) userInfo:nil repeats:YES];
}

- (void)animationTimerDidFire:(CPTimer)aTimer {
	_progress += (1.0 / _fps);
	if(_animation_function != nil) {
		_animation_function(_progress);
	}
	if((_progress >= _duration && _duration != -1) || (_stop_condition != nil && _stop_condition())) {
		[_timer invalidate];
		_timer = nil;
	}
}

@end