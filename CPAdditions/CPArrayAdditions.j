/*
 * CPMutableArrayAdditions.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <Foundation/CPArray.j>

@implementation CPArray (Polish) 

-(void) push:(id) obj {
	[self addObject:obj];
}

- (id) pop {
	return [self removeLastObject];
}

- (id) get:(int) index {
	return [self objectAtIndex:index];
}

@end
