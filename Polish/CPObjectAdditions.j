/*
 * CPObjectAdditions.j
 *
 * Created by Roberto Gamboni on 02/21/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation CPObject (Polish)

- (void) createJSMethods:(CPArray) methods withReceiver: (CPString)aReceiver{
    for(var i=0; i < methods.length ; i++){
      method_call = [self constructJSMethod:methods[i] withReceiver:aReceiver];
      eval(method_call);
    }
}

-(void) createJSMethods:(CPArray) methods
{
  [self createJSMethods:methods withReceiver: "self"];
}

- (void) createForwardJSMethods:(CPArray) methods {
  for(var i=0; i < methods.length ; i++){
    method_name = methods[i].split(':').shift();
      method_call = "self."+method_name + " = function() { return objj_msgSend(self, 'forward::', '"+  method_name  +"', arguments); }";
      eval(method_call);
    }
}

- (String) constructJSMethod: (CPString)method withReceiver:(CPString)aReceiver {
    var method_frags = method.split(':');
    var method_sig = method_frags.shift();
    var parameters = new Array();
    for(var i=0; i < method_frags.length; i++){
      parameters[i] = '__argument' + i;
    }
    var joined_params = parameters.join(",");
    var objj_params = (joined_params == '')?'':(', ' + joined_params);
  return  "self." + method_sig + " = " + "function( " + joined_params +" ){ return objj_msgSend( " + aReceiver + ",  '" + method + "' " + objj_params + ");}";
}

@end
