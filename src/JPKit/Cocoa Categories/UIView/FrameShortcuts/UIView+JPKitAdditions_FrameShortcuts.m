//
// Created by JP McGlone on 4/19/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIView+JPKitAdditions_FrameShortcuts.h"
#import <objc/runtime.h>
#import "JPViewPlan.h"

static char const *const jp_viewPlanKey = "jp_viewPlanKey";
static char const *const jp_updatingFrameKey = "jp_updatingFrameKey";

@interface UIView ()
@property (nonatomic, assign) BOOL jp_updatingFrame;
@property JPViewPlan *jp_viewPlan;
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
    self.jp_viewPlan.origin = origin;
    [self commitViewPlanIfNotUpdating];
}

#pragma mark - size
- (CGSize)jp_size
{
    return self.frame.size;
}

- (void)setJp_size:(CGSize)size
{
    self.jp_viewPlan.size = size;
    [self commitViewPlanIfNotUpdating];
}

#pragma mark - x
- (CGFloat)jp_x
{
    return self.jp_origin.x;
}

- (void)setJp_x:(CGFloat)x
{
    self.jp_viewPlan.x = x;
    [self commitViewPlanIfNotUpdating];
}

#pragma mark - y
- (CGFloat)jp_y
{
    return self.frame.origin.y;
}

- (void)setJp_y:(CGFloat)y
{
    self.jp_viewPlan.y = y;
    [self commitViewPlanIfNotUpdating];
}

#pragma mark - width
- (CGFloat)jp_width
{
    return self.bounds.size.width;
}

- (void)setJp_width:(CGFloat)width
{
    self.jp_viewPlan.width = width;
    [self commitViewPlanIfNotUpdating];
}

#pragma mark - height
- (CGFloat)jp_height
{
    return self.bounds.size.height;
}

- (void)setJp_height:(CGFloat)height
{
    self.jp_viewPlan.height = height;
    [self commitViewPlanIfNotUpdating];
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
}

- (void)jp_endFrameUpdates
{
    self.jp_updatingFrame = NO;
    [self commitViewPlanIfNotUpdating];
}

#pragma mark - jp_viewPlan
- (JPViewPlan *)jp_viewPlan
{
    JPViewPlan *viewPlan = objc_getAssociatedObject(self, jp_viewPlanKey);
    if (viewPlan == nil) {
        self.jp_viewPlan = [[JPViewPlan alloc] initWithView:self];
        viewPlan = objc_getAssociatedObject(self, jp_viewPlanKey);
    }
    return viewPlan;
}

- (void)setJp_viewPlan:(JPViewPlan *)viewPlan
{
    objc_setAssociatedObject(self, jp_viewPlanKey, viewPlan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - jp_updatingFrame
- (BOOL)jp_updatingFrame
{
    return [objc_getAssociatedObject(self, jp_updatingFrameKey) boolValue];
}

- (void)setJp_updatingFrame:(BOOL)updatingFrame
{
    objc_setAssociatedObject(self, jp_updatingFrameKey, [NSNumber numberWithBool:updatingFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - internal
- (void)commitViewPlanIfNotUpdating
{
    if (!self.jp_updatingFrame) {
        [self.jp_viewPlan commit];
    }
}

@end