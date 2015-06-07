//
//  FLGWallet.h
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FLGMoney.h"
@class FLGBroker;

@interface FLGWallet : NSObject<FLGMoney>
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) NSMutableArray *currencies;

- (id<FLGMoney>) addMoney: (FLGMoney *) other;
- (id<FLGMoney>) takeMoney: (FLGMoney *) other;
- (NSUInteger) totalNumberOfCurrencies;
- (NSString *) currencyForSection: (NSUInteger) section;
- (NSUInteger) numberOfMoneysForSection: (NSUInteger) section;
- (void) subscribeToMemoryWarning: (NSNotificationCenter *) nc;
- (FLGMoney *) moneyForIndexPath: (NSIndexPath *) indexPath
                reduceToCurrency: (NSString *) currency
                      withBroker: (FLGBroker *) broker;
- (FLGMoney *) totalMoneyForCurrency: (NSString *) currency;
- (FLGMoney *) totalMoneyForSection: (NSUInteger) section;

@end
