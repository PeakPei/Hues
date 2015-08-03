//
//  HomeViewController.h
//  Hues
//
//  Created by Drew Dunne on 7/21/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GridView.h"
#import "AppDelegate.h"

@interface HomeViewController : UIViewController <GridViewDelegate, GKGameCenterControllerDelegate> {
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    
    GridView *gridView;
    
    AppDelegate *appDelegate;
}

@end
