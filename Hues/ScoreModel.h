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

+ (instancetype)sharedScoreModel;
- (id)init;

- (void)saveData;

- (BOOL)reportScore:(NSInteger)score withHash:(NSString *)hash;

- (BOOL)purchasePowerupWithType:(PUType)puType;

- (BOOL)purchaseSkipPowerup;
- (BOOL)useSkipPowerup;

- (BOOL)purchaseAddTimePowerup;
- (BOOL)useAddTimePowerup;

- (BOOL)purchase2x2Powerup;
- (BOOL)use2x2Powerup;

- (NSString *)titleForPUType:(PUType)powerupType;
- (NSInteger)priceForPUType:(PUType)powerupType;
- (NSInteger)amountForPUType:(PUType)powerupType;
- (UIImage *)imageForPUType:(PUType)powerupType;

@end
