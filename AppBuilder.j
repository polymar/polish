/*
 * AppBuilder.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */
@import <Foundation/CPObject.j>
@import "Polish/CPWindowAdditions.j";
@import "Polish/POFactory.j";

@implementation AppBuilder : CPObject {
	CPWindow 		_mainWindow;
	CPView 			_contentView;	
}

- (id) initWithContentView:(CPWindow) mainWindow {
	self = [super init];
	if(self) {
		_mainWindow = mainWindow;
		_contentView = [_mainWindow contentView];
	}
	return self;
}

/*
* create the app (which is already created) and set the parameters.
*/
//keeping open for future.
- (id) create:(CPString) what, ... {
	[_mainWindow color:'blackColor'];
	[_mainWindow title:'CapWaves experiments'];
	//TODO convert what(JSON) to tuple 'SEL:obj'
	//TODO perform all the selector to _mainWindow
	return self;
}

/*
* forward all the not implemented method to polish factory class.
*/
- (void)forward:(SEL)aSelector :(marg_list)args
{
	var s = objj_msgSend(POFactory, aSelector);
	if(s != nil) {
//		//TODO verify args.. if there are parameters, convert them into 'SEL:obj' and apply to s
		[s frame:CGRectMake(10,10,70,18)];
		[s color:'redColor'];
		[_contentView addSubview:s];
	}
	return s;
}

- (SEL) build_selector:(CPString) method_name {
	cString = method_name+=':';
	cSel = CPSelectorFromString(cString);
	return cSel;
}

@end
