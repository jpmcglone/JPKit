//
// Created by JP McGlone on 2/10/15.
// Copyright (c) 2015 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JPKitAdditions)

// Defaults: animated -> YES
- (void)jp_scrollToTopAnimated:(BOOL)animated;
- (void)jp_scrollToTop;

- (void)jp_scrollToBottomAnimated:(BOOL)animated;
- (void)jp_scrollToBottom;

- (void)jp_scrollToLeftAnimated:(BOOL)animated;
- (void)jp_scrollToLeft;

- (void)jp_scrollToRightAnimated:(BOOL)animated;
- (void)jp_scrollToRight;

// Defaults: margin -> 10 , animated -> YES
- (void)jp_scrollToView:(UIView *)view margin:(CGFloat)margin vertical:(BOOL)vertical animated:(BOOL)animated;
- (void)jp_scrollToView:(UIView *)view margin:(CGFloat)margin animated:(BOOL)animated;
- (void)jp_scrollToView:(UIView *)view animated:(BOOL)animated;
- (void)jp_scrollToView:(UIView *)view margin:(CGFloat)margin;
- (void)jp_scrollToView:(UIView *)view;

@end