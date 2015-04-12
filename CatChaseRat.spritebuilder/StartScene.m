//
//  StartScene.m
//  CatChaseRat
//
//  Created by Huiyuan Wang on 4/11/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "StartScene.h"

@implementation StartScene

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
