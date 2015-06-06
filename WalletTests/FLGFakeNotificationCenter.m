//
//  FLGFakeNotificationCenter.m
//  Wallet
//
//  Created by Javi Alzueta on 6/6/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGFakeNotificationCenter.h"

@implementation FLGFakeNotificationCenter

- (id) init{
    if (self = [super init]) {
        _observers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject{
    
    [self.observers setObject:observer
                       forKey:aName];
}

@end
