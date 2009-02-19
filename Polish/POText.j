/*
 * POText.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPTextField.j>
@import "CPViewAdditions.j"

@implementation POText : CPTextField {
	CPString 	_name;
}

/*
* Init an editable text field with hmargin and vmargin = 0;
*/
- (id) text {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setBezelStyle:CPTextFieldSquareBezel];
	    [self setBezeled:YES];
	    [self setEditable:YES];
	}
	return self;
}

/*
* Init an editable text field with the appropriate margin.
*/
- (id) text_with_hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, 150.0 , 23.0)];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setBezelStyle:CPTextFieldSquareBezel];
	    [self setBezeled:YES];
	    [self setEditable:YES];
	}
	return self;
}

/*
* Init a label with hmargin and vmargin = 0
*/
- (id) label {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setStringValue:"Email Address:"];
	    [self setTextColor:[CPColor whiteColor]];
	    [self sizeToFit];
		[self setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]))];
	}
	return self;
}

/*
* Init a label with the appropriate margin.
*/
- (id) label_with_hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setStringValue:"Email Address:"];
	    [self setTextColor:[CPColor whiteColor]];
	    [self sizeToFit];
		[self setFrame:CGRectMake(hmargin, vmargin, CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]))];
	}
	return self;
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

- (void) value:(CPString) v {
	[self setStringValue:v];
}

- (CPString) value {
	return [self stringValue];
}

@end
