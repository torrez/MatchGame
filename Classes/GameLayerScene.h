
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#define DECK_SIZE 12
#define CARD_WIDTH 50
#define CARD_HEIGHT 90

@class HUDLayer;
@class Card;

// GameLayer Layer
@interface GameLayer : Layer
{
    HUDLayer		*hud;
    NSMutableArray	*deck;
    BOOL            in_match;
    Card            *first_card;
    Card            *second_card;
}
@property (nonatomic, retain) HUDLayer          *hud;
@property (nonatomic, retain) NSMutableArray	*deck;
@property (nonatomic, retain) Card              *first_card;
@property (nonatomic, retain) Card              *second_card;


// returns a Scene that contains the GameLayer as the only child
+ (id) scene;
- (void)initializeDeck;
- (void)shuffleDeck;
- (void)dealDeck;
- (void)flipCard:(Card *)card;
- (BOOL)inMatch;
@end
