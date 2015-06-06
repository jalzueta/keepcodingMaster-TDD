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

@interface FLGWallet : NSObject<FLGMoney>
@property (nonatomic, readonly) NSUInteger count;

- (id<FLGMoney>) addMoney: (FLGMoney *) other;
- (id<FLGMoney>) takeMoney: (FLGMoney *) other;

- (void) subscribeToMemoryWarning: (NSNotificationCenter *) nc;
@end
