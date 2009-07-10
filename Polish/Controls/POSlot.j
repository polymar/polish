@implementation POSlot: POControl
{
  var __stroke;
  var __fill;
  var __strokewidth;
}
-(id)init
{
  self = [super init];
  var meths = ['stroke:', 'strokewidth:', 'fill:'];
  [self createJSMethods: meths];
  return self;
}
-(id) createArtMethods
{
  var methods = [POArt artMethods];
  for(var i=0 ; i <  methods.length; i++)
  {
    var method = methods[i].split(':').shift();
    eval("self." + method + " = function(){ return objj_msgSend(self, 'callArt:withParams:', '" + methods[i] + "', arguments); };");
  }
}

-(id) callArt:(id)method withParams:(id)params
{
  var arguments_str = "";
  for(var j=0; j < params.length; j++)
    arguments_str = arguments_str + ', params[' + j + ']';
  var viewObj = [[POArt alloc] initWithParent: self];
  eval("objj_msgSend(viewObj, '" + method +"' " + arguments_str + ");");
  [__delegate addSubview: viewObj];
  return viewObj;
}

-(void) stroke:(id) aColor
{
  __stroke = aColor;
}

-(void) fill:(id) aFillColor
{
  __fill = aFillColor;
}

-(void) strokewidth:(id) aWidth
{
  __strokewidth = aWidth;
}

@end
