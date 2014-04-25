//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModel.h"
#import <objc/runtime.h>

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

+ (Class)classForPropertyKey:(NSString *)propertyKey
{
    objc_property_t property = class_getProperty(
            [self class],
            [propertyKey cStringUsingEncoding:[NSString defaultCStringEncoding]]
    );
    const char *type = property_getAttributes(property);
    
    NSString * typeString = [NSString stringWithUTF8String:type];
    NSArray * attributes = [typeString componentsSeparatedByString:@","];
    NSString * typeAttribute = [attributes objectAtIndex:0];
    NSString * propertyType = [typeAttribute substringFromIndex:1];
    const char * rawPropertyType = [propertyType UTF8String];
    
    if (strcmp(rawPropertyType, @encode(float)) == 0) {
        //return @"float";
    } else if (strcmp(rawPropertyType, @encode(int)) == 0) {
        //return @"int";
    } else if (strcmp(rawPropertyType, @encode(id)) == 0) {
        //return @"id";
    } else {
        // According to Apples Documentation you can determine the corresponding encoding values
    }
    
    if ([typeAttribute hasPrefix:@"T@"]) {
        NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];
        Class typeClass = NSClassFromString(typeClassName);
        return typeClass;
    }
    return nil;
}

+ (BOOL)isOrPrecedesClass:(Class)class
{
    Class c = class;
    while(c != [self class] && (c = class_getSuperclass(c)));
    return c == [self class];
}

- (void)createModelFromInfo:(id)info
{
    if ([info isKindOfClass:[NSDictionary class]]) {
        
        NSArray *keys = [info allKeys];
        for (NSString *key in keys) {
            NSString *propertyKey = [[self class] template][key] ?: key;
            if ([[self class] hasPropertyWithKey:propertyKey]) {
                id value = info[key];
                Class propertyClass = [[self class] classForPropertyKey:propertyKey];
                if ([JPModel isOrPrecedesClass:propertyClass]) {
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