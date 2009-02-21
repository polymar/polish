/*
 * CPViewAdditions.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPView.j>
@import "POColor.j"
@import "../AppBuilder.j"

@implementation CPView (Polish)

- (id) init {
 self =  [self initWithFrame:CGRectMakeZero()];
 self.polish_methods =  [ 'test', 'test1:', 'test2:second:'];

 [self createJSMethods: self.polish_methods];

 return self;
}

- (void) createJSMethods:(CPArray) methods {
  for(var i=0; i < methods.length ; i++){
    method_call = [self constructJSMethod:methods[i]];
    console.log(method_call);
    eval(method_call);
  }
}

- (String) constructJSMethod: (String)method{
  method_frags = method.split(':');
  method_sig = method_frags.shift();
  parameters = new Array();
  for(var i=0; i < method_frags.length; i++){
    parameters[i] = 'yyyyyy' + i;
  }
  joined_params = parameters.join(",");
  objj_params = (joined_params == '')?'':(', ' + joined_params);
  return "self." + method_sig + " = " + "function( " + joined_params +" ){ objj_msgSend( self,  '" + method + "' " + objj_params + ");}";
}

- (void) test{
  console.log("In test()");
}
- (void) test1: (id) attrs{
  console.log("In test1()");
}

- (void) test2: (id) first second: (id) second {
  console.log("In test2()");
}

/*
* Forces the content of the view to redraw.
*/
- (void) display {
  [self setNeedsDisplayInRect:[self frame]];
}

- (void) bkg_color:(CPColor) color {
  [self setBackgroundColor:color];
}

- (void) color:(CPString) colorName {
  c = [POColor color:colorName];
  if(c != nil)
    [self setBackgroundColor:c];
  else
    console.log(color + ' is not a supported color.');
}

- (void) width:(CGFloat) w height:(CGFloat) h {
  f = [self frame];
  [self setFrame:CGRectMake(f.origin.x, f.origin.y, w, h)];
}

- (void) hmargin:(CGFloat) hmargin vmargin:(CGFloat) vmargin {
  f = [self frame];
  [self setFrame:CGRectMake(hmargin, vmargin, f.size.width, f.size.height)];
}

- (void) frame:(CGRect) frame {
  [self setFrame:frame];
}

/*
* this are boring but they get handy when performing selectors created from parameters list.
*/
- (void) width:(CGFloat) width {
  var f = [self frame];
  [self setFrame:CGRectMake(f.origin.x, f.origin.y, width, f.size.height)];
}

- (void) height:(CGFloat) height {
  var f = [self frame];
  [self setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, height)];
}

- (void) hmargin:(CGFloat) hmargin {
  f = [self frame];
  [self setFrame:CGRectMake(hmargin, f.origin.y, f.size.width, f.size.height)];
}

- (void) vmargin:(CGFloat) vmargin {
  f = [self frame];
  [self setFrame:CGRectMake(f.origin.x, vmargin, f.size.width, f.size.height)];
}

/*
* forward the missing method to polish core.
* any view can create any object and add it to itself!!
*/
- (id)forward:(SEL)aSelector :(marg_list)args
{
  return [AppBuilder obj_create:aSelector :args :self];
}

@end
