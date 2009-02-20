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
    theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPHUDBackgroundWindowMask | CPResizableWindowMask];

	//app is visible outside using objj syntax.
	//js can interact with app using objj_msgSend(app, message, params..);
	app = [[AppBuilder alloc] initWithContentView:theWindow];
	
	//default stuff... setting background black.
	[theWindow orderFront:self];
	
	[app create:{"title" : "CapWaves exps.", "width" : 500, "height" : 500, "color" : "blackColor"}];

	stack = [app stack:{"width" : 400, "height" : 300}];
	//console.log(stack);
	[stack hmargin:10 vmargin:10];
	[stack color:'grayColor'];
	
	button = [stack button:{"width" : 70.0, "height" : 18.0}];
	//console.log(button);
	[button hmargin:300 vmargin:10];
	[button title:'click'];
	
	text = [stack text];
	//console.log(text);
	[text frame:CGRectMake(120,10,150.0,18.0)];
	
	label = [stack label];
	//console.log(label);
	[label hmargin:10 vmargin:10];
	
	progress = [stack progress];
	//console.log(progress);
	[progress frame:CGRectMake(10, 50, 200, 15.0)];
	[progress max:100.0];
	[progress value:33.0];
	
	slider = [stack slider];
	//console.log(slider);
	[slider hmargin:10 vmargin:80];
	[slider max:100.0];
	[slider value:33.0];
	
	img = [stack image];
	//console.log(img);
	[img url:'./Resources/img1.png'];
	[img frame:CGRectMake(10, 120, 100, 100)];
	
}

@end
