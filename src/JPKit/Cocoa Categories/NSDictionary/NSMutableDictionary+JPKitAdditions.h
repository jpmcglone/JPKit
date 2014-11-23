//
// Created by JP McGlone on 11/22/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (JPKitAdditions)

- (void)jp_safeSetObject:(id)object forKey:(id<NSCopying>)key;
- (void)jp_safeSetValue:(id)value forKey:(NSString *)key;

@end