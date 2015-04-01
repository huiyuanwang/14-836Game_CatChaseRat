//
//  Bird.m
//  CatChaseRat
//
//  Created by Huiyuan Wang on 3/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Bird.h"
#import "GamePlayScene.h"

@implementation Bird

- (void)didLoadFromCCB
{
    self.position = ccp(375, 100);
    self.zOrder = DrawingOrderCharacter;
    self.physicsBody.collisionType = @"bird";
}

- (void)jump
{
    [self.physicsBody applyImpulse:ccp(0, 300.f)];
}

@end