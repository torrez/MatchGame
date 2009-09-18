#import "HUDLayer.h"
#import "GameLayerScene.h"

@implementation HUDLayer
@synthesize game;
@synthesize score_label;

-(id) init
{
    if( (self=[super init] )) {
        isTouchEnabled = YES;
        CGSize window_size = [[Director sharedDirector] winSize];
		
        Sprite *sprite = [Sprite spriteWithFile:@"shuffle-cards.png"];
        sprite.position = ccp(window_size.width /2, 60);
        shuffle_rect = CGRectMake(sprite.position.x - (sprite.position.x /2), sprite.position.y - (sprite.position.y / 2), 200, 50);
        [self addChild: sprite];
        
        [self writeScore:@"Select A Card"];        
    }
    return self;
}

-(BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch   = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    CGPoint cLoc     = [[Director sharedDirector] convertCoordinate: location];

    if ([game inMatch]) 
    {
        return kEventHandled;
    }
    
    if (CGRectContainsPoint(shuffle_rect, cLoc))
    {
        [game shuffleDeck];
        [game dealDeck];
        return kEventHandled;
	} else {
		return kEventIgnored;
	}
}

- (void)setScore:(int)score
{
    [self writeScore:[NSString stringWithFormat:@"TRIES %i", score]];    
}

- (void)writeScore:(NSString *)scoreString
{
    [self removeChild:score_label cleanup:YES];
    score_label = [Label labelWithString:scoreString fontName:@"Helvetica" fontSize:13];
    CGSize size = [[Director sharedDirector] winSize];    
    score_label.position =  ccp( size.width /2 , size.height - 20 );
    
    [self addChild: score_label];
}

@end
