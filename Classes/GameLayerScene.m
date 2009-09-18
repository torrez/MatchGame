// Import the interfaces
#import "GameLayerScene.h"
#import "HUDLayer.h"
#import "Card.h"

// GameLayer implementation
@implementation GameLayer

@synthesize hud;
@synthesize deck;
@synthesize first_card;
@synthesize second_card;

+(id) scene
{
	Scene *scene = [Scene node];
	
	GameLayer *layer    = [GameLayer node];
	HUDLayer *hudlayer  = [HUDLayer node];
	
	[layer setHud:hudlayer];
	[hudlayer setGame:layer];
	
	[scene addChild:hudlayer z:1];
	[scene addChild:layer    z:0];
	
	return scene;
}

-(id) init
{
	if( (self=[super init] )) {

        isTouchEnabled = YES;        
		
        [self initializeDeck];
        [self shuffleDeck];
        [self dealDeck];
        
        first_card   = NULL;
        second_card  = NULL;
        in_match     = NO;
        score        = 0;
    }
    return self;
}

- (void) dealloc
{
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
    in_match    = NO;
    first_card  = NULL;
    second_card = NULL;
    [self resetScore];
    
    // Cleaning up cards.
    for (int x = 0; x < DECK_SIZE; x++) {
        Card *testCard = [deck objectAtIndex:x];
        testCard.is_matched = NO;
        testCard.is_flipped = NO;
    }
    
    // Randomizing order
    for (int x = 0; x < DECK_SIZE; x++) {
        int elements = DECK_SIZE - x;
        int n = (random() % elements) + x;
        [deck exchangeObjectAtIndex:x withObjectAtIndex:n];
    }
}

- (void) dealDeck
{
    [self removeAllChildrenWithCleanup:YES];

    CGSize window_size = [[Director sharedDirector] winSize];
    
    CGPoint offscreen = ccp((float)window_size.width/2, (float)0);
    CGPoint origin = ccp((float)55, (float)370);
	
    for (int x = 0,y= 1; x < DECK_SIZE; x++, y++)
	{
        Card *card = [deck objectAtIndex:x];
        [[card getCurrentView] setPosition:offscreen];
		[self addChild: [card getCurrentView]];
        [[card getCurrentView] runAction:[MoveTo actionWithDuration:.5 position:origin]];
        [[card getCurrentView] runAction:[RotateBy actionWithDuration:.5 angle:360]];
		[card set_table_location:CGRectMake(origin.x - CARD_WIDTH / 2 , origin.y - CARD_HEIGHT / 2, CARD_WIDTH, CARD_HEIGHT)];
		
        if (y==4)
		{
            origin.y -= 100;
            origin.x = 55;
            y = 0;
		} else {
			origin.x += 70;
		}
	}
}

- (BOOL) inMatch
{
    return in_match;
}

- (void) incrementScore
{
    score+=1;
    [hud setScore:score];
}

- (void) resetScore
{
    score = 0;
    [hud setScore:score];
}

-(BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UITouch *touch   = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint cLoc     = [[Director sharedDirector] convertCoordinate: location];
    
    for (int x = 0; x < DECK_SIZE; x++) 
    {
        Card *card = [deck objectAtIndex:x];
        
        if (card.is_matched)
        {
            continue;
        }
        
        if (CGRectContainsPoint(card._table_location, cLoc))
        {       
            if (card == first_card) 
            {
                [self flipCard:card];
                first_card = NULL;
                [self incrementScore];
                return kEventHandled;
            } else if ([card is_matched]) 
            {
                return kEventHandled;
            }
            
            if (first_card) 
            {
                [self flipCard:card];
                in_match = YES;
                second_card = card;
                [self schedule:@selector(check_selection:) interval:0.5];
                [self incrementScore];
            } else {
                [self flipCard:card];
                first_card = card;
            }
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

-(void) check_selection: (ccTime) dt
{
    if (first_card.value == second_card.value) 
    {
        first_card.is_matched = YES;
        second_card.is_matched = YES;
        
        first_card = NULL;
        second_card = NULL;
        
        in_match = NO;
    } else {
        [self flipCard:first_card];
        [self flipCard:second_card];
        
        in_match = NO;
        
        first_card = NULL;
        second_card = NULL;
    }
    
    [self unschedule:@selector(check_selection:)];
}
@end
