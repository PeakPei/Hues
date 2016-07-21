//
//  PowerupView.h
//  Hues
//
//  Created by Drew Dunne on 5/6/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreModel.h"
#import "UIColor+Hues.h"

@protocol PowerupViewDelegate <NSObject>

- (void)puView:(UIView *)puv didPressPurchase:(BOOL)pressed;

@end

@interface PowerupView : UIView {
    UIImageView *powerupImageView;
    UILabel *titleLabel;
    UILabel *descLabel;
    UIButton *buyButton;
    UILabel *totalPUs;
    
    PUType pu;
}

@property (nonatomic) NSObject<PowerupViewDelegate> *delegate;

- (id)initWithFrame:(CGRect)frame;

- (void)setDescription:(NSString *)desc;
- (void)setPowerupImage:(UIImage *)image;
- (void)setPU:(PUType)pwu;

- (PUType)getPU;
- (void)updateSubviews;

@end


