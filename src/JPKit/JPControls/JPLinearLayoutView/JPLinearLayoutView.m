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
    // TODO: not stretched. stacked.
    BOOL vertical = _orientation == JPLinearLayoutViewOrientationVertical;

    CGFloat weightSum = [self calculatedWeightSum];

    CGFloat selfMax = vertical ?
            self.contentSize.height - _padding.top - _padding.bottom :
            self.contentSize.width - _padding.left - _padding.right;

    CGFloat totalPositiveSpace = 0;

    CGRect constrainedRect = CGRectZero;
    constrainedRect.size = self.contentSize;
    constrainedRect = CGRectFromEdgeInsets(constrainedRect, _padding);

    for (JPLinearLayoutItem *item in _items) {
        if (item.view) {
            if (item.autoSizes) {
                item.view.jp_size = [item.view sizeThatFits:constrainedRect.size];
            }
            if (item.weight > 0) {
                totalPositiveSpace += item.weight * selfMax / weightSum;
            } else {
                totalPositiveSpace += vertical ?
                        item.view.jp_height + item.margin.top + item.margin.bottom :
                        item.view.jp_width + item.margin.left + item.margin.right;
            }
        }
    }

    CGFloat totalNegativeSpace = selfMax - totalPositiveSpace;

    CGFloat offset = _padding.top;
    for (JPLinearLayoutItem *item in _items) {
        // TODO: optimize
        CGFloat length = vertical ? item.view.jp_height : item.view.jp_width;
        CGFloat calculatedLength = item.weight > 0 ? item.weight * totalNegativeSpace / weightSum : length;
        offset += vertical ? item.margin.top : item.margin.left;

        if (item.view) {
            if (item.weight > 0) {
                if (vertical) {
                    item.view.jp_height = calculatedLength;
                } else {
                    item.view.jp_width = calculatedLength;
                }
            }

            if (vertical) {
                item.view.jp_y = offset;
            } else {
                item.view.jp_x = offset;
            }

            switch(item.alignment) {
                case JPLinearLayoutAlignmentLeft:
             // case JPLinearLayoutAlignmentTop:
                    if (vertical) {
                        item.view.jp_x = _padding.left + item.margin.left;
                    } else {
                        item.view.jp_y = _padding.top + item.margin.top;
                    }
                    break;
                case JPLinearLayoutAlignmentRight:
             // case JPLinearLayoutAlignmentBottom:
                    if (vertical) {
                        item.view.jp_right = self.contentSize.width - _padding.right - item.margin.right;
                    } else {
                        item.view.jp_bottom = self.contentSize.height - _padding.bottom - item.margin.bottom;
                    }
                    break;
                case JPLinearLayoutAlignmentStretch:
                    if (vertical) {
                        item.view.jp_width = self.jp_width - _padding.left - _padding.right - item.margin.left - item.margin.right;
                        item.view.jp_left = _padding.left + item.margin.left;
                    } else {
                        item.view.jp_height = self.jp_height - _padding.top - _padding.bottom - item.margin.top - item.margin.bottom;
                        item.view.jp_left = _padding.top + item.margin.top;
                    }
                    break;
                case JPLinearLayoutAlignmentCenter:
                default:
                    // TODO: take padding into consideration?
                    if (vertical) {
                        item.view.center = CGPointMake(self.contentSize.width * 0.5, item.view.center.y);
                    } else {
                        item.view.center = CGPointMake(item.view.center.y, self.contentSize.height * 0.5);
                    }
            }
        }
        offset += calculatedLength;
        offset += vertical ? item.margin.bottom : item.margin.right;
    }
}

@end