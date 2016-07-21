//
//  PowerupsViewController.m
//  Hues
//
//  Created by Drew Dunne on 8/11/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "PowerupsViewController.h"

@interface PowerupsViewController () {
    PowerupView *p2x2View;
    PowerupView *skipView;
    PowerupView *addTimeView;
    UILabel *totalPoints;
    UILabel *errorLabel;
}

@end

@implementation PowerupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create Nav view
    NavView *nav = [[NavView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    nav.titleLabel.text = @"Powerups";
    [nav.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    
    CGFloat distFromNav = 30;
    if ([[ UIScreen mainScreen] bounds].size.height < 568)
        distFromNav = 10;
    
    p2x2View = [[PowerupView alloc] initWithFrame:CGRectMake(0, distFromNav+50, self.view.frame.size.width, 160)];
    [p2x2View setPU:PU2x2];
    [p2x2View setDelegate:self];
    p2x2View.tag = 1;
    [self.view addSubview:p2x2View];
    
    skipView = [[PowerupView alloc] initWithFrame:CGRectMake(1*self.view.frame.size.width/3, distFromNav+50, self.view.frame.size.width, 160)];
    [skipView setPU:PUSkip];
    [skipView setDelegate:self];
    skipView.tag = 2;
    [self.view addSubview:skipView];
    
    addTimeView = [[PowerupView alloc] initWithFrame:CGRectMake(2*self.view.frame.size.width/3, distFromNav+50, self.view.frame.size.width, 160)];
    [addTimeView setPU:PUAddTime];
    [addTimeView setDelegate:self];
    addTimeView.tag = 3;
    [self.view addSubview:addTimeView];
    
    DividerView *horDivider = [[DividerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width*0.2)/2, 50+2*distFromNav+160, self.view.frame.size.width*0.8, 2)];
    [self.view addSubview:horDivider];
    
    // Error label
    errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 90, self.view.frame.size.width, 45)];
    errorLabel.textAlignment = NSTextAlignmentCenter;
    errorLabel.text = @"Not Enough Points!";
    errorLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    errorLabel.textColor = [UIColor redColor];
    errorLabel.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.15];
    errorLabel.alpha = 0;
    [self.view addSubview:errorLabel];
    
    // Total points label
    totalPoints = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 45, self.view.frame.size.width, 45)];
    totalPoints.textAlignment = NSTextAlignmentCenter;
    totalPoints.text = [NSString stringWithFormat:@"Total Points: %ld", (long)[[ScoreModel sharedScoreModel] totalPoints]];
    totalPoints.font = [UIFont fontWithName:@"Avenir" size:24];
    totalPoints.textColor = [UIColor darkHuesBlueText];
    totalPoints.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:totalPoints];
}

- (void)puView:(UIView *)puv didPressPurchase:(BOOL)pressed {
    if (pressed) {
        switch (puv.tag) {
            case 1:
                [self purchasePowerup:PU2x2];
                break;
            case 2:
                [self purchasePowerup:PUSkip];
                break;
            case 3:
                [self purchasePowerup:PUAddTime];
                break;
            default:
                break;
        }
    }
}

- (void)purchasePowerup:(PUType)put {
    BOOL couldBuy = true;
    couldBuy = [[ScoreModel sharedScoreModel] purchasePowerupWithType:put];
    if (couldBuy) {
        // update amount
        [p2x2View updateSubviews];
        [skipView updateSubviews];
        [addTimeView updateSubviews];
        totalPoints.text = [NSString stringWithFormat:@"Total Points: %ld", (long)[[ScoreModel sharedScoreModel] totalPoints]];
    } else {
        // alert not enough points
        [UIView beginAnimations:@"errorIn" context:nil];
        [UIView setAnimationDuration:0.25];
        errorLabel.alpha = 1;
        [UIView commitAnimations];
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(errorOut) userInfo:nil repeats:false];
    }
}

- (void)errorOut {
    [UIView beginAnimations:@"errorIn" context:nil];
    [UIView setAnimationDuration:0.25];
    errorLabel.alpha = 0;
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
