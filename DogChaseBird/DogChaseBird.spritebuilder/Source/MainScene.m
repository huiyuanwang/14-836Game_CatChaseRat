
#import "MainScene.h"

static const CGFloat scrollSpeed = 80.f;

@implementation MainScene {
    // two grounds to make them continuously loop
    CCNode *_ground1;
    CCNode *_ground2;
    NSArray *_grounds;
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
    
    [super initialize];
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
}

@end
