//
// Created by kkgn06 on 2013/03/09.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

typedef enum {
    KKCoinTile,
    KKEnemyTile,
    KKPotionTile,
    KKShieldTile,
    KKSwordTile,
    TileType_MAX,
} KKTileType;

@interface KKTile : CCSprite

+ (id)tileWithType:(KKTileType)type;

- (id)initWithType:(KKTileType)type;

@property(nonatomic) KKTileType type;
@property(nonatomic) int massX;
@property(nonatomic) int massY;

@end
