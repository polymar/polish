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
	    [_collection_view setMinItemSize:CGSizeMake(200, 70)];
	    [_collection_view setMaxItemSize:CGSizeMake(300, 100)];
	    [_collection_view setDelegate:self];
	
		var itemPrototype = [[CPCollectionViewItem alloc] init];
		[itemPrototype setView:[[ContactView alloc] initWithFrame:CGRectMake(0,0,200.0, 70.0)]];
        [_collection_view setItemPrototype:itemPrototype];

		__delegate = [[CPScrollView alloc] initWithFrame:rect];
		[__delegate setDocumentView:_collection_view];
        [__delegate setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [__delegate setAutohidesScrollers:YES];

        [[__delegate contentView] setBackgroundColor:[CPColor whiteColor]];

		_objects = [  ];
		[_collection_view setContent:_objects];
		[self createJSMethods:['on_click:', 'on_double_click:', 'add:', 'contacts:', 'clear', 'populate:']];
		
	}
	return self;
}

- (void) populate:(id) anObject {
	//assuming for now anObject is a twitter search result
	var data = anObject.results;
	for(var i=0; i<data.length; i++) {
		var json = data[i];
		var a = { img : json.profile_image_url, name : json.from_user, status : json.text};
	    _objects.push(a);
	}	
	objj_msgSend( _collection_view, 'reloadContent');
}

- (void) contacts:(id) list {
	for(var x in list) {
		if(list.hasOwnProperty(x)) {
			_objects.push( list[x] );
		}
	}
	objj_msgSend( _collection_view, 'reloadContent');
}

- (void) add:(id) obj {
	_objects.push( obj );
	objj_msgSend( _collection_view, 'reloadContent');
}

/*! FIXME - this method doesn't seem to work.. the collection still contains all the object !*/
- (void) clear {
	_objects = [];
	objj_msgSend( _collection_view, 'reloadContent');
}

- (void) on_click:(Function) aFunction {
	if(aFunction != undefined) {
		_click_function = aFunction;
	}
}

- (void) on_double_click:(Function) aFunction {
	if(aFunction != undefined) {
		_double_click_function = aFunction;
	}
}

- (void) color:(id) colorName {
  var c = [self sintetize_color:colorName];
  if(c != nil)
    [[__delegate contentView] setBackgroundColor:c];
  else
    console.log(color + ' is not a supported color.');
}

-(void)collectionViewDidChangeSelection:(CPCollectionView)collectionView {
	console.log('collection collectionViewDidChangeSelection');
	//TODO call the on_click function
}

-(void)collectionView:(CPCollectionView)collectionView didDoubleClickOnItemAtIndex:(int)index {
	console.log('collection didDoubleClickOnItemAtIndex');
	//TODO call the double click function
}

-(CPData)collectionView:(CPCollectionView)collectionView dataForItemsAtIndexes:(CPIndexSet)indices forType:(CPString)aType
{
    return [CPKeyedArchiver archivedDataWithRootObject:[_objects objectAtIndex:[indices firstIndex]]];
}

@end 


@implementation ContactView : CPView {
	
	CPImageView		_contactImage;
	CPTextField		_contactName;
	CPTextField		_contactStatus;
	
}

- (id) initWithFrame:(CGRect) frame {
	self = [super initWithFrame:frame];
	if(self) {
		[self setBackgroundColor:[CPColor blackColor]];
	}
	return self;
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? [CPColor grayColor] : [CPColor blackColor]];
}

- (void)setRepresentedObject:(id)anObject
{
	var img = ( anObject.hasOwnProperty('img') ) ? anObject.img : nil;
	var cname = ( anObject.hasOwnProperty('name') ) ? anObject.name : nil;
	var cstatus = ( anObject.hasOwnProperty('status') ) ? anObject.status : nil;

	if(img != nil) {
		_contactImage = [[CPImageView alloc] initWithFrame:CGRectMake(5.0, 5.0, 64.0, 64.0)];
		[_contactImage setImage:[[CPImage alloc] initWithContentsOfFile:img size:CGSizeMake(64.0, 64.0)]];
		[self addSubview:_contactImage];
	}
	
	if(cname != nil) {
		_contactName = [CPTextField labelWithTitle:cname];
		[_contactName setFont:[CPFont systemFontOfSize:16]];
	    [_contactName setTextColor:[CPColor whiteColor]];
	    [_contactName setEditable:NO];
	    [_contactName sizeToFit];
	    [_contactName setFrame:CGRectMake(80.0, 5.0, CGRectGetWidth([_contactName bounds]), CGRectGetHeight([_contactName bounds]))];
		[self addSubview:_contactName];
	}
	if(cstatus != nil) {
		_contactStatus = [CPTextField labelWithTitle:cstatus];
		[_contactStatus setFont:[CPFont systemFontOfSize:14]];
	    [_contactStatus setTextColor:[CPColor whiteColor]];
	    [_contactStatus setEditable:NO];
	    [_contactStatus sizeToFit];
	    [_contactStatus setFrame:CGRectMake(80.0, 30.0, CGRectGetWidth([_contactStatus bounds]), CGRectGetHeight([_contactStatus bounds]))];
		[self addSubview:_contactStatus];
	}   
}

@end
