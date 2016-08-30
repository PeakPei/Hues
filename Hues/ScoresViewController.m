//
//  ScoresViewController.m
//  Hues
//
//  Created by Drew Dunne on 8/11/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "ScoresViewController.h"

@interface ScoresViewController ()

@end

@implementation ScoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create Nav view
    NavView *nav = [[NavView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    nav.titleLabel.text = @"Scores";
    [nav.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    
    //Create the static timer
    UILabel *bestScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.view.frame.size.width*0.2 - 50, self.view.frame.size.width-32, 22)];
    bestScoreLabel.text = @"Best Score";
    bestScoreLabel.textColor = [UIColor darkHuesBlueText];
    bestScoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:18];
    bestScoreLabel.textAlignment = NSTextAlignmentCenter;
    bestScoreLabel.alpha = 1.0f;
//    [self.view addSubview:bestScoreLabel];
    
    //Create the timer
    highScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, bestScoreLabel.frame.origin.y + 30, self.view.frame.size.width-32, 84)];
    highScoreLabel.text = @"0";
    highScoreLabel.textColor = [UIColor huesBlue];
    highScoreLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:75];
    highScoreLabel.textAlignment = NSTextAlignmentCenter;
    highScoreLabel.alpha = 1.0f;
//    [self.view addSubview:highScoreLabel];
    
    DividerView *horDivider = [[DividerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width*0.2)/2, self.view.frame.size.width*0.2 + 128 - 50, self.view.frame.size.width*0.8, 2)];
//    [self.view addSubview:horDivider];
    
//    UIScrollView *achievementScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width*0.2 + 128+2, self.view.frame.size.width, self.view.frame.size.height - (self.view.frame.size.width*0.2 + 128+2))];
    UIScrollView *achievementScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50)];
    achievementScroller.showsVerticalScrollIndicator = false;
    achievementScroller.showsHorizontalScrollIndicator = false;
    achievementScroller.bounces = true;
    
    [achievementScroller addSubview:bestScoreLabel];
    [achievementScroller addSubview:highScoreLabel];
    [achievementScroller addSubview:horDivider];
    
    CGFloat gap = 16;
    CGFloat height = 85;
    if ([UIScreen mainScreen].bounds.size.width < 375) {
        height = 85;
        gap = 16;
    }
    NSArray *keys = [[ScoreModel sharedScoreModel] achievementKeys];
    long count = keys.count;
//    achievementScroller.contentSize = CGSizeMake(self.view.frame.size.width, gap*(count/2 + 1)+(count/2)*height);
    achievementScroller.contentSize = CGSizeMake(self.view.frame.size.width, gap*(count+1)+(count)*height + self.view.frame.size.width*0.2 + 78);
    for (int i = 0; i < count; i++) {
//        CGRect frame = (i%2 == 0) ? CGRectMake((self.view.frame.size.width*0.2)/2, gap*(i+1)+height*i, self.view.frame.size.width*0.4 - 4, height) : CGRectMake((self.view.frame.size.width*0.2)/2 + self.view.frame.size.width*0.4 + 4, gap*(i+1)+height*i, self.view.frame.size.width*0.4 - 4, height);
        CGRect frame = CGRectMake((self.view.frame.size.width*0.2)/2, gap*(i+1/2.0)+height*i + self.view.frame.size.width*0.2 + 78, self.view.frame.size.width*0.8, height);
        AchievementView *ach1 = [[AchievementView alloc] initWithFrame:frame];
        [ach1 setAchievement:keys[i]];
        [achievementScroller addSubview:ach1];
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
