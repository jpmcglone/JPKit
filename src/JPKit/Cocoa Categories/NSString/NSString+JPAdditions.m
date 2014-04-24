//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSString+JPAdditions.h"

@implementation NSString (JPAdditions)

- (NSDictionary *)JSON
{
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:JSONData
                                                         options:0
                                                           error:nil];
    return JSON;
}

@end