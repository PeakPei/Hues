//
//  NavView.m
//  Hues
//
//  Created by Drew Dunne on 7/24/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "NavView.h"
#import "UIColor+Hues.h"
#import "DividerView.h"

@implementation NavView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 0, frame.size.width-136, frame.size.height - 2)];
        self.titleLabel.text = @"Title";
        self.titleLabel.textColor = [UIColor darkHuesBlueText];
        self.titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:28];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.alpha = 1.0f;
        [self addSubview:self.titleLabel];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        double height = frame.size.height-12;
        double yPos = 5;
        if (frame.size.height <= 10) {
            yPos = 0;
            height = frame.size.height;
        }
        
        self.backButton.frame = CGRectMake(0, yPos, 60, height);
        [self.backButton setImage:[UIImage imageNamed:@"back-button.png"] forState:UIControlStateNormal];
        [self.backButton setTintColor:[UIColor huesBlue]];
        self.backButton.alpha = 0.9;
        [self addSubview:self.backButton];
        
        DividerView *horDivider = [[DividerView alloc] initWithFrame:CGRectMake(0, frame.size.height-2, frame.size.width, 2)];
        [self addSubview:horDivider];
    }
    return self;
}

@end
