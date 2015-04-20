//
//  GrassGoal.m
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GrassGoal.h"

@implementation GrassGoal

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"grassGoal";
    self.physicsBody.sensor = YES;
}

@end
