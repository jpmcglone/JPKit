//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModel.h"
#import <objc/runtime.h>
#import "NSObject+JPAdditions_Reflection.h"

@implementation JPModel

+ (NSDictionary *)template
{
    // Overwrite
    return nil;
}

- (void)createModelFromInfo:(id)info
{
    if ([info isKindOfClass:[NSDictionary class]]) {

        NSArray *keys = [info allKeys];
        for (NSString *key in keys) {
            NSString *propertyKey = [[self class] template][key] ?: key;
            if ([[self class] jp_hasPropertyWithKey:propertyKey]) {
                id value = info[key];
                Class propertyClass = [[self class] jp_classForPropertyKey:propertyKey];
                if ([JPModel jp_isOrPrecedesClass:propertyClass]) {
                    value = [[propertyClass alloc] initWithInfo:value];
                }
                [self setValue:value
                        forKey:propertyKey];
            } else {
                if (_other == nil) {
                    _other = [[NSMutableDictionary alloc] init];
                }
                _other[key] = info[key];
            }
        }
    }
    else {
        _other = info;
    }
}

- (id)initWithInfo:(id)info
{
    self = [self init];
    if (self) {
#ifdef JPDEBUG
        _info = info;
#endif
        [self createModelFromInfo:(id)info];
    }
    return self;
}

@end