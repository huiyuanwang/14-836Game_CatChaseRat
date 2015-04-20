//
//  PlayScene.m
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PlayScene.h"

@implementation PlayScene

- (void)initialize
{
    // Add the bird to make it move with the screen
    _bird = (Bird *)[CCBReader load:@"Bird"];
    [_physicsNodes addChild:_bird];
    CCLOG(@"Bird is loaded successfully.");
    
    // Add the dog to make it move with the screen
    _dog = (Dog *)[CCBReader load:@"Dog"];
    [_physicsNodes addChild:_dog];
    CCLOG(@"Dog is loaded successfully.");
}

@end