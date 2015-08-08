//
//  PauseAlertView.m
//  Hues
//
//  Created by Drew Dunne on 7/25/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "PauseAlertView.h"

const CGFloat kButtonSpacing = 26.0;
const CGFloat kPauseLabelHeight = 60.0;

@implementation PauseAlertView

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
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake(super.frame.size.width/2, super.frame.size.height/2, 0, 0)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 20;
    mainView.clipsToBounds = true;
    [self addSubview:mainView];
    
    pauseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0-super.frame.size.width*2/6, 10, 0, kPauseLabelHeight)];
    pauseLabel.text = @"Paused";
    pauseLabel.textAlignment = NSTextAlignmentCenter;
    pauseLabel.textColor = [UIColor darkHuesBlueText];
    pauseLabel.font = [UIFont boldSystemFontOfSize:45];
    pauseLabel.tag = 51;
    [mainView addSubview:pauseLabel];
    
    buttonSpacing = self.frame.size.height * 0.04;
    if (buttonSpacing < 20) {
        buttonSpacing = 8;
    }
    buttonHeight = (super.frame.size.height/2 - kPauseLabelHeight - 10 - 4*buttonSpacing)/3;
    
    resumeButton = [[HuesButton alloc] initWithColor:[UIColor huesBlue]];
    [resumeButton setTitle:@"Resume" forState:UIControlStateNormal];
    [resumeButton addTarget:self action:@selector(buttonIndexPressed:) forControlEvents:UIControlEventTouchUpInside];
    resumeButton.frame = CGRectMake(0 , 10+kPauseLabelHeight+buttonSpacing, 0, buttonHeight);
    resumeButton.tag = 1;
    [resumeButton addSoundWithContentsOfFile:@"touch.wav" forControlEvents:UIControlEventTouchDown];
    [mainView addSubview:resumeButton];
    
    storeButton = [[HuesButton alloc] initWithColor:[UIColor huesGreen]];
    [storeButton setTitle:@"Powerups" forState:UIControlStateNormal];
    [storeButton addTarget:self action:@selector(buttonIndexPressed:) forControlEvents:UIControlEventTouchUpInside];
    storeButton.frame = CGRectMake(0, 10+kPauseLabelHeight+2*buttonSpacing+buttonHeight, 0, buttonHeight);
    storeButton.tag = 2;
    [storeButton addSoundWithContentsOfFile:@"touch.wav" forControlEvents:UIControlEventTouchDown];
    [mainView addSubview:storeButton];
    
    quitButton = [[HuesButton alloc] initWithColor:[UIColor huesPink]];
    [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(buttonIndexPressed:) forControlEvents:UIControlEventTouchUpInside];
    quitButton.frame = CGRectMake(0, 10+kPauseLabelHeight+3*buttonSpacing+2*buttonHeight, 0, buttonHeight);
    quitButton.tag = 3;
    [quitButton addSoundWithContentsOfFile:@"touch.wav" forControlEvents:UIControlEventTouchDown];
    [mainView addSubview:quitButton];
}

- (void)buttonIndexPressed:(HuesButton *)sender {
    [self animateOutOfView];
    if (sender.tag == 1) {
        [self.delegate didExitWithButtonIndex:PauseAlertViewIndexResume];
    } else if (sender.tag == 2) {
        [self.delegate didExitWithButtonIndex:PauseAlertViewIndexStore];
    } else if (sender.tag == 3) {
        [self.delegate didExitWithButtonIndex:PauseAlertViewIndexQuit];
    } else {
        [self.delegate didExitWithButtonIndex:PauseAlertViewIndexNone];
    }
}

- (void)handleExitTap:(UITapGestureRecognizer *)tapGest {
    CGPoint touchPoint = [tapGest locationInView:self];
    CGPoint location = [mainView convertPoint:touchPoint fromView:mainView.window];
    if (CGRectContainsPoint(mainView.bounds, location) == false) {
        [self animateOutOfView];
        [self.delegate didExitWithButtonIndex:PauseAlertViewIndexResume];
    }
}

- (void)animateIntoView {
    [UIView beginAnimations:@"animateIn" context:nil];
    [UIView setAnimationDuration:0.25];
    mainView.frame = CGRectMake(super.frame.size.width/6, super.frame.size.height/4, super.frame.size.width*2/3, super.frame.size.height/2);
    pauseLabel.frame = CGRectMake(0, 10, mainView.frame.size.width, kPauseLabelHeight);
    resumeButton.frame = CGRectMake(20, 10+kPauseLabelHeight+buttonSpacing, mainView.frame.size.width-40, buttonHeight);
    storeButton.frame = CGRectMake(20, 10+kPauseLabelHeight+2*buttonSpacing+buttonHeight, mainView.frame.size.width-40, buttonHeight);
    quitButton.frame = CGRectMake(20, 10+kPauseLabelHeight+3*buttonSpacing+2*buttonHeight, mainView.frame.size.width-40, buttonHeight);
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)animateOutOfView {
    [UIView beginAnimations:@"animateOut" context:nil];
    [UIView setAnimationDuration:0.25];
    mainView.frame = CGRectMake(super.frame.size.width/2, super.frame.size.height/2, 0, 0);
    pauseLabel.frame = CGRectMake(0-super.frame.size.width*2/6, 10, 0, kPauseLabelHeight);
    resumeButton.frame = CGRectMake(0 , 10+kPauseLabelHeight+buttonSpacing, 0, buttonHeight);
    storeButton.frame = CGRectMake(0, 10+kPauseLabelHeight+2*buttonSpacing+buttonHeight, 0, buttonHeight);
    quitButton.frame = CGRectMake(0, 10+kPauseLabelHeight+3*buttonSpacing+2*buttonHeight, 0, buttonHeight);
    self.alpha = 0;
    [UIView commitAnimations];
}

@end
