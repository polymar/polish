Wiki = new Object();
Wiki.DB = openDatabase("Wiki", "1.0", "wiki", 1048576);
console.debug(Wiki.DB);

//Wiki.DB.transaction(function(tx) {
//    tx.executeSql('DROP TABLE  wiki',
//                  []
//                 );});
//

Wiki.DB.transaction(function(tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS wiki(title TEXT, body TEXT)',
                  []
                 );});
Wiki.insertPage = function(title, text) {
  Wiki.DB.transaction(
    function(tx){
      tx.executeSql('INSERT INTO wiki (title, body) VALUES(?, ?)', [title, text],
      function(tx, rx){
        Wiki.showPage(title, true);
      }
      );
    });
};
Wiki.updatePage = function(title, text) {
  console.debug(text);

  Wiki.DB.transaction(
    function(tx){
      tx.executeSql('UPDATE wiki SET body = ? where title = ?' , [ text, title],
    function(tx, rx){
      Wiki.showPage(title);
    });
    });
};
Wiki.showPage = function(title, edit){
  Wiki.DB.transaction(function(tx){
    tx.executeSql('SELECT * FROM wiki WHERE title = ?', [title],
    function(tx, rx){
      if(rx.rows.length > 0)
      {
        if(edit)
          Wiki.edit(rx.rows.item(0));
        else
          Wiki.render(rx.rows.item(0));
      }
      else
        Wiki.insertPage(title, '');
    } ); });
};


load_file('samples/test-api/wiki_renderer.js');
load_file('samples/test-api/wiki_app.js');
