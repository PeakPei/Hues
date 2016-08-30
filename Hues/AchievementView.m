//
//  AchievementView.m
//  Hues
//
//  Created by Drew Dunne on 7/22/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "AchievementView.h"

@interface AchievementView () {
    UILabel *titleLabel;
    UILabel *descLabel;
    UIImageView *iconView;
}

@end

@implementation AchievementView

- (id)init {
    self = [super init];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
//    self.backgroundColor = [UIColor colorWithWhite:0.99 alpha:1];
//    self.layer.borderWidth = 1.0f;
//    self.layer.borderColor = [UIColor colorWithWhite:0.90 alpha:1].CGColor;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height+6, self.frame.size.width, 2.0f);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f].CGColor;
    [self.layer addSublayer:bottomBorder];
    
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, self.frame.size.height-32, self.frame.size.height-32)];
    iconView.image = [UIImage imageNamed:@"skip.png"];
    [self addSubview:iconView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/3, 12, 2*self.frame.size.width/3-8, (self.frame.size.height-16)/2)];
    titleLabel.text = @"Achievement";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont fontWithName:@"Avenir" size:22];
    titleLabel.minimumScaleFactor = 0.5;
    titleLabel.adjustsFontSizeToFitWidth = true;
    titleLabel.textColor = [UIColor darkHuesBlueText];
    [self addSubview:titleLabel];
    
    descLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/3, 4+(self.frame.size.height-16)/2, 2*self.frame.size.width/3-8, (self.frame.size.height-16)/2)];
    descLabel.text = @"The Description";
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.font = [UIFont fontWithName:@"Avenir" size:18];
    descLabel.minimumScaleFactor = 0.5;
    descLabel.adjustsFontSizeToFitWidth = true;
    descLabel.textColor = [UIColor darkHuesBlueText];
    [self addSubview:descLabel];
}

- (void)setAchievement:(NSString *)key {
    NSDictionary *data = [[ScoreModel sharedScoreModel] achievementInfoForKey:key];
    titleLabel.text = data[@"title"];
    descLabel.text = data[@"desc"];
    NSString *imageName = ([data[@"status"] boolValue] == true) ? @"unlocked-achievement.png" : @"locked-achievement.png";
    iconView.image = [UIImage imageNamed:imageName];
}

@end
