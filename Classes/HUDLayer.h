#import "cocos2d.h"

@class GameLayer;

// HUDLayer Layer
@interface HUDLayer : Layer
{
    GameLayer   *game;
    CGRect      shuffle_rect;
    Label       *score_label;
}
@property (nonatomic, retain) GameLayer *game;
@property (nonatomic, retain) Label *score_label;

- (void) setScore:(int)score;
- (void) writeScore:(NSString *)scoreString;
@end
