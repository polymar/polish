/*
 * Roadmap.j
 *
 * Created by Roberto Gamboni on 06/21/2009.
 * Copyright 2009 Roberto Gamboni. All rights reserved.
 */

//TODO List

//TOP Priority
// - Events:
//		- Expose Mouse Events
//		- Expose Keyboard Events
//		- Expose some generic events
		
//	- Resizable and/or Scrollable
//		- Ideal no size required for stack or flow, but continuining resizing based on the content.
//		- Collection of object using CPScrollView
		
//	- Windows
//		- Refactoring: a new window is a AppBuilder object, which doesn't have any utils for dealing with the window.
//			Maybe we should have only one AppBuilder for the mainWindow and create a POWindow object.
//		- Expose more methods, for instance all the style options (closable, resizable, etc..) should be available

//MEDIUM Priority

//	- Website
//	- Samples
//	- Documentation

//LOW Priority

//	- Graphics
//		- Refactoring: why POArt is a CPView. And not a POControl wrapping a Cappuccino object? The problem with CPView
//			is that we don't have anymore all the utils for dealing with views (that have been moved in POControl).
//		- Can't we directly access the canvas without going through Cappuccino?