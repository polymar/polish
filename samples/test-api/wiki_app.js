app = Polish.app( { title : "Polish Wiki", color : lightgray() } );
stack = app.stack({ "width" : 800, "height" : 600, "color" :  darkgray(), marginX: 0, marginY:0 });

var flow_size = {width : 800, height : 50, color: rgb(0, 0.1, 0.2, 0.5)};

top_bar = stack.flow(flow_size);
label = top_bar.label({height: 50});
label.font(20);
label.value('StartPage');
button = top_bar.button();

  var stack_size ={width : 800, height : 600, color: rgb(0, 0.1, 0.2, 0.5), y: 60};
 wiki_content = stack.stack(stack_size);

edit_box = wiki_content.edit_box('', {width : 780, height : 520, color: rgb(0.9, 0.9, 0.9, 1.0)});


button_edit_action = function(page_name){
return function(event){
  Wiki.showPage(page_name, true);
}};

button_save_action = function(page_name)
{
  return function(event){

  Wiki.updatePage(page_name, edit_box.value());
  };};

Wiki.edit = function(page){
  label.value(page.title);
  console.log("editing page : " + page.title);
  edit_box.show();
  console.log("editing page body: " + page.body);
  edit_box.value(page.body);
  button.title('Save');
  button.on_click(button_save_action(page.title));
  remove_content_box()
};
function remove_content_box(){
  try{
    content_box.remove();
  } catch(e) {
  }
}
Wiki.render = function(page){
//  edit_box.value(page.body);
  label.value(page.title);
  edit_box.hide();
  remove_content_box()
  content_box = wiki_content.stack( {width : 780, height : 520, color: rgb(0.9, 0.9, 0.9, 1.0), x: 10, y: 10});
  Wiki.renderContent(content_box, page.body);
  button.title('edit');
  button.on_click(button_edit_action(page.title));
};


//Wiki.insertPage('StartPage', 'Testing.');
Wiki.showPage('StartPage', false);
