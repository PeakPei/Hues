//
//  ViewController.h
//  Hues
//
//  Created by Drew Dunne on 7/6/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GridContainer.h"
#import "GameInfoView.h"
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController <GridContainerViewDelegate, GKGameCenterControllerDelegate> {
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    
    GridContainer *gridContainer;
    GameInfoView *gameInfo;
    
    BOOL gameActive;
    BOOL gameOver;
    UIColor *selectedColor;
    NSInteger discoloredTile;
    NSInteger varyR;
    NSInteger varyG;
    NSInteger varyB;
    UIColor *discoloredColor;
    
    NSInteger score;
    NSInteger time;
    NSTimer *gameTimer;
    double breakEvenTime;
    
    AppDelegate *appDelegate;
}



@end

