//
//  HuesAlert.m
//  Hues
//
//  Created by Drew Dunne on 7/23/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "HuesAlert.h"

const CGFloat width = 250;
const CGFloat height = 126;
const CGFloat kButtonHeight = 36.0;
const CGFloat kButtonWidth = 210;
const CGFloat kTitleHeight = 30.0;

@interface HuesAlert () {
    HuesAlertIndex buttonIndex;
}

@end

@implementation HuesAlert

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
        self.alpha = 0;
        [self createSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
        self.alpha = 0;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleExitTap:)];
    [self addGestureRecognizer:tapRec];
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-width)/2, 0-height-1, width, height)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 20;
    mainView.clipsToBounds = true;
    [self addSubview:mainView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, width-20, kTitleHeight)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor darkHuesBlueText];
    titleLabel.font = [UIFont fontWithName:@"Avenir" size:26];
    titleLabel.tag = 51;
    [mainView addSubview:titleLabel];
    
    cancelButton = [[HuesButton alloc] initWithColor:[UIColor huesGreen]];
    [cancelButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonIndexPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(20, 20+kTitleHeight+20, kButtonWidth, kButtonHeight);
    cancelButton.tag = 2;
    [cancelButton addSoundWithContentsOfFile:@"touch.wav" forControlEvents:UIControlEventTouchDown];
    [mainView addSubview:cancelButton];
}

- (void)buttonIndexPressed:(HuesButton *)sender {
    if (sender.tag == 1) {
        buttonIndex = HuesAlertConfirmed;
    } else if (sender.tag == 2) {
        buttonIndex = HuesAlertCanceled;
    } else {
        buttonIndex = HuesAlertCanceled;
    }
    [self close];
}

- (void)handleExitTap:(UITapGestureRecognizer *)tapGest {
    CGPoint touchPoint = [tapGest locationInView:self];
    CGPoint location = [mainView convertPoint:touchPoint fromView:mainView.window];
    if (CGRectContainsPoint(mainView.bounds, location) == false) {
        buttonIndex = HuesAlertCanceled;
        [self close];
    }
}

- (void)setTitle:(NSString *)title {
    titleLabel.text = title;
}

- (void)setDismissButtonText:(NSString *)dismiss {
    [cancelButton setTitle:dismiss forState:UIControlStateNormal];
}

- (void)show {
    [UIView beginAnimations:@"animateIn" context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce)];
    mainView.frame = CGRectMake((self.frame.size.width-width)/2, (self.frame.size.height-height)/2+10, width, height);
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)bounce {
    [UIView beginAnimations:@"bounceUp" context:nil];
    [UIView setAnimationDuration:0.1];
    mainView.frame = CGRectMake((self.frame.size.width-width)/2, (self.frame.size.height-height)/2, width, height);
    [UIView commitAnimations];
}

- (void)close {
    [UIView beginAnimations:@"animateOut" context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(quit)];
    mainView.frame = CGRectMake((self.frame.size.width-width)/2, self.frame.size.height+height+10, width, height);
    self.alpha = 0;
    [UIView commitAnimations];
}

- (void)quit {
     [self.delegate alert:self didExitWithButtonIndex:buttonIndex];
}

@end
