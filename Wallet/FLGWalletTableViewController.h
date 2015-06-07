//
//  FLGWalletTableViewController.h
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLGWallet;
@class FLGBroker;

@interface FLGWalletTableViewController : UITableViewController

@property (nonatomic, strong, readonly) FLGWallet *wallet;

- (id) initWithWallet: (FLGWallet *) wallet
               broker: (FLGBroker *) broker;

@end
