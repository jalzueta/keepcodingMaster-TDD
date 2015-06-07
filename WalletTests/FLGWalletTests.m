//
//  FLGWalletTests.m
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "FLGMoney.h"
#import "FLGBroker.h"
#import "FLGWallet.h"

@interface FLGWalletTests : XCTestCase

@end

@implementation FLGWalletTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// 40€ + €20 (2:1)
- (void) testAdditionWithReduction{
    
    FLGBroker *broker = [FLGBroker new];
    [broker addRate: 2 fromCurrency: @"EUR" toCurrency: @"USD"];
    
    FLGWallet *wallet = [[FLGWallet alloc]initWithAmount:40 currency: @"EUR"];
    [wallet addMoney: [FLGMoney dollarWithAmount: 20]];
    
    FLGMoney *reduced = [broker reduce:wallet toCurrency: @"USD"];
    
    XCTAssertEqualObjects(reduced, [FLGMoney dollarWithAmount:100], @"€40 + $20 = $100 (2:1)");
}

// 30€ - 10€
- (void) testSimpleSubstraction{
    FLGWallet *wallet = [[FLGWallet alloc]initWithAmount:20 currency: @"EUR"];
    [wallet addMoney: [FLGMoney euroWithAmount: 10]];
    
    FLGMoney *total = [[wallet takeMoney:[FLGMoney euroWithAmount: 10]] reduceToCurrency:@"EUR"
                                                                          withBroker:[FLGBroker new]];
    
    XCTAssertEqualObjects(total, [FLGMoney euroWithAmount:20], @"€30€ - 10€ = 20€");
}

- (void) testThatSubstractionOfANonExistingMoneyThrowsException{
    FLGWallet *wallet = [[FLGWallet alloc]initWithAmount:20 currency: @"EUR"];
    [wallet addMoney: [FLGMoney euroWithAmount: 10]];
    
    XCTAssertThrows([wallet takeMoney: [FLGMoney euroWithAmount:5]], @"Substraction of a non existing money should cause exception");
}

- (void) testNumberOfCurrencies{
    FLGWallet *wallet = [[FLGWallet alloc]initWithAmount:20 currency: @"EUR"];
    [wallet addMoney: [FLGMoney euroWithAmount: 10]];
    [wallet addMoney: [FLGMoney dollarWithAmount: 10]];
    
    XCTAssertEqual([wallet totalNumberOfCurrencies], 2, @"The number of currencies in the wallet should be 2");
}

- (void) testTotalMoneyForAGivenCurrency{
    
    NSInteger initialAmount = 20;
    
    FLGMoney *euro1 = [FLGMoney euroWithAmount: initialAmount];
    FLGMoney *euro2 = [FLGMoney euroWithAmount: 10];
    FLGMoney *dollar1 = [FLGMoney dollarWithAmount: 10];
    FLGMoney *dollar2 = [FLGMoney dollarWithAmount: 50];
    FLGMoney *dollar3 = [FLGMoney dollarWithAmount: 5];
    
    FLGWallet *wallet = [[FLGWallet alloc]initWithAmount:initialAmount currency: @"EUR"];
    
    [wallet addMoney: euro2];
    [wallet addMoney: dollar1];
    [wallet addMoney: dollar2];
    [wallet addMoney: dollar3];
    
    FLGMoney *totalEuros = [euro1 plus:euro2];
    FLGMoney *totalDollars = [(FLGMoney *)[dollar1 plus:dollar2] plus: dollar3];
    
    XCTAssertEqualObjects([wallet totalMoneyForCurrency: euro1.currency], totalEuros, @"Total money for a given currency should be the same");
    XCTAssertEqualObjects([wallet totalMoneyForCurrency: dollar1.currency], totalDollars, @"Total money for a given currency should be the same");
}

@end
