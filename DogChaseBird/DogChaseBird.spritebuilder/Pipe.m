//
//  Pipe.m
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Pipe.h"

@implementation Pipe {
    CCNode *_pipe;
}

#define ARC4RANDOM_MAX      0x100000000
// The y position to add the pipe obstacle is static
static const CGFloat YPosition = 0.f;
// We want the x position to be set in a random range
static const CGFloat miniXPosition = 50.f;
static const CGFloat maxiXPosition = 100.f;

- (void)didLoadFromCCB {
    _pipe.physicsBody.collisionType = @"pipeLevel";
    _pipe.physicsBody.sensor = YES;
}

- (void)setupRandomPosition {
    // value between 0.f and 1.f
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);
    CGFloat range = maxiXPosition - miniXPosition;
    self.position = ccp(self.position.x + random * range, YPosition);
    //self.position = ccp(self.position.x, YPosition);
}

@end