Wiki.renderContent = function(parent_stack, cbody)
{
  lines = cbody.split('\n');
  var code_block = '';
  var code_started = false;
  for(var i=0; i < lines.length; i++)
    {
      var first_ele = first_element(lines[i]);
      console.log(first_ele);
      if( first_ele == '=' )
        {
          header_ele = lines[i].split('=');
          console.debug(parent_stack);
          labl = parent_stack.label({font : 16, value: header_ele[1], textcolor: rgb(0.1, 0.1, 0.1, 1.0)});
          labl.value(header_ele[1]);
        }
      else if(first_ele == '[')
      {
        var page_name = lines[i].split('[')[1].split(']')[0];
        var but = parent_stack.button({title: page_name});
        but.on_click(function(){ Wiki.showPage(this.title(), false);});
      }
      else if(first_ele == '%')
      {
        if(code_started == true)
          {
            console.log('encountered % again');
            code_para = parent_stack.para(code_block, {textcolor: rgb(0.1, 0.1, 0.1, 1.0), width: 760});
            code_run_button = parent_stack.button({title: 'Run', y: code_para.y(), x: 500});
            code_run_button.on_click(function(){
                                       eval(code_block);
                                     });
            code_started = false;
          } else
            {
            code_started = true;
              console.log('setting code started to true');

            }
      }
      else if(first_ele == undefined)
      {

      }
      else
      {
       if(code_started)
        {
          code_block = code_block +  lines[i] + "\n";
        }
        else{
        console.log('calling para');
        para = parent_stack.para(lines[i], {textcolor: rgb(0.1, 0.1, 0.1, 1.0), width: 760});
        }
      }
    }
  console.log(lines);
};

function first_element(line){
  for(var i=0; i < line.length ; i++)
    {
      if(line.charAt(i) != ' ')
        return line.charAt(i);
    }
};
