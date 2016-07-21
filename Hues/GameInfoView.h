//
//  GameInfoView.h
//  Hues
//
//  Created by Drew Dunne on 7/7/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameInfoButton.h"
#import "UIColor+Hues.h"

@interface GameInfoView : UIView {
    NSTimer *flashTimer;
    BOOL flashState;
}

@property (nonatomic, readonly) UILabel *scoreLabel;
@property (nonatomic, readonly) UILabel *timeLabel;

@property (nonatomic, readonly) GameInfoButton *puAddTime;
@property (nonatomic, readonly) GameInfoButton *pu2x2;
@property (nonatomic, readonly) GameInfoButton *puSkip;

@property (nonatomic, readonly) GameInfoButton *pause;

- (void)enableButtonBar:(BOOL)enabled;
- (void)enablePowerups:(BOOL)enabled;

- (void)setScore:(NSInteger)score;
- (void)setTime:(NSInteger)time;

- (void)flashTime;

- (void)update2x2Title;
- (void)updateSkipTitle;
- (void)updateAddTimeTitle;

@end
