/*
 * POFriendCollection.j
 *
 * Created by Roberto Gamboni on 05/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */
//@import "../Helpers/twitter_helpers.js"

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
	    [_collection_view setMinItemSize:CGSizeMake(298, 90)];
	    [_collection_view setMaxItemSize:CGSizeMake(450, 150)];
	    [_collection_view setDelegate:self];
	
		var itemPrototype = [[CPCollectionViewItem alloc] init];
		[itemPrototype setView:[[ContactView alloc] initWithFrame:CGRectMake(0,0, 298, 90)]];
        [_collection_view setItemPrototype:itemPrototype];

		__delegate = [[CPScrollView alloc] initWithFrame:rect];
		[__delegate setDocumentView:_collection_view];
        [__delegate setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [__delegate setAutohidesScrollers:YES];

        [[__delegate contentView] setBackgroundColor:[CPColor whiteColor]];

		_objects = [];
		[_collection_view setContent:_objects];
		[self createJSMethods:['on_click:', 'on_double_click:', 'add:', 'clear', 'populate:']];
		
	}
	return self;
}

- (void) populate:(id) anObject {
	for(var i=0; i<anObject.length; i++) {
		var json = anObject[i];
		/*
		if(json.user == nil)
			var a = { img : json.profile_image_url, name : json.from_user, status : json.text };
		else
			var a = { img : json.user.profile_image_url, name : json.user.name, status : json.text };
		*/
	    _objects.push(json);
	}	
	objj_msgSend( _collection_view, 'reloadContent');
}

/*
- (void) contacts:(id) list {
	for(var x in list) {
		if(list.hasOwnProperty(x)) {
			_objects.push( list[x] );
		}
	}
	objj_msgSend( _collection_view, 'reloadContent');
}
*/

- (void) add:(id) obj {
	_objects.push( obj );
	objj_msgSend( _collection_view, 'reloadContent');
}

- (void) clear {
	_objects = [];
	[_collection_view setContent:_objects];
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
	//TODO call the on_click function
}

-(void)collectionView:(CPCollectionView)collectionView didDoubleClickOnItemAtIndex:(int)index {
	if(_double_click_function != nil) {
		_double_click_function(_objects[index]);
	}
}

-(CPData)collectionView:(CPCollectionView)collectionView dataForItemsAtIndexes:(CPIndexSet)indices forType:(CPString)aType
{
    return [CPKeyedArchiver archivedDataWithRootObject:[_objects objectAtIndex:[indices firstIndex]]];
}

@end 


@implementation ContactView : CPView {
	
	//POStack			_stack;
	//CPImageView		_contactImage;
	//CPTextField		_contactName;
	//CPTextField		_date;
	//CPTextView		_contactStatus;
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
    [self setBackgroundColor:isSelected ? [CPColor redColor] : [CPColor blackColor]];
}

- (void)setRepresentedObject:(id)anObject
{
	var img = ( anObject.hasOwnProperty('user') ) ? anObject.user.profile_image_url : nil;
	if(img == nil) {
		img = anObject.profile_image_url;
	}
	var cname = ( anObject.hasOwnProperty('user') ) ? anObject.user.name : nil;
	if(cname == nil) {
		cname = anObject.from_user;
	}
	var cstatus = ( anObject.hasOwnProperty('text') ) ? anObject.text : nil;
	var cdate = ( anObject.hasOwnProperty('created_at') ) ? anObject.created_at : nil;
	
	var s = [[POStack alloc] stack];
	s.size(300,90);
	s.location(0,0);
	[s marginY:5];
	
	s.stroke(white());
	s.fill(darkgray());
	s.strokewidth(5.0);
	s.rect({left:1, top:2, width:296, height:86, curve:14});

	var flow1 = s.flow( {width : 270, height : 52, marginX : 3, marginY : 3});
	var flow2 = s.flow( {width : 270, height : 20, marginX : 3, marginY : 0});
	flow1.image( { url : img, width : 50, height : 50} );
	flow1.para( cstatus, { width : 218, height : 58, color : darkgray(), textcolor : white()});

	flow2.label( { value : cname, font : 12 });
	flow2.label( { value : cdate, width : 180, font : 12 });
	
	[self addSubview:[s view]];
	
	/*
	_contactImage = [[CPImageView alloc] initWithFrame:CGRectMake(2.0, 2.0, 70.0, 70.0)];
	[_contactImage setImage:[[CPImage alloc] initWithContentsOfFile:img size:CGSizeMake(70.0, 70.0)]];
	[self addSubview:_contactImage];
	
	_contactName = [CPTextField labelWithTitle:cname];
	[_contactName setFont:[CPFont systemFontOfSize:16]];
	[_contactName setTextColor:[CPColor whiteColor]];
	[_contactName setEditable:NO];
	[_contactName sizeToFit];
	[_contactName setFrame:CGRectMake(80.0, 0.0, CGRectGetWidth([_contactName bounds]), CGRectGetHeight([_contactName bounds]))];
	[self addSubview:_contactName];
	
	_contactStatus = [[CPTextView alloc] initWithFrame:CGRectMakeZero()];
	[_contactStatus setStringValue:cstatus];
		//[_contactStatus setFont:[CPFont systemFontOfSize:14]];
	    //[_contactStatus setTextColor:[CPColor whiteColor]];
	    //[_contactStatus setEditable:NO];
	    //[_contactStatus sizeToFit];
	[_contactStatus setFrame:CGRectMake(80.0, 23.0, 350, 49)];
	[self addSubview:_contactStatus]; 
	*/
}

@end
