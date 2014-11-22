//
// Created by JP McGlone on 9/28/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPTextField.h"
#import "UIView+JPKitAdditions.h"
#import <objc/runtime.h>

@implementation JPTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return self;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
}

- (void)resetPlaceholderColor
{
    if (_placeholderColor && self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : _placeholderColor}];
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = [placeholderColor copy];
    [self resetPlaceholderColor];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    [self resetPlaceholderColor];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    return CGRectFromEdgeInsets(rect, _edgeInsets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    return CGRectFromEdgeInsets(rect, _edgeInsets);
}

@end