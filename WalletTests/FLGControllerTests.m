//
//  FLGControllerTests.m
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FLGSimpleViewController.h"
#import "FLGWalletTableViewController.h"
#import "FLGWallet.h"

@interface FLGControllerTests : XCTestCase
@property (nonatomic, strong) FLGSimpleViewController *simpleVC;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) FLGWalletTableViewController *walletVC;
@property (nonatomic, strong) FLGWallet *wallet;
@end

@implementation FLGControllerTests

- (void)setUp {
    [super setUp];
    // Creamos el entorno de laboratorio
    self.simpleVC = [[FLGSimpleViewController alloc] initWithNibName:nil
                                                              bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola" forState:UIControlStateNormal];
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.simpleVC.displayLabel = self.label;
    
    self.wallet = [[FLGWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet addMoney:[FLGMoney euroWithAmount:1]];
    self.walletVC = [[FLGWalletTableViewController alloc] initWithModel: self.wallet];
}

- (void)tearDown {
    // Desmontamos el entorno de laboratorio
    self.simpleVC = nil;
    self.button = nil;
    self.label = nil;
    [super tearDown];
}

- (void) testThatTextOnLabelIsEqualToTextOnButton{
    
    // Mandamos el mensaje
    [self.simpleVC displayText: self.button];
    
    //comprobamos que etiqueta y botón tienen el mismo texto
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text, @"Button and Label have the same text");
}

#pragma mark - FLGWalletTableViewController
- (void) testThatTableHasOneSection{
    
    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    
    XCTAssertEqual(sections, 1, @"The number of sections should be one");
}

- (void) testThatNumberOfCellsIsNumberOfMoneysPlusOne{
    XCTAssertEqual(self.wallet.count + 1, [self.walletVC tableView:nil numberOfRowsInSection:0], @"Number of cells is the number of moneys plus 1 (one cell for the total)");
}

@end
