//
//  ScoreModel.h
//  Hues
//
//  Created by Drew Dunne on 7/25/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "AppDelegate.h"
#import "UIColor+Hues.h"

typedef enum : NSUInteger {
    PUSkip,
    PUAddTime,
    PU2x2,
} PUType;

@interface ScoreModel : NSObject <NSCoding> {
    AppDelegate *appDelegate;
}

@property (nonatomic) NSInteger totalPoints;
@property (nonatomic) NSInteger highScore;
@property (nonatomic) NSInteger latestScore;
@property (nonatomic) NSInteger totalSkips;
@property (nonatomic) NSInteger totalAddTime;
@property (nonatomic) NSInteger total2x2;

// Achievements
@property (nonatomic) NSInteger totalBlues;
@property (nonatomic) NSInteger totalGreens;
@property (nonatomic) NSInteger totalPinks;
@property (nonatomic) NSInteger highestStreak;

@property (nonatomic) BOOL hasBlueMaster;
@property (nonatomic) BOOL hasGreenMaster;
@property (nonatomic) BOOL hasPinkMaster;
@property (nonatomic) BOOL hasGettingHot;
@property (nonatomic) BOOL hasOnFire;
@property (nonatomic) BOOL hasBlazing;
@property (nonatomic) BOOL hasHueMaster;
@property (nonatomic) BOOL hasDiscoFreak;

+ (instancetype)sharedScoreModel;
- (id)init;

- (void)saveData;

- (void)newGame;
- (NSArray *)getNewUnlocks;
- (BOOL)reportScore:(NSInteger)score andAmount:(NSInteger)amount ofColor:(HuesColor)color withHash:(NSString *)hash;

- (BOOL)purchasedPoints:(NSInteger)addedPoints withTransaction:(NSString *)transID withHash:(NSString *)hash;

- (BOOL)purchasePowerupWithType:(PUType)puType;

- (BOOL)purchaseSkipPowerup;
- (BOOL)useSkipPowerup;

- (BOOL)purchaseAddTimePowerup;
- (BOOL)useAddTimePowerup;

- (BOOL)purchase2x2Powerup;
- (BOOL)use2x2Powerup;

- (NSArray *)achievementKeys;
- (NSDictionary *)achievementInfoForKey:(NSString *)key;
- (NSString *)titleForPUType:(PUType)powerupType;
- (NSInteger)priceForPUType:(PUType)powerupType;
- (NSInteger)amountForPUType:(PUType)powerupType;
- (UIImage *)imageForPUType:(PUType)powerupType;

@end
