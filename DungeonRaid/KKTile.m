//
// Created by kkgn06 on 2013/03/09.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "KKTile.h"


@implementation KKTile {

}

+ (id)tileWithType:(TileType)type {
    return [[[self alloc] initWithType:type] autorelease];
}

- (id)initWithType:(TileType)type {
    self = [super init];
    if (self) {
        _type = type;

        NSString *fileName = nil;
        switch (self.type) {
            case coin:
                fileName = @"coin.png";
                break;
            case enemy:
                fileName = @"enemy.png";
                break;
            case potion:
                fileName = @"potion.png";
                break;
            case shield:
                fileName = @"shield.png";
                break;
            case sword:
                fileName = @"sword.png";
                break;
            case TileType_MAX:
                NSAssert(NO, @"このTileTypeはまだ実装されてない");
                break;
        }
        CCSprite *sprite = [CCSprite spriteWithFile:fileName];
        [self addChild:sprite];
    }
    return self;
}

@end
