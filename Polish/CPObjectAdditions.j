/*
 * CPObjectAdditions.j
 *
 * Created by Roberto Gamboni on 02/21/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation CPObject (Polish)

- (void) createJSMethods:(CPArray) methods {
    for(var i=0; i < methods.length ; i++){
      method_call = [self constructJSMethod:methods[i]];
      eval(method_call);
    }
}

- (void) createForwardJSMethods:(CPArray) methods {
  for(var i=0; i < methods.length ; i++){
    method_name = methods[i].split(':').shift();
      method_call = "self."+method_name + " = function() { console.debug( "+ method_name + " ); return objj_msgSend(self, 'forward::', '"+  method_name  +"', arguments); }";
      eval(method_call);
    }
}

- (String) constructJSMethod: (String)method {
    var method_frags = method.split(':');
    var method_sig = method_frags.shift();
    var parameters = new Array();
    for(var i=0; i < method_frags.length; i++){
      parameters[i] = '__argument' + i;
    }
    var joined_params = parameters.join(",");
    var objj_params = (joined_params == '')?'':(', ' + joined_params);
  return "self." + method_sig + " = " + "function( " + joined_params +" ){ return objj_msgSend( self,  '" + method + "' " + objj_params + ");}";
}

@end
