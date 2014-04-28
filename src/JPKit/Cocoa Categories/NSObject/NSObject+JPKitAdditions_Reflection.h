//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JPKitAdditions_Reflection)

+ (BOOL)jp_hasPropertyWithKey:(NSString *)key;

+ (NSString *)jp_typeNameForPropertyKey:(NSString *)propertyKey;

+ (Class)jp_classForPropertyKey:(NSString *)propertyKey;

+ (BOOL)jp_isOrPrecedesClass:(Class)class;

@end