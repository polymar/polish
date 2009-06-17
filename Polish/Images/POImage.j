/*
 * POImage.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPImageView.j>

@implementation POImage : POControl {
	CPString 	_name;
	CPImage		_img;
	
	//var			_fade_timer;
	float		_fade_in_time;
	float		_fade_out_time;
}

/*
* Init an image with hmargin and vmargin = 0;
*/
- (id) image {
	self = [super init];
	if(self) {
		__delegate = [[CPImageView alloc] initWithFrame:CGRectMake(0,0,50,50)];
		_fade_in_time = 0;
		_fade_out_time = 0;
		[self createJSMethods: ['url:', 'fade:']];
	}
	return self;
}

- (void) fade:(float) t {
	if(t != undefined) {
		_fade_in_time = t / 2;
		_fade_out_time = t / 2;
	} 
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

- (void) fade_out:(CPImage) aImg1 in:(CPImage) aImg2 {
	if(_fade_out_time > 0) {
		var fade_out_timer_time = _fade_out_time / 20;
		[CPTimer scheduledTimerWithTimeInterval:fade_out_timer_time 
							   target:self 
							   selector:@selector(decrease_alpha:) 
							   userInfo:aImg2 repeats:YES];
	}
}

- (void) fade_in:(CPImage) aImg {
	if(_fade_in_time > 0) {
		[__delegate setAlphaValue:0.5];
		[__delegate setImage:aImg];
	} else {
		[__delegate setImage:aImg];
	}
}

- (void) decrease_alpha:(CPTimer)aTimer {
	if([__delegate alphaValue] <= 0.5) {
		[__delegate setAlphaValue:0.5];
		[__delegate setImage:[aTimer userInfo]];
		[aTimer invalidate];
	}
	[__delegate setAlphaValue:[__delegate alphaValue] - 0.025];
}

- (void) increase_alpha:(CPTimer)aTimer {
	if([__delegate alphaValue] >= 1.0) {
		[aTimer invalidate];
	}
	[__delegate setAlphaValue:[__delegate alphaValue] + 0.025];
}

- (void) url:(CPString) path {
	if(path != undefined) {
		_img = [[CPImage alloc] initWithContentsOfFile:path size:CGSizeMake([__delegate frame].size.width, [__delegate frame].size.height)];
		[_img setDelegate:self];
		
		var old_img = [__delegate image];
		if(old_img != nil) {
			[self fade_out:old_img in:_img];
		}
		else {
			[self fade_in:_img];
		}
	} else {
		return [_img filename];
	}
}

- (void)imageDidLoad:(CPNotification)aNotification {
	[CPTimer scheduledTimerWithTimeInterval:(_fade_in_time / 20)
							 target:self 
							 selector:@selector(increase_alpha:) 
							 userInfo:nil repeats:YES];

	[__delegate display];
}


@end
