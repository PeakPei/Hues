//
//  GameOverViewController.m
//  Hues
//
//  Created by Drew Dunne on 7/24/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "GameOverViewController.h"
#import "NSString+MD5.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //High Score Verification
    /*NSString *hash = [[NSUserDefaults standardUserDefaults] valueForKey:@"_8gy*wa+f"];
    if ([hash rangeOfString:@"F3A71G9E"].location == NSNotFound) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"high_score"];
    }*/
    
    //Create Nav view
    NavView *nav = [[NavView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    nav.titleLabel.text = @"Game Over";
    [nav.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    
    //Create static score label
    UILabel *staticScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.view.frame.size.width*0.2, (self.view.frame.size.width-40)/2, 22)];
    staticScoreLabel.text = @"Score";
    staticScoreLabel.textColor = [UIColor darkHuesBlueText];
    staticScoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:18];
    staticScoreLabel.textAlignment = NSTextAlignmentCenter;
    staticScoreLabel.alpha = 1.0f;
    [self.view addSubview:staticScoreLabel];
    
    //Create Score Label
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, staticScoreLabel.frame.origin.y + 30, (self.view.frame.size.width-40)/2, 84)];
    scoreLabel.text = @"0";
    scoreLabel.textColor = [UIColor huesBlue];
    scoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:75];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.alpha = 1.0f;
    [self.view addSubview:scoreLabel];
    
    //Create the static timer
    UILabel *staticTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(24+(self.view.frame.size.width-40)/2, self.view.frame.size.width*0.2, (self.view.frame.size.width-40)/2, 22)];
    staticTimeLabel.text = @"Best Score";
    staticTimeLabel.textColor = [UIColor darkHuesBlueText];
    staticTimeLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:18];
    staticTimeLabel.textAlignment = NSTextAlignmentCenter;
    staticTimeLabel.alpha = 1.0f;
    [self.view addSubview:staticTimeLabel];
    
    //Create the timer
    highScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(24+(self.view.frame.size.width-40)/2, staticTimeLabel.frame.origin.y + 30, (self.view.frame.size.width-40)/2, 84)];
    highScoreLabel.text = @"0";
    highScoreLabel.textColor = [UIColor huesBlue];
    highScoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:75];
    highScoreLabel.textAlignment = NSTextAlignmentCenter;
    highScoreLabel.alpha = 1.0f;
    [self.view addSubview:highScoreLabel];
    
    DividerView *vertDivider = [[DividerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-2)/2, self.view.frame.size.width*0.2 - 5, 2, 118)];
    [self.view addSubview:vertDivider];
    
    DividerView *horDivider = [[DividerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width*0.2)/2, self.view.frame.size.width*0.2 + 128, self.view.frame.size.width*0.8, 2)];
    [self.view addSubview:horDivider];
    
    
    
    restartButton = [TileButton buttonWithType:UIButtonTypeCustom];
    double width = self.view.frame.size.width;
    NSInteger spacing = width/60;
    double tileWidth = (width-(3+1)*spacing)/3.00;
    restartButton.adjustsImageWhenHighlighted = false;
    restartButton.frame = CGRectMake(16 + ((self.view.frame.size.width-40)/2 - tileWidth)/2, self.view.frame.size.width*0.2 + 158, tileWidth, tileWidth);
    [restartButton setImage:[UIImage imageNamed:@"restart.png"] forState:UIControlStateNormal];
    restartButton.backgroundColor = [UIColor huesBlue];
    [restartButton addTarget:self action:@selector(playAgain:) forControlEvents:UIControlEventTouchUpInside];
    restartButton.enabled = true;
    restartButton.opaque = true;
    restartButton.layer.borderWidth = 0;
    restartButton.layer.cornerRadius = 5.0;
    [restartButton addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:restartButton];
    
    storeButton = [TileButton buttonWithType:UIButtonTypeCustom];
    storeButton.adjustsImageWhenHighlighted = false;
    storeButton.frame = CGRectMake(24+(self.view.frame.size.width-40)/2 + ((self.view.frame.size.width-40)/2 - tileWidth)/2, self.view.frame.size.width*0.2 + 158, tileWidth, tileWidth);
    [storeButton setImage:[UIImage imageNamed:@"powerups_2.png"] forState:UIControlStateNormal];
    storeButton.backgroundColor = [UIColor huesPink];
    //[storeButton addTarget:self action:@selector(playAgain:) forControlEvents:UIControlEventTouchUpInside];
    storeButton.enabled = true;
    storeButton.opaque = true;
    storeButton.layer.borderWidth = 0;
    storeButton.layer.cornerRadius = 5.0;
    [storeButton addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:storeButton];
    
    NSInteger latestScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"latest_score"];
    NSString *latestHash = [[NSUserDefaults standardUserDefaults] valueForKey:@"^RFH&)#D"];
    NSString *latestScoreString = [NSString stringWithFormat:@"F3A7%ld1G9E",(long)latestScore];
    NSMutableString *magicLatestCheck = [latestScoreString MD5String].mutableCopy;
    if (![latestHash isEqualToString:magicLatestCheck]) {
        NSLog(@"Cheater!");
        latestScore = 0;
    }
    
    NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"high_score"];
    NSString *highHash = [[NSUserDefaults standardUserDefaults] valueForKey:@"_8gy*wa+f"];
    
    NSString *highScoreString = [NSString stringWithFormat:@"F3A7%ld1G9E",(long)highScore];
    NSMutableString *magicHighCheck = [highScoreString MD5String].mutableCopy;
    
    if (![highHash isEqualToString:magicHighCheck]) {
        NSLog(@"Cheater!");
        highScore = 0;
    }
    
    scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)latestScore];
    highScoreLabel.text = [NSString stringWithFormat:@"%ld",(long)highScore];
}

- (IBAction)playAgain:(id)sender {
    //[self.navigationController popViewControllerAnimated:true];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
