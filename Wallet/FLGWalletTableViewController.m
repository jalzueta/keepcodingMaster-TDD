//
//  FLGWalletTableViewController.m
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGWalletTableViewController.h"
#import "FLGWallet.h"
#import "FLGBroker.h"

@interface FLGWalletTableViewController ()
@property (nonatomic, strong) FLGWallet *wallet;
@property (nonatomic, strong) FLGBroker *broker;
@end

@implementation FLGWalletTableViewController

- (id) initWithWallet: (FLGWallet *) wallet
               broker: (FLGBroker *) broker{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        _wallet = wallet;
        _broker = broker;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.wallet totalNumberOfCurrencies] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.wallet numberOfMoneysForSection:section] + 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section < [self.wallet totalNumberOfCurrencies]) {
        return [self.wallet currencyForSection:section];
    }else{
        return @"TOTAL";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"moneyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
    }
    
    FLGMoney *money = [self.wallet moneyForIndexPath:indexPath
                                   reduceToCurrency:nil
                                         withBroker:self.broker];
    
    if (indexPath.row < [self.wallet numberOfMoneysForSection:indexPath.section]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", money.amount];
    }else{
        if (indexPath.section < [self.wallet totalNumberOfCurrencies]) {
            cell.textLabel.text = [NSString stringWithFormat:@"SUBTOTAL: %@", money.amount];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"%@", money.amount];
        }
    }
    cell.detailTextLabel.text = money.currency;
    
    return cell;
}




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row < [self.wallet numberOfMoneysForSection:indexPath.section]) {
        return YES;
    }else{
        return NO;
    }
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.wallet takeMoney:[self.wallet moneyForIndexPath:indexPath
                                             reduceToCurrency:nil
                                                   withBroker:self.broker]];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
