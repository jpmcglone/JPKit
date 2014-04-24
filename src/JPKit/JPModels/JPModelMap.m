//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModelMap.h"
#import "NSString+JPAdditions.h"

@implementation JPModelMap

+ (NSArray *)mapsWithSingularKey:(NSString *)singularKey
                       pluralKey:(NSString *)pluralKey
                           class:(Class)aClass
{
    NSMutableArray *maps = [[NSMutableArray alloc] init];

    JPModelMap *singularMap;
    JPModelMap *pluralMap;
    if (singularKey) {
        singularMap = [[JPModelMap alloc] initWithKey:singularKey
                                                class:aClass
                                             isPlural:NO];
    }

    if (pluralKey) {
        pluralMap = [[JPModelMap alloc] initWithKey:pluralKey
                                              class:aClass
                                           isPlural:YES];
    }

    [maps addObject:singularMap ?: [NSNull null]];
    [maps addObject:pluralMap ?: [NSNull null]];
    return [maps copy];
}

- (id)initWithJSON:(NSDictionary *)JSON
{
    /* examples:
     * @{@"key":@"person",
     *   @"class":@"Person"};
     *
     * @(@"key":@"people",
     *   @"class":@"Person",
     *   @"isPlural":@(YES)};
     */
    NSString *key = JSON[@"key"];
    Class aClass = NSClassFromString(JSON[@"class"]);
    BOOL isPlural = [JSON[@"isPlural"] boolValue];

    return [self initWithKey:key
                       class:aClass
                    isPlural:isPlural];
}

- (id)initWithKey:(NSString *)key
            class:(Class)aClass
         isPlural:(BOOL)isPlural
{
    self = [super init];

    if (self) {
        self.key = key;
        self.aClass = aClass;
        self.isPlural = isPlural;
    }
    return self;
}

@end