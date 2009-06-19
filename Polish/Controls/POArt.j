@implementation POArt: CPView
{
  (id) __parent;
  (id) obj;
}

-(void) drawRect:(CPRect)aRect
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
  //  CGContextSetLineWidth(1.0);
  //  [[CPColor blackColor] set];
  [obj stroke];
  [obj fill];
}

-(void) setBrush
{
  if(parent.__stroke)
    [[CPColor redColor] setStroke];
  if(parent.__fill)
    [[CPColor blackColor] setFill];
  if(parent.__strokewidth)
    CGContextSetLineWidth(1.0);
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
  [obj appendBezierPathWithOvalInRect:rect];
}

+(id) artMethods
{
  return ['oval:'];
}

@end

