app = Polish.app( { title : "Credential Form", color : lightgray() } );

w = Polish.window({"title" : "Credential Form", "width" : 400, "height" : 300, "color" :  darkgray(), x: 200, y: 200 });

stack = w.stack( {width : 375, height : 270, color : darkgray()} );

var flow_size = {width : 350, height : 50};

first_name = stack.flow( flow_size );
last_name = stack.flow( flow_size );
credit_card = stack.flow( flow_size );
expiration = stack.flow( flow_size );

first_name.label( { value : 'Firstname:', y : 15} );
first_name.text();

last_name.label( { value : 'Lastname:', y : 15} );
last_name.text();

credit_card.label( { value : 'Card #:', y : 15} );
credit_card.text();

expiration.label( { value : 'Exp Month:', y : 15} );
expiration.list_box( { width : 70, items : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'] } );
expiration.label( { value : 'Exp Year:', y : 15} );
expiration.list_box( { width : 70, items : ['2009', '2010', '2011', '2012'] } );