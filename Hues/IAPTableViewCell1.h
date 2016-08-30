//
//  IAPTableViewCell.h
//  Hues
//
//  Created by Drew Dunne on 7/23/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuesButton.h"

@interface IAPTableViewCell : UITableViewCell {
    UILabel *titleLabel;
    UILabel *buyButton;
}

- (void)setTitleLabelText:(NSString *)text;
- (void)setPrice:(NSString *)price;

@end
