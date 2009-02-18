/*
 * AppBuilder.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */
@import "CPAdditions/CPViewAdditions.j"
@import "CPAdditions/CPArrayAdditions.j"
@import "CPAdditions/CPWindowAdditions.j"
@import "CPAdditions/CPColorAdditions.j"
@import "Polish/PHFactory.j"

@implementation AppBuilder : CPObject {
	CPWindow 		_mainWindow;
	CPView 			_contentView;
	int				_stack_index;
	CPMutableArray	_stack_array;	
}

- (id) initWithContentView:(CPWindow) mainWindow {
	self = [super init];
	if(self) {
		_mainWindow = mainWindow;
		_contentView = [_mainWindow contentView];
		_stack_array = [[CPMutableArray alloc] initWithCapacity:5];
		[_stack_array push:_contentView];
		_stack_index = 0;
	}
	return self;
}

- (id) create:(CPString) what, ... {
	//console.log(arguments.length);
	cSel = [self build_selector:what];
	el = [PHFactory performSelector:cSel withObject:[_stack_array get:_stack_index]];
	if(arguments.length > 3) {
		//TODO map the arguments in selector and apply
	}
	[_stack_array push:el];
	_stack_index += 1;
	return el;
}

- (SEL) build_selector:(CPString) method_name {
	cString = method_name+=':';
	cSel = CPSelectorFromString(cString);
	return cSel;
}

- (void) close {
	[[_stack_array get:_stack_index] complete];
	_stack_index -= 1;
	[_stack_array pop];
}

- (void) create_test {
	//creation 1
	stack_one = [self create:'stack'];
	
	//modification 1
	c = [CPColor redColor];
	[stack_one bkg_color:c];
	[stack_one frame:CGRectMake(50.0, 50.0, 400.0, 400.0)];
	
	b = [self create:'button'];
	[b setTitle:'ciao'];
	[b setBackgroundColor:[CPColor blueColor]];
	[self close];
	
	//creation 2
	stack_two = [self create:'stack', 'width', 10, 'height', 10];
	
	//modification 2
	c = [CPColor whiteColor];
	[stack_two bkg_color:c];
	[stack_two width:100.0 height:100.0];
	[stack_two hmargin:50.0 vmargin:100.0];
	
	b = [self create:'button'];
	[b setTitle:'ciao'];
	[b setBackgroundColor:[CPColor blueColor]];
	[self close];
	
	//closing 2
	[self close];
	
	//creation 3
	stack_three = [self create:'stack'];
	
	//modification 3
	c = [CPColor yellowColor];
	[stack_three bkg_color:c];
	[stack_three hmargin:250.0 vmargin:100.0];
	[stack_three width:100.0 height:100.0];
	
	//closing 3
	[self close];
	
	//closing 1
	[self close];
}

@end
