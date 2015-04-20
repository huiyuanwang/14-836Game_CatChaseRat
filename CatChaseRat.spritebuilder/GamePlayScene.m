//
//  GamePlayScene.m
//  CatChaseRat
//
//  Created by Huiyuan Wang on 3/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlayScene.h"

@implementation GamePlayScene

- (void)initialize
{
    // Add the bird to make it move with the screen
    _bird = (Bird *)[CCBReader load:@"Bird"];
    [_physicsNode addChild:_bird];
    CCLOG(@"Bird is loaded successfully.");
    
    // Add the dog to make it move with the screen
    _dog = (Dog *)[CCBReader load:@"Dog"];
    [_physicsNode addChild:_dog];
    CCLOG(@"Dog is loaded successfully.");
    
    // Add grass obstable for bird character
    CCLOG(@"Grass obstacle is ready to load in initialize.");
    [self addGrassObstacle];
    // Set the timer to catch when to add a new grass obstable
    timeSinceGrass = 0.0f;
    
    // Add grass obstable for bird character
    CCLOG(@"Pipe obstacle is ready to load in initialize.");
    [self addPipeObstacle];
    // Set the timer to catch when to add a new grass obstable
    timeSincePipe = 0.0f;
}

- (void)update:(CCTime)delta {
    // Increment the time since the last obstacle was added
    timeSinceGrass += delta; // delta is approximately 1/60th of a second
    timeSincePipe += delta;
    
    // Check to see if two seconds have passed
    if (timeSinceGrass > 5.0f)
    {
        // Add a new grass obstacle
        [self addGrassObstacle];
        // Then reset the timer.
        timeSinceGrass = 0.0f;
    }
    if (timeSincePipe > 6.0f)
    {
        [self addPipeObstacle];
        timeSincePipe = 0.0f;
    }
}

- (void)touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event {
    // Catch the touch position
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    
    if (CGRectContainsPoint([_birdButton boundingBox], touchLocation)) {
        // this will be called each time the player touches in the range of bird button
        [_bird jump];
    }
    if (CGRectContainsPoint([_dogButton boundingBox], touchLocation)) {
        // this will be called each time the player touched in the range of dog button
        [_dog crouch];
    }
}


@end
