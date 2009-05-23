/*
 * POLogin.j
 *
 * Created by Roberto Gamboni on 02/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "POForm.j"

@implementation POLogin : POForm {
	CPTextField			_title;
	CPTextField 		_userName;
	CPSecureTextField 	_password;
	CPButton 			_login;
	CPButton			_forgot;
	
	CPString 			_forgotUrl;
}

/*
* Init a form with hmargin and vmargin = 0;
*/
- (id) login {
	self = [super create];
	if(self) {
		[self size:400 xy:180];
		[self location:0 xy:0];
		[self setBackgroundColor:[CPColor blackColor]];

	    var emailLabel = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
	    [emailLabel setFont:[CPFont systemFontOfSize:14]];
	    [emailLabel setStringValue:"Email Address:"];
	    [emailLabel setTextColor:[CPColor whiteColor]];
	    [emailLabel sizeToFit];
	    [emailLabel setFrame:CGRectMake(30, 48, CGRectGetWidth([emailLabel bounds]), CGRectGetHeight([emailLabel bounds]))];

	    var passwordLabel = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
	    [passwordLabel setFont:[CPFont systemFontOfSize:14]];
	    [passwordLabel setStringValue:"Password:"];
	    [passwordLabel setTextColor:[CPColor whiteColor]];
	    [passwordLabel sizeToFit];
	    [passwordLabel setFrame:CGRectMake(60, 90, CGRectGetWidth([emailLabel bounds]), CGRectGetHeight([emailLabel bounds]))];
	
	    _userName = [[CPTextField alloc] initWithFrame:CGRectMake(150, 50, 200, 23  )];
	    [_userName setFont:[CPFont systemFontOfSize:14]];
	    [_userName setBezelStyle:CPTextFieldSquareBezel];
	    [_userName setBezeled:YES];
	    [_userName setEditable:YES];

	    _password = [[CPSecureTextField alloc] initWithFrame:CGRectMake(150, 90, 200, 23)];
	    [_password setFont:[CPFont systemFontOfSize:14]];
	    [_password setBezelStyle:CPTextFieldSquareBezel];
	    [_password setBezeled:YES];
	    [_password setEditable:YES];

	    _login = [[CPButton alloc] initWithFrame:CGRectMake(280, 140, 70, 20)];
	    [_login setTitle:"Login"];
	    //[_login setAction:@selector(loginButtonPressed)];
	    [_login setBezelStyle:CPHUDBezelStyle];

	    _forgot = [[CPButton alloc] initWithFrame:CGRectMake(200, 140, 70, 20)];
	    [_forgot setTitle:"Cancel"];
	    //[_forgot setAction:@selector(cancelButtonPressed)];
	    [_forgot setBezelStyle:CPHUDBezelStyle];

	    [self addSubview:emailLabel];
	    [self addSubview:_userName];
	    [self addSubview:passwordLabel];
	    [self addSubview:_password];

	    [self addSubview:_login];
	    [self addSubview:_forgot];
	}
	return self;
}

@end