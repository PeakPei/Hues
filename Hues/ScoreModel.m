//
//  ScoreModel.m
//  Hues
//
//  Created by Drew Dunne on 7/25/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "ScoreModel.h"
#import "NSString+MD5.h"

const NSInteger POWERUP_SKIP_COST = 500;
const NSInteger POWERUP_2x2_COST = 250;
const NSInteger POWERUP_ADDTIME_COST = 100;

static NSString *leaderboardID = @"threebythree.hues";

@implementation ScoreModel

+ (instancetype)sharedScoreModel {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //Get the total points
//        _totalPoints = [[NSUserDefaults standardUserDefaults] integerForKey:@"total_points"];
//        NSString *totalPointsHash = [[NSUserDefaults standardUserDefaults] valueForKey:@"Hd4yG34D7e"];
//        NSString *totalPointsString = [NSString stringWithFormat:@"RF6H%ld9UD4",(long)_totalPoints];
//        NSMutableString *magicTotalCheck = [totalPointsString MD5String].mutableCopy;
//        if (![totalPointsHash isEqualToString:magicTotalCheck]) {
//            NSLog(@"Cheater - Points!");
//            _totalPoints = 0;
//            [[NSUserDefaults standardUserDefaults] setValue:[[NSString stringWithFormat:@"RF6H%ld9UD4",(long)_totalPoints] MD5String] forKey:@"Hd4yG34D7e"];
//            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"total_points"];
//        }
        
        //Get total skips
//        _totalSkips = [[NSUserDefaults standardUserDefaults] integerForKey:@"powerup_skips"];
//        NSString *totalSkipsHash = [[NSUserDefaults standardUserDefaults] valueForKey:@"&$HF8rs"];
//        NSString *totalSkipsString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)_totalSkips];
//        NSMutableString *magicSkipsCheck = [totalSkipsString MD5String].mutableCopy;
//        if (![totalSkipsHash isEqualToString:magicSkipsCheck]) {
//            NSLog(@"Cheater - Skips!");
//            _totalSkips = 0;
//            [[NSUserDefaults standardUserDefaults] setValue:[[NSString stringWithFormat:@"7GE6%ld4IA7",(long)_totalSkips] MD5String] forKey:@"&$HF8rs"];
//            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"powerup_skips"];
//        }
        
    }
    return self;
}

+ (NSString*)filePath {
    static NSString* filePath = nil;
    if (!filePath) {
        filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"GameData"];
    }
    return filePath;
}

static NSString* const HDataHighScoreKey = @"highScore";
static NSString* const HDataLatestScoreKey = @"latestScore";
static NSString* const HDataTotalPointsKey = @"totalPoints";
static NSString* const HDataTotalSkipsKey = @"totalSkips";
static NSString* const HDataTotal2x2Key = @"total2x2s";
static NSString* const HDataTotalAddTimeKey = @"totalAddTimes";

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:self.totalPoints forKey:HDataTotalPointsKey];
    [encoder encodeInteger:self.highScore forKey: HDataHighScoreKey];
    [encoder encodeInteger:self.latestScore forKey: HDataLatestScoreKey];
    [encoder encodeInteger:self.totalSkips forKey: HDataTotalSkipsKey];
    [encoder encodeInteger:self.total2x2 forKey: HDataTotal2x2Key];
    [encoder encodeInteger:self.totalAddTime forKey: HDataTotalAddTimeKey];
}

+ (instancetype)loadInstance
{
    NSData* decodedData = [NSData dataWithContentsOfFile: [ScoreModel filePath]];
    if (decodedData) {
        ScoreModel *scoreModel = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        return scoreModel;
    }
    
    return [[ScoreModel alloc] init];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
        _totalPoints = [decoder decodeIntegerForKey: HDataTotalPointsKey];
        _highScore = [decoder decodeIntegerForKey: HDataHighScoreKey];
        _latestScore = [decoder decodeIntegerForKey: HDataLatestScoreKey];
        _totalSkips = [decoder decodeIntegerForKey: HDataTotalSkipsKey];
        _total2x2 = [decoder decodeIntegerForKey: HDataTotal2x2Key];
        _totalAddTime = [decoder decodeIntegerForKey: HDataTotalAddTimeKey];
        _totalSkips = 100;
        _total2x2 = 100;
        _totalAddTime = 100;
    }
    return self;
}

-(void)saveData {
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[ScoreModel filePath] atomically:YES];
}

- (BOOL)reportScore:(NSInteger)score withHash:(NSString *)hash {
    
    NSString *scoreString = [NSString stringWithFormat:@"F3A7%ld1G9E",(long)score];
    NSMutableString *magicCheck = [scoreString MD5String].mutableCopy;
    
    if (![hash isEqualToString:magicCheck]) {
        NSLog(@"Cheater - Score!");
//        [[NSUserDefaults standardUserDefaults] setValue:[[NSString stringWithFormat:@"F3A7%ld1G9E",(long)0] MD5String] forKey:@"_8gy*wa+f"];
//        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"high_score"];
        return false;
    } else {
        self.latestScore = score;
        BOOL newHigh = score > self.highScore;
        self.highScore = MAX(self.highScore, self.latestScore);
//        NSInteger prevHighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"high_score"];
//        BOOL newHigh = false;
//        if (score > prevHighScore) {
//            [[NSUserDefaults standardUserDefaults] setValue:hash forKey:@"_8gy*wa+f"];
//            [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"high_score"];
//            newHigh = true;
//        }
        
//        [[NSUserDefaults standardUserDefaults] setValue:hash forKey:@"^RFH&)#D"];
//        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"latest_score"];
        
        self.totalPoints += score;
//        NSString *totalPointsString = [NSString stringWithFormat:@"RF6H%ld9UD4",(long)self.totalPoints];
//        NSMutableString *magicTotal = [totalPointsString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicTotal forKey:@"Hd4yG34D7e"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.totalPoints forKey:@"total_points"];
        
        [self saveData];
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
        
//        NSString *totalPointsString = [NSString stringWithFormat:@"RF6H%ld9UD4",(long)self.totalPoints];
//        NSMutableString *magicTotal = [totalPointsString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicTotal forKey:@"Hd4yG34D7e"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.totalPoints forKey:@"total_points"];
//        
//        NSString *totalSkipsString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)self.totalSkips];
//        NSMutableString *magicSkips = [totalSkipsString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicSkips forKey:@"&$HF8rs"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.totalSkips forKey:@"powerup_skips"];
        [self saveData];
        return true;
    }
    
    //Not enough to buy skip
    return false;
}

- (BOOL)useSkipPowerup {
    if (self.totalSkips > 0) {
        self.totalSkips--;
        
//        NSString *totalSkipsString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)self.totalSkips];
//        NSMutableString *magicSkips = [totalSkipsString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicSkips forKey:@"&$HF8rs"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.totalSkips forKey:@"powerup_skips"];
        [self saveData];
        return true;
    }
    
    //Not enough for use skip
    return false;
}

- (BOOL)purchaseAddTimePowerup {
    if (self.totalPoints >= POWERUP_ADDTIME_COST) {
        self.totalPoints -= POWERUP_ADDTIME_COST;
        self.totalAddTime++;
        
//        NSString *totalPointsString = [NSString stringWithFormat:@"RF6H%ld9UD4",(long)self.totalPoints];
//        NSMutableString *magicTotal = [totalPointsString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicTotal forKey:@"Hd4yG34D7e"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.totalPoints forKey:@"total_points"];
//        
//        NSString *totalAddTimeString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)self.totalAddTime];
//        NSMutableString *magicAddTimes = [totalAddTimeString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicAddTimes forKey:@"Hdfh(d9"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.totalAddTime forKey:@"powerup_addtime"];
        [self saveData];
        return true;
    }
    
    //Not enough to buy add time
    return false;
}

- (BOOL)useAddTimePowerup {
    if (self.totalAddTime > 0) {
        self.totalAddTime--;
        
//        NSString *totalAddTimeString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)self.totalAddTime];
//        NSMutableString *magicAddTimes = [totalAddTimeString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicAddTimes forKey:@"Hdfh(d9"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.totalAddTime forKey:@"powerup_addtime"];
        [self saveData];
        return true;
    }
    
    //Not enough for use add time
    return false;
}

- (BOOL)purchase2x2Powerup {
    if (self.totalPoints >= POWERUP_ADDTIME_COST) {
        self.totalPoints -= POWERUP_ADDTIME_COST;
        self.total2x2++;
        
//        NSString *totalPointsString = [NSString stringWithFormat:@"RF6H%ld9UD4",(long)self.totalPoints];
//        NSMutableString *magicTotal = [totalPointsString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicTotal forKey:@"Hd4yG34D7e"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.totalPoints forKey:@"total_points"];
//        
//        NSString *totalAddTimeString = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)self.total2x2];
//        NSMutableString *magicAddTimes = [totalAddTimeString MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magicAddTimes forKey:@"DWTd8^s"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.total2x2 forKey:@"powerup_2x2"];
        [self saveData];
        return true;
    }
    
    //Not enough to buy 2x2
    return false;
}

- (BOOL)use2x2Powerup {
    if (self.total2x2 > 0) {
        self.total2x2--;
        
//        NSString *total2x2String = [NSString stringWithFormat:@"7GE6%ld4IA7",(long)self.total2x2];
//        NSMutableString *magic2x2 = [total2x2String MD5String].mutableCopy;
//        [[NSUserDefaults standardUserDefaults] setValue:magic2x2 forKey:@"DWTd8^s"];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.total2x2 forKey:@"powerup_2x2"];
        [self saveData];
        return true;
    }
    
    //Not enough for use 2x2
    return false;
}

- (BOOL)purchasePowerupWithType:(PUType)puType {
    switch (puType) {
        case PUSkip:
            return [self purchaseSkipPowerup];
            break;
        case PU2x2:
            return [self purchase2x2Powerup];
            break;
        case PUAddTime:
            return [self purchaseAddTimePowerup];
            break;
            
        default:
            return false;
            break;
    }
    return false;
}

- (NSString *)titleForPUType:(PUType)powerupType {
    switch (powerupType) {
        case PUSkip:
            return @"Skip";
            break;
        case PU2x2:
            return @"2x2";
            break;
        case PUAddTime:
            return @"Add Time";
            break;
            
        default:
            return nil;
            break;
    }
    return nil;
}

- (NSInteger)priceForPUType:(PUType)powerupType {
    switch (powerupType) {
        case PUSkip:
            return POWERUP_SKIP_COST;
            break;
        case PU2x2:
            return POWERUP_2x2_COST;
            break;
        case PUAddTime:
            return POWERUP_ADDTIME_COST;
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}

- (NSInteger)amountForPUType:(PUType)powerupType {
    switch (powerupType) {
        case PUSkip:
            return self.totalSkips;
            break;
        case PU2x2:
            return self.total2x2;
            break;
        case PUAddTime:
            return self.totalAddTime;
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}

- (UIImage *)imageForPUType:(PUType)powerupType {
    switch (powerupType) {
        case PUSkip:
            return [UIImage imageNamed:@"skip.png"];
            break;
        case PU2x2:
            return [UIImage imageNamed:@"2x2.png"];;
            break;
        case PUAddTime:
            return [UIImage imageNamed:@"addTime.png"];;
            break;
            
        default:
            return nil;
            break;
    }
    return nil;
}

@end
