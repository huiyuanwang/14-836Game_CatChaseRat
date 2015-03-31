//
//  Dog.m
//  CatChaseRat
//
//  Created by Huiyuan Wang on 3/31/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Dog.h"
#import "GamePlayScene.h"

@implementation Dog

- (void)didLoadFromCCB
{
    self.position = ccp(175, 150);
    self.zOrder = DrawingOrderCharacter;
    self.physicsBody.collisionType = @"dog";
}

- (void)crouch
{
    [self.physicsBody applyImpulse:ccp(0, 300.f)];
}

@end