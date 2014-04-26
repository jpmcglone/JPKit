//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSDictionary *)propertyOverrides
{
    static NSDictionary *overrides = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        overrides = @{@"id" : @"personID"};
    });
    return overrides;
}

+ (NSDictionary *)arrayClasses
{
    static NSDictionary *arrayClasses = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        arrayClasses = @{@"parents" : [Person class]};
    });
    return arrayClasses;
}
@end