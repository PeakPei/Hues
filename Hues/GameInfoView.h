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

@interface GameInfoView : UIView

@property (nonatomic, readonly) UILabel *scoreLabel;
@property (nonatomic, readonly) UILabel *timeLabel;

@property (nonatomic, readonly) GameInfoButton *powerup1;
@property (nonatomic, readonly) GameInfoButton *powerup2;

@property (nonatomic, readonly) GameInfoButton *pause;

- (void)setScore:(NSInteger)score;
- (void)setTime:(NSInteger)time;

@end
