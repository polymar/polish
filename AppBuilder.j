/*
 * AppBuilder.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */
polish_components   =   ['stack', 'button', 'text', 'progress', 'image', 'video', 'label', 'login', 'form', 'submit', 'friend', 'friend_collection'];

@implementation AppBuilder : CPObject {
  CPWindow    _mainWindow;
  CPView      _contentView;
}

- (id) initWithContentView:(CPWindow) mainWindow {
  self = [super init];
  if(self) {
    [self createJSMethods: ['create:']];
    [self createForwardJSMethods: polish_components];
    _mainWindow = mainWindow;
    _contentView = [_mainWindow contentView];
  }
  return self;
}

/*
* create the app and set the parameters.
*/
- (id) create:(CPObject) what, ... //keeping open for future.
{
  for( var memb in what ) {
    objj_msgSend(AppBuilder , 'apply_method:to:with:', memb, _mainWindow, eval('what.'+memb) );
  }
  if(arguments.length > 3) {
    console.warn('@#!Polish Warning - Variable parameters list not supported yet.');
  }
  //force the _mainWindow to redraw the content.
  objj_msgSend(_mainWindow , 'display');
  return self;
}

/*
* forward all the not implemented method to polish factory class.
*/
- (id)forward:(SEL)aSelector :(marg_list)args {
  return [AppBuilder obj_create:aSelector :args :_contentView];
}

+ (id) obj_create:(SEL)aSelector :(man_list)args :(id) parent {
  //just sanity check... not coming here coz of a wrong 'create' message.
  if ((aSelector == 'create:') || (aSelector == 'create')) {
    console.error('@#!Polish Error - Valid Syntax: app.create(json_params); ');
    return;
  }
  polish_selector = objj_msgSend(AppBuilder, 'sanitize_selector:' , aSelector);
  var s = objj_msgSend(POFactory, polish_selector);
  if(s != nil) {
    if(args.length > 2) {
      console.warn('@#!Polish Warning - Variable parameters list not supported yet.');
    }
    if(args.length > 0) {
      var p_list = args[0];

      if(args.length > 1){
        if(typeof args[1] == 'function')
          s['afterInit'] = args[1]; //add the function to call after initializing the object.
        else
          console.warn('second argument is not a function');
      }
      for( var memb in p_list) {
        objj_msgSend(AppBuilder , 'apply_method:to:with:', memb, s, eval('p_list.'+memb) );
      }
      if(s.afterInit){
        s.afterInit();
      }
    }
    objj_msgSend( parent, 'addSubview:', objj_msgSend(s, 'view'));
  }
  return s;
}

/*
* sanitize the selector, removing the colon ':' from the selector name.
* removes only the last colon, if present.
*/

+ (SEL) sanitize_selector:(SEL) aSelector {
  return aSelector.split(':').shift();
}

/*
* creates a selector and apply to an object.
*/
+ (SEL) apply_method:(CPString) method_name to:(id) obj with:(CPObject) param {
  cString = method_name+=':';
  cSel = CPSelectorFromString(cString);
  objj_msgSend(obj , cSel , param);
}

@end
