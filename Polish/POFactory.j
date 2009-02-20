/*
 * POFactory.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "POStack.j"
@import "POButton.j"
@import "POText.j"
@import "POSlider.j"
@import "POProgress.j"
@import "POImage.j"

@implementation POFactory : CPObject

+ (id) stack {
	return [[POStack alloc] stack];
} 

+ (id) button {
	return [[POButton alloc] button];
}

+ (id) text {
	return [[POText alloc] text];
}

+ (id) label {
	return [[POText alloc] label];
}

+ (id) slider {
	return [[POSlider alloc] slider];
}

+ (id) progress {
	return [[POProgress alloc] progress];
}

+ (id) image {
	return [[POImage alloc] image];
}

//Just message to the user in case of invalid selector received.
+ (void)forward:(SEL)aSelector :(marg_list)args
{
	console.error('@#!Polish Error -> '+aSelector+' is not a known message.');
}

@end