//
//  FLGBroker.m
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGBroker.h"
#import "FLGMoney.h"

@interface FLGBroker ()
@end

@implementation FLGBroker

// Sobreescribimos el init de NSObject para inicializar el diccionario de rates
- (id) init{
    if (self = [super init]) {
        _rates = [@{} mutableCopy];
    }
    return self;
}

- (FLGMoney *)reduce: (id<FLGMoney>) money
          toCurrency: (NSString *) currency{
    
    // double dispatch
    return [money reduceToCurrency: currency
                        withBroker: self];
}

- (void) addRate: (NSInteger) rate
    fromCurrency: (NSString *) fromCurrency
      toCurrency: (NSString *) toCurrency{
    
    [self.rates setObject:@(rate)
                   forKey:[self keyFromCurrency: fromCurrency
                                     toCurrency: toCurrency]];
    
    [self.rates setObject:@(1.0f/rate)
                   forKey:[self keyFromCurrency: toCurrency
                                     toCurrency: fromCurrency]];
}

- (NSString *) keyFromCurrency: fromCurrency
                    toCurrency: (NSString *) toCurrency{
    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
}

#pragma mark - Rates

- (void) parseJSONRates: (NSData *) json{
    
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:json
                                             options:NSJSONReadingAllowFragments
                                               error:&err];
    
    if (obj != nil) {
        // Pillamos los rates y los vamos añadiendo al broker
    }else{
        // No hemos recibido nada
        [NSException raise:@"NoRatesInJSONException"
                    format:@"JSON must carry some data!"];
    }
}

@end
