//
//  ScoreModel.m
//  Hues
//
//  Created by Drew Dunne on 7/25/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "ScoreModel.h"
#import "NSString+MD5.h"

#define POWERUP_SKIP_COST 500

static NSString *leaderboardID = @"threebythree.hues";

@implementation ScoreModel

static ScoreModel *sharedScoreModel = nil;

+ (id)sharedScoreModel {
    @synchronized(self)
    {
        if (sharedScoreModel == nil)
        {
            sharedScoreModel = [[ScoreModel alloc] init];
        }
    }
    return sharedScoreModel;
}

- (id)init {
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //Get the total points
        _totalPoints = [[NSUserDefaults standardUserDefaults] integerForKey:@"total_points"];
        NSString *totalPointsHash = [[NSUserDefaults standardUserDefaults] valueForKey:@"Hd4yG34D7e"];
        NSString *totalPointsString = [NSString stringWithFormat:@"RF6H%ld9UD4",(long)_totalPoints];
        NSMutableString *magicTotalCheck = [totalPointsString MD5String].mutableCopy;
        if (![totalPointsHash isEqualToString:magicTotalCheck]) {
            NSLog(@"Cheater - Points!");
            _totalPoints = 0;
            [[NSUserDefaults standardUserDefaults] setValue:[[NSString stringWithFormat:@"RF6H%ld9UD4",(long)_totalPoints] MD5String] forKey:@"Hd4yG34D7e"];
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"total_points"];
        }
        
        //Get total skips
        _totalSkips = [[NSUserDefaults standardUserDefaults] integerForKey:@"powerup_skips"];
        NSString *totalSkipsHash = [[NSUserDefaults standardUserDefaults] valueForKey:@"&$HF8rs"];
        NSString *totalSkipsString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)_totalSkips];
        NSMutableString *magicSkipsCheck = [totalSkipsString MD5String].mutableCopy;
        if (![totalSkipsHash isEqualToString:magicSkipsCheck]) {
            NSLog(@"Cheater - Skips!");
            _totalSkips = 0;
            [[NSUserDefaults standardUserDefaults] setValue:[[NSString stringWithFormat:@"7GE6%ld4IA7",(long)_totalSkips] MD5String] forKey:@"&$HF8rs"];
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"powerup_skips"];
        }
        
    }
    return self;
}

- (BOOL)reportScore:(NSInteger)score withHash:(NSString *)hash {
    
    NSString *scoreString = [NSString stringWithFormat:@"F3A7%ld1G9E",(long)score];
    NSMutableString *magicCheck = [scoreString MD5String].mutableCopy;
    
    if (![hash isEqualToString:magicCheck]) {
        NSLog(@"Cheater - Score!");
        [[NSUserDefaults standardUserDefaults] setValue:[[NSString stringWithFormat:@"F3A7%ld1G9E",(long)0] MD5String] forKey:@"_8gy*wa+f"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"high_score"];
        return false;
    } else {
        NSInteger prevHighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"high_score"];
        BOOL newHigh = false;
        if (score > prevHighScore) {
            [[NSUserDefaults standardUserDefaults] setValue:hash forKey:@"_8gy*wa+f"];
            [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"high_score"];
            newHigh = true;
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:hash forKey:@"^RFH&)#D"];
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"latest_score"];
        
        self.totalPoints += score;
        NSString *totalPointsString = [NSString stringWithFormat:@"RF6H%ld9UD4",(long)self.totalPoints];
        NSMutableString *magicTotal = [totalPointsString MD5String].mutableCopy;
        [[NSUserDefaults standardUserDefaults] setValue:magicTotal forKey:@"Hd4yG34D7e"];
        [[NSUserDefaults standardUserDefaults] setInteger:self.totalPoints forKey:@"total_points"];
        
        if (appDelegate.gameCenterEnabled) {
            GKScore *gkScore = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardID];
            gkScore.value = score;
            
            [GKScore reportScores:@[gkScore] withCompletionHandler:^(NSError *error) {
                if (error != nil) {
                    NSLog(@"%@", [error localizedDescription]);
                    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"LastScoreReportedToGC"];
                } else {
                    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"LastScoreReportedToGC"];
                }
            }];
        }
        
        return newHigh;
    }
    return false;
}

- (BOOL)purchaseSkipPowerup {
    if (self.totalPoints >= POWERUP_SKIP_COST) {
        self.totalPoints -= POWERUP_SKIP_COST;
        self.totalSkips++;
        
        NSString *totalPointsString = [NSString stringWithFormat:@"RF6H%ld9UD4",(long)self.totalPoints];
        NSMutableString *magicTotal = [totalPointsString MD5String].mutableCopy;
        [[NSUserDefaults standardUserDefaults] setValue:magicTotal forKey:@"Hd4yG34D7e"];
        [[NSUserDefaults standardUserDefaults] setInteger:self.totalPoints forKey:@"total_points"];
        
        NSString *totalSkipsString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)self.totalSkips];
        NSMutableString *magicSkips = [totalSkipsString MD5String].mutableCopy;
        [[NSUserDefaults standardUserDefaults] setValue:magicSkips forKey:@"&$HF8rs"];
        [[NSUserDefaults standardUserDefaults] setInteger:self.totalSkips forKey:@"powerup_skips"];
    }
    
    //Not enough to buy skip
    return false;
}

- (BOOL)useSkipPowerup {
    if (self.totalSkips > 0) {
        self.totalSkips--;
        
        NSString *totalSkipsString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)self.totalSkips];
        NSMutableString *magicSkips = [totalSkipsString MD5String].mutableCopy;
        [[NSUserDefaults standardUserDefaults] setValue:magicSkips forKey:@"&$HF8rs"];
        [[NSUserDefaults standardUserDefaults] setInteger:self.totalSkips forKey:@"powerup_skips"];
    }
    
    //Not enough for use skip
    return false;
}

@end
