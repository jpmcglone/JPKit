//
// Created by JP McGlone on 9/18/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIView+JPKitAdditions.h"
#import "UIScrollView+JPKitAdditions.h"

@implementation UIView (JPKitAdditions)

+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    if (delay == 0 && duration == 0) {
        if (animations) {
            animations();
        }
        if (completion) {
            completion(YES);
        }
    } else {
        [UIView animateWithDuration:duration delay:delay options:options animations:animations completion:completion];
    }
}
+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    [self jp_animateWithDuration:duration delay:delay options:0 animations:animations completion:completion];
}

+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations
{
    [self jp_animateWithDuration:duration delay:delay animations:animations completion:nil];
}

+ (void)jp_animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    [self jp_animateWithDuration:duration delay:0 options:0 animations:animations completion:completion];
}

+ (void)jp_animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations
{
    [self jp_animateWithDuration:duration animations:animations completion:nil];
}

- (UIView *)jp_oldestAncestorOfClass:(Class)theClass
{
    UIView *ancestorWithClass = nil;
    UIView *view = self;
    do {
        if ([view isKindOfClass:theClass]) {
            ancestorWithClass = view;
        }
        view = view.superview;
    } while (view);

    return ancestorWithClass;
}

- (UIView *)jp_youngestAncestorOfClass:(Class)theClass
{
    UIView *view = self;
    do {
        if ([view isKindOfClass:theClass]) {
            return view;
        }
        view = view.superview;
    } while (view);

    return nil;
}

- (void)_jp_addAllSubviewsToArray:(NSMutableArray *)array fromView:(UIView *)view
{
    if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) {
        [array addObject:view];
        return; // Subviews of a first responder being a first responder? I'm not sure we need this.
    }

    NSArray *subviews = view.subviews;
    for (UIView *subview in subviews) {
        [self _jp_addAllSubviewsToArray:array fromView:subview];
    }
}

- (NSComparisonResult)_jp_yValuesCompare:(UIView *)otherView ascending:(BOOL)ascending {
    CGFloat y = [self convertRect:self.frame toView:nil].origin.y;
    CGFloat otherY = [self convertRect:otherView.frame toView:nil].origin.y;

    if (ascending) {
        return [@(y) compare:@(otherY)];
    } else {
        return [@(otherY) compare:@(y)];
    }
}

- (NSComparisonResult)_jp_ascendingYValuesCompare:(UIView *)otherView {
    return [self _jp_yValuesCompare:otherView ascending:YES];
}

- (NSComparisonResult)_jp_descendingYValuesCompare:(UIView *)otherView {
    return [self _jp_yValuesCompare:otherView ascending:NO];
}

- (void)jp_goToNextFirstResponder
{
    UIView *nextFirstResponder = self.jp_nextFirstResponder;
    if (nextFirstResponder) {
        [nextFirstResponder becomeFirstResponder];
    } else {
        UIView *firstResponder = self.jp_firstResponder;
        [self endEditing:YES];
        UIScrollView *scrollView = [firstResponder jp_youngestAncestorOfClass:[UIScrollView class]];
        if (scrollView) {
            [scrollView jp_scrollToBottom];
        }
    }
}

- (void)jp_goToPreviousFirstResponder
{
    UIView *previousFirstResponder = self.jp_previousFirstResponder;
    if (previousFirstResponder) {
        [previousFirstResponder becomeFirstResponder];
    } else {
        UIView *firstResponder = self.jp_firstResponder;
        [self endEditing:YES];
        UIScrollView *scrollView = [firstResponder jp_youngestAncestorOfClass:[UIScrollView class]];
        if (scrollView) {
            [scrollView jp_scrollToTop];
        }
    }
}

- (NSMutableArray *)_jp_allSubviewsOfView:(UIView *)view
{
    NSMutableArray *allSubviews = [[NSMutableArray alloc] init];
    [self _jp_addAllSubviewsToArray:allSubviews fromView:self];
    return allSubviews;
}

- (UIView *)jp_nextFirstResponder
{
    UIView *firstResponder = self.jp_firstResponder;
    NSMutableArray *sortedSubviews = [[self _jp_allSubviewsOfView:self] sortedArrayUsingSelector:@selector(_jp_ascendingYValuesCompare:)];
    NSUInteger index = 0;
    if (firstResponder) {
      index = [sortedSubviews indexOfObject:self.jp_firstResponder];
    }
    if (sortedSubviews.count - 1 > index) {
        return sortedSubviews[index+1];
    }
    return nil;
}

- (UIView *)jp_previousFirstResponder
{
    UIView *firstResponder = self.jp_firstResponder;
    NSMutableArray *sortedSubviews = [[self _jp_allSubviewsOfView:self] sortedArrayUsingSelector:@selector(_jp_descendingYValuesCompare:)];
    NSUInteger index = 0;
    if (firstResponder) {
        index = [sortedSubviews indexOfObject:self.jp_firstResponder];
    }

    if (sortedSubviews.count - 1 > index) {
        return sortedSubviews[index+1];
    }
    return nil;
}

- (UIView *)jp_firstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subview in self.subviews) {
        UIView *responder = [subview jp_firstResponder];
        if (responder) return responder;
    }
    return nil;
}

@end