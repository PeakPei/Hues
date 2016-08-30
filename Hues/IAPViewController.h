//
//  IAPViewController.h
//  Hues
//
//  Created by Drew Dunne on 7/23/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavView.h"
#import "ScoreModel.h"
#import "HuesButton.h"
#import "IAPTableViewCell.h"
#import <StoreKit/StoreKit.h>
#import "NSString+MD5.h"

@interface IAPViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end
