
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#define DECK_SIZE 12

@class HUDLayer;

// GameLayer Layer
@interface GameLayer : Layer
{
	HUDLayer		*hud;
	Sprite			*testCard;
	NSMutableArray	*deck;
	int				available_cards[11];
}
@property (nonatomic, retain) HUDLayer	*hud;
@property (nonatomic, retain) Sprite	*testCard;
@property (nonatomic, retain) NSArray	*deck;

// returns a Scene that contains the GameLayer as the only child
+(id) scene;
-(void)initializeDeck;
-(void)shuffleDeck;
-(void)dealDeck;
@end
