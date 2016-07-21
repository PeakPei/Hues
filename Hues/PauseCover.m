//
//  PauseCover.m
//  Hues
//
//  Created by Drew Dunne on 4/7/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "PauseCover.h"

#define RESUME_BUTTON_SIDE_LENGTH 160
#define QUIT_BUTTON_LENGTH 100

@implementation PauseCover

- (id)init {
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        self.alpha = 0;
        [self createSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        self.alpha = 0;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    resumeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resumeButton setTintColor:[UIColor huesBlue]];
    [resumeButton addTarget:self action:@selector(buttonIndexPressed:) forControlEvents:UIControlEventTouchUpInside];
    resumeButton.frame = CGRectMake((self.frame.size.width-RESUME_BUTTON_SIDE_LENGTH)/2, (self.frame.size.height-RESUME_BUTTON_SIDE_LENGTH)/2, RESUME_BUTTON_SIDE_LENGTH, RESUME_BUTTON_SIDE_LENGTH);
    resumeButton.tag = 1;
    [resumeButton addSoundWithContentsOfFile:@"touch.wav" forControlEvents:UIControlEventTouchDown];
    [resumeButton setImage:[UIImage imageNamed:@"resume.png"] forState:UIControlStateNormal];
    [self addSubview:resumeButton];
    
    quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    quitButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:30];
    [quitButton setTitleColor:[UIColor huesBlue] forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(buttonIndexPressed:) forControlEvents:UIControlEventTouchUpInside];
    quitButton.frame = CGRectMake((self.frame.size.width-QUIT_BUTTON_LENGTH)/2, self.frame.size.height-60, QUIT_BUTTON_LENGTH, 50);
    quitButton.tag = 2;
    [quitButton addSoundWithContentsOfFile:@"touch.wav" forControlEvents:UIControlEventTouchDown];
    [self addSubview:quitButton];
}

- (void)buttonIndexPressed:(UIButton *)sender {
    [self animateOutOfView];
    if (sender.tag == 1) {
        [self.delegate didExitWithButtonIndex:PauseCoverIndexResume];
    } else if (sender.tag == 2) {
        [self.delegate didExitWithButtonIndex:PauseCoverIndexQuit];
    } else {
        [self.delegate didExitWithButtonIndex:PauseCoverIndexNone];
    }
}

- (void)handleExitTap:(UITapGestureRecognizer *)tapGest {
    CGPoint touchPoint = [tapGest locationInView:self];
    CGPoint resumeLocation = [resumeButton convertPoint:touchPoint fromView:resumeButton.window];
    CGPoint quitLocation = [quitButton convertPoint:touchPoint fromView:quitButton.window];
    if (CGRectContainsPoint(resumeButton.bounds, resumeLocation) == false && CGRectContainsPoint(quitButton.bounds, quitLocation) == false) {
        [self animateOutOfView];
        [self.delegate didExitWithButtonIndex:PauseCoverIndexResume];
    }
}

- (void)animateIntoView {
    [UIView beginAnimations:@"animateIn" context:nil];
    [UIView setAnimationDuration:0.25];
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)animateOutOfView {
    [UIView beginAnimations:@"animateOut" context:nil];
    [UIView setAnimationDuration:0.25];
    self.alpha = 0;
    [UIView commitAnimations];
}

@end
