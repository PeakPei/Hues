//
//  PauseAlertView.h
//  Hues
//
//  Created by Drew Dunne on 7/25/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "defines.h"

typedef enum : NSUInteger {
    PauseAlertViewIndexNone,
    PauseAlertViewIndexStore,
    PauseAlertViewIndexQuit,
    PauseAlertViewIndexResume
} PauseAlertViewIndex;

@protocol PauseAlertViewDelegate <NSObject>
- (void)didExitWithButtonIndex:(PauseAlertViewIndex)index;
@end

@interface PauseAlertView : UIView {
    UIView *mainView;
    UILabel *pauseLabel;
    HuesButton *resumeButton;
    HuesButton *storeButton;
    HuesButton *quitButton;
    
    double buttonSpacing;
    double buttonHeight;
}

@property (weak) id <PauseAlertViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (void)animateIntoView;
- (void)animateOutOfView;

@end
