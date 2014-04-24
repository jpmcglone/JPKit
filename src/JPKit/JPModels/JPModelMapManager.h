//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPModelMap.h"

@interface JPModelMapManager : NSObject

+ (JPModelMapManager *)sharedManager;

- (void)addModelMap:(JPModelMap *)map;
- (void)addModelMaps:(NSArray *)modelMaps;

- (void)removeModelWithKey:(NSString *)key;
- (void)removeModelsWithKeys:(NSArray *)keys;

- (JPModelMap *)mapForKey:(NSString *)key;

@end