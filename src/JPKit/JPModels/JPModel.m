//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModel.h"
#import <objc/runtime.h>
#import "NSObject+JPKitAdditions_Reflection.h"

@implementation JPModel

- (void)createModelFromInfo:(id)info
{
    if ([info isKindOfClass:[NSDictionary class]]) {
        NSArray *keys = [info allKeys];
        for (NSString *key in keys) {
            NSString *propertyKey = [[self class] specs][key][@"name"] ?: key;
            if ([[self class] jp_hasPropertyWithKey:propertyKey]) {
                id value = info[key];
                Class propertyClass = [[self class] jp_classForPropertyKey:propertyKey];
                if ([JPModel jp_isOrPrecedesClass:propertyClass]) {
                    value = [(JPModel *)[propertyClass alloc] initWithInfo:value];
                } else if ([value isKindOfClass:[NSArray class]]&& [NSArray jp_isOrPrecedesClass:propertyClass]) {
                    NSString *classString = [[self class] specs][key][@"class"] ?: nil;
                    Class objClass = NSClassFromString(classString);
                    if (objClass != nil) {
                        NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:[value count]];
                        for (id i in value) {
                            id obj = [(JPModel *)[objClass alloc] initWithInfo:i];
                            [newArray addObject:obj];
                        }
                        value = newArray;
                    }
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

+ (NSDictionary *)specs
{
    static NSMutableDictionary *overrideMaps = nil;
    if (!overrideMaps) {
        overrideMaps = [[NSMutableDictionary alloc] init];
    }
    Class<NSCopying> c = [self class];
    if (overrideMaps[c] == nil) {
        NSDictionary *overrides = [self overrides];
        if (overrides) {
            overrideMaps[c] = overrides;
        }
    }
    return overrideMaps[c];
}

+ (NSDictionary *)overrides
{
    return nil;
}

@end