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
    NSLog(@"Initializing Deck");
	[self setDeck:[NSMutableArray arrayWithCapacity:DECK_SIZE]];
	for (int x = 1; x < 7; x++) {
		[deck addObject:[Card newFromValue:x]];
		[deck addObject:[Card newFromValue:x]];
	}
    
    NSLog(@"Deck has a size of %i.", [deck count]);
}

- (void) shuffleDeck
{
    NSLog(@"In shuffle deck.");
    for (int x = 0; x < DECK_SIZE; x++) {
        int elements = DECK_SIZE - x;
        int n = (random() % elements) + x;
        [deck exchangeObjectAtIndex:x withObjectAtIndex:n];
        NSLog(@"Moving item %i to %i.", x, n);
    }
    NSLog(@"Deck has size of %i.", [deck count]);
}

- (void) dealDeck
{
    NSLog(@"Dealing Deck");
    int left = 50;
    int top = 400;
	
    [self removeAllChildrenWithCleanup:YES];

	for (int x = 0,y= 1;x < DECK_SIZE; x++, y++)
	{
		CGPoint origin = ccp((float)left, (float)top);
        
        NSLog(@"About to grab a card at %i.", x);
		Card *card = [deck objectAtIndex:x];
        NSLog(@"Grabbed card %i", x);
        [card setIs_flipped:NO];
		[[card getCurrentView] setPosition:origin];
		[self addChild: [card getCurrentView]];
		[card set_table_location:CGRectMake(origin.x, origin.y, CARD_WIDTH, CARD_HEIGHT)];
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

- (void) deckInfo
{
    NSLog(@"Deck info");//: %@", deck);
}

-(BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint cLoc = [[Director sharedDirector] convertCoordinate: location];
	
	NSLog(@"GAME LAYER received a click.");
	NSLog(@"x=%f,y=%f", location.x, location.y);
	NSLog(@"x=%f,y=%f", cLoc.x,cLoc.y);
	
	if(0)
	{
		return kEventHandled;
	} else {
		return kEventIgnored;
	}
}
@end
