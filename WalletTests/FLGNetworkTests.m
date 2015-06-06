//
//  FLGNetworkTests.m
//  Wallet
//
//  Created by Javi Alzueta on 6/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "FLGBroker.h"

@interface FLGNetworkTests : XCTestCase

@end

@implementation FLGNetworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testThatEmptyRatesRaisesException{
    FLGBroker *broker = [FLGBroker new];
    NSData *jsonData = nil;
    
    XCTAssertThrows([broker parseJSONRates: jsonData], @"An empty json should raise exception");
}

@end
