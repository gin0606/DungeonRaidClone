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
    NSString *fileName = [KKTile fileNameWithType:type];
    self = [super initWithFile:fileName];
    if (self) {
        _type = type;
    }
    return self;
}

+ (NSString *)fileNameWithType:(TileType)type {
    NSString *fileName = nil;
    switch (type) {
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
    return fileName;
}

- (void)setMassX:(int)massX {
    _massX = massX;
    CGSize s = self.contentSize;
    self.position = ccp(s.width * 0.5f + s.width * _massX, self.position.y);
}

- (void)setMassY:(int)massY {
    _massY = massY;
    CGSize s = self.contentSize;
    self.position = ccp(self.position.x, s.height * 0.5f + s.height * _massY);
}

@end
