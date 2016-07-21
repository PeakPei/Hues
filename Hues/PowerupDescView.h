//
//  PowerupDescView.h
//  Hues
//
//  Created by Drew Dunne on 4/27/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hues.h"

@interface PowerupDescView : UIButton {
    UIImageView *powerupImageView;
    UILabel *titleLabel;
    UILabel *descLabel;
    UIButton *buyButton;
}

- (id)initWithFrame:(CGRect)frame;

- (void)setDescription:(NSString *)desc;
- (void)setPowerupTitle:(NSString *)title;
- (void)setPowerupImage:(UIImage *)image;

@end
