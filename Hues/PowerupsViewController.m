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
    
    CGFloat distFromNav = 50;
    if ([[ UIScreen mainScreen] bounds].size.height < 568)
        distFromNav = 30;
    
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
    
    double viewDist = 50+2*distFromNav+160+2;
    if ([[ UIScreen mainScreen] bounds].size.width >= 375) {
        DividerView *horDivider = [[DividerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width*0.2)/2, 50+2*distFromNav+160, self.view.frame.size.width*0.8, 2)];
        [self.view addSubview:horDivider];
    } else {
        viewDist = 50+distFromNav+160+2;
    }
//    UILabel *needMorePointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 50+2*distFromNav+160 + 16, self.view.frame.size.width-32, 22)];
//    needMorePointsLabel.text = @"Need More Points?";
//    needMorePointsLabel.textColor = [UIColor darkHuesBlueText];
//    needMorePointsLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:18];
//    needMorePointsLabel.textAlignment = NSTextAlignmentCenter;
//    needMorePointsLabel.alpha = 1.0f;
//    [self.view addSubview:needMorePointsLabel];
    
    
    UIView *iapContainer = [[UIView alloc] initWithFrame:CGRectMake(0, viewDist, self.view.frame.size.width, self.view.frame.size.height - viewDist - 80)];
    [self.view addSubview:iapContainer];
    
    UILabel *needMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, (iapContainer.frame.size.height-84)/2, self.view.frame.size.width-32, 30)];
    needMoreLabel.text = @"Need More Points?";
    needMoreLabel.textColor = [UIColor darkHuesBlueText];
    needMoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:26];
    needMoreLabel.textAlignment = NSTextAlignmentCenter;
    needMoreLabel.alpha = 1.0f;
    [iapContainer addSubview:needMoreLabel];
    
    HuesButton *buyMoreButton = [HuesButton buttonWithColor:[UIColor huesBlue]];
    buyMoreButton.frame = CGRectMake(self.view.frame.size.width*0.1, (iapContainer.frame.size.height-84)/2 + 38, self.view.frame.size.width*0.8, 46);
    [buyMoreButton setTitle:@"Yes I do" forState:UIControlStateNormal];
    [buyMoreButton addTarget:self action:@selector(iapPressed) forControlEvents:UIControlEventTouchUpInside];
    [iapContainer addSubview:buyMoreButton];

    
//    double labelAndButtonHeight = 22+8+30;
//    double viewHeight = iapContainer.frame.size.height;
//    double spacer = (viewHeight - 2*labelAndButtonHeight)/3;
//    const double gap = 24;
//    
//    UILabel *points2500 = [[UILabel alloc] initWithFrame:CGRectMake(16, spacer, self.view.frame.size.width/2-32, 22)];
//    points2500.text = @"2500 Points";
//    points2500.textColor = [UIColor darkHuesBlueText];
//    points2500.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
//    points2500.textAlignment = NSTextAlignmentCenter;
//    points2500.alpha = 1.0f;
//    [iapContainer addSubview:points2500];
//
//    HuesButton *buy2500 = [HuesButton buttonWithColor:[UIColor huesBlue]];
//    buy2500.frame = CGRectMake(gap, spacer+22+8, self.view.frame.size.width/2 - 2*gap, 30);
//    [buy2500 setTitle:@"$0.99" forState:UIControlStateNormal];
//    [buy2500 addTarget:self action:@selector(iapPressed) forControlEvents:UIControlEventTouchUpInside];
//    [iapContainer addSubview:buy2500];
//
//    UILabel *points7500 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+16, spacer, self.view.frame.size.width/2-32, 22)];
//    points7500.text = @"7500 Points";
//    points7500.textColor = [UIColor darkHuesBlueText];
//    points7500.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
//    points7500.textAlignment = NSTextAlignmentCenter;
//    points7500.alpha = 1.0f;
//    [iapContainer addSubview:points7500];
//    
//    HuesButton *buy7500 = [HuesButton buttonWithColor:[UIColor huesBlue]];
//    buy7500.frame = CGRectMake(self.view.frame.size.width/2+gap, spacer+22+8, self.view.frame.size.width/2 - 2*gap, 30);
//    [buy7500 setTitle:@"$1.99" forState:UIControlStateNormal];
//    [buy7500 addTarget:self action:@selector(iapPressed) forControlEvents:UIControlEventTouchUpInside];
//    [iapContainer addSubview:buy7500];
//    
//    UILabel *points30000 = [[UILabel alloc] initWithFrame:CGRectMake(16, 2*spacer+labelAndButtonHeight, self.view.frame.size.width/2-32, 22)];
//    points30000.text = @"30,000 Points";
//    points30000.textColor = [UIColor darkHuesBlueText];
//    points30000.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
//    points30000.textAlignment = NSTextAlignmentCenter;
//    points30000.alpha = 1.0f;
//    [iapContainer addSubview:points30000];
//    
//    HuesButton *buy30000 = [HuesButton buttonWithColor:[UIColor huesBlue]];
//    buy30000.frame = CGRectMake(gap, 2*spacer+labelAndButtonHeight+22+8, self.view.frame.size.width/2 - 2*gap, 30);
//    [buy30000 setTitle:@"$4.99" forState:UIControlStateNormal];
//    [buy30000 addTarget:self action:@selector(iapPressed) forControlEvents:UIControlEventTouchUpInside];
//    [iapContainer addSubview:buy30000];
//    
//    UILabel *points100000 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+16, 2*spacer+labelAndButtonHeight, self.view.frame.size.width/2-32, 22)];
//    points100000.text = @"100000 Points";
//    points100000.textColor = [UIColor darkHuesBlueText];
//    points100000.font = [UIFont fontWithName:@"Avenir Next Medium" size:16];
//    points100000.textAlignment = NSTextAlignmentCenter;
//    points100000.alpha = 1.0f;
//    [iapContainer addSubview:points100000];
//    
//    HuesButton *buy100000 = [HuesButton buttonWithColor:[UIColor huesBlue]];
//    buy100000.frame = CGRectMake(self.view.frame.size.width/2+gap, 2*spacer+labelAndButtonHeight+22+8, self.view.frame.size.width/2 - 2*gap, 30);
//    [buy100000 setTitle:@"$9.99" forState:UIControlStateNormal];
//    [buy100000 addTarget:self action:@selector(iapPressed) forControlEvents:UIControlEventTouchUpInside];
//    [iapContainer addSubview:buy100000];
    
    // Error label
    errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width, 35)];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPoints) name:@"com.drewsdunne.hues.refreshPoints" object:nil];
}

- (void)refreshPoints {
    NSLog(@"Resfreshing");
    totalPoints.text = [NSString stringWithFormat:@"Total Points: %ld", (long)[[ScoreModel sharedScoreModel] totalPoints]];
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

- (void)iapPressed {
    [self performSegueWithIdentifier:@"iap_push" sender:self];
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
