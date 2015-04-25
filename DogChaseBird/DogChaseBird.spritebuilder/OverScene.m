//
//  OverScene.m
//  DogChaseBird
//
//  Created by Huiyuan Wang on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OverScene.h"
#import <FBSDKShareKit/FBSDKSharePhoto.h>
#import <FBSDKShareKit/FBSDKSharePhotoContent.h>
#import <FBSDKShareKit/FBSDKShareDialog.h>

@implementation OverScene {
    CCLabelTTF *_finalScoreLabel;
}

- (void)didLoadFromCCB {
    runTime += 1;
    _finalScoreLabel.string = [NSString stringWithFormat:@"%d", points];
}

- (void)restart {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (UIImage *) screenShot: (CCNode *)sNode {
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;
    
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    CCRenderTexture *renTxture = [CCRenderTexture renderTextureWithWidth:winSize.width height:winSize.height];
    
    [renTxture begin];
    [sNode visit];
    [renTxture end];
    
    return [renTxture getUIImage];
}

- (void)shareToFacebook {
    CCLOG(@"Begin to share to Facebook.");
    CCScene *runScene = [[CCDirector sharedDirector] runningScene];
    CCNode *node = [runScene.children objectAtIndex:0];
    UIImage *img = [self screenShot:node];
    //UIImage *img = [UIImage imageNamed:@"dogchasebird.png"];
    
    FBSDKSharePhoto *screen = [[FBSDKSharePhoto alloc] init];
    screen.image = img;
    screen.userGenerated = YES;
    //[screen setImageURL:[NSURL URLWithString:@""]];
                         
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[screen];
                         
    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    dialog.fromViewController = [CCDirector sharedDirector];
    [dialog setShareContent:content];
    dialog.mode = FBSDKShareDialogModeShareSheet;
    [dialog show];
}

@end
