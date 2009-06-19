@import <AppKit/CPBezierPath.j>
@implementation POArt: CPView
{
  (id) __parent;
  (id) __stroke;
  (id) __fill;
  (id) __strokewidth;
  (id) obj;
}

-(void) drawRect:(CPRect)aRect
{
  [self setBrush];
  [obj stroke];
  [obj fill];
}

-(void) setBrush
{
  if(__stroke)
    objj_msgSend(__stroke.__delegate,  'setStroke');
  if(__fill)
    objj_msgSend(__fill.__delegate,  'setFill');
  if(__strokewidth)
    objj_msgSend(obj, 'setLineWidth:', __strokewidth);

}

-(id) initWithParent:(id) aParent
{
  self = [super init];
  __parent = aParent;
  var __stroke = __parent.__stroke;
  var __fill = __parent.__fill;
  var __strokewidth = __parent.__strokewidth;
  return self;
}

-(id) oval:(id) params
{
  if(params['radius']){
    params['width'] = 2 * params['radius'];
    params['height'] = 2 * params['radius'];
  }
  var rect = CGRectMake(params['left'], params['top'], params['width'], params['height']);
  [self setFrame:rect];
  obj = [CPBezierPath  bezierPath];
  [obj appendBezierPathWithOvalInRect:[self frameSizeAfterStroke]];
}

-(id)frameSizeAfterStroke
{
  var sw = __parent.__strokewidth;
  var fr = [self frame];
  return CGRectMake(sw / 2.0, sw / 2.0, fr.size.width - sw, fr.size.height -   sw);
}
-(id) rect:(id) params
{
  var rect = CGRectMake(params['left'], params['top'], params['width'] , params['height']);
  [self setFrame:rect];
  obj = [CPBezierPath  bezierPath];
  if(params['curve'])
    [obj appendBezierPathWithRoundedRect:[self frameSizeAfterStroke] xRadius: params['curve'] yRadius:params['curve']];
  else
    [obj appendBezierPathWithRect:[self frameSizeAfterStroke]];
}

+(id) artMethods
{
  return ['oval:', 'rect:'];
}

@end

