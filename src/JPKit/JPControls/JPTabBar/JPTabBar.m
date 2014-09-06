//
// Created by JP McGlone on 8/30/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPTabBar.h"
#import "JPTabBarItem.h"
#import "UIView+JPKitAdditions.h"

@implementation JPTabBar {
    NSMutableArray *_items;
    BOOL _needsToLayout;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.multipleTouchEnabled = NO;
    }
    return self;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    _needsToLayout = YES;
    [self setNeedsLayout];
}

- (NSArray *)items {
    return _items;
}
- (void)selectItemAtIndex:(NSUInteger)index
{
    [self selectItem:_items[index]];
}

- (void)removeAllItems
{
    [_items removeAllObjects];
}

- (void)reload
{
    NSUInteger numberOfItems = [self.delegate numberOfItemsInTabBar:self];
    for (NSUInteger i = 0; i < numberOfItems; i++) {
        JPTabBarItem *item = [self.delegate tabBar:self itemAtIndex:i];
        item.exclusiveTouch = YES;
        [item addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [item addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        [_items addObject:item];
    }
    _needsToLayout = YES;
}

- (JPTabBarItem *)itemAtIndex:(NSUInteger)index
{
    return _items[index];
}

- (void)deselectSelectedItem
{
    if ([self.delegate respondsToSelector:@selector(tabBar:willDeselectItemAtIndex:)]) {
        [self.delegate tabBar:self willDeselectItemAtIndex:index];
    }
    _selectedItem.selected = NO;
    _selectedItem = nil;
}

- (void)selectItem:(JPTabBarItem *)item
{
    NSUInteger index = [_items indexOfObject:item];
    BOOL shouldSelect = YES;
    if ([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]) {
        shouldSelect = [self.delegate tabBar:self shouldSelectItemAtIndex:index];
        if (!shouldSelect) {
            return;
        }
    }

    item.highlighted = NO;
    item.selected = YES;
    _selectedItem = item;
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    [_backgroundView removeFromSuperview];
    _backgroundView = backgroundView;
    [self addSubview:_backgroundView];
    [self layoutBackgroundView];
}

- (void)layoutBackgroundView
{
    _backgroundView.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_needsToLayout) {
        [self layoutBackgroundView];
        CGFloat width = self.jp_width / _items.count;
        for (NSUInteger i = 0; i < _items.count; i++) {
            JPTabBarItem *item = _items[i];
            CGRect frame = CGRectMake(i * width, 0, width, self.jp_height);;
            item.frame = CGRectFromEdgeInsets(frame, _edgeInsets);
        }
        _needsToLayout = NO;
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"highlighted"]) {
        if ([self.delegate respondsToSelector:@selector(tabBar:highlighted:atIndex:)]) {
            BOOL highlighted = [change[@"new"] boolValue];
            BOOL old = [change[@"old"] boolValue];
            if (highlighted == old) {
                return;
            }
            JPTabBarItem *tabBarItem = object;
            NSUInteger index = [_items indexOfObject:tabBarItem];
            [self.delegate tabBar:self highlighted:highlighted atIndex:index];
        }
    } else if([keyPath isEqualToString:@"selected"]) {
        BOOL selected = [change[@"new"] boolValue];
        JPTabBarItem *tabBarItem = object;
        NSUInteger index = [_items indexOfObject:tabBarItem];

        if (selected) {
            if ([self.delegate respondsToSelector:@selector(tabBar:willSelectItemAtIndex:)]) {
                index = [self.delegate tabBar:self willSelectItemAtIndex:index];
            }

            // TODO: if (index != _selectedIndex) {
            // TODO: will deselect?
            [self deselectSelectedItem];

            if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
                [self.delegate tabBar:self didSelectItemAtIndex:index];
            }

            // TODO: else do nothing?
        } else {
            // TODO:
            if ([self.delegate respondsToSelector:@selector(tabBar:didDeselectItemAtIndex:)]) {
                [self.delegate tabBar:self didDeselectItemAtIndex:index];
            }
        }
    }
}

- (NSUInteger)indexOfItem:(JPTabBarItem *)item
{
    return [_items indexOfObject:item];
}

@end