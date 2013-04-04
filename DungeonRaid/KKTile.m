//
// Created by kkgn06 on 2013/03/09.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "KKTile.h"


@implementation KKTile {

}

+ (id)tile {
    NSAssert(NO, @"各Tileクラスでoverrideして使って下さい。");
    return [[[self alloc] init] autorelease];
}

+ (id)tileWithType:(KKTileType)type {
    return [[[self alloc] initWithType:type] autorelease];
}

- (id)initWithType:(KKTileType)type {
    NSString *fileName = [KKTile fileNameWithType:type];
    self = [super initWithFile:fileName];
    if (self) {
        _type = type;
    }
    return self;
}

+ (NSString *)fileNameWithType:(KKTileType)type {
    NSString *fileName = nil;
    switch (type) {
        case KKTileTypeCoin:
            fileName = @"coin.png";
            break;
        case KKTileTypeEnemy:
            fileName = @"enemy.png";
            break;
        case KKTileTypePotion:
            fileName = @"potion.png";
            break;
        case KKTileTypeShield:
            fileName = @"shield.png";
            break;
        case KKTileTypeSword:
            fileName = @"sword.png";
            break;
        case TileTypeType_MAX:
            NSAssert(NO, @"このTileTypeはまだ実装されてない");
            break;
    }
    return fileName;
}

- (void)setMassX:(int)massX {
    NSAssert(massX >= 0, @"arg : %d, posX : %d, posY : %d", massX, self.massX,self.massY);
    _massX = massX;
    CGSize s = self.contentSize;
    self.position = ccp(s.width * 0.5f + s.width * _massX, self.position.y);
}

- (void)setMassY:(int)massY {
    NSAssert(massY >= 0, @"arg : %d, posX : %d, posY : %d", massY, self.massX,self.massY);
    _massY = massY;
    CGSize s = self.contentSize;
    self.position = ccp(self.position.x, s.height * 0.5f + s.height * _massY);
}

@end
