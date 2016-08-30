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
    scoreLabel.minimumScaleFactor = 0.2;
    scoreLabel.adjustsFontSizeToFitWidth = true;
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
    highScoreLabel.minimumScaleFactor = 0.2;
    highScoreLabel.adjustsFontSizeToFitWidth = true;
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
    CGFloat yPos = self.view.frame.size.height - tileWidth - (8 + ((self.view.frame.size.width-40)/2 - tileWidth)/2);
    restartButton.adjustsImageWhenHighlighted = false;
    restartButton.frame = CGRectMake(16 + ((self.view.frame.size.width-40)/2 - tileWidth)/2, yPos, tileWidth, tileWidth);
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
    storeButton.frame = CGRectMake(24+(self.view.frame.size.width-40)/2 + ((self.view.frame.size.width-40)/2 - tileWidth)/2, yPos, tileWidth, tileWidth);
    [storeButton setImage:[UIImage imageNamed:@"powerups_2.png"] forState:UIControlStateNormal];
    storeButton.backgroundColor = [UIColor huesPink];
    [storeButton addTarget:self action:@selector(storePressed:) forControlEvents:UIControlEventTouchUpInside];
    storeButton.enabled = true;
    storeButton.opaque = true;
    storeButton.layer.borderWidth = 0;
    storeButton.layer.cornerRadius = 5.0;
    [storeButton addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:storeButton];
    
    UIScrollView *achievementScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width*0.2 + 128+2, self.view.frame.size.width, self.view.frame.size.height - (self.view.frame.size.width*0.2 + 128+2) - (self.view.frame.size.height - (yPos-20)))];
    achievementScroller.showsVerticalScrollIndicator = false;
    achievementScroller.showsHorizontalScrollIndicator = false;
    achievementScroller.bounces = true;
    
    CGFloat gap = 16;
    CGFloat textSpacer = 16;
    CGFloat height = 56;
    if ([UIScreen mainScreen].bounds.size.width < 375) {
        height = 48;
    }
    CGFloat bonusHeight = 36;
    
    UILabel *bonusLabel = [[UILabel alloc] initWithFrame:CGRectMake(achievementScroller.frame.size.width*0.2/2, textSpacer, achievementScroller.frame.size.width*0.8, bonusHeight)];
    bonusLabel.text = @"No New Achievements";
    bonusLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    bonusLabel.textColor = [UIColor darkHuesBlueText];
    bonusLabel.minimumScaleFactor = 0.2;
    bonusLabel.adjustsFontSizeToFitWidth = true;
    bonusLabel.textAlignment = NSTextAlignmentCenter;
    bonusLabel.alpha = 1.0f;
    bonusLabel.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    bonusLabel.layer.borderWidth = 1;
    bonusLabel.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    [achievementScroller addSubview:bonusLabel];
    
    NSArray *keys = [[ScoreModel sharedScoreModel] getNewUnlocks];
    
    long bonusPoints = 0;
    long count = keys.count;
    achievementScroller.contentSize = CGSizeMake(self.view.frame.size.width, 2*textSpacer+bonusHeight+gap*(count/2)+(count/2)*height);
    for (int i = 0; i < count; i++) {
        CGRect frame = (i%2 == 0) ? CGRectMake((self.view.frame.size.width*0.2)/2, 2*textSpacer+bonusHeight+gap*(floor(i/2))+height*floor(i/2), self.view.frame.size.width*0.4 - 4, height) : CGRectMake((self.view.frame.size.width*0.2)/2 + self.view.frame.size.width*0.4 + 4, 2*textSpacer+bonusHeight+gap*(floor(i/2))+height*floor(i/2), self.view.frame.size.width*0.4 - 4, height);
        AchievementView *ach1 = [[AchievementView alloc] initWithFrame:frame];
        [ach1 setAchievement:keys[i]];
        [achievementScroller addSubview:ach1];
        NSDictionary *info = [[ScoreModel sharedScoreModel] achievementInfoForKey:keys[i]];
        bonusPoints += [info[@"bonus"] integerValue];
    }
    if (bonusPoints != 0) {
        bonusLabel.text = [NSString stringWithFormat:@"+ %ld Points!",bonusPoints];
        DividerView *horDivider2 = [[DividerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width*0.2)/2, yPos-20, self.view.frame.size.width*0.8, 2)];
        [self.view addSubview:horDivider2];
    }
    
    [self.view addSubview:achievementScroller];
    
    
    
//    NSInteger latestScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"latest_score"];
//    NSString *latestHash = [[NSUserDefaults standardUserDefaults] valueForKey:@"^RFH&)#D"];
//    NSString *latestScoreString = [NSString stringWithFormat:@"F3A7%ld1G9E",(long)latestScore];
//    NSMutableString *magicLatestCheck = [latestScoreString MD5String].mutableCopy;
//    if (![latestHash isEqualToString:magicLatestCheck]) {
//        NSLog(@"Cheater!");
//        latestScore = 0;
//    }
//    
//    NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"high_score"];
//    NSString *highHash = [[NSUserDefaults standardUserDefaults] valueForKey:@"_8gy*wa+f"];
//    
//    NSString *highScoreString = [NSString stringWithFormat:@"F3A7%ld1G9E",(long)highScore];
//    NSMutableString *magicHighCheck = [highScoreString MD5String].mutableCopy;
//    
//    if (![highHash isEqualToString:magicHighCheck]) {
//        NSLog(@"Cheater!");
//        highScore = 0;
//    }
    
    scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] latestScore]];
    highScoreLabel.text = [NSString stringWithFormat:@"%ld",(long)[[ScoreModel sharedScoreModel] highScore]];
}

- (IBAction)playAgain:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.drewsdunne.hues.restartGame" object:nil];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)storePressed:(id)sender {
//    [self.navigationController popViewControllerAnimated:true];
    [self performSegueWithIdentifier:@"powerups_from_end" sender:self];
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
