//
//  FLGMoney.h
//  Wallet
//
//  Created by Javi Alzueta on 3/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLGMoney;
@class FLGBroker;

@protocol FLGMoney <NSObject>

- (id) initWithAmount: (NSInteger) amount
             currency: (NSString *) currency;
- (FLGMoney *)reduceToCurrency: (NSString *) currency
                    withBroker: (FLGBroker *) broker;

@end

@interface FLGMoney : NSObject<FLGMoney>

@property (nonatomic, readonly) NSString *currency;
@property (nonatomic, strong, readonly) NSNumber *amount;

+ (id) euroWithAmount: (NSInteger) amount;
+ (id) dollarWithAmount: (NSInteger) amount;

- (id<FLGMoney>) times: (NSUInteger) multiplier;
- (id<FLGMoney>) plus: (FLGMoney *) other;
- (id<FLGMoney>) minus: (FLGMoney *) other;

@end
