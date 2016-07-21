//
//  PauseCover.h
//  Hues
//
//  Created by Drew Dunne on 4/7/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hues.h"
#import "UIControl+SoundForControlEvents.h"

typedef enum : NSUInteger {
    PauseCoverIndexNone,
    PauseCoverIndexQuit,
    PauseCoverIndexResume
} PauseCoverIndex;

@protocol PauseCoverDelegate <NSObject>
- (void)didExitWithButtonIndex:(PauseCoverIndex)index;
@end

@interface PauseCover : UIView {
    UIButton *resumeButton;
    UIButton *quitButton;
}

@property (weak) id <PauseCoverDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (void)animateIntoView;
- (void)animateOutOfView;

@end