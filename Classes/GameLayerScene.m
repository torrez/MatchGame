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
		
		// create and initialize a Label
		Label* label = [Label labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[Director sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
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
	deck = [NSMutableArray arrayWithCapacity:20];
	/*testCard = [Sprite spriteWithFile:@"card-1.png"];
	[testCard setPosition:ccp(100, 100)];
	[self addChild:testCard];
	 */
	for (int x = 1; x < 7; x++) {
		[deck addObject:[Card newFromValue:x]];
		[deck addObject:[Card newFromValue:x]];
	}	
}

- (void) shuffleDeck
{
	//nop
}

- (void) dealDeck
{
	int left = 10;
	int top = 10;
	
	for(int x = 0; x<12;x++)
	{
		CGPoint origin = ccp((float)left, (float)top);
		Card *card = [deck objectAtIndex:x];
		[card.front_sprite setPosition:origin];
		[self addChild: card.front_sprite];
		if ((x % 3) == 0) 
		{
			top += 20;
			left = 10;
		} else {
			left += 20;
		}
	}
}

@end
