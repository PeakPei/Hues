//
//  HuesAlert.h
//  Hues
//
//  Created by Drew Dunne on 7/23/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuesButton.h"

typedef enum : NSUInteger {
    HuesAlertCanceled,
    HuesAlertConfirmed,
} HuesAlertIndex;

@protocol HuesAlertDelegate <NSObject>
- (void)alert:(UIView *)view didExitWithButtonIndex:(HuesAlertIndex)index;
@end

@interface HuesAlert : UIView {
    UIView *mainView;
    UILabel *titleLabel;
    UILabel *descLabel;
    HuesButton *confirmButton;
    HuesButton *cancelButton;
}

@property (weak) id <HuesAlertDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (void)setTitle:(NSString *)title;
- (void)setDismissButtonText:(NSString *)dismiss;

- (void)show;
- (void)close;

@end
