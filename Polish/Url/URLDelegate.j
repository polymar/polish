var _auth;

@implementation URLDelegate : CPObject {
	
	var _delegate;
	
}

- (void) initWithDelegate:(id) d {
	self = [super init];
	if(self) {
		_delegate = d;
	}
	return self;
}

- (void) startRequest:(CPURLRequest) _req {
	var _req_auth = [_req valueForHTTPHeaderField:"Authorization"];
	if(_req_auth != nil) {
		_auth = _req_auth;
	}
	if(_auth != nil) {
		[_req setValue:_auth forHTTPHeaderField:"Authorization"];
	}
	console.log([_req valueForHTTPHeaderField:"Authorization"]);
	[CPURLConnection connectionWithRequest:_req delegate:self];
}

- (void)connection:(CPURLConnection)aConnection didReceiveData:(CPString)data {
	console.log('didReceiveData');
	if(data) {
		[_delegate didReceiveData:data];
	}
}

- (void)connection:(CPURLConnection)aConnection didFailWithError:(CPString)error {
	console.log('didFailWithError');
	[_delegate didFailWithError:error];
}

- (void)connectionDidReceiveAuthenticationChallenge:(id)connection {
	console.log('connectionDidReceiveAuthenticationChallenge');
	//considering authentication challenge as an error
	[_delegate didFailWithError:@"require authentication"];
}

@end