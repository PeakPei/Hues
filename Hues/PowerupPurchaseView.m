//
//  PowerupPurchaseView.m
//  Hues
//
//  Created by Drew Dunne on 4/29/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "PowerupPurchaseView.h"

const CGFloat kButtonSpacing = 26.0;
const CGFloat kPurchaseLabelHeight = 30.0;

@implementation PowerupPurchaseView

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
    
    purchaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0-super.frame.size.width*2/6, 10, 0, kPurchaseLabelHeight)];
    purchaseLabel.text = @"Buy";
    purchaseLabel.textAlignment = NSTextAlignmentCenter;
    purchaseLabel.textColor = [UIColor darkHuesBlueText];
//    purchaseLabel.font = [UIFont boldSystemFontOfSize:26];
    purchaseLabel.font = [UIFont fontWithName:@"Avenir" size:26];
    purchaseLabel.tag = 51;
    [mainView addSubview:purchaseLabel];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0-super.frame.size.width*2/6, 20+kPurchaseLabelHeight, 0, kPurchaseLabelHeight)];
    priceLabel.text = @"Buy";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor darkHuesBlueText];
    //    purchaseLabel.font = [UIFont boldSystemFontOfSize:26];
    priceLabel.font = [UIFont fontWithName:@"Avenir" size:18];
    priceLabel.tag = 58;
    priceLabel.backgroundColor = [UIColor redColor];
    [mainView addSubview:priceLabel];
    
    buttonSpacing = self.frame.size.height * 0.04;
    if (buttonSpacing < 20) {
        buttonSpacing = 8;
    }
    buttonHeight = (super.frame.size.height/2 - kPurchaseLabelHeight - 10 - 4*buttonSpacing)/3;
    
    purchaseButton = [[HuesButton alloc] initWithColor:[UIColor huesBlue]];
    [purchaseButton setTitle:@"Buy" forState:UIControlStateNormal];
    [purchaseButton addTarget:self action:@selector(buttonIndexPressed:) forControlEvents:UIControlEventTouchUpInside];
    purchaseButton.frame = CGRectMake(0 , 10+kPurchaseLabelHeight+buttonSpacing, 0, buttonHeight);
    purchaseButton.tag = 1;
    [purchaseButton addSoundWithContentsOfFile:@"touch.wav" forControlEvents:UIControlEventTouchDown];
    [mainView addSubview:purchaseButton];
    
    cancelButton = [[HuesButton alloc] initWithColor:[UIColor huesGreen]];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonIndexPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(0, 10+kPurchaseLabelHeight+2*buttonSpacing+buttonHeight, 0, buttonHeight);
    cancelButton.tag = 2;
    [cancelButton addSoundWithContentsOfFile:@"touch.wav" forControlEvents:UIControlEventTouchDown];
    [mainView addSubview:cancelButton];
}

- (void)buttonIndexPressed:(HuesButton *)sender {
    [self animateOutOfView];
    if (sender.tag == 1) {
        [self.delegate didExitWithButtonIndex:PUPurchased];
    } else if (sender.tag == 2) {
        [self.delegate didExitWithButtonIndex:PUCanceled];
    } else {
        [self.delegate didExitWithButtonIndex:PUCanceled];
    }
}

- (void)handleExitTap:(UITapGestureRecognizer *)tapGest {
    CGPoint touchPoint = [tapGest locationInView:self];
    CGPoint location = [mainView convertPoint:touchPoint fromView:mainView.window];
    if (CGRectContainsPoint(mainView.bounds, location) == false) {
        [self animateOutOfView];
        [self.delegate didExitWithButtonIndex:PUCanceled];
    }
}

- (void)setPowerup:(PUType)powerupType {
    pu = powerupType;
    NSString *title = [[ScoreModel sharedScoreModel] titleForPUType:powerupType];
    NSInteger price = [[ScoreModel sharedScoreModel] priceForPUType:powerupType];
    NSLog(@"1 %@ (%ld points)",title, (long)price);
    purchaseLabel.text = [NSString stringWithFormat:@"1 %@",title];
    priceLabel.text = [NSString stringWithFormat:@"%ld points",(long)price];
}

- (PUType)getPU {
    return pu;
}

- (void)animateIntoView {
    [UIView beginAnimations:@"animateIn" context:nil];
    [UIView setAnimationDuration:0.25];
    mainView.frame = CGRectMake(super.frame.size.width/6, super.frame.size.height/4, super.frame.size.width*2/3, 200);
    purchaseLabel.frame = CGRectMake(0, 10, mainView.frame.size.width, kPurchaseLabelHeight);
    priceLabel.frame = CGRectMake(0, 20+kPurchaseLabelHeight, mainView.frame.size.width, kPurchaseLabelHeight);
    purchaseButton.frame = CGRectMake(20, 10+kPurchaseLabelHeight+buttonSpacing, mainView.frame.size.width-40, buttonHeight);
    cancelButton.frame = CGRectMake(20, 10+kPurchaseLabelHeight+2*buttonSpacing+buttonHeight, mainView.frame.size.width-40, buttonHeight);
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)animateOutOfView {
    [UIView beginAnimations:@"animateOut" context:nil];
    [UIView setAnimationDuration:0.25];
    mainView.frame = CGRectMake(super.frame.size.width/2, super.frame.size.height/2, 0, 0);
    purchaseLabel.frame = CGRectMake(0-super.frame.size.width*2/6, 10, 0, kPurchaseLabelHeight);
    priceLabel.frame = CGRectMake(0-super.frame.size.width*2/6, 20+kPurchaseLabelHeight, 0, kPurchaseLabelHeight);
    purchaseButton.frame = CGRectMake(0 , 10+kPurchaseLabelHeight+buttonSpacing, 0, buttonHeight);
    cancelButton.frame = CGRectMake(0, 10+kPurchaseLabelHeight+2*buttonSpacing+buttonHeight, 0, buttonHeight);
    self.alpha = 0;
    [UIView commitAnimations];
}


@end
