@implementation POArt: CPView
{
  (id) __parent;
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
  var st = __parent.__stroke;
  var fl = __parent.__fill;
  var sw = __parent.__strokewidth;
  if(st)
    objj_msgSend(st.__delegate,  'setStroke');
  if(fl)
    objj_msgSend(fl.__delegate,  'setFill');
  if(sw)
    objj_msgSend(obj, 'setLineWidth:', sw);
}

-(id) initWithParent:(id) aParent
{
  self = [super init];
  __parent = aParent;
  return self;
}

-(id) oval:(id) params
{
  var rect = CGRectMake(params['left'], params['top'], params['width'], params['height']);
  [self setFrame:rect];
  obj = [CPBezierPath  bezierPath];
  [obj appendBezierPathWithOvalInRect:[self frameSizeAfterStroke]];
}

-(id)frameSizeAfterStroke
{
  var sw = __parent.__strokewidth;
  var fr = [self frame];
  return CGRectMake(fr.origin.x, fr.origin.y, fr.size.width - 2 * sw, fr.size.height - 2 * sw);
}
-(id) rect:(id) params
{
  var rect = CGRectMake(params['left'], params['top'], params['width'] , params['height']);
  [self setFrame:rect];
  obj = [CPBezierPath  bezierPath];
  if(params['curve'])
    [obj appendBezierPathWithRoundedRect:[self frameSizeAfterStroke] xRadius: params['curve'] yRadius:params['curve']];
  else
    [obj appendBezierPathWithRect:rect];
}

+(id) artMethods
{
  return ['oval:', 'rect:'];
}

@end

