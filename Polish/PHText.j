/*
 * PHText.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPTextField.j>

@implementation PHText : CPTextField {
	CPView 		_parent;
	CPString 	_name;
}

/*
* Init a text field with hmargin and vmargin = 0;
*/
- (id) text:(CPView) parent {
	self = [super initWithFrame:CGRectMake(0, 0, ([parent frame].size.width < 150) ? [parent frame].size.width : 150 , 23.0)];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setBezelStyle:CPTextFieldSquareBezel];
	    [self setBezeled:YES];
	    [self setEditable:YES];
		[self parent:parent];
	}
	return self;
}

/*
* Init a text field with the appropriate margin.
*/
- (id) text:(CPView) parent hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
	self = [super initWithFrame:CGRectMake(hmargin, vmargin, ([parent frame].size.width < 150) ? [parent frame].size.width : 150 , 23.0)];
	if(self) {
		[self setFont:[CPFont systemFontOfSize:14]];
	    [self setBezelStyle:CPTextFieldSquareBezel];
	    [self setBezeled:YES];
	    [self setEditable:YES];
		[self parent:parent];
	}
	return self;
}

- (void) parent:(CPView) parent {
	_parent = parent;
}

- (id) parent {
	return _parent;
}

//- (void) name:(CPString) n {
//	_name = n;
//}

//- (CPString) name {
//	return _name;
//}

//- (void) value:(CPString) v {
//	//TODO accessing internal state
//}

//- (CPString) value {
//	//TODO accessing internal state
//}

@end
