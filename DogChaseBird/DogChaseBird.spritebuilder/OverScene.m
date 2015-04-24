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
    _finalScoreLabel.string = [NSString stringWithFormat:@"%d", points];
}

- (void)restart {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)shareToFacebook {
    UIImage *img = [UIImage imageNamed:@"spacemonkey.png"];
    
    FBSDKSharePhoto *screen = [[FBSDKSharePhoto alloc] init];
    screen.image = img;
    screen.userGenerated = YES;
    [screen setImageURL:[NSURL URLWithString:@"http://spacemonkey.kailiangchen.com"]];
                         
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[screen];
                         
    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    dialog.fromViewController = [CCDirector sharedDirector];
    [dialog setShareContent:content];
    dialog.mode = FBSDKShareDialogModeShareSheet;
    [dialog show];
}

@end
