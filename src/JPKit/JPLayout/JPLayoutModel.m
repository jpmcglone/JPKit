//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPLayoutModel.h"

@implementation JPLayoutModel

- (id)init
{
    self = [super init];
    if (self) {
        _transform = CGAffineTransformIdentity;
    }
    return self;
}

- (id)initWithRect:(CGRect)rect
{
    self = [self init];
    if (self) {
        _frame = rect;
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
    CGRect frame;
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
    self.view.transform = _transform;
}

@end