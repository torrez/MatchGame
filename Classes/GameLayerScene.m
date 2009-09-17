// Import the interfaces
#import "GameLayerScene.h"
#import "HUDLayer.h"
#import "Card.h"

// GameLayer implementation
@implementation GameLayer

@synthesize hud;
@synthesize testCard;
@synthesize deck;

+(id) scene
{
	// 'scene' is an autorelease object.
	Scene *scene = [Scene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	HUDLayer *hudlayer = [HUDLayer node];
	
	[layer setHud:hudlayer];
	[hudlayer setGame:layer];
	
	// add layer as a child to scene
	[scene addChild:hudlayer z:1];
	[scene addChild:layer z:0];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
        
		isTouchEnabled = YES;
		[self initializeDeck];
		[self shuffleDeck];
		[self dealDeck];
        
        firstCard   = NULL;
        secondCard  = NULL;
        in_match    = NO;
	}
	return self;
}

- (void) dealloc
{
	
	//finally
	[super dealloc];
}

- (void) initializeDeck
{
	[self setDeck:[NSMutableArray arrayWithCapacity:DECK_SIZE]];
	for (int x = 1; x < 7; x++) {
		[deck addObject:[Card newFromValue:x]];
		[deck addObject:[Card newFromValue:x]];
	}
}

- (void) shuffleDeck
{
    for (int x = 0; x < DECK_SIZE; x++) {
        int elements = DECK_SIZE - x;
        int n = (random() % elements) + x;
        [deck exchangeObjectAtIndex:x withObjectAtIndex:n];
    }
}

- (void) dealDeck
{
    int left = 50;
    int top = 400;
	
    [self removeAllChildrenWithCleanup:YES];
    
	for (int x = 0,y= 1;x < DECK_SIZE; x++, y++)
	{
		CGPoint origin = ccp((float)left, (float)top);
        
		Card *card = [deck objectAtIndex:x];
		[[card getCurrentView] setPosition:origin];
		[self addChild: [card getCurrentView]];
		[card set_table_location:CGRectMake(origin.x - CARD_WIDTH / 2 , origin.y - CARD_HEIGHT / 2, CARD_WIDTH, CARD_HEIGHT)];
		if (y==4)
		{
            top -= 100;
            left = 50;
            y = 0;
		} else {
			left += 70;
		}
	}
}

-(BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint cLoc = [[Director sharedDirector] convertCoordinate: location];
    
    for (int x = 0; x < DECK_SIZE; x++) {
        Card *card = [deck objectAtIndex:x];
        if (card.is_matched){
            continue;
        }
        
        if (CGRectContainsPoint(card._table_location, cLoc))
        {
            if (card != firstCard) {
                [self flipCard:card];
            }
            /*
            if (in_match) {
                if (firstCard == card) {
                    //changed mind?
                    NSLog(@"clicked same card");
                    firstCard = NULL;
                    in_match = NO;
                    [self flipCard:card];
                } else if (firstCard.value == card.value) {
                    NSLog(@"Match!");
                    [self flipCard:card];
                    card.is_matched = YES;
                    in_match = NO;
                    [self flipCard:firstCard];
                    firstCard = NULL;
                } else {
                    NSLog(@"No match.");
                    in_match = NO;
                    [self flipCard:card];
                    [self flipCard:firstCard];
                    firstCard = NULL;
                }
            } else {
                firstCard = card;
                in_match = YES;
            }*/
            return kEventHandled;
        }
    }
	return kEventIgnored;
}

- (void)flipCard:(Card *)card
{
    CGPoint origin = [[card getCurrentView] position];
    [self removeChild:[card getCurrentView] cleanup:YES];
    [card flip];
    [self addChild:[card getCurrentView]];
    [[card getCurrentView] setPosition: origin];
}
@end
