//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModelMapManager.h"

@implementation JPModelMapManager {
    NSMutableDictionary *maps_;
}

+ (JPModelMapManager *)sharedManager
{
    static JPModelMapManager *sharedManager = nil;
    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        sharedManager = [[JPModelMapManager alloc] init];
    });

    return sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        maps_ = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addModelMap:(JPModelMap *)map
{
    if (![map isEqual:[NSNull null]]) {
        maps_[map.key] = map;
    }
}

- (void)addModelMaps:(NSArray *)modelMaps
{
    for (JPModelMap *map in modelMaps) {
        [self addModelMap:map];
    }
}

- (void)removeModelWithKey:(NSString *)key
{
    //TODO
}

- (void)removeModelsWithKeys:(NSArray *)keys
{
    for (NSString *key in keys) {
        [self removeModelWithKey:key];
    }
}

- (JPModelMap *)mapForKey:(NSString *)key
{
    return maps_[key];
}

@end