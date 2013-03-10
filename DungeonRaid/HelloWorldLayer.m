//
//  HelloWorldLayer.m
//  DungeonRaid
//
//  Created by kkgn06 on 03/09/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "KKTile.h"

@interface HelloWorldLayer ()
@property(nonatomic, retain) CCArray *tileArray;
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

        self.tileArray = [CCArray array];
        KKTile *kkTile = [KKTile tileWithType:coin];
        CGSize tileSize = kkTile.textureRect.size;
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 6; j++) {
                TileType type = (int) (CCRANDOM_0_1() * 1000) % TileType_MAX;
                KKTile *t = [KKTile tileWithType:type];
                t.position = ccp(tileSize.width / 2 + tileSize.width * i, tileSize.height / 2 + tileSize.height * j);
                [self addChild:t];
                [self.tileArray addObject:t];
            }
        }
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];

    for (KKTile *tile in self.tileArray) {
        NSAssert([tile isKindOfClass:[KKTile class]], @"self.tileArrayにはKKTileしか入れない");
        if (CGRectContainsPoint([tile boundingBox], touchPos)) {
            tile.visible = NO;
            self.touchedTileType = tile.type;
            [self.touchTiles addObject:tile];
            return;
        }
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];

    for (KKTile *tile in self.tileArray) {
        NSAssert([tile isKindOfClass:[KKTile class]], @"self.tileArrayにはKKTileしか入れない");
        if (tile.type == self.touchedTileType
                && ccpFuzzyEqual(tile.position, touchPos, tile.contentSize.height / 3)) {
            tile.visible = NO;
            [self.touchTiles addObject:tile];
            return;
        }
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];

    for (KKTile *tile in self.touchTiles) {
        [self.touchTiles removeObject:tile];
        [self.tileArray removeObject:tile];
        [self removeChild:tile cleanup:YES];
    }
    self.touchedTileType = TileType_MAX;
}


@end
