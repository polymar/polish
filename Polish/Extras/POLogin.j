/*
 * POLogin.j
 *
 * Created by Roberto Gamboni on 02/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

	
_keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

// public method for encoding
encode = function (input) {
	var output = "";
	var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
	var i = 0;

	input = _utf8_encode(input);

	while (i < input.length) {

		chr1 = input.charCodeAt(i++);
		chr2 = input.charCodeAt(i++);
		chr3 = input.charCodeAt(i++);

		enc1 = chr1 >> 2;
		enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		enc4 = chr3 & 63;

		if (isNaN(chr2)) {
			enc3 = enc4 = 64;
		} else if (isNaN(chr3)) {
			enc4 = 64;
		}

		output = output +
		_keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
		_keyStr.charAt(enc3) + _keyStr.charAt(enc4);

	}

	return output;
}

// private method for UTF-8 encoding
_utf8_encode = function (string) {
	string = string.replace(/\r\n/g,"\n");
	var utftext = "";

	for (var n = 0; n < string.length; n++) {

		var c = string.charCodeAt(n);

		if (c < 128) {
			utftext += String.fromCharCode(c);
		}
		else if((c > 127) && (c < 2048)) {
			utftext += String.fromCharCode((c >> 6) | 192);
			utftext += String.fromCharCode((c & 63) | 128);
		}
		else {
			utftext += String.fromCharCode((c >> 12) | 224);
			utftext += String.fromCharCode(((c >> 6) & 63) | 128);
			utftext += String.fromCharCode((c & 63) | 128);
		}

	}

	return utftext;
}


BASIC_AUTH = "basic";

@implementation POLogin : POForm {
	
	var		_loginType;
	var		_on_forgot;
	var 	_auth_type;
}

- (id) login {
	self = [super init];
	if(self) {
		__delegate = [[CPLogin alloc] login];
		_auth_type = BASIC_AUTH;
		_preprocess = function() {
			var u = objj_msgSend(__delegate, 'getUsername');
			var p = objj_msgSend(__delegate, 'getPassword');
			if(u == '' || p == '') {
				return false;
			}
			return true;
		};
 		[self createJSMethods: ['on_forgot:', 'login_type:', 'auth_type:']];
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

- (CPURLRequest) generateRequest {
	if(_action == undefined) {
		console.log('unable to submit a form without action');
		return nil;
	}
	//GET -> creating tag0=value0?tag1=value1
	if(_method == 'GET') {
		var request = [CPURLRequest requestWithURL:_action];
		var u = [__delegate getUsername];
		var p = [__delegate getPassword];
		var auth = [CPString stringWithFormat:@"%s:%s", u,p];
		var base64auth = [CPString stringWithFormat:@"Basic %s", encode(auth)];
		[request setHTTPMethod:"GET"];
		[request setValue:base64auth forHTTPHeaderField:"Authentication"];
		return request;
	} 
	//POST/PUT -> creating application/x-www-form-urlencoded or multipart/form-data
	else {
		if(_enctype == 'x-www-form-urlencoded') {
			//TODO
		} else {
			//TODO
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

- (CPString) getUsername {
	return [_userName stringValue];
}

- (CPString) getPassword {
	return [_password stringValue];
}

@end