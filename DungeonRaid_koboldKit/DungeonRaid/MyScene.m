/*
 * Copyright (c) 2013 Steffen Itterheim.
 * Released under the MIT License:
 * KoboldAid/licenses/KoboldKitFree.License.txt
 */

#import "MyScene.h"
#import "KKTile.h"

#define TILE_NUM_X 6
#define TILE_NUM_Y TILE_NUM_X * 2

@interface MyScene ()
@property(nonatomic, strong) NSMutableArray *touchTiles;
@property(nonatomic, strong) KKTile *touchedTile;
@end

@implementation MyScene {
    KKTile *mass[TILE_NUM_X][TILE_NUM_Y];
}


- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        self.touchTiles = [NSMutableArray array];

        for (int i = 0; i < TILE_NUM_X; i++) {
            for (int j = 0; j < TILE_NUM_Y; j++) {
                KKTileType type = (KKTileType) arc4random_uniform(TileTypeType_MAX);
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

- (BOOL)canTouchTile:(KKTile *)tile {
    // 直前にタッチした隣のTileしかタッチ出来ない
    int massDiffX = self.touchedTile.massX - tile.massX;
    int massDiffY = self.touchedTile.massY - tile.massY;
    if (!(abs(massDiffX) <= 1 && abs(massDiffY) <= 1)) {
        return NO;
    }

    if (self.touchedTile.type == KKTileTypeEnemy || self.touchedTile.type == KKTileTypeSword) {
        return tile.type == KKTileTypeEnemy || tile.type == KKTileTypeSword;
    } else {
        return self.touchedTile.type == tile.type;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [touch locationInNode:self];

    for (int i = 0; i < TILE_NUM_X; i++) {
        for (int j = 0; j < TILE_NUM_Y; j++) {
            KKTile *tile = mass[i][j];
            if (CGRectContainsPoint(tile.frame, touchPos)) {
                tile.alpha = 0.5;
                self.touchedTile = tile;
                [self.touchTiles addObject:tile];
                return;
            }
        }
    }

    // (optional) call super implementation to allow KKScene to dispatch touch events
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [touch locationInNode:self];

    for (int i = 0; i < TILE_NUM_X; i++) {
        for (int j = 0; j < TILE_NUM_Y; j++) {
            KKTile *tile = mass[i][j];
            if (ccpFuzzyEqual(tile.position, touchPos, CGRectGetHeight(tile.frame) / 3)
                    && [self canTouchTile:tile]) {
                tile.alpha = 0.5;
                self.touchedTile = tile;
                [self.touchTiles addObject:tile];
                return;
            }
        }
    }

    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.touchTiles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        KKTile *tt = obj;
        mass[tt.massX][tt.massY] = nil;
        [tt removeFromParent];
    }];
    [self.touchTiles removeAllObjects];
    self.touchedTile = nil;

    for (int i = 0; i < TILE_NUM_X; i++) {
        for (int j = 0; j < TILE_NUM_Y; j++) {
            if (mass[i][j]) {
                int y;
                for (y = 1; y < TILE_NUM_X && y <= j && !mass[i][j - y]; y++);

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
                KKTileType type = (KKTileType) arc4random_uniform(TileTypeType_MAX);
                KKTile *t = [KKTile tileWithType:type];
                t.massX = i;
                t.massY = j;
                [self addChild:t];
                mass[i][j] = t;
            }
        }
    }

    [super touchesEnded:touches withEvent:event];
}


- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

    // (optional) call super implementation to allow KKScene to dispatch update events
    [super update:currentTime];
}

@end
