//
//  Card.m
//  MatchGame
//
//  Created by Andre Torrez on 9/15/09.
//  Copyright 2009 Simpleform. All rights reserved.
//

#import "Card.h"
#import "cocos2d.h"

@implementation Card

@synthesize is_flipped;
@synthesize value;
@synthesize front_sprite;
@synthesize back_sprite;
@synthesize _table_location;

+ (id)newFromValue:(int)n
{
	if(n > 0){
		Card *new_card = [[[Card alloc] init] autorelease];
		new_card.front_sprite = [Sprite spriteWithFile:[NSString stringWithFormat:@"card-%i.png", n]];
		new_card.back_sprite  =	[Sprite spriteWithFile:@"card-back.png"];
		new_card.value = n;
		new_card._table_location = CGRectMake(900,900, 0,0); //hackety!
		return new_card;
	} else {
		return NULL;
	}
}

- (id)init
{
	[super init];
	is_flipped = YES;
	return self;
}

- (void) release
{
    NSLog(@"About to be released at %i", value);
    [super release];
}

- (void) flip
{
	is_flipped = is_flipped ? NO : YES;
}

- (Sprite *)getCurrentView
{
	if (is_flipped) {
		return front_sprite;
	} else {
		return back_sprite;
	}

}

@end

