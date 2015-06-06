//
//  FLGWallet.m
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGWallet.h"

@interface FLGWallet ()
@property (nonatomic, strong) NSMutableArray *moneys;
@end

@implementation FLGWallet

- (NSUInteger) count{
    return self.moneys.count;
}

- (id) initWithAmount: (NSInteger) amount
             currency: (NSString *) currency{
    if (self = [super init]) {
        FLGMoney *money = [[FLGMoney alloc] initWithAmount:amount
                                                  currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
    }
    return self;
}

- (id<FLGMoney>) times: (NSUInteger) multiplier{
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity:self.moneys.count];
    for (FLGMoney *each in self.moneys) {
        FLGMoney *newMoney = [each times:multiplier];
        [newMoneys addObject:newMoney];
    }
    self.moneys = newMoneys;
    return self;
}

- (id<FLGMoney>) addMoney: (FLGMoney *) other{
    [self.moneys addObject:other];
    return self;
}

- (id<FLGMoney>) takeMoney: (FLGMoney *) other{
    if (![self.moneys containsObject:other]) {
        [NSException raise:@"TryingToSubstractANonExistingMoneyException"
                    format:@"Imposible to substract %@ %@ form the wallet", other.amount, other.currency];
    }
    [self.moneys removeObject:other];
    return self;
}

- (FLGMoney *)reduceToCurrency:(NSString *)currency
                    withBroker:(FLGBroker *)broker{
    
    FLGMoney *result = [[FLGMoney alloc] initWithAmount:0
                                               currency:currency];
    for (FLGMoney *each in self.moneys) {
        result = [result plus:[each reduceToCurrency:currency
                                          withBroker:broker]];
    }
    return result;
}

- (void) subscribeToMemoryWarning: (NSNotificationCenter *) nc{
    
    [nc addObserver:self
           selector:@selector(dumpToDisk:)
               name:UIApplicationDidReceiveMemoryWarningNotification
             object:nil];
    
}

- (void) dumpToDisk: (NSNotification *) notification{
    // Guarda las cosas en disco cuando la cosa se pknga fea
}

@end
