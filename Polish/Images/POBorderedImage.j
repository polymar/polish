/*
 * POBorderedImage.j
 *
 * Created by Roberto Gamboni on 06/21/2009.
 * Copyright 2009 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPImageView.j>
@import "CPImageViewAdditions.j"

@implementation POBorderedImage : POControl {
	CPString 	_name;
	CPImage		_img;
	CPImageView	_imgView;
	
	//var			_fade_timer;
	float		_fade_in_time;
	float		_fade_out_time;
	
	var 		_on_click;
	var 		_on_double_click;
	
	var 		_border_color;
	var			_border_selected_color;
	
	var 		_border_size;
}

/*
* Init an image with hmargin and vmargin = 0;
*/
- (id) bimage {
	self = [super init];
	if(self) {
		__delegate = [[CPView alloc] initWithFrame:CGRectMake(0,0,50,50)];
		_border_color = [CPColor blackColor];
		_border_selected_color = [CPColor lightGrayColor];
		_border_size = 0;
		[__delegate setBackgroundColor:_border_color];
		_imgView = [[CPImageView alloc] initWithFrame:CGRectMake(0,0,50,50)];
		[__delegate addSubview:_imgView];
		_fade_in_time = 0;
		_fade_out_time = 0;
		[self createJSMethods: ['url:', 'fade:', 'border:', 'border_color:', 'selected_color:', 'on_click:', 'on_double_click:']];
		[_imgView setNextResponder:self];
	}
	return self;
}

- (void) on_click:(Function) aFunction {
	if(aFunction != undefined) {
		_on_click = aFunction;
	}
}

- (void) on_double_click:(Function) aFunction {
	if(aFunction != undefined) {
		_on_double_click = aFunction;
	}
}

- (void) border:(int) _borderSize {
	_border_size = _borderSize;
	var f = [__delegate frame];
	var rect = CGRectMake( _border_size, _border_size, f.size.width - (2 * _border_size), f.size.height - (2 * _border_size));
	[_imgView setFrame:rect];
}

- (void) width:(float) xxx {
  	__width = xxx;
	var f = [__delegate frame];
	if(xxx != undefined) {
		[__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, f.size.height)];
		f = [__delegate frame];
		var rect = CGRectMake( _border_size, _border_size, f.size.width - (2 * _border_size), f.size.height - (2 * _border_size));
		[_imgView setFrame:rect];
	} else {
		return f.size.width;
	}
}

- (void) height:(CGFloat) xxx {
	__height = xxx;
	var f = [__delegate frame];
	if(xxx != undefined) {
	    [__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, xxx)];
		f = [__delegate frame];
		var rect = CGRectMake( _border_size, _border_size, f.size.width - (2 * _border_size), f.size.height - (2 * _border_size));
		[_imgView setFrame:rect];
	} else {
	    return f.size.height;
	}
}

- (void) border_color:(id) _color {
	var c = [self sintetize_color:_color];
	if(c != nil) {
		_border_color = c;
		[__delegate setBackgroundColor:c];
	}
	else
	    console.log(color + ' is not a supported color.');
}

- (void) selected_color:(id) _color {
	var c = [self sintetize_color:_color];
	if(c != nil)
		_border_selected_color = c;
	else
	    console.log(color + ' is not a supported color.');
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
		[_imgView setImage:aImg];
		[CPTimer scheduledTimerWithTimeInterval:(_fade_in_time / 20)
								 target:self 
								 selector:@selector(increase_alpha:) 
								 userInfo:nil repeats:YES];
	} else {
		[_imgView setImage:aImg];
	}
}

- (void) decrease_alpha:(CPTimer)aTimer {
	if([__delegate alphaValue] <= 0.5) {
		[__delegate setAlphaValue:0.5];
		//[__delegate setImage:[aTimer userInfo]];
		[self fade_in:[aTimer userInfo]];
		[aTimer invalidate];
		return;
	}
	[__delegate setAlphaValue:[__delegate alphaValue] - 0.025];
}

- (void) increase_alpha:(CPTimer)aTimer {
	if([__delegate alphaValue] >= 1.0) {
		[__delegate setAlphaValue:1.0];
		[aTimer invalidate];
		return;
	}
	[__delegate setAlphaValue:[__delegate alphaValue] + 0.025];
}

- (void) url:(CPString) path {
	if(path != undefined) {
		_img = [[CPImage alloc] initWithContentsOfFile:path size:CGSizeMake([_imgView frame].size.width, [_imgView frame].size.height)];
		[_img setDelegate:self];
		
		var old_img = [_imgView image];
		if(old_img != nil) {
			[self fade_out:old_img in:_img];
		} else {
			[self fade_in:_img];	
		}
	} else {
		return [_img filename];
	}
}

- (void) mouseDown: (CPEvent) anEvent {
	var _count = [anEvent clickCount];
	//trigger selection or on_click function
	if(_count == 1) {
		if(_on_click != undefined) {
			_on_click(anEvent._location.x, anEvent._location.y);
		} else {
			if(_border_size == 0) return;
			if([__delegate backgroundColor] == _border_color) {
				[__delegate setBackgroundColor:_border_selected_color];
			} else {
				[__delegate setBackgroundColor:_border_color];
			}
			//TODO deselect other images in the same parent stack
			/*
			var _parent = self.__parent;
			if( [_parent isKindOfClass:POStack] || [_parent isKindOfClass:POFlow] ) {
				for (var el = 0; el < _parent.members.length; el++) {
					
				}
			}
			*/
		}
	}
	//trigger double_click function 
	else {
		_on_double_click(anEvent._location.x, anEvent._location.y);
	}
}  	

/*
* forward the missing method to parent object.
* this is required caused CPResponder requires several methods but i might be interested in few of them
*/
- (id)forward:(SEL)aSelector :(marg_list)args
{
  return [__delegate performSelector:aSelector withObject:args];
}

//I removed this because the callback happpens a lot after the image is loaded and visible
/*
- (void)imageDidLoad:(CPNotification)aNotification {
	[__delegate setAlphaValue:1.0];
	
	[CPTimer scheduledTimerWithTimeInterval:(_fade_in_time / 20)
							 target:self 
							 selector:@selector(increase_alpha:) 
							 userInfo:nil repeats:YES];
	
	[__delegate display];
}
*/

@end
