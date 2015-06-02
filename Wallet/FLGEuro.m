//
//  FLGEuro.m
//  Wallet
//
//  Created by Javi Alzueta on 2/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGEuro.h"

@interface FLGEuro ()
@property (nonatomic) NSInteger amount; // Lectuura/escritura desde dentro
@end

@implementation FLGEuro

- (id) initWithAmount: (NSInteger) amount{
    if (self = [super init]) {
        _amount = amount;
    }
    return self;
}

- (FLGEuro *) times: (NSUInteger) multiplier{
    return [[FLGEuro alloc] initWithAmount:self.amount * multiplier];
}

#pragma mark - Overwritten

- (BOOL)isEqual:(id)object{
    return YES;
//    return [self amount] == [object amount];
}

@end
