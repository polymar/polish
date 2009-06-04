/*
 * POForm.j
 *
 * Created by Roberto Gamboni on 02/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POForm : POControl {
	
	CPString 	_action;
	CPString 	_method;
	CPString	_enctype;

	//function performed before submitting the form.
	var 		_preprocess;
	//function performed after submitting the form.
	var			_postprocess;
	//function performed in case of error.
	var			_form_error;
	
	var			_children;
	
	//FIX THIS - now this is specific for JSON API
	//CPURLConnection		_connection;
	CPJSONPConnection 		_connection;
}

/*
* Init a form with hmargin and vmargin = 0;
*/
- (id) form {
	self = [super init];
	if(self) {
		__delegate = [[CPForm alloc] init];
		[self createForwardJSMethods: polish_components];
		[self initForm];
	}
	return self;
}

- (void) initForm {
	[self createJSMethods:['action:', 'enctype:', 'pre:', 'post:', 'form_error:', 'http_method:']];
	_children = [];
	objj_msgSend(__delegate, 'setDelegate:', self);
	_method = 'GET';
	_enctype = 'TEXT/PLAIN';
}

- (void) addChild:(POControl) child {
	[super addChild:child];
	_children.push(child);
}

- (void) didSubmit:(id) sender {
	if(_preprocess != undefined) {
		var t = _preprocess();
		if(t == false) {
			return;
		}
	}
	if(_connection) {
		[_connection cancel];	
	}
	var req = [self generateRequest];
	if(req != nil) {
		_connection = [CPJSONPConnection connectionWithRequest:req callback:'callback' delegate:self];
	}
}

- (void)connection:(CPJSONPConnection)aConnection didReceiveData:(CPString)data {
	if(data) {
		if(_postprocess != undefined) {
			_postprocess(data);
		}
	}
}

- (void)connection:(CPJSONPConnection)aConnection didFailWithError:(CPString)error {
	if(_form_error != undefined) {
		_form_error(error);
	}
}

- (CPURLRequest) generateRequest {
	if(_action == undefined) {
		console.log('unable to submit a form without action');
		return nil;
	}
	//GET -> creating tag0=value0?tag1=value1
	if(_method == 'GET') {
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
	var index;
	var params = '';
	for(index = 0; index < _children.length; index++) {
		var el = _children[index];
		//FIXME kind of hack... need to identify which object are serializable.
		if([el class] != [POSubmit class]) {
			if(el.name() != '') {
				params += el.name() + '=' + el.value() + '&';
			}
		}
	}
	return params;
}

- (void) form_error:(Function)aFunction {
	_form_error = aFunction;
}

- (void) pre:(Function)aFunction {
	_preprocess = aFunction;
}

- (void) post:(Function)aFunction {
	_postprocess = aFunction;
}

- (void) http_method:(CPString) m {
	if(m != undefined) {
		_method = m;
	} else {
		return _method;
	}
}

- (void) action:(CPString) u {
	if(u != undefined) {
		_action = u;
	} else {
		return _action;
	}
}

- (void) enctype:(CPString) e {
	if(e != undefined) {
		_enctype = e;
	} else {
		return _enctype;
	}
}

@end

@implementation CPForm : CPView {
	
	var			_delegate;
	
}

- (void) setDelegate:(id) del {
	_delegate = del;
}

- (void) submit_form {
	if(_delegate != nil) {
		objj_msgSend(_delegate, 'didSubmit:', self);
	}
}

@end