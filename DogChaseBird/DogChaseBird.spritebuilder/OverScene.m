//
//  OverScene.m
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OverScene.h"

@implementation OverScene

- (void)restart {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end