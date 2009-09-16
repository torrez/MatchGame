//
//  HUDLayer.m
//  MatchGame
//
//  Created by Andre Torrez on 9/14/09.
//  Copyright 2009 Simpleform. All rights reserved.
//

#import "HUDLayer.h"
#import "GameLayerScene.h"

@implementation HUDLayer
@synthesize game;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		isTouchEnabled = YES;
		CGSize window_size = [[Director sharedDirector] winSize];
		
		// Add shuffle button
		Sprite *sprite = [Sprite spriteWithFile:@"shuffle-cards.png"];
		sprite.position = ccp(window_size.width /2, 60);
		shuffle_rect = CGRectMake(sprite.position.x - (sprite.position.x /2), sprite.position.y - (sprite.position.y / 2), 200, 50);
		[self addChild: sprite];
	}
	return self;
}

-(BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint cLoc = [[Director sharedDirector] convertCoordinate: location];
	
	if (CGRectContainsPoint(shuffle_rect, cLoc))
	{
        
        [game shuffleDeck];
        [game dealDeck];
		return kEventHandled;
	} else {
		return kEventIgnored;
	}
}



@end
