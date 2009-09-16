//
//  Card.h
//  MatchGame
//
//  Created by Andre Torrez on 9/15/09.
//  Copyright 2009 Simpleform. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@class Sprite;
@interface Card : NSObject {
	BOOL	is_flipped;
	int		value;
	Sprite	*back_sprite;
	Sprite	*front_sprite;
}

@property BOOL		is_flipped;
@property int		value;
@property (nonatomic, retain) Sprite *back_sprite;
@property (nonatomic, retain) Sprite *front_sprite;

+ (id) newFromValue:(int)n;
- (void)flip;
- (double) getWidth;
@end
