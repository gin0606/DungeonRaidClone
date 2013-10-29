//
// Created by gin0606 on 2013/10/29.
//


#import "KKTile.h"


@implementation KKTile {

}
+ (id)tile {
    NSAssert(NO, @"各Tileクラスでoverrideして使って下さい。");
    return [[self alloc] init];
}

+ (id)tileWithType:(KKTileType)type {
    return [[self alloc] initWithType:type];
}

- (id)initWithType:(KKTileType)type {
    NSString *fileName = [KKTile fileNameWithType:type];
    self = [super initWithImageNamed:fileName];
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
            break;
    }
    return fileName;
}

- (void)setMassX:(int)massX {
    NSAssert(massX >= 0, @"arg : %d, posX : %d, posY : %d", massX, self.massX, self.massY);
    _massX = massX;
    CGSize s = self.frame.size;
    self.position = ccp(s.width * 0.5f + s.width * _massX, self.position.y);
}

- (void)setMassY:(int)massY {
    NSAssert(massY >= 0, @"arg : %d, posX : %d, posY : %d", massY, self.massX, self.massY);
    _massY = massY;
    CGSize s = self.frame.size;
    self.position = ccp(self.position.x, s.height * 0.5f + s.height * _massY);
}

@end
