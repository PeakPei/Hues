//
//  GameInfoView.m
//  Hues
//
//  Created by Drew Dunne on 7/7/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "GameInfoView.h"
#import "ScoreModel.h"
#import "UIControl+SoundForControlEvents.h"

#define GAME_INFO_HEIGHT 70

@implementation GameInfoView

@synthesize timeLabel, scoreLabel;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    //Create static score label
    UILabel *staticScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, (self.frame.size.width-40)/2, 20)];
    staticScoreLabel.text = @"Score";
    staticScoreLabel.textColor = [UIColor darkHuesBlueText];
    staticScoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:15];
    staticScoreLabel.textAlignment = NSTextAlignmentCenter;
    staticScoreLabel.alpha = 1.0f;
    [self addSubview:staticScoreLabel];
    
    //Create Score Label
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 36, (self.frame.size.width-40)/2, 22)];
    self.scoreLabel.text = @"0";
    self.scoreLabel.textColor = [UIColor huesBlue];
    self.scoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:28];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.alpha = 1.0f;
    [self addSubview:self.scoreLabel];
    
    //Create the static timer
    UILabel *staticTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(24+(self.frame.size.width-40)/2, 8, (self.frame.size.width-40)/2, 20)];
    staticTimeLabel.text = @"Time";
    staticTimeLabel.textColor = [UIColor darkHuesBlueText];
    staticTimeLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:15];
    staticTimeLabel.textAlignment = NSTextAlignmentCenter;
    staticTimeLabel.alpha = 1.0f;
    [self addSubview:staticTimeLabel];
    
    //Create the timer
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(24+(self.frame.size.width-40)/2, 36, (self.frame.size.width-40)/2, 22)];
    self.timeLabel.text = @"10";
    self.timeLabel.textColor = [UIColor huesBlue];
    self.timeLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:28];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.alpha = 1.0f;
    [self addSubview:self.timeLabel];
    
    UIView *horDarkDiv = [[UIView alloc] initWithFrame:CGRectMake(0, GAME_INFO_HEIGHT, self.frame.size.width, 1)];
    horDarkDiv.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self addSubview:horDarkDiv];
    
    _powerup1 = [GameInfoButton buttonWithType:UIButtonTypeCustom];
    self.powerup1.frame = CGRectMake(0, GAME_INFO_HEIGHT, self.frame.size.width/2, self.frame.size.height-GAME_INFO_HEIGHT);
    self.powerup1.adjustsImageWhenHighlighted = false;
    [self.powerup1 setImage:[UIImage imageNamed:@"skip.png"] forState:UIControlStateNormal];
    [self.powerup1 setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    self.powerup1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.powerup1.titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
    [self.powerup1 setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] totalSkips]] forState:UIControlStateNormal];
    if ([[ScoreModel sharedScoreModel] totalSkips] > 0) {
        self.powerup1.enabled = true;
    } else {
        self.powerup1.enabled = false;
    }
    [self.powerup1 setTitleColor:[UIColor darkHuesBlueText] forState:UIControlStateNormal];
    [self.powerup1 addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"skip" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.powerup1];
    
    _pause = [GameInfoButton buttonWithType:UIButtonTypeCustom];
    self.pause.frame = CGRectMake(self.frame.size.width/2, GAME_INFO_HEIGHT, self.frame.size.width/2, self.frame.size.height-GAME_INFO_HEIGHT);
    self.pause.adjustsImageWhenHighlighted = false;
    [self.pause setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    [self.pause setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    self.pause.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.pause.titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
    [self.pause setTitle:@"Pause" forState:UIControlStateNormal];
    [self.pause setTitleColor:[UIColor darkHuesBlueText] forState:UIControlStateNormal];
    [self.pause addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pause" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.pause];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePowerup1Title) name:@"hues.powerup1.update" object:nil];
}

- (void)updatePowerup1Title {
    [self.powerup1 setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] totalSkips]] forState:UIControlStateNormal];
    if ([[ScoreModel sharedScoreModel] totalSkips] > 0) {
        self.powerup1.enabled = true;
    } else {
        self.powerup1.enabled = false;
    }
}

- (void)setScore:(NSInteger)score {
    [self.scoreLabel setText:[NSString stringWithFormat:@"%ld",(long)score]];
}

- (void)setTime:(NSInteger)time {
    timeLabel.text = [NSString stringWithFormat:@"%ld",(long)time];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
