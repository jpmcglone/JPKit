//
// Created by JP McGlone on 4/27/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIView+JPKitAdditions_LayerShortcuts.h"


@implementation UIView (JPKitAdditions_LayerShortcuts)

#pragma mark - borderColor
- (void)setJp_borderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)jp_borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

#pragma mark - borderWidth
- (void)setJp_borderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)jp_borderWidth
{
    return self.layer.borderWidth;
}

#pragma mark - masksToBounds
- (void)setJp_masksToBounds:(BOOL)masksToBounds
{
    self.layer.masksToBounds = masksToBounds;
}

- (BOOL)jp_masksToBounds
{
    return self.layer.masksToBounds;
}

#pragma mark - cornerRadius
- (void)setJp_cornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)jp_cornerRadius
{
    return self.layer.cornerRadius;
}

@end