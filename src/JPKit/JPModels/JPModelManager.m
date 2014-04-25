//
// Created by JP McGlone on 4/24/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModelManager.h"
#import "JPModelMapManager.h"
#import "JPModel.h"

@implementation JPModelManager

+ (id)modelsFromJSON:(id)JSON
{
    JPModelMapManager *mapManager = [JPModelMapManager sharedManager];

    if ([JSON isKindOfClass:[NSDictionary class]]) {
        NSArray *allKeys = [JSON allKeys];
        NSMutableDictionary *other = [[NSMutableDictionary alloc] init];
        for (NSString *key in allKeys) {
            id info = JSON[key];
            JPModelMap *map = [mapManager mapForKey:key];
            if (map != nil) {
                Class aClass = map.aClass;
                if (map.isPlural) {
                    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[info count]];
                    for (id value in info) {
                        id obj = [[aClass alloc] initWithInfo:value];
                        [array addObject:obj];
                    }
                    other[key] = array;
                } else {
                    other[key] = [[aClass alloc] initWithInfo:info];
                }
            }
            else {
                id models = [[self class] modelsFromJSON:info];
                other[key] = models;
            }
        }
        return other;
    }
    else if ([JSON isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[JSON count]];
        for (id info in JSON) {
            id models = [[self class] modelsFromJSON:info];
            [array addObject:models];
        }
        return array;
    }
    else {
        return JSON;
    }
}
@end