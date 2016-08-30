//
//  IAPTableViewCell.h
//  Hues
//
//  Created by Drew Dunne on 7/23/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hues.h"
#import "HuesButton.h"

@interface IAPTableViewCell : UITableViewCell{
    IBOutlet UILabel *titleLabel;
}

@property (weak, nonatomic) IBOutlet HuesButton *buyButton;

- (void)setTitleLabelText:(NSString *)text;
- (void)setPrice:(NSString *)price;

@end
