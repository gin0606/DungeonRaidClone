//
//  HelloWorldLayer.m
//  DungeonRaid
//
//  Created by kkgn06 on 03/09/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "KKTile.h"

#define TILE_NUM_X 6
#define TILE_NUM_Y TILE_NUM_X * 2


@interface HelloWorldLayer () {
    KKTile *mass[TILE_NUM_X][TILE_NUM_Y];
}
@property(nonatomic, retain) CCArray *touchTiles;
@property(nonatomic) KKTileType touchedTileType;

@end

@implementation HelloWorldLayer

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    HelloWorldLayer *layer = [HelloWorldLayer node];
    [scene addChild:layer];

    return scene;
}

- (id)init {
    if ((self = [super init])) {
        self.isTouchEnabled = YES;
        self.touchTiles = [CCArray array];
        self.touchedTileType = TileTypeType_MAX;

        for (int i = 0; i < TILE_NUM_X; i++) {
            for (int j = 0; j < TILE_NUM_Y; j++) {
                KKTileType type = (KKTileType) ((int) (CCRANDOM_0_1() * 1000) % TileTypeType_MAX);
                KKTile *t = [self createTileWithType:type];
                t.massX = i;
                t.massY = j;
                [self addChild:t];
                mass[i][j] = t;
            }
        }
    }
    return self;
}

- (KKTile *)createTileWithType:(KKTileType)type {
    KKTile *tile = nil;
    switch (type) {
        case KKTileTypeCoin:
            tile = [KKTile tileWithType:type];
            break;
        case KKTileTypeEnemy:
            tile = [KKTile tileWithType:type];
            break;
        case KKTileTypePotion:
            tile = [KKTile tileWithType:type];
            break;
        case KKTileTypeShield:
            tile = [KKTile tileWithType:type];
            break;
        case KKTileTypeSword:
            tile = [KKTile tileWithType:type];
            break;
        case TileTypeType_MAX:
            NSAssert(NO, @"このTileTypeは実装されてません");
            break;
    }
    return tile;
}

- (BOOL)canTouchTile:(KKTile *)tile {
    if (self.touchedTileType == KKTileTypeEnemy || self.touchedTileType == KKTileTypeSword) {
        return tile.type == KKTileTypeEnemy || tile.type == KKTileTypeSword;
    } else {
        return self.touchedTileType == tile.type;
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];

    for (int i = 0; i < TILE_NUM_X; i++) {
        for (int j = 0; j < TILE_NUM_Y; j++) {
            KKTile *tile = mass[i][j];
            if (CGRectContainsPoint([tile boundingBox], touchPos)) {
                tile.opacity = 128;
                self.touchedTileType = tile.type;
                [self.touchTiles addObject:tile];
                return;
            }
        }
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];

    for (int i = 0; i < TILE_NUM_X; i++) {
        for (int j = 0; j < TILE_NUM_Y; j++) {
            KKTile *tile = mass[i][j];
            if ([self canTouchTile:tile]
                    && ccpFuzzyEqual(tile.position, touchPos, tile.contentSize.height / 3)) {
                tile.opacity = 128;
                [self.touchTiles addObject:tile];
                return;
            }
        }
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (KKTile *tile in self.touchTiles) {
        mass[tile.massX][tile.massY] = nil;
        [self removeChild:tile cleanup:YES];
    }
    [self.touchTiles removeAllObjects];
    self.touchedTileType = TileTypeType_MAX;

    for (int i = 0; i < TILE_NUM_X; i++) {
        for (int j = 0; j < TILE_NUM_Y; j++) {
            if (mass[i][j]) {
                int y;
                for (y = 1; y < TILE_NUM_X && y <= j && !mass[i][j - y]; y++) {
                    while (0) {/* 最適化で消されないように */}
                }

                y--;
                KKTile *tile = mass[i][j];
                mass[i][j] = nil;
                mass[i][j - y] = tile;
                tile.massY -= y;
            }
        }
    }

    for (int i = 0; i < TILE_NUM_X; i++) {
        for (int j = 0; j < TILE_NUM_Y; j++) {
            if (!mass[i][j]) {
                KKTileType type = (KKTileType) ((int) (CCRANDOM_0_1() * 1000) % TileTypeType_MAX);
                KKTile *t = [KKTile tileWithType:type];
                t.massX = i;
                t.massY = j;
                [self addChild:t];
                mass[i][j] = t;
            }
        }
    }
}
@end
