/*
 * POControl.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */


polish_methods    = [ 'color:', 'width:', 'height:', 'x:', 'y:', 'size:xy:', 'location:xy:', 'name:', 'remove'];

@implementation POControl : CPObject {
  id      __delegate;
  id      __height;
  id      __width;
  CPString  _name;
}

- (id) control:(CPString)aControl withArgs: (id)args {
  self = [self performSelector: aControl];
    [self applyMethods:args[0] onControl: self];
    return self;
}

- (id) applyMethods: (id)methodList onControl:(id)aControl {
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

- (void) remove {
	if(__delegate) {
		[__delegate removeFromSuperview];
	}
	//TODO notify to parent of redrawing.
}

- (void) name:(CPString) n {
    if(n != undefined)
      _name = n;
    else {
      if(_name == undefined) {
        return __delegate.__address;
      } else {
          return _name;
      }
    }
}

- (void) addChild:(POControl) child {
  /*
  if([child isKindOfClass:CPView]) {
    [self addSubview:child];
    return;
  }
  */
  if([child isKindOfClass:POControl]) {
    [self addSubview:[child view]];
  }
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
  var c = [self sintetize_color:colorName];
  if(c != nil)
    [__delegate setBackgroundColor:c];
  else
    console.log(color + ' is not a supported color.');
}

- (CPColor) sintetize_color:(id) colorName {
  if (colorName.isa.name == 'CPColor') {
    return colorName;
  }
  if (colorName.isa.name == 'POColor') {
    return [colorName color];
  }
  return [POColor colorWithName:colorName];
}

- (void) width:(CGFloat) xxx height:(CGFloat) yyy {
  __width = xxx;
  __height = yyy;
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
  __width = xxx;
  var f = [__delegate frame];
  if(xxx != undefined) {
      [__delegate setFrame:CGRectMake(f.origin.x, f.origin.y, xxx, f.size.height)];
  } else {
    return f.size.width;
  }
}

- (void) height:(CGFloat) xxx {
  __height = xxx;
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
