//
// Created by JP McGlone on 8/30/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPTabBar.h"
#import "JPTabBarItem.h"
#import "UIView+JPKitAdditions_FrameShortcuts.h"

@implementation JPTabBar {
    NSMutableArray *_items;
    BOOL _needsToLayout;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        self.multipleTouchEnabled = NO;
    }
    return self;
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
        [item addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [item addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        [_items addObject:item];
    }
    _needsToLayout = YES;
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
}

- (void)layoutSubviews
{
    if (_needsToLayout) {
        CGFloat width = self.jp_width / _items.count;
        for (NSUInteger i = 0; i < _items.count; i++) {
            JPTabBarItem *item = _items[i];
            item.frame = CGRectMake(i * width, 0, width, self.jp_height);
        }
        _needsToLayout = NO;
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"highlighted"]) {
        if ([self.delegate respondsToSelector:@selector(tabBar:highlighted:item:atIndex:)]) {
            BOOL highlighted = [change[@"new"] boolValue];
            BOOL old = [change[@"old"] boolValue];
            if (highlighted == old) {
                return;
            }
            NSLog(@"%@", change);
            JPTabBarItem *tabBarItem = object;
            NSUInteger index = [_items indexOfObject:tabBarItem];
            [self.delegate tabBar:self highlighted:highlighted item:tabBarItem atIndex:index];
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

@end