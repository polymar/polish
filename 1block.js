function $(ele){
  return document.getElementById(ele);
};
function Ajax() {
  this.script = false;
  return this;
};
Ajax.prototype.request = function (options, el){
  url = options['url'];
  this.req = new XMLHttpRequest();
  this.req.onreadystatechange = this.requestChanged;
  this.oncomplete = options['callback'];
  this.oncomplete_update = options['update'];
  if(this.type == 'GET'){
    this.req.open(this.type, url, true);
    this.req.send("");
  } else {
    this.req.open(this.type, url, true);
    this.req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
    this.req.setRequestHeader('Accept', 'text/javascript, text/html, application/xml, text/xml, */*');
    this.req.send(this.serializeForm(el));
  }
};
Ajax.prototype.requestChanged = function () {
  var reqt = req.req;
  // only if req shows "loaded"
  if (reqt.readyState == 4) {
    if(req.oncomplete_update){
      req.update(req.oncomplete_update, reqt);
    }
    if(req.oncomplete){
      req.oncomplete(reqt);
      return false;
    };
  }
};

Ajax.prototype.serializeForm = function(form) {
    var ret = '';
    var els = form.getElementsByTagName('*');
    function key_val(el){
      return el.name + '=' + encodeURIComponent(el.value);
    };
    for( var idx = 0; idx < els.length; idx++ ) {
      var el = els[idx];
      if( !el.disabled && el.name && el.name.length > 0 ) {
        switch(el.tagName.toLowerCase()) {
          case 'input':
            switch( el.type ) {
              case 'checkbox':
              case 'radio':
                if( el.checked ) {
                  if( ret.length > 0 ) {
                    ret += '&';
                  }
                  ret += key_val(el);
                }
                break;
              case 'submit':
              case 'button':
              case 'hidden':
              case 'password':
              case 'text':
                if( ret.length > 0 ) {
                  ret += '&';
                }
                ret += key_val(el);
                break;
            }
            break;
          case 'select':
          case 'textarea':
            if( ret.length > 0 ) {
              ret += '&';
            }
            ret += key_val(el);
            break;
        }
      }
    }
    return ret;
};

Ajax.prototype.update = function(id, req){
  var element = $(id);
  if(element != null) {
    element.innerHTML = req.responseText;
  }
};

function aget(options, element){
  req = new Ajax();
  req.type = 'GET';
  req.request(options, element);
}

function apost(options, element){
  req = new Ajax();
  req.type = 'POST';
  req.request(options, element);
}


// Examples.
//:onClick => "aget({ 'url' : '#{href}', 'update' : 'location_block'}); #{ga_button_click('edit', 'location').to_s}; return false;"

//a.location_link! 'Add a Comment', :onClick => "aget({'url' : '#{href}', 'update' : 'add_comment'}); #{ga_button_click('edit', 'comment').to_s}; return false"

// :html => { :name => :change_linfo, :onsubmit => "apost({'url' : '#{url}', 'update': 'location_block'}, this); return false" })

// apost({'url': '#{href}', 'callback': display_response}, $('add_listing'));
