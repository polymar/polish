@implementation CPTextView : CPControl
{
    DOMElement      FIXME_textArea;
	CPString		_text;
	var				_fontSize;
    
    id              _delegate;
    
    CPScrollView    _scrollView;
    CPView          _contentView;
    
    JSObject        _existingSelectStart;
    
    BOOL            _alreadyFired;
}

-(id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame: aFrame];
    
    FIXME_textArea = document.createElement("textarea");
    
    FIXME_textArea.style.width  = "100%";
    FIXME_textArea.style.height = "100%";
    
    if(document.selection)
        FIXME_textArea.style.overflow = "auto";
    else
        FIXME_textArea.style.overflow = "hidden";
        
    FIXME_textArea.style.position = "absolute";
    
    FIXME_textArea.style.left    = "0";
    FIXME_textArea.style.top     = "0";
    FIXME_textArea.style.border  = "0";
    FIXME_textArea.style.margin  = "0";
    FIXME_textArea.style.padding = "0";
    
    FIXME_textArea.style.backgroundColor = "rgb(245, 245, 245)";
	_fontSize = 14;
    FIXME_textArea.style.fontSize = "14px";
    FIXME_textArea.style.fontFamily = "Arial";
     
    FIXME_textArea.style.resize = "none";
    FIXME_textArea.style.outlineStyle = "none";

    FIXME_textArea.onkeydown = function() {
        [self textDidChange: self];
    };
        
    FIXME_textArea.onkeypress = function() {
        [self textDidChange: self];
    };

    FIXME_textArea.onkeyup = function() {
        [self textDidChange: self];
    };

    if(document.attachEvent)
    {
        FIXME_textArea.onfocus = function() {
            _existingSelectStart = document.body.onselectstart;
            document.body.onselectstart = function() { };
        };
        
        FIXME_textArea.onblur = function() {
            if(_existingSelectStart)
                document.body.onselectstart = _existingSelectStart;
        };
    }
    
    _DOMElement.appendChild(FIXME_textArea);

    return self;
}

- (void)setFrame:(CGRect)aFrame
{
	[super setFrame:aFrame];
	[self sizeToFit];
}

-(void) sizeToFit
{
  	var size = [_text sizeWithFont:[CPFont systemFontOfSize:_fontSize] inWidth:[self frame].size.width],
	    minSize = { width : 100, height : 30};	
	if (FIXME_textArea.getAttribute("disable") == nil)
    	size.width = CGRectGetWidth([self frame]);
	size.width = (size.width < minSize.width) ? minSize.width : size.width;
	size.height = (size.height < minSize.height) ? minSize.height : size.height;
	[super setFrameSize:size];
}

- (void)setDelegate:(id)delegate
{
    _delegate = delegate;
}

- (id)delegate
{
    return _delegate;
}

- (void)textDidChange:(id)sender
{
    [_delegate textViewDidChange: self];
	_text = FIXME_textArea.value;
	[self sizeToFit];
	/*
    if (!_contentView)
        return;
    
    var bounds = [_contentView bounds];

    FIXME_textArea.style.height = CGRectGetHeight(bounds) + "px";
    FIXME_textArea.style.height = MAX(CGRectGetHeight(bounds), FIXME_textArea.scrollHeight) + "px";
    
    [self setFrameSize:CGSizeMake(CGRectGetWidth(bounds), parseInt(FIXME_textArea.style.height, 10))];
    [self scrollToCaret];
    
    [[CPRunLoop currentRunLoop] performSelectors];
	*/
}

- (void)scrollToCaret
{
    if(![_scrollView verticalScroller] || [[_scrollView verticalScroller] isHidden])
        return;
            
    if(FIXME_textArea.selectionStart)
    {
        var start = FIXME_textArea.selectionStart,
            end = FIXME_textArea.selectionEnd;

        var imposter = document.createElement('div'),
            referenceSpan = document.createElement('span'),
            stringValue = FIXME_textArea.value;
        
        imposter.style.overflow   = "hidden";
        imposter.style.fontSize   = "14px";
        imposter.style.padding    = "0";
        imposter.style.margin     = "0";
        imposter.style.height     = FIXME_textArea.style.height;
        imposter.style.width      = getComputedStyle(FIXME_textArea, "").getPropertyValue('width');
        imposter.style.fontFamily = getComputedStyle(FIXME_textArea, "").getPropertyValue('font-family');    
        
        for(var i=0; i<start; i++)
        {
            referenceSpan.innerHTML = stringValue.charAt(i).replace("\n", "<br />");
            imposter.appendChild(referenceSpan.cloneNode(true));
        }
    
        while (imposter.childNodes[start - 1] && imposter.childNodes[start - 1].innerHTML == " ")
            start--;
                
        document.body.appendChild(imposter);
    
        var caretOffsetTop = imposter.childNodes[start - 1].offsetTop - imposter.offsetTop,
            caretHeight = imposter.childNodes[start-1].offsetHeight;
        
        document.body.removeChild(imposter);
    }
    else if(document.selection)
    {
        FIXME_textArea.focus();
        var range = document.selection.createRange();
        
        window.range = range;
        if(range.parentElement() != FIXME_textArea) 
            return;
                            
        var caretOffsetTop = range.offsetTop + _DOMElement.offsetTop - 18,
            caretHeight = 18;
    }
    else
        return;

    [self scrollRectToVisible:CGRectMake(1, caretOffsetTop, 1, caretHeight)];
}

- (void) disable {
	FIXME_textArea.disabled = "yes";
}

- (void) enable {
	FIXME_textArea.removeAttribute('disabled');
}

- (void) setBackgroundColor:(CPColor) _col {
	FIXME_textArea.style.backgroundColor = [_col cssString];
}

- (void) setTextColor:(CPColor) _col {
	FIXME_textArea.style.color = [_col cssString];
}

- (void) setFontSize:(int) _size {
	_fontSize = _size;
	FIXME_textArea.style.fontSize = (_size +"px");
	[self sizeToFit];
}

- (CPString)stringValue
{
    return FIXME_textArea.value;
}

- (void)setStringValue:(CPString)aString
{    
    if(aString) {
        FIXME_textArea.value = aString;
		_text = aString;
	}
    else {
        FIXME_textArea.value = "";    
		_text = "";
	}
    
    [self textDidChange: self];
}

- (void)focus
{
    window.setTimeout(function(){
        FIXME_textArea.focus();
    }, 0);
}

- (void)viewDidMoveToSuperview
{
    _scrollView = [self enclosingScrollView];
    _contentView = [_scrollView contentView];
}

- (void)setFrameSize:(CGSize)aSize
{
    [super setFrameSize:aSize];
    
    [self scrollToCaret];
}

@end

