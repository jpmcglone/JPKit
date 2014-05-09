//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JPAdditions)

@property (nonatomic, readonly) NSDictionary *jp_JSON;

- (BOOL)jp_containsString:(NSString *)string;

@end