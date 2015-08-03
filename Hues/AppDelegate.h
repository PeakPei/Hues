//
//  AppDelegate.h
//  Hues
//
//  Created by Drew Dunne on 7/6/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

//static NSString *leaderboardID = @"threebythree.hues";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL gameCenterEnabled;

- (void)authenticateLocalPlayer;

@end

