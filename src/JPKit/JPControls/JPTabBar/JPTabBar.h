//
// Created by JP McGlone on 8/30/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPTabBarItem;
@class JPTabBar;
@protocol JPTabBarDelegate<NSObject>
@required
- (NSUInteger)numberOfItemsInTabBar:(JPTabBar *)tabBar;
- (JPTabBarItem *)tabBar:(JPTabBar *)tabBar itemAtIndex:(NSUInteger)index;
@optional
- (void)tabBar:(JPTabBar *)tabBar highlighted:(BOOL)highlighted atIndex:(NSUInteger)index;

- (BOOL)tabBar:(JPTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index;
- (NSUInteger)tabBar:(JPTabBar *)tabBar willSelectItemAtIndex:(NSUInteger)index;
- (void)tabBar:(JPTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index;

- (void)tabBar:(JPTabBar *)tabBar willDeselectItemAtIndex:(NSUInteger)index;
- (void)tabBar:(JPTabBar *)tabBar didDeselectItemAtIndex:(NSUInteger)index;

@end

@interface JPTabBar : UIView

@property (nonatomic, weak) id<JPTabBarDelegate> delegate;
@property (nonatomic, readonly) JPTabBarItem *selectedItem;
@property (nonatomic, readonly) NSArray *items;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, strong) UIView *backgroundView;

- (void)reload;
- (JPTabBarItem *)itemAtIndex:(NSUInteger)index;
- (void)selectItemAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfItem:(JPTabBarItem *)item;

@end