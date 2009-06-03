/*
 * POPhotoCollection.j
 *
 * Created by Roberto Gamboni on 05/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POPhotoCollection : POControl {
	
	var _objects;
	var _collection_view;
	
	var _click_function;
	var	_double_click_function;

}

- (id) photo_collection {
	self = [super init];
	if(self) {
		
		var rect = CGRectMake(0, 0, 200, 220);
		_collection_view = [[CPCollectionView alloc] initWithFrame:rect];
		[_collection_view setAutoresizingMask:CPViewWidthSizable];
	    [_collection_view setMinItemSize:CGSizeMake(100, 100)];
	    [_collection_view setMaxItemSize:CGSizeMake(100, 100)];
	    [_collection_view setDelegate:self];
	
		var itemPrototype = [[CPCollectionViewItem alloc] init];
		[itemPrototype setView:[[PhotoView alloc] initWithFrame:CGRectMakeZero()]];
        [_collection_view setItemPrototype:itemPrototype];

		__delegate = [[CPScrollView alloc] initWithFrame:rect];
		[__delegate setDocumentView:_collection_view];
        [__delegate setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [__delegate setAutohidesScrollers:YES];

        [[__delegate contentView] setBackgroundColor:[CPColor whiteColor]];

		_objects = [ ];
		[_collection_view setContent:_objects];
		[self createJSMethods:['photos:', 'on_click:', 'on_double_click:', 'add:']];
		
	}
	return self;
}

- (void) photos:(id) list {
	for(var x in list) {
		if(list.hasOwnProperty(x)) {
			_objects.push( [[CPImage alloc] initWithContentsOfFile:list[x] size:CGSizeMake(100.0, 100.0)] );
		}
	}
	objj_msgSend( _collection_view, 'reloadContent');
}

- (void) add:(id) obj {
	_objects.push( [[CPImage alloc] initWithContentsOfFile:obj size:CGSizeMake(100.0, 100.0)] );
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


@implementation PhotoView : CPImageView
{
    CPImageView _imageView;
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? [CPColor grayColor] : nil];
}

- (void)setRepresentedObject:(id)anObject
{
    if (!_imageView)
    {
        _imageView = [[CPImageView alloc] initWithFrame:CGRectInset([self bounds], 5.0, 5.0)];
        
        [_imageView setImageScaling:CPScaleProportionally];
        [_imageView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        
        [self addSubview:_imageView];
    }
    
    [_imageView setImage:anObject];
}

@end
