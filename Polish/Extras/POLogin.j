/*
 * POLogin.j
 *
 * Created by Roberto Gamboni on 02/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POLogin : POForm {
	
	var		_loginType;
	
	var		_on_forgot;
}

- (id) login {
	self = [super init];
	if(self) {
		__delegate = [[CPLogin alloc] login];
		[self createJSMethods: ['on_forgot:', 'login_type:']];
		[self initForm];
	}
	return self;
}

- (id) view {
	if(_loginType == undefined) {
		_loginType = 'classic';
		objj_msgSend(__delegate, 'setClassicViewType');
	}
	return __delegate;
}

- (void) login_type:(CPString) t {
	if(t != undefined) {
		if(t == 'classic') {
			if(_loginType != 'classic') {
				objj_msgSend(__delegate, 'setClassicViewType');
				_loginType = 'classic';
			}
		} else if(t == 'horizontal'){
			if(_loginType != 'horizontal') {
				objj_msgSend(__delegate, 'setHorizontalViewType');
				_loginType = 'horizontal';
			}
		}
	}
}

- (void) on_forgot:(Function) aFunction {
	_on_forgot = aFunction;
}

- (void) didPressForgot {
	if(_on_forgot) {
		_on_forgot();
	}
}

@end 

@implementation CPLogin : CPView {
	
	id 					_delegate;
	
	CPTextField			_title;
	CPTextField 		_userName;
	CPSecureTextField 	_password;
	CPButton 			_login;
	CPButton			_forgot;
	
	CPString 			_forgotUrl;
}

- (void) setDelegate:(id) del {
	_delegate = del;
}

- (void) setClassicViewType {
	[self setFrame:CGRectMake(0,0,400,150)];
	_title = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
	[_title setFont:[CPFont systemFontOfSize:16]];
    [_title setBezelStyle:CPTextFieldSquareBezel];
	[_title setTextColor:[CPColor whiteColor]];
	[_title setStringValue:"Credentials here"];
    [_title setEditable:NO];
	[_title sizeToFit];
	[_title setFrame:CGRectMake(200 - ([_title bounds].size.width / 2), 5, CGRectGetWidth([_title bounds]), CGRectGetHeight([_title bounds]))]

    var emailLabel = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
    [emailLabel setFont:[CPFont systemFontOfSize:14]];
    [emailLabel setStringValue:"Email Address:"];
    [emailLabel setTextColor:[CPColor whiteColor]];
    [emailLabel sizeToFit];
    [emailLabel setFrame:CGRectMake(30, 36, CGRectGetWidth([emailLabel bounds]), CGRectGetHeight([emailLabel bounds]))];

    var passwordLabel = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
    [passwordLabel setFont:[CPFont systemFontOfSize:14]];
    [passwordLabel setStringValue:"Password:"];
    [passwordLabel setTextColor:[CPColor whiteColor]];
    [passwordLabel sizeToFit];
    [passwordLabel setFrame:CGRectMake(60, 76, CGRectGetWidth([emailLabel bounds]), CGRectGetHeight([emailLabel bounds]))];

    _userName = [[CPTextField alloc] initWithFrame:CGRectMake(160, 30, 200, 30  )];
    [_userName setFont:[CPFont systemFontOfSize:14]];
    [_userName setBezelStyle:CPTextFieldSquareBezel];
    [_userName setBezeled:YES];
    [_userName setEditable:YES];

    _password = [[CPSecureTextField alloc] initWithFrame:CGRectMake(160, 70, 200, 30)];
    [_password setFont:[CPFont systemFontOfSize:14]];
    [_password setBezelStyle:CPTextFieldSquareBezel];
    [_password setBezeled:YES];
    [_password setEditable:YES];

    _login = [[CPButton alloc] initWithFrame:CGRectMake(265, 120, 110, 24)];
    [_login setTitle:"Login"];
    [_login setTarget:self];
    [_login setAction:@selector(loginButtonPressed:)];
    [_login setBezelStyle:CPHUDBezelStyle];

    _forgot = [[CPButton alloc] initWithFrame:CGRectMake(145, 120, 110, 24)];
    [_forgot setTitle:"Forgot Password"];
    [_forgot setTarget:self];
    [_forgot setAction:@selector(cancelButtonPressed:)];
    [_forgot setBezelStyle:CPHUDBezelStyle];

	[self addSubview:_title];
    [self addSubview:emailLabel];
    [self addSubview:_userName];
    [self addSubview:passwordLabel];
    [self addSubview:_password];

    [self addSubview:_login];
    [self addSubview:_forgot];
}

- (void) setHorizontalViewType {
	[self setFrame:CGRectMake(0,0,600,60)];
	
	_userName = [[CPTextField alloc] initWithFrame:CGRectMake(10, 10, 260, 30 )];
    [_userName setFont:[CPFont systemFontOfSize:14]];
    [_userName setBezelStyle:CPTextFieldSquareBezel];
	[_userName setPlaceholderString:'Insert username'];
    [_userName setBezeled:YES];
    [_userName setEditable:YES];

    _password = [[CPSecureTextField alloc] initWithFrame:CGRectMake(280, 10, 260, 30)];
    [_password setFont:[CPFont systemFontOfSize:14]];
    [_password setBezelStyle:CPTextFieldSquareBezel];
	[_password setPlaceholderString:'Insert password'];
    [_password setBezeled:YES];
    [_password setEditable:YES];

    _login = [[CPButton alloc] initWithFrame:CGRectMake(565, 14, 80, 24)];
    [_login setTitle:"Login"];
    [_login setTarget:self];
    [_login setAction:@selector(loginButtonPressed:)];
    [_login setBezelStyle:CPHUDBezelStyle];

	[self addSubview:_userName];
    [self addSubview:_password];

    [self addSubview:_login];
}

/*
* Init a form with hmargin and vmargin = 0;
*/
- (id) login {
	self = [super initWithFrame:CGRectMakeZero()];
	if(self) {
		[self setBackgroundColor:[CPColor blackColor]];
	}
	return self;
}

- (void) loginButtonPressed:(id) sender {
	if(_delegate) {
		objj_msgSend(_delegate, 'didSubmit:');
	}
}

- (void) cancelButtonPressed:(id) sender {
	if(_delegate) {
		objj_msgSend(_delegate, 'didPressForgot');
	}
}

@end