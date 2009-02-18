/*
 * PHFactory.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "PHStack.j"
@import "PHButton.j"
@import "PHText.j"

@implementation PHFactory : CPObject 

+ (id) stack:(CPView) parent {
	return [[PHStack alloc] stack:parent];
} 

+ (id) button:(CPView) parent {
	return [[PHButton alloc] button:parent];
}

+ (id) text:(CPView) parent {
	return [[PHText alloc] text:parent];
}

@end