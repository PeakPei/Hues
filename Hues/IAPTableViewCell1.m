//
//  IAPTableViewCell.m
//  Hues
//
//  Created by Drew Dunne on 7/23/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "IAPTableViewCell.h"

@implementation IAPTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    CGFloat buttonWidth = 84;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, self.frame.size.width-buttonWidth-48, self.frame.size.height)];
    titleLabel.text = @"2500 Points";
    titleLabel.textColor = [UIColor darkHuesBlueText];
    titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:20];
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.alpha = 1.0f;
    [self addSubview:titleLabel];
    
    buyButton = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-buttonWidth-32, (self.frame.size.height-30)/2, buttonWidth, 30)];
    buyButton.text = @"$0.99";
    buyButton.textColor = [UIColor darkHuesBlueText];
    buyButton.font = [UIFont monospacedDigitSystemFontOfSize:14 weight:0.1];
    buyButton.textAlignment = NSTextAlignmentCenter;
    buyButton.alpha = 1.0f;
    buyButton.backgroundColor = [UIColor huesGreen];
    buyButton.layer.cornerRadius = 15;
    [self addSubview:buyButton];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitleLabelText:(NSString *)text {
    titleLabel.text = text;
}

- (void)setPrice:(NSString *)price {
    buyButton.text = price;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
