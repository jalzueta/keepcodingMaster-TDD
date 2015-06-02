//
//  FLGEuro.h
//  Wallet
//
//  Created by Javi Alzueta on 2/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLGEuro : NSObject

@property (nonatomic, readonly) NSInteger amount;
- (id) initWithAmount: (NSInteger) amount;

- (FLGEuro *) times: (NSUInteger) multiplier;
@end
