/*
 * CPColorAdditions.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

//TODO this can be optimized with colors caching, despite the fact CPColor are already cached.
//TODO most of the methods could be generated on the fly.

function rgb(r,g,b) {
	return [POColor r:r g:g b:b];
}

function rgb(r,g,b,a) {
	return [POColor r:r g:g b:b a:a];
}

function gray(b) {
	return [POColor gray:b];
}

function gray(b, a) {
	return [POColor gray:b alpha:a];
}

function red() {
	return [POColor red];
}

function blue() {
	return [POColor blue];
}

function green() {
	return [POColor green];
}

function yellow() {
	return [POColor yellow];
}

function white() {
	return [POColor white];
}

function black() {
	return [POColor black];
}

function gray() {
	return [POColor gray];
}

function darkgray() {
	return [POColor darkgray];
}

function lightgray() {
	return [POColor lightgray];
}

@implementation POColor : CPObject {
	id 			__delegate;	
}

+ (id) red {
	return [[POColor alloc] initWithColorName:'redColor'];
}

+ (id) blue {
	return [[POColor alloc] initWithColorName:'blueColor'];
}

+ (id) green {
	return [[POColor alloc] initWithColorName:'greenColor'];
}

+ (id) yellow {
	return [[POColor alloc] initWithColorName:'yellowColor'];
}

+ (id) black {
	return [[POColor alloc] initWithColorName:'blackColor'];
}

+ (id) white {
	return [[POColor alloc] initWithColorName:'whiteColor'];
}

+ (id) gray {
	return [[POColor alloc] initWithColorName:'grayColor'];
}

+ (id) darkgray {
	return [[POColor alloc] initWithColorName:'darkGrayColor'];
}

+ (id) lightgray {
	return [[POColor alloc] initWithColorName:'lightGrayColor'];
}

+ (id) r:(float)r g:(float)g b:(float)b {
	return [[POColor alloc] initWithRed:r green:g blue:b alpha:1.0];
}

+ (id) r:(float)r g:(float)g b:(float)b a:(float)a {
	return [[POColor alloc] initWithRed:r green:g blue:b alpha:a];
}

+ (id) gray:(float)b {
	return [[POColor alloc] initWithCalibrateWhite:b alpha:1.0];
}

+ (id) gray:(float)b alpha:(float)a {
	return [[POColor alloc] initWithCalibrateWhite:b alpha:a];
}

- (id) initWithRed:(float) red green:(float) green blue:(float) blue alpha:(float) alpha {
	self = [super init];
	if(self) {
		__delegate = [CPColor colorWithRed:red green:green blue:blue alpha:alpha];
	}
	return self;
}

- (id) initWithColorName:(CPString) colorName {
	self = [super init];
	if(self) {
		__delegate = [POColor colorWithName:colorName];
	}
	return self;
}

- (id) initWithCalibrateWhite:white alpha:alpha {
	self = [super init];
	if(self) {
		__delegate = [CPColor colorWithCalibratedWhite:white alpha:alpha];
	}
	return self;
}

+ (CPColor) colorWithName:(CPString) colorName {
	cSel = CPSelectorFromString(colorName);
	if([CPColor respondsToSelector:cSel]) {
		return [CPColor performSelector:cSel];
	} 
}

- (CPColor) color {
	return __delegate;
}

@end
