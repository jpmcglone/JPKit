//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSObject+JPAdditions_Reflection.h"
#import <objc/runtime.h>

@implementation NSObject (JPAdditions_Reflection)

+ (BOOL)jp_hasPropertyWithKey:(NSString *)key
{
    SEL selector = NSSelectorFromString(key);
    return [self instancesRespondToSelector:selector];
}

+ (NSString *)jp_typeNameForPropertyKey:(NSString *)propertyKey
{
    objc_property_t property = class_getProperty(
            [self class],
            [propertyKey cStringUsingEncoding:[NSString defaultCStringEncoding]]
    );
    const char *type = property_getAttributes(property);

    NSString *typeString = [NSString stringWithUTF8String:type];
    NSArray *attributes = [typeString componentsSeparatedByString:@","];
    NSString *typeAttribute = [attributes objectAtIndex:0];
    NSString *propertyType = [typeAttribute substringFromIndex:1];
    const char *rawPropertyType = [propertyType UTF8String];

    if (strcmp(rawPropertyType, @encode(float)) == 0) {
        return @"float";
    } else if (strcmp(rawPropertyType, @encode(int)) == 0) {
        return @"int";
    } else if (strcmp(rawPropertyType, @encode(BOOL)) == 0) {
        return @"BOOL";
    } else if (strcmp(rawPropertyType, @encode(char)) == 0) {
        return @"char";
    } else if (strcmp(rawPropertyType, @encode(id)) == 0) {
        return @"id";
    } else if (strcmp(rawPropertyType, @encode(Point)) == 0) {
        return @"Point";
    } else {
        // According to Apples Documentation you can determine the corresponding encoding values
    }

    if ([typeAttribute hasPrefix:@"T@"]) {
        NSString *typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length] - 4)];
        return typeClassName;
    }
    return nil;
}

+ (Class)jp_classForPropertyKey:(NSString *)propertyKey
{
    NSString *typeClassName = [self jp_typeNameForPropertyKey:propertyKey];
    return NSClassFromString(typeClassName);
}

+ (BOOL)jp_isOrPrecedesClass:(Class)class
{
    Class c = class;
    while (c != [self class] && (c = class_getSuperclass(c)));
    return c == [self class];
}

@end