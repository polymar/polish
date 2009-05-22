/*
 * AppController.j
 * capp_subfolder_issue
 *
 * Created by You on May 21, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "AppBuilder.j"
@import "Polish/CPObjectAdditions.j"
@import "Polish/CPWindowAdditions.j"
/*
@import <AppKit/CPButton.j>
@import <AppKit/CPColor.j>
@import <AppKit/CPImageView.j>
@import <AppKit/CPProgressIndicator.j>
@import <AppKit/CPSlider.j>
@import <AppKit/CPTextField.j>
@import <AppKit/CPFlashView.j>
@import <AppKit/CPFlashMovie.j>
@import <AppKit/CPTabView.j>
@import <AppKit/CPSplitView.j>
@import <AppKit/CPView.j>
@import <AppKit/CPWebView.j>
@import <AppKit/CPAlert.j>
*/
@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    	//app is visible outside using objj syntax.
		//js can interact with app using objj_msgSend(app, message, params..);
		app = [[AppBuilder alloc] initWithContentView:theWindow];
		
		/*
		var view1 = [[CPView alloc] initWithFrame:CGRectMake(10,10,400,300)];
		[view1 setBackgroundColor:[CPColor blackColor]];
		
		var button1 = [[CPButton alloc] initWithFrame:CGRectMake(10,10,120,25)];
		[button1 setTitle:@"Click"];
		[button1 setTarget:self];
	    [button1 setAction:@selector(exec)]; 
	
		var text1 = [CPTextField textFieldWithStringValue:@"" placeholder:@"write here" width:175];
		[text1 setEditable:true];
		[text1 setFrame:CGRectMake(10, 60, 175, 30)];
		
		var text2 = [CPTextField roundedTextFieldWithStringValue:@"" placeholder:@"write here" width:175];
		[text2 setEditable:true];
		[text2 setFrame:CGRectMake(10, 100, 175, 30)];
		
		var text3 = [CPTextField labelWithTitle:@"this is a label"];
		[text3 setTextColor:[CPColor redColor]];
		[text3 setFrame:CGRectMake(10, 140, 175, 30)];
		
		var image = [[CPImageView alloc] initWithFrame:CGRectMake(10,200,60,60)];
		var img = [[CPImage alloc] initWithContentsOfFile:@"Resources/img1.png" size:CGSizeMake(60,60)];
		[img setDelegate:self];
		[image setImage:img];
		
		var web = [[CPWebView alloc] initWithFrame:CGRectMake(500, 10, 400, 600)];
		[web setMainFrameURL:@"http://www.google.com"];
		
		[view1 addSubview:button1];
		[view1 addSubview:text1];
		[view1 addSubview:text2];
		[view1 addSubview:text3];
		[view1 addSubview:image];
		
		[contentView addSubview:view1];
		[contentView addSubview:web];
		
		*/
		//default stuff... setting background black.
		[theWindow orderFront:self];

		POLISH_NOTIFICATION[POLISH_NOTIFY_ONLOAD].call();
}

/*
-(void)imageDidLoad:(CPImage)image {
	console.log("imageDidLoad");
}

-(void)imageDidError:(CPImage)image {
	console.log("imageDidError");
}

- (void) exec {
	var alert = [[CPAlert alloc] init];
	//[alert setWindowStyle:CPHUDBackgroundWindowMask];
	[alert setAlertStyle:CPInformationalAlertStyle];//CPWarningAlertStyle//CPCriticalAlertStyle//CPInformationalAlertStyle
	[alert setTitle:@"alert_test"];
	[alert setMessageText:@"something is wrong on the internet."];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"button1"];
	[alert addButtonWithTitle:@"button2"];
	[alert runModal];
}

-(void)alertDidEnd:(CPAlert)theAlert returnCode:(int)returnCode {
	console.log(returnCode);
}
*/

@end
