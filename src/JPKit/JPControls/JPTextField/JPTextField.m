//
// Created by JP McGlone on 9/28/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPTextField.h"
#import "UIView+JPKitAdditions.h"
#import <objc/runtime.h>

#define kGap 10

@implementation JPTextField {
    UIImageView *_imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
    [self setNeedsDisplay];
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

- (CGSize)imageSize
{
    if (!_image) {
        return CGSizeZero;
    }
    CGFloat width = self.jp_height * 0.5;
    return CGSizeMake(width, width);
}

- (CGRect)adjustRectForImageAndInsets:(CGRect)rect
{
    rect = CGRectFromEdgeInsets(rect, _edgeInsets);
    
    CGSize imageSize = [self imageSize];
    if (imageSize.height == 0 || imageSize.width == 0) {
        return rect;
    }

    rect.size.width -= (imageSize.width + kGap);
    rect.origin.x += (imageSize.width + kGap);

    return rect;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    return [self adjustRectForImageAndInsets:rect];
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    return [self adjustRectForImageAndInsets:rect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize imageSize = [self imageSize];
    _imageView.jp_size = imageSize;
    _imageView.jp_left = _edgeInsets.left;
    _imageView.jp_centerY = self.jp_middle.y - 0.5 * (_edgeInsets.top + _edgeInsets.bottom);
}

- (CGSize)sizeThatFits:(CGSize)size
{
    // adjust for insets
    size.height -= (_edgeInsets.top + _edgeInsets.bottom);
    size.width -= (_edgeInsets.left + _edgeInsets.right);

    CGSize theSize = [super sizeThatFits:size];

    theSize.height += _edgeInsets.top + _edgeInsets.bottom;
    theSize.width += _edgeInsets.left + _edgeInsets.right;

    return theSize;
}

@end