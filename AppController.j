/*
 * AppController.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "AppBuilder.j"

@implementation AppController : CPObject
{
	
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
	//this is the mainWindow. For modify this object there are utilities methods in app.
    theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];

	//app is visible outside using objj syntax.
	//js can interact with app using objj_msgSend(app, message, params..);
	app = [[AppBuilder alloc] initWithContentView:theWindow];
	
	//default stuff... setting background black.
	//[theWindow color:'blackColor'];
	//[theWindow title:'CapWaves experiments'];
	[theWindow orderFront:self];
	
	[app create:'json string'];
	stack = [app stack];
	console.log(stack);
}

@end
