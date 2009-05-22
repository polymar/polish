/*
 * POFactory.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "Controls/POStack.j"
@import "Controls/POButton.j"
//@import "POText.j"
//@import "POSlider.j"
//@import "POProgress.j"
//@import "POImage.j"
//@import "POLogin.j"
//@import "POForm.j"
//@import "POSubmit.j"
//@import	"POVideo.j"
//@import "../Misc/FriendView.j"
//@import "../Misc/FriendsCollection.j"

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
		//"form"				: POForm,
		//"login"				: POLogin,
		"stack"				: POStack,
		"button"			: POButton,
		//"submit"			: POSubmit,
		//"imageview"			: POImage,
		//"progress"			: POProgress,
		//"text"				: POText,
		//"label"				: POText,
		//"slider"			: POSlider,
		//"video"				: POVideo
	};
};

function get_class(sel) {
	var class_map = load_class();
	return eval('class_map.' + sel);
}