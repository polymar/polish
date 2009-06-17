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

@end