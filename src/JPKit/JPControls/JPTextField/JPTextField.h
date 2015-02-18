//
// Created by JP McGlone on 9/28/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPTextField : UITextField

// image is always made square
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, copy) UIColor *placeholderColor;

@end