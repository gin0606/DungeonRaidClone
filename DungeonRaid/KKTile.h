//
// Created by kkgn06 on 2013/03/09.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

typedef enum {
    coin,
    enemy,
    potion,
    shield,
    sword,
    TileType_MAX,
} TileType;

@interface KKTile : CCNode

+ (id)tileWithType:(TileType)type;

- (id)initWithType:(TileType)type;

@property(nonatomic) TileType type;
@end
