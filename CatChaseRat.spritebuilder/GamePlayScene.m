//
//  GamePlayScene.m
//  CatChaseRat
//
//  Created by Huiyuan Wang on 3/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlayScene.h"
#import "Bird.h"
#import "Grass.h"

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
}

- (void)update:(CCTime)delta {
    // Increment the time since the last obstacle was added
    timeSinceGrass += delta; // delta is approximately 1/60th of a second
    
    // Check to see if two seconds have passed
    if (timeSinceGrass > 5.0f)
    {
        // Add a new grass obstacle
        [self addGrassObstacle];
        // Then reset the timer.
        timeSinceGrass = 0.0f;
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // this will get called every time the player touches the screen
    [_bird jump];
}

@end
