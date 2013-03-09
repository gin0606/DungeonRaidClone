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

        self.tileArray = [CCArray array];
        KKTile *kkTile = [KKTile tileWithType:coin];
        CGSize tileSize = kkTile.sprite.textureRect.size;
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

@end
