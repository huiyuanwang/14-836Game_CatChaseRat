//
//  GamePlayScene.h
//  CatChaseRat
//
//  Created by Huiyuan Wang on 3/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Bird.h"

typedef NS_ENUM(NSInteger, DrawingOrder) {
    DrawingOrderPipes,
    DrawingOrderGround,
    DrawingOrderCharacter
};

@interface GamePlayScene : CCNode <CCPhysicsCollisionDelegate>
{
    Bird *_bird;
    CCPhysicsNode *_physicsNode;
    float timeSinceGrass;
}

-(void) initialize;
-(void) addGrassObstacle;

@end

