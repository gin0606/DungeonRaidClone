//
//  HelloWorldLayer.m
//  DungeonRaid
//
//  Created by kkgn06 on 03/09/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "KKTile.h"

#define TILE_NUM 6

@interface HelloWorldLayer () {
    KKTile *mass[TILE_NUM][TILE_NUM];
}
@property(nonatomic, retain) CCArray *touchTiles;
@property(nonatomic) TileType touchedTileType;

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
        self.touchedTileType = TileType_MAX;

        KKTile *kkTile = [KKTile tileWithType:coin];
        CGSize tileSize = kkTile.textureRect.size;
        for (int i = 0; i < TILE_NUM; i++) {
            for (int j = 0; j < TILE_NUM; j++) {
                TileType type = (int) (CCRANDOM_0_1() * 1000) % TileType_MAX;
                KKTile *t = [KKTile tileWithType:type];
                t.massX = i;
                t.massY = j;
                [self addChild:t];
                mass[i][j] = t;
            }
        }
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];

    for (int i = 0; i < TILE_NUM; i++) {
        for (int j = 0; j < TILE_NUM; j++) {
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

    for (int i = 0; i < TILE_NUM; i++) {
        for (int j = 0; j < TILE_NUM; j++) {
            KKTile *tile = mass[i][j];
            if (tile.type == self.touchedTileType
                    && ccpFuzzyEqual(tile.position, touchPos, tile.contentSize.height / 3)) {
                tile.opacity = 128;
                [self.touchTiles addObject:tile];
                return;
            }
        }
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];

    for (KKTile *tile in self.touchTiles) {
        mass[tile.massX][tile.massY] = nil;
        [self removeChild:tile cleanup:YES];
    }
    [self.touchTiles removeAllObjects];
    self.touchedTileType = TileType_MAX;

    for (int i = 0; i < TILE_NUM; i++) {
        for (int j = 1; j < TILE_NUM; j++) {
            int y;
            for (y = 1; y < TILE_NUM && !mass[i][j - y]; y++) {
                while (0) {};
            }
            y--;
            CCLOG(@"%d", y);
            KKTile *tile = mass[i][j];
            mass[i][j] = nil;
            mass[i][j - y] = tile;
            tile.massY -= y;
        }
    }
}
@end
