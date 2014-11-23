//
// Created by JP McGlone on 11/22/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSMutableDictionary+JPKitAdditions.h"

@implementation NSMutableDictionary (JPKitAdditions)

- (void)jp_safeSetObject:(id)object forKey:(id<NSCopying>)key
{
    if (object && key) {
        [self setObject:object forKey:key];
    }
}

- (void)jp_safeSetValue:(id)value forKey:(NSString *)key
{
    if (value && key) {
        [self setValue:value forKey:key];
    }
}

@end