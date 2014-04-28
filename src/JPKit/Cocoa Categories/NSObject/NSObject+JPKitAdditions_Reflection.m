//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSObject+JPKitAdditions_Reflection.h"
#import <objc/runtime.h>

@implementation NSObject (JPKitAdditions_Reflection)

+ (BOOL)jp_hasPropertyWithKey:(NSString *)key
{
    SEL selector = NSSelectorFromString(key);
    return [self instancesRespondToSelector:selector];
}

+ (NSString *)jp_typeNameFromRawPropertyType:(const char *)rawPropertyType
{
    if (strcmp(rawPropertyType, @encode(int)) == 0) return @"int";
    if (strcmp(rawPropertyType, @encode(BOOL)) == 0) return @"BOOL";
    if (strcmp(rawPropertyType, @encode(bool)) == 0) return @"bool";
    if (strcmp(rawPropertyType, @encode(short)) == 0) return @"short";
    if (strcmp(rawPropertyType, @encode(long)) == 0) return @"long";
    if (strcmp(rawPropertyType, @encode(long long)) == 0) return @"long long";
    if (strcmp(rawPropertyType, @encode(unsigned char)) == 0) return @"unsigned char";
    if (strcmp(rawPropertyType, @encode(unsigned int)) == 0) return @"unsigned int";
    if (strcmp(rawPropertyType, @encode(unsigned short)) == 0) return @"unsigned short";
    if (strcmp(rawPropertyType, @encode(unsigned long)) == 0) return @"unsigned long";
    if (strcmp(rawPropertyType, @encode(unsigned long long)) == 0) return @"unsigned long long";
    if (strcmp(rawPropertyType, @encode(float)) == 0) return @"float";
    if (strcmp(rawPropertyType, @encode(double)) == 0) return @"double";
    if (strcmp(rawPropertyType, @encode(id)) == 0) return @"id";
    if (strcmp(rawPropertyType, @encode(Class)) == 0) return @"Class";
    
    // If it is a struct, return the struct's type
    NSString *propertyType = [NSString stringWithCString:rawPropertyType
                                                encoding:[NSString defaultCStringEncoding]];
    
    // e.g. {CGPoint:ff} we don't care about the types in the struct
    NSString *pattern = @"\\{(\\w*)=";
    NSRange range = NSMakeRange(0, [propertyType length]);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:nil];
    NSArray *matches = [regex matchesInString:propertyType
                                      options:0
                                        range:range];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match rangeAtIndex:1];
        NSString* matchString = [propertyType substringWithRange:matchRange];
        return matchString;
    }    
    
    return nil;
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

    NSString *typeName = [self jp_typeNameFromRawPropertyType:rawPropertyType];
    if (typeName == nil && [typeAttribute hasPrefix:@"T@"]) {
        typeName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length] - 4)];
    }
    return typeName;
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