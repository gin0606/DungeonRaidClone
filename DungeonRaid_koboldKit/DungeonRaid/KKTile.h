//
// Created by gin0606 on 2013/10/29.
//


#import <Foundation/Foundation.h>

typedef enum {
    KKTileTypeCoin,
    KKTileTypeEnemy,
    KKTileTypePotion,
    KKTileTypeShield,
    KKTileTypeSword,
    TileTypeType_MAX,
} KKTileType;

@interface KKTile : KKSpriteNode
@property(nonatomic) KKTileType type;
@property(nonatomic) int massX;
@property(nonatomic) int massY;


+ (id)tile;

+ (id)tileWithType:(KKTileType)type;

- (id)initWithType:(KKTileType)type;
@end
