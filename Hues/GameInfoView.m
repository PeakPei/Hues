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
    UILabel *staticScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, (self.frame.size.width-40)/3, 20)];
    staticScoreLabel.text = @"Score";
    staticScoreLabel.textColor = [UIColor darkHuesBlueText];
    staticScoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:15];
    staticScoreLabel.textAlignment = NSTextAlignmentCenter;
    staticScoreLabel.alpha = 1.0f;
    [self addSubview:staticScoreLabel];
    
    //Create Score Label
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 34, (self.frame.size.width-40)/3, 24)];
    self.scoreLabel.text = @"0";
    self.scoreLabel.textColor = [UIColor huesBlue];
    self.scoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:28];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.alpha = 1.0f;
    [self addSubview:self.scoreLabel];
    
    //Create the static timer
    UILabel *staticTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(24+(self.frame.size.width-40)/3, 8, (self.frame.size.width-40)/3, 20)];
    staticTimeLabel.text = @"Time";
    staticTimeLabel.textColor = [UIColor darkHuesBlueText];
    staticTimeLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:15];
    staticTimeLabel.textAlignment = NSTextAlignmentCenter;
    staticTimeLabel.alpha = 1.0f;
    [self addSubview:staticTimeLabel];
    
    //Create the timer
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(24+(self.frame.size.width-40)/3, 34, (self.frame.size.width-40)/3, 24)];
    self.timeLabel.text = @"10";
    self.timeLabel.textColor = [UIColor huesBlue];
    self.timeLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:28];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.alpha = 1.0f;
    [self addSubview:self.timeLabel];
    
    UIView *horDarkDiv = [[UIView alloc] initWithFrame:CGRectMake(0, GAME_INFO_HEIGHT, self.frame.size.width, 1)];
    horDarkDiv.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self addSubview:horDarkDiv];
    
    _pu2x2 = [GameInfoButton buttonWithType:UIButtonTypeCustom];
    self.pu2x2.frame = CGRectMake(0, GAME_INFO_HEIGHT, self.frame.size.width/3, self.frame.size.height-GAME_INFO_HEIGHT);
    self.pu2x2.adjustsImageWhenHighlighted = false;
    [self.pu2x2 setImage:[UIImage imageNamed:@"2x2.png"] forState:UIControlStateNormal];
    [self.pu2x2 setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    self.pu2x2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.pu2x2.titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
    [self.pu2x2 setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] total2x2]] forState:UIControlStateNormal];
    if ([[ScoreModel sharedScoreModel] total2x2] > 0) {
        self.pu2x2.enabled = true;
    } else {
        self.pu2x2.enabled = false;
    }
    [self.pu2x2 setTitleColor:[UIColor darkHuesBlueText] forState:UIControlStateNormal];
    [self.pu2x2 addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"skip" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.pu2x2];
    
    _puSkip = [GameInfoButton buttonWithType:UIButtonTypeCustom];
    self.puSkip.frame = CGRectMake(self.frame.size.width/3, GAME_INFO_HEIGHT, self.frame.size.width/3, self.frame.size.height-GAME_INFO_HEIGHT);
    self.puSkip.adjustsImageWhenHighlighted = false;
    [self.puSkip setImage:[UIImage imageNamed:@"skip.png"] forState:UIControlStateNormal];
    [self.puSkip setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    self.puSkip.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.puSkip.titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
    [self.puSkip setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] totalSkips]] forState:UIControlStateNormal];
    if ([[ScoreModel sharedScoreModel] totalSkips] > 0) {
        self.puSkip.enabled = true;
    } else {
        self.puSkip.enabled = false;
    }
    [self.puSkip setTitleColor:[UIColor darkHuesBlueText] forState:UIControlStateNormal];
    [self.puSkip addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"skip" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.puSkip];
    
    _puAddTime = [GameInfoButton buttonWithType:UIButtonTypeCustom];
    self.puAddTime.frame = CGRectMake(2*self.frame.size.width/3, GAME_INFO_HEIGHT, self.frame.size.width/3, self.frame.size.height-GAME_INFO_HEIGHT);
    self.puAddTime.adjustsImageWhenHighlighted = false;
    [self.puAddTime setImage:[UIImage imageNamed:@"addTime.png"] forState:UIControlStateNormal];
    [self.puAddTime setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    self.puAddTime.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.puAddTime.titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
    [self.puAddTime setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] totalAddTime]] forState:UIControlStateNormal];
    if ([[ScoreModel sharedScoreModel] totalAddTime] > 0) {
        self.puAddTime.enabled = true;
    } else {
        self.puAddTime.enabled = false;
    }
    [self.puAddTime setTitleColor:[UIColor darkHuesBlueText] forState:UIControlStateNormal];
    [self.puAddTime addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"skip" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.puAddTime];
    
    _pause = [GameInfoButton buttonWithType:UIButtonTypeSystem];
    self.pause.frame = CGRectMake(24+2*(self.frame.size.width-40)/3, 0, (self.frame.size.width-40)/3, GAME_INFO_HEIGHT);
    self.pause.adjustsImageWhenHighlighted = false;
    [self.pause setImage:[UIImage imageNamed:@"pause-large.png"] forState:UIControlStateNormal];
    [self.pause setTintColor:[UIColor huesBlue]];
    [self.pause setImageEdgeInsets:UIEdgeInsetsMake(30, 0, 10, 0)];
    self.pause.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.pause.titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
//    [self.pause setTitle:@"Pause" forState:UIControlStateNormal];
    [self.pause setTitleColor:[UIColor darkHuesBlueText] forState:UIControlStateNormal];
    [self.pause addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pause" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.pause];
    
    UILabel *staticPauseLabel = [[UILabel alloc] initWithFrame:CGRectMake(24+2*(self.frame.size.width-40)/3, 8, (self.frame.size.width-40)/3, 20)];
    staticPauseLabel.text = @"Pause";
    staticPauseLabel.textColor = [UIColor darkHuesBlueText];
    staticPauseLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:15];
    staticPauseLabel.textAlignment = NSTextAlignmentCenter;
    staticPauseLabel.alpha = 1.0f;
    [self addSubview:staticPauseLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update2x2Title) name:@"hues.pu2x2.update" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSkipTitle) name:@"hues.puSkip.update" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAddTimeTitle) name:@"hues.puAddTime.update" object:nil];
}

- (void)flashTime {
    timeLabel.textColor = [UIColor huesGreen];
    flashTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(flash) userInfo:nil repeats:true];
    flashState = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(endFlash) userInfo:nil repeats:false];
}

- (void)flash {
    if (flashState) {
        self.timeLabel.textColor = [UIColor huesBlue];
        flashState = NO;
    } else {
        timeLabel.textColor = [UIColor huesGreen];
        flashState = YES;
    }
}

- (void)endFlash {
    [flashTimer invalidate];
}

- (void)enableButtonBar:(BOOL)enabled {
    if (enabled) {
        [self update2x2Title];
        [self updateAddTimeTitle];
        [self updateSkipTitle];
    } else {
        self.pu2x2.enabled = false;
        self.puAddTime.enabled = false;
        self.puSkip.enabled = false;
    }
    self.pause.enabled = enabled;
}

- (void)enablePowerups:(BOOL)enabled {
    if (enabled) {
        [self update2x2Title];
        [self updateAddTimeTitle];
        [self updateSkipTitle];
    } else {
        self.pu2x2.enabled = false;
        self.puAddTime.enabled = false;
        self.puSkip.enabled = false;
    }
}

- (void)update2x2Title {
    [self.pu2x2 setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] total2x2]] forState:UIControlStateNormal];
    if ([[ScoreModel sharedScoreModel] total2x2] > 0) {
        self.pu2x2.enabled = true;
    } else {
        self.pu2x2.enabled = false;
    }
}

- (void)updateSkipTitle {
    [self.puSkip setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] totalSkips]] forState:UIControlStateNormal];
    if ([[ScoreModel sharedScoreModel] totalSkips] > 0) {
        self.puSkip.enabled = true;
    } else {
        self.puSkip.enabled = false;
    }
}

- (void)updateAddTimeTitle {
    [self.puAddTime setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] totalAddTime]] forState:UIControlStateNormal];
    if ([[ScoreModel sharedScoreModel] totalAddTime] > 0) {
        self.puAddTime.enabled = true;
    } else {
        self.puAddTime.enabled = false;
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
