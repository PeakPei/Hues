//
//  IAPViewController.m
//  Hues
//
//  Created by Drew Dunne on 7/23/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "IAPViewController.h"

static NSString *kProductPrefix = @"com.drewsdunne.Hues.";
static NSString *k10000ProductIdentifier = @"10000";
static NSString *k30000ProductIdentifier = @"30000p";
static NSString *k100000ProductIdentifier = @"100000";
static NSString *k250000ProductIdentifier = @"250000";

@interface IAPViewController () {
    NSMutableArray *iaps;
    UITableView *iapTable;
}

@end

@implementation IAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create Nav view
    NavView *nav = [[NavView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    nav.titleLabel.text = @"Get More Points";
    nav.titleLabel.minimumScaleFactor = 0.2;
    nav.titleLabel.adjustsFontSizeToFitWidth = true;
    [nav.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    
    iapTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50) style:UITableViewStyleGrouped];
    iapTable.delegate = self;
    iapTable.dataSource = self;
    iapTable.allowsSelection = false;
    iapTable.backgroundColor = [UIColor whiteColor];
    iapTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [iapTable registerClass:IAPTableViewCell.self forCellReuseIdentifier:@"iap_cell"];
    [iapTable registerNib:[UINib nibWithNibName:@"IAPTableViewCell" bundle:nil] forCellReuseIdentifier:@"iap_cell"];
    [self.view addSubview:iapTable];
    
    iaps = @[k10000ProductIdentifier, k30000ProductIdentifier, k100000ProductIdentifier, k250000ProductIdentifier].mutableCopy;
}

- (void)iapPressed:(UIButton *)sender {
    NSLog(@"Pressed, %ld",(long)sender.tag);
    NSString *prodID = kProductPrefix;
    switch (sender.tag) {
        case 1:
            prodID = [prodID stringByAppendingString:k10000ProductIdentifier];
            break;
        case 2:
            prodID = [prodID stringByAppendingString:k30000ProductIdentifier];
            break;
        case 3:
            prodID = [prodID stringByAppendingString:k100000ProductIdentifier];
            break;
        case 4:
            prodID = [prodID stringByAppendingString:k250000ProductIdentifier];
            break;
            
        default:
            break;
    }
    NSLog(@"%@",prodID);
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"User can make payments");
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:prodID]];
        productsRequest.delegate = self;
        [productsRequest start];
    } else {
        NSLog(@"User cannot make payments");
        //this is called the user cannot make payments, most likely due to parental controls
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    SKProduct *validProduct = nil;
    NSUInteger count = [response.products count];
    if (count > 0) {
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    } else if (!validProduct) {
        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (void)purchase:(SKProduct *)product {
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - SKPaymentTransactionObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        NSString *prodID;
        switch(transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                // Give package
                prodID = transaction.payment.productIdentifier;
                BOOL purchased = false;
                if (prodID != nil) {
                    NSInteger addedPoints = 0;
                    if ([[prodID componentsSeparatedByString:@"."].lastObject isEqualToString:k10000ProductIdentifier]) {
                        addedPoints = 10000;
                    } else if ([[prodID componentsSeparatedByString:@"."].lastObject isEqualToString:k30000ProductIdentifier]) {
                        addedPoints = 30000;
                    } else if ([[prodID componentsSeparatedByString:@"."].lastObject isEqualToString:k100000ProductIdentifier]) {
                        addedPoints = 100000;
                    } else if ([[prodID componentsSeparatedByString:@"."].lastObject isEqualToString:k250000ProductIdentifier]) {
                        addedPoints = 250000;
                    } else {
                        NSLog(@"This isn't a valid product!");
                    }
                    NSString *pointsString = [NSString stringWithFormat:@"aW2f3d3bf%ldhey%@8e6G",(long)(addedPoints),transaction.transactionIdentifier];
                    NSMutableString *hash = [pointsString MD5String].mutableCopy;
                    purchased = [[ScoreModel sharedScoreModel] purchasedPoints:addedPoints withTransaction:transaction.transactionIdentifier withHash:hash];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"com.drewsdunne.hues.refreshPoints" object:nil];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                NSLog(@"Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Restored");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                // Failed
                if (transaction.error.code == SKErrorPaymentCancelled) {
                    NSLog(@"Cancelled");
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateDeferred:
                NSLog(@"Cancelled");
                // In between Ask to Buy
                break;
        }
    }
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return iaps.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IAPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iap_cell"];
    if (!cell) {
        printf("No reuse");
        cell = [[IAPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iap_cell"];
    }
    cell.buyButton.tag = indexPath.section+1;
    [cell.buyButton addTarget:self action:@selector(iapPressed:) forControlEvents:UIControlEventTouchUpInside];
    NSString *title = @"";
    NSString *price = @"";
    if ([iaps[indexPath.section] isEqualToString:k10000ProductIdentifier]) {
        title = @"10,000 Points";
        price = @"$0.99";
    } else if ([iaps[indexPath.section] isEqualToString:k30000ProductIdentifier]) {
        title = @"30,000 Points";
        price = @"$1.99";
    } else if ([iaps[indexPath.section] isEqualToString:k100000ProductIdentifier]) {
        title = @"100,000 Points";
        price = @"$4.99";
    } else if ([iaps[indexPath.section] isEqualToString:k250000ProductIdentifier]) {
        title = @"250,000 Points";
        price = @"$9.99";
    } else {
        NSLog(@"This isn't a valid product!");
    }
    [cell setTitleLabelText:title];
    [cell setPrice:price];
//    cell.textLabel.text = @"2500 Points";
//    cell.detailTextLabel.text = @"$0.99";
    
    return cell;
}



@end
