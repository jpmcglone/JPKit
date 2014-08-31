//
// Created by JP McGlone on 8/30/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPTabBarItem.h"
#import "UILabel+JPKitAdditions.h"
#import "UIView+JPKitAdditions_FrameShortcuts.h"


@implementation JPTabBarItem

- (id)initWithReusableIdentifier:(NSString *)reusableIdentifier
{
    self = [self init];
    if (self) {
        _reusableIdentifier = reusableIdentifier;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createTitleLabel];
        [self createImageView];
    }
    return self;
}

- (void)createTitleLabel
{
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
}

- (void)createImageView
{
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
}

- (void)layoutSubviews
{
    BOOL hasText = _titleLabel.text;
    BOOL hasImage = _imageView.image;

    CGFloat margin = 5;
    CGFloat totalHeight = 0;
    CGFloat gap = 0;

    CGSize maxSize = CGRectInset(self.bounds, margin, margin).size;
    CGSize titleLabelSize;
    if (hasText) {
        titleLabelSize = [_titleLabel jp_sizeConstrainedToSize:maxSize];
        totalHeight += titleLabelSize.height;
    }
    if (hasImage) {
        // TODO
        totalHeight += 10;
    }
    if (hasText && hasImage) {
        totalHeight += gap;
    }

    if (hasText) {
        _titleLabel.frame = CGRectMake(
                (self.jp_width - titleLabelSize.width) * 0.5,
                (self.jp_height - totalHeight) * 0.5,
                titleLabelSize.width,
                titleLabelSize.height
        );
    }
}

@end