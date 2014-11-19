//
// Created by JP McGlone on 11/15/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPLinearLayoutItem.h"

@implementation JPLinearLayoutItem

+ (JPLinearLayoutItem *)itemForView:(UIView *)view weight:(CGFloat)weight
{
    JPLinearLayoutItem *item = [[JPLinearLayoutItem alloc] init];
    item.view = view;
    item.weight = weight;
    item.autoSizes = YES;
    return item;
}

+ (JPLinearLayoutItem *)itemWithWeight:(CGFloat)weight
{
    return [self itemForView:nil weight:weight];
}

+ (JPLinearLayoutItem *)itemForView:(UIView *)view
{
    return [self itemForView:view weight:0];
}

- (id)initWithView:(UIView *)view
{
    self = [self init];
    if (self) {
        _view = view;
    }
    return self;
}

@end