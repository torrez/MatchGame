#import <Foundation/Foundation.h>
#import "cocos2d.h"


@class Sprite;
@interface Card : NSObject {
    BOOL    is_flipped;
    BOOL    is_matched;
    int     value;
    CGRect  _table_location;
    Sprite  *back_sprite;
    Sprite  *front_sprite;
}

@property BOOL      is_flipped;
@property BOOL      is_matched;
@property int       value;
@property CGRect    _table_location;
@property (nonatomic, retain) Sprite *back_sprite;
@property (nonatomic, retain) Sprite *front_sprite;

+ (id) newFromValue:(int)n;
- (void) flip;
- (Sprite *) getCurrentView;
@end
