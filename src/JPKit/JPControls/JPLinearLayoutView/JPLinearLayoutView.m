//
// Created by JP McGlone on 11/15/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPLinearLayoutView.h"
#import "JPLinearLayoutItem.h"
#import "UIView+JPKitAdditions_FrameShortcuts.h"
#import "UIView+JPKitAdditions.h"

@implementation JPLinearLayoutView {
    NSArray *_oldItems;
}

- (void)removeOldItems
{
    // TODO: animate?
    for(JPLinearLayoutItem *item in _oldItems) {
        [item.view removeFromSuperview];
    }
    _oldItems = nil;
}

-(void)addNewItems
{
    // TODO: animate
    for(JPLinearLayoutItem *item in _items) {
        if (item.view) {
            [self addSubview:item.view];
        }
    }
}

- (void)refresh
{
    [self removeOldItems];
    [self addNewItems];
    [self internalLayoutSubviews];
    // TODO: animate all of this O_O
}

- (CGFloat)calculatedWeightSum
{
    if (_weightSum > 0) {
        return _weightSum;
    }

    CGFloat weightSum = 0;
    for(JPLinearLayoutItem *item in _items) {
        weightSum += item.weight;
    }
    return weightSum;
}

- (void)setItems:(NSArray *)items
{
    _oldItems = _items;
    _items = items;
    [self refresh];
}

- (void)setWeightSum:(CGFloat)weightSum
{
    _weightSum = weightSum;
    [self refresh];
}

- (void)internalLayoutSubviews
{
    // Vertical
    // TODO: horizontal
    CGFloat weightSum = [self calculatedWeightSum];
    CGFloat selfHeight = self.contentSize.height - _padding.top - _padding.bottom;
    CGFloat totalPositiveSpace = 0;

    CGRect constrainedRect = CGRectZero;
    constrainedRect.size = self.contentSize;
    constrainedRect = CGRectFromEdgeInsets(constrainedRect, _padding);

    for (JPLinearLayoutItem *item in _items) {
        if (item.view) {
            CGAffineTransform transform = item.view.transform;
            CATransform3D layerTransform = item.view.layer.transform;
            item.view.transform = transform;
            item.view.layer.transform = layerTransform;

            if (item.autoSizes) {
                item.view.jp_size = [item.view sizeThatFits:constrainedRect.size];
            }

            item.view.transform = transform;
            item.view.layer.transform = layerTransform;

            if (item.weight > 0) {
                totalPositiveSpace += item.weight * selfHeight / weightSum;
            } else {
                totalPositiveSpace += item.view.jp_height + item.margin.top + item.margin.bottom;
            }
        }
    }

    CGFloat totalNegativeSpace = selfHeight - totalPositiveSpace;

    CGFloat offset = _padding.top;
    for (JPLinearLayoutItem *item in _items) {
        CGFloat calculatedHeight = item.weight > 0 ? item.weight * totalNegativeSpace / weightSum : item.view.jp_height;
        offset += item.margin.top;

        if (item.view) {
            if (item.weight > 0) {
                item.view.jp_height = calculatedHeight;
            }
            item.view.jp_y = offset;

            switch(item.alignment) {
                case JPLinearLayoutAlignmentLeft:
             // case JPLinearLayoutAlignmentTop:
                    item.view.jp_x = _padding.left + item.margin.left;
                    break;
                case JPLinearLayoutAlignmentRight:
             // case JPLinearLayoutAlignmentBottom:
                    item.view.jp_right = self.contentSize.width - _padding.right - item.margin.right;
                    break;
                case JPLinearLayoutAlignmentCenter:
                default:
                    item.view.center = CGPointMake(self.contentSize.width * 0.5, item.view.center.y);
            }
        }
        offset += calculatedHeight;
        offset += item.margin.bottom;
    }
}

@end