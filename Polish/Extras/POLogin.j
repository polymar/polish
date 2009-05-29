/*
 * POLogin.j
 *
 * Created by Roberto Gamboni on 02/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POLogin : POControl {
	
}

- (id) login {
	self = [super init];
	if(self) {
		__delegate = [[CPLogin alloc] login];
	}
	return self;
}

@end 

@implementation CPLogin : CPView {
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
	self = [super initWithFrame:CGRectMake(0,0,400,180)];
	if(self) {
		[self setBackgroundColor:[CPColor blackColor]];

	    var emailLabel = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
	    [emailLabel setFont:[CPFont systemFontOfSize:14]];
	    [emailLabel setStringValue:"Email Address:"];
	    [emailLabel setTextColor:[CPColor whiteColor]];
	    [emailLabel sizeToFit];
	    [emailLabel setFrame:CGRectMake(30, 56, CGRectGetWidth([emailLabel bounds]), CGRectGetHeight([emailLabel bounds]))];

	    var passwordLabel = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
	    [passwordLabel setFont:[CPFont systemFontOfSize:14]];
	    [passwordLabel setStringValue:"Password:"];
	    [passwordLabel setTextColor:[CPColor whiteColor]];
	    [passwordLabel sizeToFit];
	    [passwordLabel setFrame:CGRectMake(60, 96, CGRectGetWidth([emailLabel bounds]), CGRectGetHeight([emailLabel bounds]))];
	
	    _userName = [[CPTextField alloc] initWithFrame:CGRectMake(160, 50, 200, 30  )];
	    [_userName setFont:[CPFont systemFontOfSize:14]];
	    [_userName setBezelStyle:CPTextFieldSquareBezel];
	    [_userName setBezeled:YES];
	    [_userName setEditable:YES];

	    _password = [[CPSecureTextField alloc] initWithFrame:CGRectMake(160, 90, 200, 30)];
	    [_password setFont:[CPFont systemFontOfSize:14]];
	    [_password setBezelStyle:CPTextFieldSquareBezel];
	    [_password setBezeled:YES];
	    [_password setEditable:YES];

	    _login = [[CPButton alloc] initWithFrame:CGRectMake(265, 140, 110, 24)];
	    [_login setTitle:"Login"];
	    //[_login setAction:@selector(loginButtonPressed)];
	    [_login setBezelStyle:CPHUDBezelStyle];

	    _forgot = [[CPButton alloc] initWithFrame:CGRectMake(145, 140, 110, 24)];
	    [_forgot setTitle:"Forgot Password"];
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