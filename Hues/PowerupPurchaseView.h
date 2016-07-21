//
//  PowerupPurchaseView.h
//  Hues
//
//  Created by Drew Dunne on 4/29/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuesButton.h"
#import "ScoreModel.h"

typedef enum : NSUInteger {
    PUPurchased,
    PUCanceled,
} PUPurchaseViewIndex;

@protocol PUPurchaseViewDelegate <NSObject>
- (void)didExitWithButtonIndex:(PUPurchaseViewIndex)index;
@end

@interface PowerupPurchaseView : UIView {
    UIView *mainView;
    UILabel *purchaseLabel;
    UILabel *priceLabel;
    HuesButton *purchaseButton;
    HuesButton *cancelButton;
    
    double buttonSpacing;
    double buttonHeight;
    
    PUType pu;
}

@property (weak) id <PUPurchaseViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (void)animateIntoView;
- (void)animateOutOfView;

- (void)setPowerup:(PUType)powerupType;
- (PUType)getPU;

@end
