OBJJ_MAIN_FILE = "main.j";
POLISH_NOTIFICATION = function() {
  polish_loaded();
};
function load_file(filename) {
  objj_import(filename, YES, function(){ });
};

function polish_loaded(){
  load_file('./samples/test-api/wiki.js');
  //load_file('./samples/test-api/testbed.js');
//  load_file('./samples/test-api/stack_test.js');
// load_file('./samples/test-api/art.js');
//load_file('./samples/tweet-polish/tweet.js');
 // load_file('./samples/test-api/Application.js');
  //load_file('./samples/slideshow/Application.js');
}

