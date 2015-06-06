//
//  FLGWalletTableViewController.h
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLGWallet;

@interface FLGWalletTableViewController : UITableViewController

@property (nonatomic, strong, readonly) FLGWallet *model;

- (id) initWithModel: (FLGWallet *) model;

@end
