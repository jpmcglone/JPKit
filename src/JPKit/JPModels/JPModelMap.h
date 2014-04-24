//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPModelMap : NSObject

+ (NSArray *)mapsWithSingularKey:(NSString *)singularKey
                       pluralKey:(NSString *)pluralKey
                           class:(Class)aClass;

@property (nonatomic, copy) NSString *key;

// YES is an array of aClass objects, NO is just an aClass object
@property (nonatomic, assign) BOOL isPlural;

@property (nonatomic, assign) Class aClass;

- (id)initWithJSON:(NSDictionary *)JSON;
- (id)initWithKey:(NSString *)key
            class:(Class)aClass
         isPlural:(BOOL)isPlural;

@end