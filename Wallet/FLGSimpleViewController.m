//
//  FLGSimpleViewController.m
//  Wallet
//
//  Created by Javi Alzueta on 5/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGSimpleViewController.h"

@interface FLGSimpleViewController ()

@end

@implementation FLGSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayText:(id)sender {
    UIButton *button = sender;
    self.displayLabel.text = button.titleLabel.text;
}
@end
