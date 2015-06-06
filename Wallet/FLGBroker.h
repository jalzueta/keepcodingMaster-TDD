//
//  FLGBroker.h
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLGMoney.h"

@interface FLGBroker : NSObject

@property (nonatomic, strong) NSMutableDictionary *rates;

- (id<FLGMoney>)reduce: (id<FLGMoney>) money
            toCurrency: (NSString *) currency;

- (void) addRate: (NSInteger) rate
    fromCurrency: (NSString *) fromCurrency
      toCurrency: (NSString *) toCurrency;

- (NSString *) keyFromCurrency: fromCurrency
                    toCurrency: (NSString *) toCurrency;

- (void) parseJSONRates: (NSData *) json;

@end
