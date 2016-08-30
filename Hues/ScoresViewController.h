//
//  ScoresViewController.h
//  Hues
//
//  Created by Drew Dunne on 8/11/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavView.h"
#import "DividerView.h"
#import "NSString+MD5.h"
#import "UIColor+Hues.h"
#import "ScoreModel.h"
#import "AchievementView.h"

@interface ScoresViewController : UIViewController {
    UILabel *scoreLabel;
    UILabel *highScoreLabel;
}

@end
