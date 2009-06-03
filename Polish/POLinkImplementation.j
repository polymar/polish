
@implementation POLinkImpl : CPControl
{
  CPString       _href;
  CPString       _text;
  DOMElement      FIXME_link;
  DOMElement        _LINK_TEXTElement;

  id              _delegate;

  CPScrollView    _scrollView;
  CPView          _contentView;

  JSObject        _existingSelectStart;

  BOOL            _alreadyFired;
}



+(id)withTextValue:(CPString)aText href:(CPString)aHref
{
  var link = [[POLinkImpl alloc] initWithFrame:CGRectMakeZero()];
  link._text = link._href = aHref;
  [link sizeToFit];

  //   console.debug(size);

   link.FIXME_link = document.createElement("a");

   link.FIXME_link.style.width  = "100%";
    link.FIXME_link.style.height = "100%";


    link.FIXME_link.style.position = "absolute";

    link.FIXME_link.style.left    = "0";
    link.FIXME_link.style.top     = "0";
    link.FIXME_link.style.border  = "0";
    link.FIXME_link.style.margin  = "0";
    link.FIXME_link.style.padding = "0";

    link.FIXME_link.style.backgroundColor = "rgb(245, 245, 245, 0)";
    //    link.FIXME_link.style.fontSize = "14px";
    //    link.FIXME_link.style.fontFamily = "Arial";

    link.FIXME_link.style.resize = "none";
    link.FIXME_link.style.outlineStyle = "none";
    link.FIXME_link.href = aHref;
    link.FIXME_link.target = '_blank';
    link._LINK_TEXTElement = document.createTextNode(aText);

    link.FIXME_link.appendChild(link._LINK_TEXTElement);
    link._DOMElement.appendChild(link.FIXME_link);


    return link;
}
-(void) sizeToFit
{
  var size = [(_text || " ") sizeWithFont:[self currentValueForThemeAttribute:@"font"]];
  [self setFrameSize:CGSizeMake(size.width + (16.0 * size.width/100.0), size.height + 6)];
  console.debug(size);
}


-(void) text: aText
{
  _LINK_TEXTElement.data = aText;
  _text = aText;

  [self sizeToFit];
}
-(void) href: aHref
{
  _href = aHref;
  FIXME_link.href = aHref;
}




- (void)viewDidMoveToSuperview
{
    _scrollView = [self enclosingScrollView];
    _contentView = [_scrollView contentView];
}

- (void)setFrameSize:(CGSize)aSize
{
    [super setFrameSize:aSize];

    // [self scrollToCaret];
}

@end



