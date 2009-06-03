/*
 * POControl.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */


polish_methods    = [ 'color:', 'width:', 'height:', 'x:', 'y:', 'size:xy:', 'location:xy:'];

@implementation POControl : CPObject {
  id      __delegate;
  CPString  _name;
}
- (id)withControl:(CPString)aControl withArgs: (id)args
{
  var control = [self performSelector: aControl];

  [self applyMethods:args[0] onControl: control];

//      if(args.length > 1){
//        if(typeof args[1] == 'function')
//          s['afterInit'] = args[1]; //add the function to call after initializing the object.
//        else
//          console.warn('second argument is not a function');
//      }
  if(control.afterInit){
    control.afterInit();
  }

  return control;
}

- (id) applyMethods: (id)methodList onControl:(id)aControl
{
  for( var memb in methodList) {
      objj_msgSend(POControl , 'apply_method:to:with:', memb, aControl, methodList[memb] );
  }
}
/*
* creates a selector and apply to an object.
*/
+ (SEL) apply_method:(CPString) method_name to:(id) obj with:(CPObject) param {
  cString = method_name+=':';
  cSel = CPSelectorFromString(cString);
  objj_msgSend(obj , cSel , param);
}


- (id) init {
  self = [super init];
  if(self) {
    [self createJSMethods: polish_methods];
  }
  return self;
}
- (void) name:(CPString) n {
  if(n != undefined)
    _name = n;
  else
    return _name;
}

- (CPString) name {
  return _name;
}

- (void) addSubview:(CPView) v {
  [__delegate addSubview:v];
}

- (id) view {
  return __delegate;
}

- (void) size:xxx xy:yyy {
  [self width:xxx height:yyy];
}

- (void) location:xxx xy:yyy {
  [self hmargin:xxx vmargin:yyy];
}

- (void) x:(CGFloat) f {
  if(f != undefined) {
    [self hmargin:f];
  } else {
    return [__delegate frame].origin.x;
  }
}

- (void) y:(CGFloat) f {
  if(f != undefined) {
    [self vmargin:f];
  } else {
    return [__delegate frame].origin.y;
  }
}

/*
* Forces the content of the view to redraw.
*/
- (void) display {
  [__delegate setNeedsDisplayInRect:[__delegate frame]];
}

- (void) color:(id) colorName {
  if (colorName.isa.name == 'CPColor') {
  [__delegate setBackgroundColor:colorName];
  return;
  }
  if (colorName.isa.name == 'POColor') {
  [__delegate setBackgroundColor:[colorName color]];
  return;
  }
  c = [POColor colorWithName:colorName];
  if(c != nil)
    [__delegate setBackgroundColor:c];
  else
    console.log(color + ' is not a supported color.');
}

- (void) width:(CGFloat) xxx height:(CGFloat) yyy {
  var f = [__delegate frame];
  [__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, yyy)];
}

- (void) hmargin:(CGFloat) xxx vmargin:(CGFloat) yyy {
    var f = [__delegate frame];
  [__delegate setFrame:CGRectMake(xxx, yyy, f.size.width, f.size.height)];
}

/*
* this are boring but they get handy when performing selectors created from parameters list.
*/
- (void) width:(float) xxx {
    var f = [__delegate frame];
  if(xxx != undefined) {
      [__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, f.size.height)];
  } else {
    return f.size.width;
  }
}

- (void) height:(CGFloat) xxx {
    var f = [__delegate frame];
  if(xxx != undefined) {
      [__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, xxx)];
  } else {
    return f.size.height;
  }
}

- (void) hmargin:(CGFloat) xxx {
    f = [__delegate frame];
    [__delegate setFrame:CGRectMake(xxx, f.origin.y, f.size.width, f.size.height)];
}

- (void) vmargin:(CGFloat) xxx {
    f = [__delegate frame];
    [__delegate setFrame:CGRectMake(f.origin.x, xxx, f.size.width, f.size.height)];
}

/*
* forward the missing method to embedded object.
*/
- (id)forward:(SEL)aSelector :(marg_list)args
{
  return [AppBuilder obj_create:aSelector :args :self];
}

@end
