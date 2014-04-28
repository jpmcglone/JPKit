//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JPKitAdditions_AutoDescription)

- (NSString *)jp_autoDescribeWithAddresses:(BOOL)withAddresses showsNulls:(BOOL)showsNulls;
- (NSString *)jp_autoDescribeWithAddresses:(BOOL)withAddresses;
- (NSString *)jp_autoDescribe;

@end