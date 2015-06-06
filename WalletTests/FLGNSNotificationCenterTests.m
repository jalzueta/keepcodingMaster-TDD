//
//  FLGNSNotificationCenterTests.m
//  Wallet
//
//  Created by Javi Alzueta on 6/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FLGFakeNotificationCenter.h"
#import "FLGWallet.h"

@interface FLGNSNotificationCenterTests : XCTestCase

@end

@implementation FLGNSNotificationCenterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testThatSubscribesToMemoryWarning{
    
    // Este objeto lo creamos para el test - Para no usar un Singleton
    FLGFakeNotificationCenter *fakeNc = [FLGFakeNotificationCenter new];
    
    // Este objeto ya existiría en mi App (usamos Wallet)
//    FLGBigAndFatObject *fat = [FLGBigAndFatObject new];
    FLGWallet *fatWallet = [FLGWallet new];
    
    // Preparamos el codgo para recibir el NC como parámetro. Asi lo hacemos mas escalable, en vez de coger el NC del singleton del sistema directamente. Por ejemplo para migrar el codigo a OSX, cambiaríamos el NC y listo.
    [fatWallet subscribeToMemoryWarning: (NSNotificationCenter *) fakeNc];
    
    NSDictionary *obs = [fakeNc observers];
    
    id observer = [obs objectForKey:UIApplicationDidReceiveMemoryWarningNotification];
    
    XCTAssertEqualObjects(observer, fatWallet, @"Fat object must suscribe to UIApplicationDidReceiveMemoryWarningNotification");
    
}









@end
