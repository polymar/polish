@implementation JSONPDelegate : CPObject {
	
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
	[CPJSONPConnection connectionWithRequest:_req callback:"callback" delegate:self];
}

-(void)connection:(CPURLConnection)connection didReceiveResponse:(CPHTTPURLResponse)response {
	console.log('didReceiveResponse');
	[_delegate didReceiveResponse:response];
}

-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data {
	console.log('didReceiveData');
	if(data) {
		[_delegate didReceiveData:data];
	}
}

-(void)connectionDidFinishLoading:(CPURLConnection)connection {
	console.log('connectionDidFinishLoading');
	[_delegate didFinishLoading];
}

-(void)connection:(CPURLConnection)connection didFailWithError:(id)error {
	console.log('didFailWithError');
	console.log(error);
	[_delegate didFailWithError:error];
}

@end