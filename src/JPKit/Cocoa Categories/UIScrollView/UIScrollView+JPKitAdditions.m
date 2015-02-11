//
// Created by JP McGlone on 2/10/15.
// Copyright (c) 2015 JP McGlone. All rights reserved.
//

#import "UIScrollView+JPKitAdditions.h"
#import "UIView+JPKitAdditions_FrameShortcuts.h"

@implementation UIScrollView (JPKitAdditions)

- (void)jp_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.contentOffset.x, 0) animated:animated];
}
- (void)jp_scrollToTop
{
    [self jp_scrollToTopAnimated:YES];
}

- (void)jp_scrollToBottomAnimated:(BOOL)animated
{
    if (self.contentSize.height <= self.jp_height) {
        return;
    }
    CGFloat y = self.contentSize.height - self.jp_height;
    [self setContentOffset:CGPointMake(self.contentOffset.x, y) animated:animated];
}

- (void)jp_scrollToBottom
{
    [self jp_scrollToBottomAnimated:YES];
}

- (void)jp_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0, self.contentOffset.y) animated:animated];
}

- (void)jp_scrollToLeft
{
    [self jp_scrollToLeftAnimated:YES];
}

- (void)jp_scrollToRightAnimated:(BOOL)animated
{
    if (self.contentSize.width <= self.jp_width) {
        return;
    }
    CGFloat x = self.contentSize.height - self.jp_width;
    [self setContentOffset:CGPointMake(x, self.contentOffset.y) animated:animated];
}

- (void)jp_scrollToRight
{
    [self jp_scrollToRightAnimated:YES];
}

- (void)jp_scrollToView:(UIView *)view margin:(CGFloat)margin vertical:(BOOL)vertical animated:(BOOL)animated
{
    CGRect frameInScrollView = [view convertRect:view.bounds toView:self];
    if (vertical) {
        CGFloat y = CGRectGetMaxY(frameInScrollView) + margin - (self.jp_height - self.contentInset.bottom);
        y = y < 0 ? 0 : y;
        [self setContentOffset:CGPointMake(self.contentOffset.x, y) animated:animated];
    } else {
        CGFloat x = CGRectGetMaxX(frameInScrollView) + margin - (self.jp_width - self.contentInset.right);
        x = x < 0 ? 0 : x;
        [self setContentOffset:CGPointMake(x, self.contentOffset.y) animated:animated];
    }
}

- (void)jp_scrollToView:(UIView *)view margin:(CGFloat)margin animated:(BOOL)animated
{
    [self jp_scrollToView:view margin:margin vertical:YES animated:animated];
}

- (void)jp_scrollToView:(UIView *)view animated:(BOOL)animated
{
    [self jp_scrollToView:view margin:10 animated:animated];
}

- (void)jp_scrollToView:(UIView *)view margin:(CGFloat)margin
{
    [self jp_scrollToView:view margin:margin animated:YES];
}

- (void)jp_scrollToView:(UIView *)view
{
    [self jp_scrollToView:view animated:YES];
}

@end