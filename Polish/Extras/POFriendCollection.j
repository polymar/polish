/*
 * POFriendCollection.j
 *
 * Created by Roberto Gamboni on 05/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POFriendCollection : POControl {
		
		var _objects;
		var _collection_view;

		var _click_function;
		var	_double_click_function;

}

- (id) friend_collection {
	self = [super init];
	if(self) {
		
		var rect = CGRectMake(0, 0, 300, 200);
		_collection_view = [[CPCollectionView alloc] initWithFrame:rect];
		[_collection_view setAutoresizingMask:CPViewWidthSizable];
	    [_collection_view setMinItemSize:CGSizeMake(250, 80)];
	    [_collection_view setMaxItemSize:CGSizeMake(300, 100)];
	    [_collection_view setDelegate:self];
	
		var itemPrototype = [[CPCollectionViewItem alloc] init];
		[itemPrototype setView:[[ContactView alloc] initWithFrame:CGRectMakeZero()]];
        [_collection_view setItemPrototype:itemPrototype];

		__delegate = [[CPScrollView alloc] initWithFrame:rect];
		[__delegate setDocumentView:_collection_view];
        [__delegate setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [__delegate setAutohidesScrollers:YES];

        [[__delegate contentView] setBackgroundColor:[CPColor whiteColor]];

		_objects = [ ];
		[_collection_view setContent:_objects];
		[self createJSMethods:['on_click:', 'on_double_click:', 'insert:', 'len:']];
		
	}
	return self;
}

@end 

@implementation ContactView : CPView {
	
	CPImageView		_contactImage;
	CPTextField		_contactName;
	CPTextField		_contactStatus;
	
}
@end
