
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@class HUDLayer;

// GameLayer Layer
@interface GameLayer : Layer
{
	HUDLayer *hud;
}
@property (nonatomic, retain) HUDLayer *hud;


// returns a Scene that contains the GameLayer as the only child
+(id) scene;

@end
