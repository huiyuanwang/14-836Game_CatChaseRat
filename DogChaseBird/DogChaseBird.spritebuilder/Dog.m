//
//  Dog.m
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Dog.h"
#import "PlayScene.h"

@implementation Dog

- (void)didLoadFromCCB
{
    self.position = ccp(175, 100);
    self.zOrder = DrawingOrderCharacter;
    self.physicsBody.collisionType = @"dog";
}

- (void)jump
{
    [self.physicsBody applyImpulse:ccp(0, 800.f)];
}

@end
