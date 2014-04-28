//
// Created by JP McGlone on 4/19/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIView+JPKitAdditions_FrameShortcuts.h"
#import <objc/runtime.h>

static char const *const jp_initialFrameKey = "jp_initialFrame";
static char const *const jp_updatingFrameKey = "jp_updatingFrameKey";

@interface UIView ()
@property (nonatomic, assign) CGRect jp_initialFrame;
@property (nonatomic, assign) BOOL jp_updatingFrame;
@end

@implementation UIView (JPKitAdditions_FrameShortcuts)

#pragma mark - Frame shortcuts
#pragma mark - origin
- (CGPoint)jp_origin
{
    return self.frame.origin;
}

- (void)setJp_origin:(CGPoint)origin
{
    CGRect frame;
    [self jp_getUpdatingFrameIfNeeded:&frame];
    frame.origin = origin;
    [self jp_setUpdatingFrameIfNeeded:frame];
}

#pragma mark - size
- (CGSize)jp_size
{
    return self.frame.size;
}

- (void)setJp_size:(CGSize)size
{
    CGRect frame = self.frame;
    [self jp_getUpdatingFrameIfNeeded:&frame];
    frame.size = size;
    [self jp_setUpdatingFrameIfNeeded:frame];
}

#pragma mark - x
- (CGFloat)jp_x
{
    return self.jp_origin.x;
}

- (void)setJp_x:(CGFloat)x
{
    CGRect frame = self.frame;
    [self jp_getUpdatingFrameIfNeeded:&frame];
    frame.origin = CGPointMake(x, frame.origin.y);
    [self jp_setUpdatingFrameIfNeeded:frame];
}

#pragma mark - y
- (CGFloat)jp_y
{
    return self.frame.origin.y;
}

- (void)setJp_y:(CGFloat)y
{
    CGRect frame = self.frame;
    [self jp_getUpdatingFrameIfNeeded:&frame];
    frame.origin = CGPointMake(frame.origin.x, y);
    [self jp_setUpdatingFrameIfNeeded:frame];
}

#pragma mark - width
- (CGFloat)jp_width
{
    return self.bounds.size.width;
}

- (void)setJp_width:(CGFloat)width
{
    CGRect frame = self.frame;
    [self jp_getUpdatingFrameIfNeeded:&frame];
    frame.size = CGSizeMake(width, frame.size.width);
    [self jp_setUpdatingFrameIfNeeded:frame];
}

#pragma mark - height
- (CGFloat)jp_height
{
    return self.bounds.size.height;
}

- (void)setJp_height:(CGFloat)height
{
    CGRect frame = self.frame;
    [self jp_getUpdatingFrameIfNeeded:&frame];
    frame.size = CGSizeMake(frame.size.width, height);
    [self jp_setUpdatingFrameIfNeeded:frame];
}

#pragma mark - Frame alias helpers 
#pragma mark - top
- (CGFloat)jp_top
{
    return self.frame.origin.y;
}

- (void)setJp_top:(CGFloat)top
{
    self.jp_y = top;
}

#pragma mark - right
- (CGFloat)jp_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setJp_right:(CGFloat)right
{
    self.jp_x = right - self.jp_width;
}

#pragma mark - bottom
- (CGFloat)jp_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setJp_bottom:(CGFloat)bottom
{
    self.jp_y = bottom - self.jp_height;
}

#pragma mark - left
- (CGFloat)jp_left
{
    return self.frame.origin.x;
}

- (void)setJp_left:(CGFloat)left
{
    self.jp_x = left;
}

#pragma mark - JP Update Frames
#pragma mark - begin / end updates
- (void)jp_beginFrameUpdates
{
    self.jp_updatingFrame = YES;
    self.jp_initialFrame = self.frame;
}

- (void)jp_endFrameUpdates
{
    self.jp_updatingFrame = NO;
    self.frame = self.jp_initialFrame;
}

#pragma mark - jp_initialFrame
- (CGRect)jp_initialFrame
{
    return [objc_getAssociatedObject(self, jp_initialFrameKey) CGRectValue];
}

- (void)setJp_initialFrame:(CGRect)initialFrame
{
    objc_setAssociatedObject(self, jp_initialFrameKey, [NSValue valueWithCGRect:initialFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - jp_updatingFrame
- (BOOL)jp_updatingFrame
{
    return [objc_getAssociatedObject(self, jp_updatingFrameKey) boolValue];
}

- (void)setJp_updatingFrame:(BOOL)jp_updatingFrame
{
    objc_setAssociatedObject(self, jp_updatingFrameKey, [NSNumber numberWithBool:jp_updatingFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - internal
- (void)jp_getUpdatingFrameIfNeeded:(CGRect *)frame
{
    if (self.jp_updatingFrame) {
        *frame = self.jp_initialFrame;
    } else {
        *frame = self.frame;
    }
}

- (void)jp_setUpdatingFrameIfNeeded:(CGRect)frame
{
    if (self.jp_updatingFrame) {
        self.jp_initialFrame = frame;
    } else {
        self.frame = frame;
    }
}

@end