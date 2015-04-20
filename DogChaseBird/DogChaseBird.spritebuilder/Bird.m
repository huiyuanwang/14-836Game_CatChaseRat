//
//  Bird.m
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Bird.h"
#import "PlayScene.h"

@implementation Bird

- (void)didLoadFromCCB
{
    self.position = ccp(375, 80);
    self.zOrder = DrawingOrderCharacter;
    self.physicsBody.collisionType = @"bird";
}

- (void)jump
{
    [self.physicsBody applyImpulse:ccp(0, 300.f)];
}

@end
