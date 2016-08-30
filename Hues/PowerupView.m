//
//  PowerupView.m
//  Hues
//
//  Created by Drew Dunne on 5/6/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "PowerupView.h"
#import "HuesButton.h"

@implementation PowerupView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width/3, 160)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    powerupImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-36)/2, 9, 36, 36)];
    [powerupImageView setImage:[UIImage imageNamed:@"skip.png"]];
    [self addSubview:powerupImageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 53, self.frame.size.width, 24)];
    titleLabel.text = @"Skip";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    titleLabel.textColor = [UIColor darkHuesBlueText];
    [self addSubview:titleLabel];
    
    buyButton = [HuesButton buttonWithColor:[UIColor huesBlue]];
    buyButton.frame = CGRectMake((self.frame.size.width-84)/2, 85, 84, 30);
    [buyButton setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] priceForPUType:pu]] forState:UIControlStateNormal];
    [buyButton addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pause" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [buyButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buyButton];
    
    totalPUs = [[UILabel alloc] initWithFrame: CGRectMake((self.frame.size.width-84)/2, 126, 84, 30)];
    totalPUs.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    totalPUs.layer.borderWidth = 2;
    totalPUs.layer.borderColor = [UIColor colorWithWhite:0.85 alpha:1].CGColor;
    totalPUs.textAlignment = NSTextAlignmentCenter;
    NSOperatingSystemVersion sysVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    if (sysVersion.majorVersion > 8)
        totalPUs.font = [UIFont monospacedDigitSystemFontOfSize:14 weight:0.1];
    else
        totalPUs.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    totalPUs.textColor = [UIColor darkHuesBlueText];
    [self addSubview:totalPUs];
}

- (void)buttonPressed {
    if (_delegate != nil) {
        [_delegate puView:self didPressPurchase:true];
    }
}

- (void)setDescription:(NSString *)desc {
    descLabel.text = desc;
}

- (void)setPU:(PUType)pwu {
    pu = pwu;
    titleLabel.text = [NSString stringWithFormat:@"%@", [[ScoreModel sharedScoreModel] titleForPUType:pu]];
    totalPUs.text = [NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] amountForPUType:pu]];
    [buyButton setTitle:[NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] priceForPUType:pu]] forState:UIControlStateNormal];
    [powerupImageView setImage:[[ScoreModel sharedScoreModel] imageForPUType:pu]];
}

- (void)updateSubviews {
    totalPUs.text = [NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] amountForPUType:pu]];
}

- (PUType)getPU {
    return pu;
}

- (void)setPowerupImage:(UIImage *)image {
    [powerupImageView setImage:image];
}

@end
