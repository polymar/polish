function visit(_url) {
	window.open(_url);
}

function download(_url, _aFunction1, _aFunction2) {
	objj_msgSend( POUrl, 'invokeAtURL:callback:error:', _url, _aFunction1, _aFunction2);
}

function do_post(_url, _body, _aFunction1, _aFunction2) {
	objj_msgSend( POUrl, 'postAtURL:body:callback:error:', _url, _body, _aFunction1, _aFunction2);
}

@implementation POUrl : CPObject {
	
	var		_callback_function;
	var		_error_function;
	
	var		_connection_delegate;
	
} 

+ (void) postAtURL:(CPString) _url body:_b callback:_function1 error:_function2 {
	var _poUrl = [[POUrl alloc] initWithCallback:_function1 error:_function2];
	[_poUrl post:_b at:_url];
}

+ (void) invokeAtURL:(CPString) _url callback:_function1 error:_function2 {
	var _poUrl = [[POUrl alloc] initWithCallback:_function1 error:_function2];
	[_poUrl invoke:_url];
}

- (id) initWithCallback:_aFunction1 error:_aFunction2 {
	self = [super init];
	if(self) {
		_callback_function = _aFunction1;
		_error_function = _aFunction2;
	}
	return self;
}

- (void) post:(CPString) b at:u {
	var request = [CPURLRequest requestWithURL:u];
	[request setHTTPMethod:'POST'];
	[request setHTTPBody:encodeURI(b)];
	[request setValue:"application/x-www-form-urlencoded" forHTTPHeaderField:"Content-Type"];
	
	_connection_delegate = [[URLDelegate alloc] initWithDelegate:self];
	[_connection_delegate startRequest:request];
}

- (void) invoke:(CPString) u {
	var request = [CPURLRequest requestWithURL:u];
	var _conn_type = u.search('localhost');
	if(_conn_type == -1) {
		_connection_delegate = [[JSONPDelegate alloc] initWithDelegate:self];
	} else {
		_connection_delegate = [[URLDelegate alloc] initWithDelegate:self];
	}
	[_connection_delegate startRequest:request];
}

- (void) didReceiveResponse:(CPHTTPURLResponse)resp {
	
}

- (void) didFailWithError:(CPString) error {
	if(_error_function != undefined) {
		_error_function(error);
	}
}

- (void) didReceiveData:(CPString) data {
	if(_callback_function != undefined) {
		_callback_function(data);
	}
}

- (void) didFinishLoading {
	
}

@end