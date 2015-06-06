//
//  FLGMoney.m
//  Wallet
//
//  Created by Javi Alzueta on 3/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGMoney.h"
#import "NSObject+GNUStepAddons.h"
#import "FLGBroker.h"

@interface FLGMoney ()
@property (nonatomic, strong) NSNumber *amount;
@end

@implementation FLGMoney

+ (instancetype) euroWithAmount: (NSInteger) amount{
    return [[FLGMoney alloc] initWithAmount:amount
                                   currency:@"EUR"];
}
+ (instancetype) dollarWithAmount: (NSInteger) amount{
    return [[FLGMoney alloc] initWithAmount:amount
                                   currency:@"USD"];
}

- (id) initWithAmount: (NSInteger) amount
             currency: (NSString *) currency{
    if (self = [super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    return self;
}

//- (FLGMoney *) times: (NSUInteger) multiplier{
//    // No se debería llamar, sino que se debería
//    // usar el de la sub-clase
//    return [self subclassResponsibility:_cmd]; // _cmd: parametro oculto de Objective-C que identifica el selector actual ("self" también es un parametro de ese tipo)
//}

- (id<FLGMoney>) times: (NSUInteger) multiplier{
    return [[FLGMoney alloc] initWithAmount:[self.amount integerValue] * multiplier
                                   currency:self.currency];
}

- (id<FLGMoney>) plus: (FLGMoney *) other{
    return [[FLGMoney alloc] initWithAmount:([self.amount integerValue] + [[other amount] integerValue])
                                   currency:self.currency];
}

- (id<FLGMoney>) minus: (FLGMoney *) other{
    if ([other.amount integerValue] > [self.amount integerValue]) {
        [NSException raise:@"TryingToSubstractBiggestAmountThanExistingException"
                    format:@"Imposible to substract %@ %@ form %@ %@", other.amount, other.currency, self.amount, self.currency];

    }
    return [[FLGMoney alloc] initWithAmount:([self.amount integerValue] - [[other amount] integerValue])
                                   currency:self.currency];
}

- (FLGMoney *)reduceToCurrency: (NSString *) currency
                    withBroker: (FLGBroker *) broker{
    FLGMoney *result;
    double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency
                                                           toCurrency:currency]] doubleValue];
    
    // Comprobamos si divisa de origen y destino son iguales
    if ([self.currency isEqual:currency]) {
        result = self;
    }
    else if (rate == 0){
        // No hay tasa de conversion, lanzar excepcion
        [NSException raise:@"NoConversionRateException"
                    format:@"Must have a conversion for %@ to %@", self.currency, currency];
    }
    else{
        
        NSInteger newAmount = [self.amount integerValue] * rate;
        
        result = [[FLGMoney alloc] initWithAmount:newAmount
                                         currency:currency];
    }
    return result;
}

#pragma mark - Overwritten

- (NSString *) description{
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], [self currency], [self amount]];
}

- (BOOL) isEqual:(id)object{
    if ([[self currency] isEqual:[object currency]]) {
        return [self amount] == [object amount];
    }else{
        return NO;
    }
}

// Siempre que se implemente "isEqual", se debe implamentar "hash"
// Todos los objetos que devuelvan "true" en "isEqual", deben tener el mismo Hash
- (NSUInteger) hash{
    return [self.amount integerValue];
}



@end
