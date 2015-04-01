//
//  MainScene.m
//  CatCatchRat
//
//  Created by Huiyuan Wang on 03/25/15
//

#import "MainScene.h"
#import "Grass.h"
#import "Pipe.h"

static const CGFloat scrollSpeed = 80.f;

@implementation MainScene {
    // two grounds to make them continuously loop
    CCNode *_ground1;
    CCNode *_ground2;
    NSArray *_grounds;
    
    NSTimeInterval _sinceTouch;
    
    NSMutableArray *_grassObstacles;
    NSMutableArray *_pipeObstacles;
    
    BOOL _gameOver;
    BOOL _oneJump;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _grounds = @[_ground1, _ground2];
    
    for (CCNode *ground in _grounds) {
        // set collision type of ground
        ground.physicsBody.collisionType = @"ground";
        ground.zOrder = DrawingOrderGround;
    }
    
    // set this class as delegate
    _physicsNode.collisionDelegate = self;
    
    _grassObstacles = [NSMutableArray array];
    _pipeObstacles = [NSMutableArray array];
    
    [super initialize];
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    if (!_gameOver) {
        _sinceTouch = 0.f;
        
        @try {
            if (!_oneJump) {
                [super touchBegan:touch withEvent:event];
                _oneJump = TRUE;
            }
        }
        @catch(NSException *ex) {
            
        }
    }
}

- (void)addGrassObstacle {
    CCLOG(@"Grass obstacle is ready to load in addGrassObstacle.");
    Grass *_grassObstacle = (Grass *)[CCBReader load:@"Grass"];
    CCLOG(@"Grass obstacle is loaded.");
    CGPoint screenPosition = [self convertToWorldSpace:ccp(380, 0)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _grassObstacle.position = worldPosition;
    [_grassObstacle setupRandomPosition];
    _grassObstacle.zOrder = DrawingOrderPipes;
    [_physicsNode addChild:_grassObstacle];
    [_grassObstacles addObject:_grassObstacle];
}

- (void)addPipeObstacle {
    CCLOG(@"Pipe obstacle is ready to load in addGrassObstacle.");
    Pipe *_pipeObstacle = (Pipe *)[CCBReader load:@"Pipe"];
    CCLOG(@"Pipe obstacle is loaded.");
    CGPoint screenPosition = [self convertToWorldSpace:ccp(380, 0)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _pipeObstacle.position = worldPosition;
    [_pipeObstacle setupRandomPosition];
    _pipeObstacle.zOrder = DrawingOrderPipes;
    [_physicsNode addChild:_pipeObstacle];
    [_grassObstacles addObject:_pipeObstacle];
}

- (void)gameOver {
    if (!_gameOver) {
        CCLOG(@"The game is over. Because the bird is crashed.");
        //_gameOver = TRUE;
    }
}

- (void)oneJump {
    _oneJump = FALSE;
}

- (void)update:(CCTime)delta {
    _bird.position = ccp(_bird.position.x + delta * scrollSpeed, _bird.position.y);
    _dog.position = ccp(_dog.position.x + delta * scrollSpeed, _dog.position.y);
    _physicsNode.position = ccp(_physicsNode.position.x - delta * scrollSpeed, _physicsNode.position.y);
    
    // loop the group
    for (CCNode *ground in _grounds) {
        // get the world position of the ground
        CGPoint groundWorldPosition = [_physicsNode convertToWorldSpace:ground.position];
        // get the screen position of the ground
        CGPoint groundScreenPosition = [self convertToNodeSpace:groundWorldPosition];
        // if the left corner is one complete width off the screen, move it to the right
        if (groundScreenPosition.x <= (-1.4 * ground.contentSize.width)) {
            ground.position = ccp(ground.position.x + 2.8 * ground.contentSize.width, ground.position.y);
        }
    }
    
    NSMutableArray *offScreenObstacles = nil;
    
    for (CCNode *obstacle in _grassObstacles) {
        CGPoint obstacleWorldPosition = [_physicsNode convertToWorldSpace:obstacle.position];
        CGPoint obstacleScreenPosition = [self convertToNodeSpace:obstacleWorldPosition];
        if (obstacleScreenPosition.x < -obstacle.contentSize.width) {
            if (!offScreenObstacles) {
                offScreenObstacles = [NSMutableArray array];
            }
            [offScreenObstacles addObject:obstacle];
        }
    }
    
    for (CCNode *obstacleToRemove in offScreenObstacles) {
        [obstacleToRemove removeFromParent];
        [_grassObstacles removeObject:obstacleToRemove];
    }
    
    if (!_gameOver) {
        @try {
            [super update:delta];
        }
        @catch(NSException* ex) {
            
        }
    }
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair bird:(CCSprite*)bird ground:(CCNode*)ground {
    [self oneJump];
    return TRUE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair bird:(CCSprite*)bird grasslevel:(CCNode*)grasslevel {
    [self gameOver];
    return TRUE;
}

@end
