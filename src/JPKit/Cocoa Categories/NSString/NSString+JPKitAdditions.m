//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSString+JPKitAdditions.h"

@implementation NSString (JPKitAdditions)

- (NSDictionary *)jp_JSON
{
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:JSONData
                                                         options:0
                                                           error:nil];
    return JSON;
}

- (BOOL)jp_containsString:(NSString *)string
{
    return !NSEqualRanges([self rangeOfString:string], NSMakeRange(NSNotFound, 0));
}

@end