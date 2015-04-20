//
//  PipeGoal.m
//  CatChaseRat
//
//  Created by Huiyuan Wang on 4/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PipeGoal.h"

@implementation PipeGoal

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"pipeGoal";
    self.physicsBody.sensor = YES;
}

@end
