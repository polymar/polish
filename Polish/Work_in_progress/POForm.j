/*
 * POForm.j
 *
 * Created by Roberto Gamboni on 02/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POForm : POStack {
	CPString 	_action;
	CPString 	_method;
	CPString	_enctype;
	CPString	_result;
	
	//function performed before submitting the form.
	var 		_preprocess;
	//function performed after submitting the form.
	var			_postprocess;
	
	CPJSONPConnection connection;
}

/*
* Init a form with hmargin and vmargin = 0;
*/
- (id) form {
	self = [super create];
	if(self) {
		[self createJSMethods:['action:', 'enctype:', 'pre:', 'post:', 'http_method:', 'result']];
		_method = 'GET';
		_enctype = 'TEXT/PLAIN'
	}
	return self;
}

- (void) pre:(Function)aFunction {
	if(aFunction != undefined)
		_preprocess = aFunction;
}

- (void) post:(Function)aFunction {
	if(aFunction != undefined)
		_postprocess = aFunction;
}

- (CPString) result {
	return _result;
}

- (CPString) http_method:(CPString) m {
	if(m != undefined)
		_method = m;
	else
		return _method;
}

- (CPString) action:(CPString) u {
	if(u != undefined)
		_action = u;
	else
		return _action;
}

- (CPString) enctype:(CPString) e {
	if(e != undefined)
		_enctype = e;
	else
		return _enctype;
}


- (void) submit_form {
	//preprocessing
	if(_preprocess != undefined) {
		var test = _preprocess.call();
		if(test == false) {
			//preprocess failed.
			return;
		}
	}
		
	//submit the form
	if(connection)
		[connection cancel];
	connection = [CPJSONPConnection connectionWithRequest:[self generateRequest] callback:@"callback" delegate:self];
}

- (CPURLRequest) generateRequest {
	//GET -> creating tag0=value0?tag1=value1
	if(self.http_method() == 'GET') {
		var query = [self generateParams];
		var url = [CPString stringWithFormat:@"%s?%s", _action, encodeURI(query)];
		var request = [CPURLRequest requestWithURL:url];
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

- (CPString) generateParams {
	var elements = [self subviews];
	var index;
	var params = '';
	for(index = 0; index < elements.length; index++) {
		var el = elements[index];
		//FIXME kind of hack... need to identify which object are serializable.
		if([el class] != [POSubmit class]) {
			if(el.name() != '') {
				params += el.name() + '=' + el.value() + '?';
			}
		}
	}
	return params;
}

- (void)connection:(CPJSONPConnection)aConnection didReceiveData:(CPString)data
{
	if(data) {
		_result = data;
		if(_postprocess != undefined) {
			_postprocess.call();
		}
	}
}

- (void)connection:(CPJSONPConnection)aConnection didFailWithError:(CPString)error
{
	alert(error);
}

@end