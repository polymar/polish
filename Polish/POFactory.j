/*
 * POFactory.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <Foundation/CPObject.j>

@implementation POFactory : CPObject

//Just message to the user in case of invalid selector received.
+ (void)forward:(SEL)aSelector :(marg_list)args
{
  var class_type =  get_class(aSelector);
  if(class_type != nil) {
    var cl = [class_type alloc];
    return [cl performSelector:aSelector];
  }
  console.error('@#!Polish Error -> '+aSelector+' is not a known message.');
}

@end

function load_class() {
	return {
		//"friend_collection" : FriendsCollection,
		//"friend" 			: FriendView,
		"form"				: POForm,
		"login"				: POLogin,
		"stack"				: POStack,
		"button"			: POButton,
		"submit"			: POSubmit,
		"image"				: POImage,
		"progress"			: POProgress,
		"text"				: POText,
		"label"				: POText,
		"subtitle"			: POText,
		"password"			: POText,
		"video"				: POVideo,
		"alert"				: POAlert,
		"confirm"			: POConfirm,
		"ask_color"			: POAskColor,
		"check"				: POCheck,
		"radio"				: PORadio,
		"slider"			: POSlider,
		"list_box"			: POList 
	};
};

function get_class(sel) {
  var class_map = load_class();
  return eval('class_map.' + sel);
}
