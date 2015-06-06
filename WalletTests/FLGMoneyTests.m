//
//  FLGMoneyTests.m
//  Wallet
//
//  Created by Javi Alzueta on 3/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FLGMoney.h"

@interface FLGMoneyTests : XCTestCase

@end

@implementation FLGMoneyTests

//- (void) testThatRaisesException{
//    // Cuando mandemos el mensaje "times" a una instancia de "FLGMoney", se debería lanzar una excepción
//    FLGMoney *money = [[FLGMoney alloc] initWithAmount:1];
//    XCTAssertThrows([money times:2], @"Should raise an exception");
//}

- (void) testCurrencies{
    
    XCTAssertEqualObjects(@"EUR", [[FLGMoney euroWithAmount:1] currency], @"The currency of euros should be EUR");
    XCTAssertEqualObjects(@"USD", [[FLGMoney dollarWithAmount:1] currency], @"The currency of dollars should be USD");
}

- (void) testMultiplication{
    
    FLGMoney *five = [FLGMoney euroWithAmount:5];
    FLGMoney *ten = [FLGMoney euroWithAmount:10];
    FLGMoney *total = [five times:2];
    
    XCTAssertEqualObjects(total, ten, @"5€ * 2 should be 10€");
}

- (void) testEquality{
    FLGMoney *five = [FLGMoney euroWithAmount:5];
    FLGMoney *ten = [FLGMoney euroWithAmount:10];
    FLGMoney *totalEuros = [five times:2];
    
    FLGMoney *four = [FLGMoney dollarWithAmount:4];
    FLGMoney *eight = [FLGMoney dollarWithAmount:8];
    FLGMoney *totalDollars = [four times:2];
    
    XCTAssertEqualObjects(ten, totalEuros, @"Equivalent objects should be equal");
    XCTAssertEqualObjects(eight, totalDollars, @"Equivalent objects should be equal");
    XCTAssertFalse([totalEuros isEqual:five], @"Non equivalent objects should not be equal");
}

- (void) testDifferentCurrencies{
    FLGMoney *euro = [FLGMoney euroWithAmount:1];
    FLGMoney *dollar = [FLGMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different currencies should not be equal");
}

- (void) testHash{
    
    FLGMoney *a = [FLGMoney euroWithAmount:2];
    FLGMoney *b = [FLGMoney euroWithAmount:2];
    
    FLGMoney *c = [FLGMoney dollarWithAmount:1];
    FLGMoney *d = [FLGMoney dollarWithAmount:1];
    
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
    XCTAssertEqual([c hash], [d hash], @"Equal objects must have same hash");
}

- (void) testAmountStorage{
    int amount = 10;
    FLGMoney *euro = [FLGMoney euroWithAmount:amount];
    FLGMoney *dollar = [FLGMoney dollarWithAmount:amount];
    
    // Eliminamos el warnig que habia por acceder a un selector de la parte privada
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqual(amount, [[euro performSelector:@selector(amount)] integerValue], @"The value retrieved should be the same as the stored");
    XCTAssertEqual(amount, [[dollar performSelector:@selector(amount)] integerValue], @"The value retrieved should be the same as the stored");
#pragma clang diagnostic pop
    
}

- (void) testSimpleAdition{
    FLGMoney *sum = [[FLGMoney dollarWithAmount:5] plus: [FLGMoney dollarWithAmount:5]];
    XCTAssertEqualObjects(sum, [FLGMoney dollarWithAmount:10],  @"$5 + $5 should be $10");
}

- (void) testSimpleSubstraction{
    FLGMoney *subs = [[FLGMoney dollarWithAmount:10] minus: [FLGMoney dollarWithAmount:5]];
    XCTAssertEqualObjects(subs, [FLGMoney dollarWithAmount:5],  @"$10 - $5 should be $5");
}

- (void) testThatSubstractionOfBiggestAmountThanExistingThrowsException{
    XCTAssertThrows([[FLGMoney dollarWithAmount:1] minus: [FLGMoney dollarWithAmount:2]], @"Substraction of biggest amount than existing should cause exception");
}

- (void) testThatHashIsAmount{
    FLGMoney *one = [FLGMoney dollarWithAmount:1];
    XCTAssertEqual([one hash], 1, @"The hash must be the same as the amount");
}

- (void) testDescription{
    
    FLGMoney *one = [FLGMoney dollarWithAmount:1];
    NSString *desc = @"<FLGMoney: USD 1>";
    
    XCTAssertEqualObjects(desc, [one description], @"Description must match template");
}





@end
