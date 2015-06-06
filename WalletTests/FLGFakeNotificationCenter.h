//
//  FLGFakeNotificationCenter.h
//  Wallet
//
//  Created by Javi Alzueta on 6/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLGFakeNotificationCenter : NSObject

@property (nonatomic, strong) NSMutableDictionary *observers;

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject;

@end
