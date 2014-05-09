//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPViewPlan.h"

@implementation JPViewPlan

- (id)init
{
    self = [super init];
    if (self) {
        _alpha = 1.0;
        _transform = CGAffineTransformIdentity;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (id)initWithView:(UIView *)view
{
    self = [self initWithFrame:view.frame];
    if (self) {
        self.view = view;
        _alpha = view.alpha;
        _transform = view.transform;
    }
    return self;
}

#pragma mark - x
- (CGFloat)x
{
    return self.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(x, frame.origin.y);
    self.frame = frame;
}

#pragma mark - y
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(frame.origin.x, y);
    self.frame = frame;
}

#pragma mark - width
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size = CGSizeMake(width, frame.size.width);
    self.frame = frame;
}

#pragma mark - height
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size = CGSizeMake(frame.size.width, height);
    self.frame = frame;
}


#pragma mark - origin
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

#pragma mark - size
- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - Frame alias helpers
#pragma mark - top
- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

#pragma mark - right
- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right
{
    self.x = right - self.width;
}

#pragma mark - bottom
- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}

#pragma mark - left
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

#pragma mark - commit
- (void)commit
{
    self.view.frame = _frame;
}

@end