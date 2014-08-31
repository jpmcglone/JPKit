//
// Created by JP McGlone on 8/30/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSObject+JPKitAdditions_Tagging.h"
#import <objc/runtime.h>

@implementation NSObject (JPKitAdditions_Tagging)

- (void)setJp_tag:(id)jp_tag
{
    objc_setAssociatedObject(self, @"jp_tag", jp_tag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)jp_tag
{
    return objc_getAssociatedObject(self, @"jp_tag");
}

@end
