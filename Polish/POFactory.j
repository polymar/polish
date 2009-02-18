/*
 * PHFactory.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "POStack.j"
@import "POButton.j"
@import "POText.j"

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

//- (void)forward:(SEL)aSelector :(marg_list)args
//{
//	console.log('@#!Polish Error -> '+aSelector+' is not a known message.');
//}

@end