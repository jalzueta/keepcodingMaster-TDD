//
//  FLGBrokerTests.m
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FLGMoney.h"
#import "FLGBroker.h"

@interface FLGBrokerTests : XCTestCase
@property (nonatomic, strong) FLGBroker *emptyBroker;
@property (nonatomic, strong) FLGMoney *oneDollar;
@end

@implementation FLGBrokerTests

- (void)setUp {
    [super setUp];
    self.emptyBroker = [FLGBroker new];
    self.oneDollar = [FLGMoney dollarWithAmount:1];
}

- (void)tearDown {
    self.emptyBroker = nil;
    self.oneDollar = nil;
    [super tearDown];
}

- (void) testSimpleReduction{
    FLGMoney *sum = [[FLGMoney dollarWithAmount:5] plus:[FLGMoney dollarWithAmount:5]];
    
    FLGMoney *reduced = [self.emptyBroker reduce: sum toCurrency: @"USD"];
    
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency should be a NOP");
}

// $10 == 5€ (2:1)

- (void) testReduction{
    [self.emptyBroker addRate: 2
                 fromCurrency: @"EUR"
                   toCurrency: @"USD"];
    
    FLGMoney *dollars = [FLGMoney dollarWithAmount:10];
    FLGMoney *euros = [FLGMoney euroWithAmount:5];
    
    FLGMoney *converted = [self.emptyBroker reduce:dollars
                                        toCurrency:@"EUR"];
    
    XCTAssertEqualObjects(converted, euros, @"$10 == 5€ (2:1)");
}

- (void) testThatNoRateRaisesException{
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"], @"No rates should cause exception");
}

- (void) testThatNilConversionDoesNotChangeMoney{
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce:self.oneDollar toCurrency:self.oneDollar.currency], @"A nil conversion should have no effect");
}



@end
