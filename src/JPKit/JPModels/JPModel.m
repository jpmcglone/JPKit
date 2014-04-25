//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModel.h"
#import "NSString+JPAdditions.h"
#import "JPModelMapManager.h"

@implementation JPModel

+ (NSDictionary *)template
{
    // Overwrite
    return nil;
}

+ (BOOL)hasPropertyWithKey:(NSString *)key
{
    SEL selector = NSSelectorFromString(key);
    return [self instancesRespondToSelector:selector];
}

- (void)createModelFromInfo:(id)info
{
    if ([info isKindOfClass:[NSDictionary class]]) {
        
        NSArray *keys = [info allKeys];
        for (NSString *key in keys) {
            NSString *propertyKey = [[self class] template][key] ?: key;
            if ([[self class] hasPropertyWithKey:propertyKey]) {
                id value = info[key];
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
    self = [super init];
    if (self) {
#ifdef JPDEBUG
        _info = info;
#endif
        [self createModelFromInfo:(id)info];
    }
    return self;
}

@end