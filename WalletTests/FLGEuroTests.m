//
//  FLGEuroTests.m
//  Wallet
//
//  Created by Javi Alzueta on 2/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "FLGEuro.h"

@interface FLGEuroTests : XCTestCase

@end

@implementation FLGEuroTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testMultiplication{
    
    FLGEuro *five = [[FLGEuro alloc] initWithAmount:5];
    FLGEuro *total = [five times:2];
    
    XCTAssertEqual(10, total.amount, @"5*2 should be 10");
}

- (void) testEquality{
    FLGEuro *five = [[FLGEuro alloc] initWithAmount:5];
    FLGEuro *ten = [[FLGEuro alloc] initWithAmount:10];
    
    FLGEuro *total = [five times:2];
    
    XCTAssertEqualObjects(ten, total, @"Equivalent objects should be equal");
}

@end
