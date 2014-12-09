//
// Created by JP McGlone on 9/18/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIView+JPKitAdditions.h"

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

- (id)jp_firstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subview in self.subviews) {
        id responder = [subview jp_firstResponder];
        if (responder) return responder;
    }
    return nil;
}

@end