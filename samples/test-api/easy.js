app = Polish.app( { title : 'my first app' } );

s = app.stack( {width : 400, height : 400, color : red()} );

b = s.button( { title : 'Push' } );
b.on_click( function() { alert( 'puuush' ); } );
