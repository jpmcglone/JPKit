//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSDictionary+JPKitAdditions.h"

@implementation NSDictionary (JPKitAdditions)

- (NSDictionary *)jp_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:self];
    [mutableDictionary addEntriesFromDictionary:dictionary];
    return [NSDictionary dictionaryWithDictionary:mutableDictionary];
}

@end