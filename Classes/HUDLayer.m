//
//  HUDLayer.m
//  MatchGame
//
//  Created by Andre Torrez on 9/14/09.
//  Copyright 2009 Simpleform. All rights reserved.
//

#import "HUDLayer.h"


@implementation HUDLayer
@synthesize game;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// create and initialize a Label
		Label* label = [Label labelWithString:@"How you doin?" fontName:@"Marker Felt" fontSize:32];
		
		// ask director the the window size
		CGSize size = [[Director sharedDirector] winSize];
		
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 + 20 , size.height/2 - 20);

		// add the label as a child to this Layer
		[self addChild: label];
	}
	return self;
}


@end
