//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSDictionary *)template
{
    static NSDictionary *template = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        template = @{@"id":@"personID"};
    });
    return template;
}

@end