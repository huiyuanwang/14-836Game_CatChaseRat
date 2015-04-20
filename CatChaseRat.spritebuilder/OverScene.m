//
//  OverScene.m
//  CatChaseRat
//
//  Created by Huiyuan Wang on 4/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OverScene.h"

@implementation OverScene {
    
    CCLabelTTF *_finalScoreLabel;
}

- (void)didLoadFromCCB {
    _finalScoreLabel.string = [NSString stringWithFormat:@"%d", points];
}

- (void)restart {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
