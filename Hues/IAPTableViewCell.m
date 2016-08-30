//
//  IAPTableViewCell.m
//  Hues
//
//  Created by Drew Dunne on 7/23/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "IAPTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation IAPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    titleLabel.textColor = [UIColor darkHuesBlueText];
    titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:20];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.alpha = 1.0f;
    
//    buyButton.textColor = [UIColor whiteColor];
//    buyButton.font = [UIFont monospacedDigitSystemFontOfSize:14 weight:0.1];
//    buyButton.textAlignment = NSTextAlignmentCenter;
//    buyButton.alpha = 1.0f;
//    buyButton.backgroundColor = [UIColor huesGreen];
//    buyButton.layer.cornerRadius = 15;
//    buyButton = [HuesButton buttonWithColor:[UIColor huesBlue]];
    self.buyButton.defaultColor = [UIColor huesGreen];
    self.buyButton.backgroundColor = self.buyButton.defaultColor;
    NSOperatingSystemVersion sysVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    if (sysVersion.majorVersion > 8)
        self.buyButton.titleLabel.font = [UIFont monospacedDigitSystemFontOfSize:14 weight:0.1];
    else
        self.buyButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [self.buyButton setTitle:@"$0.99" forState:UIControlStateNormal];
}

- (void)setTitleLabelText:(NSString *)text {
    titleLabel.text = text;
}

- (void)setPrice:(NSString *)price {
//    buyButton.text = price;
    [self.buyButton setTitle:price forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
