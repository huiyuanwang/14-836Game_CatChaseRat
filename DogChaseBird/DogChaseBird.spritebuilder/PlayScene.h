//
//  PlayScene.h
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Bird.h"
#import "Dog.h"

typedef NS_ENUM(NSInteger, DrawingOrder) {
    DrawingOrderPipes,
    DrawingOrderGround,
    DrawingOrderCharacter
};

@interface PlayScene : CCNode <CCPhysicsCollisionDelegate>
{
    Bird *_bird;
    Dog *_dog;
    CCPhysicsNode *_physicsNodes;
    //float timeSinceGrass;
    //float timeSincePipe;
}

-(void) initialize;

@end
