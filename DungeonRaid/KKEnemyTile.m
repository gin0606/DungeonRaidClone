//
// Created by kkgn06 on 2013/04/05.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "KKEnemyTile.h"


@implementation KKEnemyTile {

}
+ (id)tile {
    return [[[self alloc] initWithType:KKTileTypeEnemy] autorelease];
}

- (id)initWithType:(KKTileType)type {
    self = [super initWithType:type];
    if (self) {

    }

    return self;
}

@end
