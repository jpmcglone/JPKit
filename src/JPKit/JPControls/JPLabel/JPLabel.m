//
//  JPLabel.m
//  JPKit
//
//  Created by JP McGlone on 1/24/15.
//  Copyright (c) 2015 JP McGlone. All rights reserved.
//

#import "JPLabel.h"

@implementation JPLabel

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _edgeInsets)];
}

@end
