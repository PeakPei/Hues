//
//  HuesButton.m
//  Hues
//
//  Created by Drew Dunne on 8/3/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "HuesButton.h"

const CGFloat kHuesButtonBoldLineWidth = 3.0;
const CGFloat kHuesButtonNormalLineWidth = 2.0;

@implementation HuesButton

+ (HuesButton *)buttonWithColor:(UIColor *)color {
    HuesButton *button = [HuesButton buttonWithType:UIButtonTypeCustom];
    button.defaultColor = color;
    button.backgroundColor = color;
    button.titleLabel.font = [UIFont monospacedDigitSystemFontOfSize:14 weight:0.1];
    return button;
}

- (id)initWithColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        //stuff
        _defaultColor = color;
        self.backgroundColor = color;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.titleLabel.font = [UIFont monospacedDigitSystemFontOfSize:12 weight:0.1];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
        self.layer.cornerRadius = self.bounds.size.height/2;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.layer.cornerRadius = self.frame.size.height/2;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [UIView beginAnimations:@"scale_tile" context:NULL];
    [UIView setAnimationDuration: 0.1];
    if (highlighted) {
        self.backgroundColor = [UIColor darkerColorForColor:self.defaultColor];
    } else {
        self.backgroundColor = self.defaultColor;
    }
    [UIView commitAnimations];
}

@end
