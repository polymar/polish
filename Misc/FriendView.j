/*
 * FriendView.j
 *
 * Created by Roberto Gamboni on 02/28/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "../Polish/CPViewAdditions.j"

@implementation FriendView : CPView {
	CPImageView _imageView;
	CPTextField	_friendStatus;
}

/*
* Init a friend with hmargin and vmargin = 0;
*/
- (id) friend {
	self = [super init];
	if(self) {
		self.size(300, 50);
		self.color('blackColor');
		[self layout];
	}
	return self;
}

- (void) layout {
	
	_imageView = [[CPImageView alloc] initWithFrame:CGRectMake(5.0, 5.0, 50.0, 50.0)];
    [_imageView setImageScaling:CPScaleProportionally];
    [self addSubview:_imageView];

	_friendStatus = [[CPTextField alloc] initWithFrame:CGRectMake(60.0, 15.0, 200.0, 50.0)];
	[_friendStatus setFont:[CPFont systemFontOfSize:12]];
    [_friendStatus setTextColor:[CPColor whiteColor]];
	[self addSubview:_friendStatus];
}

- (void) loadTwitterObj:(id) obj {
	var size = CGSizeMake([_imageView frame].size.width, [_imageView frame].size.height);
    [_imageView setImage:[[CPImage alloc] initWithContentsOfFile:obj.profile_image_url size:size]];
    [_friendStatus setStringValue:obj.text];
	[_friendStatus sizeToFit];
}

@end