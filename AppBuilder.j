/*
 * AppBuilder.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */
polish_components   =   ['stack', 'flow', 'ask_color', 'confirm', 'alert',
            'button', 'check', 'radio', 'slider', 'text', 'password', 'list_box', 'progress', 'link', 'edit_box', 'para',
            'image', 'video',
            'label', 'subtitle',
            'login', 'form', 'submit',
            'friend_collection', 'photo_collection'];

@implementation AppBuilder : CPObject {
  CPWindow    _mainWindow;
  CPView      _contentView;
}

- (id) init
{
  return [self initWithContentView: nil];
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

+(id) create:(id) attrs
{
  var win = [[self alloc] init];
  return [win create: attrs];
}
/*
* create the app and set the parameters.
*/
- (id) create:(CPObject) what, ... //keeping open for future.
{
    if (_mainWindow == nil)
    {
      _mainWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:(CPTitledWindowMask | CPClosableWindowMask | CPResizableWindowMask)];
      _contentView = [_mainWindow contentView];
      [_mainWindow orderFront:self];
    }

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

-(void) addChild:(id)aControl
{
  var view = objj_msgSend(aControl, 'view');
  if(view != nil)
    objj_msgSend( _contentView, 'addSubview:', view);
}

/*
* forward all the not implemented methods to polish factory class.
*/
- (id)forward:(SEL)aSelector :(marg_list)args {
  return [AppBuilder obj_create:aSelector :args :self];
}

+ (id) obj_create:(SEL)aSelector :(man_list)args :(id) parent {
  //just sanity check... not coming here coz of a wrong 'create' message.
  if ((aSelector == 'create:') || (aSelector == 'create')) {
    console.error('@#!Polish Error - Valid Syntax: app.create(json_params); ');
    return;
  }
  polish_control = [AppBuilder sanitize_selector:aSelector];
  //Object created.
  var s = [POFactory control: polish_control withArgs: args parent: parent];

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
