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

@interface ScoreModel : NSObject {
    AppDelegate *appDelegate;
}

@property (nonatomic) NSInteger totalPoints;
@property (nonatomic) NSInteger totalSkips;

+ (id)sharedScoreModel;
- (id)init;

- (BOOL)reportScore:(NSInteger)score withHash:(NSString *)hash;

- (BOOL)purchaseSkipPowerup;
- (BOOL)useSkipPowerup;

@end
