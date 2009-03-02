/*
 * FriendsCollection.j
 *
 * Created by Roberto Gamboni on 03/01/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "../Polish/CPViewAdditions.j"

@implementation FriendsCollection : CPScrollView {
	float _current_y;	
}

/*
* Init a friend with hmargin and vmargin = 0;
*/
- (id) friend_collection {
	self = [super init];
	if(self) {
		[self createJSMethods: ['add_friend:', 'clear']];
		_current_y = 0;
		self.size(300, 400);
		self.color('grayColor');
		[self setHasVerticalScroller:YES];
	}
	return self;
}

- (void) add_friend:(id) obj_friend {
	var friend = [[FriendView alloc] friend];
	[friend loadTwitterObj:obj_friend];
	friend.location(friend.x(), _current_y);
	[self addSubview:friend];
	_current_y += [friend frame].size.height;
}

- (void) clear {
	var elements = [self subviews];
	var index = 0;
	//for(index = 0; index < elements.length; index++) {
	//	[elements[index] removeFromSuperview];
	//}
}

@end