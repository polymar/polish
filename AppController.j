/*
 * AppController.j
 * Polish
 *
 * Created by Roberto Gamboni on May 21, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "Polish.j"

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
  Polish = new Object();
  var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];


  //app is visible outside using objj syntax.
  //js can interact with app using objj_msgSend(app, message, params..);
  Polish.app = [[AppBuilder alloc] initWithContentView:theWindow].create;
  Polish.window = newWindow = [[AppBuilder alloc] init].create;

  //default stuff... setting background black.
  [theWindow orderFront:self];

  POLISH_NOTIFICATION.call();
}

@end
