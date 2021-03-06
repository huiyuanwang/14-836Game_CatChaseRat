//
//  MainScene.m
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grass.h"
#import "Pipe.h"

static NSString *dogJumpSound = @"DogJump.mp3";
static NSString *birdJumpSound = @"BirdJump.mp3";
static NSString *dogBombSound = @"DogBomb.mp3";
static NSString *birdBombSound = @"BirdBomb.mp3";

int points;
int runTime;

@implementation MainScene {
    // two grounds to make them continuously loop
    CCNode *_ground1;
    CCNode *_ground2;
    NSArray *_grounds;
    
    NSMutableArray *_grassObstacles;
    NSMutableArray *_pipeObstacles;
    float timeSinceGrass;
    float timeSincePipe;
    
    BOOL _gameOver;
    BOOL _dogOneJump;
    BOOL _birdOneJump;
    
    CCNode *_buttonNodes;
    CCNode *_dogButton;
    CCNode *_birdButton;
    
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_tipLabel;
    CCLabelTTF *_levelLabel;
    
    CGFloat scrollSpeed;
    CGFloat grassInterval;
    CGFloat pipeInterval;
    int intervalLevel;
    int temp;
    int level;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _grounds = @[_ground1, _ground2];
    
    for (CCNode *ground in _grounds) {
        // set collision type of ground
        ground.physicsBody.collisionType = @"ground";
    }
    
    // set this class as delegate
    _physicsNodes.collisionDelegate = self;
    
    _grassObstacles = [NSMutableArray array];
    _pipeObstacles = [NSMutableArray array];
    
    // Add grass obstable for bird character
    //CCLOG(@"Grass obstacle is ready to load in initialize.");
    //[self addGrassObstacle];
    // Set the timer to catch when to add a new grass obstable
    timeSinceGrass = 0.0f;
    
    // Add grass obstable for bird character
    //CCLOG(@"Pipe obstacle is ready to load in initialize.");
    //[self addPipeObstacle];
    // Set the timer to catch when to add a new grass obstable
    timeSincePipe = 0.0f;
    
    // Preload sounds
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio preloadEffect:dogJumpSound];
    [audio preloadEffect:birdJumpSound];
    [audio preloadEffect:dogBombSound];
    [audio preloadEffect:birdBombSound];
    
    points = 0;
    scrollSpeed = 110.0f;
    grassInterval = 4.0f;
    pipeInterval = 5.0f;
    temp = 0;
    level = 1;
    intervalLevel = 1;
    
    
    if (runTime > 0) {
        _tipLabel.string = [NSString stringWithFormat:@"%s", ""];
        _levelLabel.string = [NSString stringWithFormat:@"  Level: %d", level];
    } else
        _levelLabel.string = [NSString stringWithFormat:@"%s", ""];
    
    [super initialize];
}

- (void)addGrassObstacle {
    CCLOG(@"Grass obstacle is ready to load in addGrassObstacle.");
    Grass *_grassObstacle = (Grass *)[CCBReader load:@"Grass"];
    CCLOG(@"Grass obstacle is loaded.");
    CGPoint screenPosition = [self convertToWorldSpace:ccp(380, 0)];
    CGPoint worldPosition = [_physicsNodes convertToNodeSpace:screenPosition];
    _grassObstacle.position = worldPosition;
    [_grassObstacle setupRandomPosition];
    _grassObstacle.zOrder = DrawingOrderPipes;
    [_physicsNodes addChild:_grassObstacle];
    [_grassObstacles addObject:_grassObstacle];
}

- (void)addPipeObstacle {
    CCLOG(@"Pipe obstacle is ready to load in addPipeObstacle.");
    Pipe *_pipeObstacle = (Pipe *)[CCBReader load:@"Pipe"];
    CCLOG(@"Pipe obstacle is loaded.");
    CGPoint screenPosition = [self convertToWorldSpace:ccp(290, 0)];
    CGPoint worldPosition = [_physicsNodes convertToNodeSpace:screenPosition];
    _pipeObstacle.position = worldPosition;
    [_pipeObstacle setupRandomPosition];
    _pipeObstacle.zOrder = DrawingOrderPipes;
    [_physicsNodes addChild:_pipeObstacle];
    [_pipeObstacles addObject:_pipeObstacle];
}


- (void)update:(CCTime)delta {
    _bird.position = ccp(_bird.position.x + delta * scrollSpeed, _bird.position.y);
    _dog.position = ccp(_dog.position.x + delta * scrollSpeed, _dog.position.y);
    _physicsNodes.position = ccp(_physicsNodes.position.x - delta * scrollSpeed, _physicsNodes.position.y);
    
    // loop the group
    for (CCNode *ground in _grounds) {
        // get the world position of the ground
        CGPoint groundWorldPosition = [_physicsNodes convertToWorldSpace:ground.position];
        // get the screen position of the ground
        CGPoint groundScreenPosition = [self convertToNodeSpace:groundWorldPosition];
        // if the left corner is one complete width off the screen, move it to the right
        if (groundScreenPosition.x <= (-1.3 * ground.contentSize.width)) {
            ground.position = ccp(ground.position.x + 2.6 * ground.contentSize.width, ground.position.y);
        }
    }
    
    NSMutableArray *offScreenObstacles = nil;
    
    for (CCNode *obstacle in _grassObstacles) {
        CGPoint obstacleWorldPosition = [_physicsNodes convertToWorldSpace:obstacle.position];
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
    
    for (CCNode *obstacle in _pipeObstacles) {
        CGPoint obstacleWorldPosition = [_physicsNodes convertToWorldSpace:obstacle.position];
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
        [_pipeObstacles removeObject:obstacleToRemove];
    }
    
    // Increment the time since the last obstacle was added
    timeSinceGrass += delta; // delta is approximately 1/60th of a second
    timeSincePipe += delta;
    
    // Check to see if two seconds have passed
    if (timeSinceGrass > grassInterval)
    {
        // Add a new grass obstacle
        [self addGrassObstacle];
        // Then reset the timer.
        timeSinceGrass = 0.0f;
    }
    if (timeSincePipe > pipeInterval)
    {
        [self addPipeObstacle];
        timeSincePipe = 0.0f;
        _levelLabel.string = [NSString stringWithFormat:@"%s", ""];
        if (runTime == 0) {
            _tipLabel.string = [NSString stringWithFormat:@"%s", ""];
            runTime += 1;
        }
    }
    if (temp > 8 && scrollSpeed <= 150.0f) {
        level ++;
        intervalLevel = level / 2;
        if (intervalLevel == 3)
            intervalLevel -= 1;
        _levelLabel.string = [NSString stringWithFormat:@"Good Job!!\n The speed is up.\n  Level: %d", level];
        scrollSpeed += 10.0f;
        grassInterval = 4.0f - intervalLevel;
        pipeInterval = 5.0f - intervalLevel;
        temp = 0;
    }
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    // Catch the touch position
    CGPoint touchLocation = [touch locationInNode:_buttonNodes];
    if (!_gameOver) {
        if (CGRectContainsPoint([_dogButton boundingBox], touchLocation) && !_dogOneJump) {
            [[OALSimpleAudio sharedInstance] playEffect:dogJumpSound];
            [_dog jump];
            _dogOneJump = TRUE;
        }
        if (CGRectContainsPoint([_birdButton boundingBox], touchLocation) && !_birdOneJump) {
            [[OALSimpleAudio sharedInstance] playEffect:birdJumpSound];
            [_bird jump];
            _birdOneJump = TRUE;
        }
    }
}

- (void)gameOver {
    if (!_gameOver) {
        _gameOver = TRUE;
        CCScene *gameoverScene = [CCBReader loadAsScene:@"OverScene"];
        [[CCDirector sharedDirector] replaceScene:gameoverScene];
    }
}

- (void)dogOneJump {
    _dogOneJump = FALSE;
}

- (void)birdOneJump {
    _birdOneJump = FALSE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair dog:(CCSprite*)dog ground:(CCNode*)ground {
    [self dogOneJump];
    return TRUE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair bird:(CCSprite*)bird ground:(CCNode*)ground {
    [self birdOneJump];
    return TRUE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair dog:(CCSprite *)dog pipeGoal:(CCNode *)pipeGoal {
    [pipeGoal removeFromParent];
    points++;
    temp ++;
    _scoreLabel.string = [NSString stringWithFormat:@"%d", points];
    return TRUE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair bird:(CCSprite *)bird grassGoal:(CCNode *)grassGoal {
    [grassGoal removeFromParent];
    points ++;
    temp ++;
    _scoreLabel.string = [NSString stringWithFormat:@"%d", points];
    return TRUE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair dog:(CCSprite*)dog pipeLevel:(CCNode *)pipeLevel {
    [[OALSimpleAudio sharedInstance] playEffect:dogBombSound];
    [self gameOver];
    CCLOG(@"The game is over. Because the dog is crashed.");
    return TRUE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair bird:(CCSprite*)bird grassLevel:(CCNode*)grassLevel {
    [[OALSimpleAudio sharedInstance] playEffect:birdBombSound];
    [self gameOver];
    CCLOG(@"The game is over. Because the bird is crashed.");
    return TRUE;
}

@end
