//
// Created by JP McGlone on 4/27/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (JPKitAdditions_LayerShortcuts)

@property (nonatomic, assign) CGFloat jp_cornerRadius;
@property (nonatomic, strong) UIColor *jp_borderColor;
@property (nonatomic, assign) CGFloat jp_borderWidth;
@property (nonatomic, assign) BOOL jp_masksToBounds;

@end