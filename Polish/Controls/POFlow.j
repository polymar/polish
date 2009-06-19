/*
 * POStack.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POFlow : POSlot {
  id members;
  id marginY;
  id marginX;
  // need to maintain this since x,y of a child can be changed.
  id lastX;
  id lastY;
  id currentRowHeight;
}

/*
* Init a flow with hmargin and vmargin = 0;
*/
- (id) flow {
  members = [];
  marginY = 10;
  marginX = 10;
  currentRowHeight = 0;
  currentRowWidth = 0;
  self = [super init];
  if(self) {
    __delegate = [[CPView alloc] initWithFrame:CGRectMakeZero()];
    [self createForwardJSMethods: polish_components];
    [self createArtMethods];
  }
  return self;
}

-(void)marginX:(id) margin
{
  marginX = margin
}
-(void)marginY:(id) margin
{
  marginY = margin
}


- (void) addChild:(POControl) child {
  if([child isKindOfClass:POControl]) {
    [self addSubview:[child view]];
  }
  [self place: child];
}

- (void) place:(id)aChild
{
  //First one.
  if(members.length == 0)
    {
      lastX = marginX;
      lastY = marginY;
    } else
    {
      var lastMember = members[members.length - 1];

      lastX = lastX + lastMember.width() + marginX;
      currentRowHeight = (currentRowHeight > aChild.height())?currentRowHeight:aChild.height();
      if((self.width() - (lastX + aChild.width())) < 0)
      {
        lastX = marginX;
        lastY = lastY + currentRowHeight + marginY;
      }
    }
  //console.log("X : " + lastX + "Y : " + lastY);
  aChild.x(lastX);
  aChild.y(lastY);
  members.push(aChild);
}

//- (void) redraw
//{
//  var membersClone = members;
//  members = [];
//  membersClone.each { |member| [self addChild: member] }
//}
//
//- (void) removeChild: aChild
//{
//  membersRemove;
//  redraw
//}
@end
