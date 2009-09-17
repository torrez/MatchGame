#import "cocos2d.h"

@class GameLayer;

// HUDLayer Layer
@interface HUDLayer : Layer
{
    GameLayer	*game;
    CGRect		shuffle_rect;
}
@property (nonatomic, retain) GameLayer *game;

@end
