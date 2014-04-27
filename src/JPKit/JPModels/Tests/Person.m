//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSDictionary *)specs
{
    static NSDictionary *overrides = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        overrides = @{
                @"id" : @{
                        @"name" : @"personID",
                        //@"class" : @"Person"
                        //@"isPlural" : @(NO),
                },
                @"parents" : @{
                        //@"name" : @"parents",
                        @"class" : @"Person"
                        //@"isPlural" : @(YES),
                }
        };
    });
    return overrides;
}

@end