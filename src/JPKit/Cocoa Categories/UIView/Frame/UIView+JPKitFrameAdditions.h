//
// Created by JP McGlone on 4/19/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JPKitFrameAdditions)

@property(nonatomic, readwrite) CGPoint origin;
@property(nonatomic, readwrite) CGSize size;

@property(nonatomic, readwrite) CGFloat x;
@property(nonatomic, readwrite) CGFloat y;
@property(nonatomic, readwrite) CGFloat width;
@property(nonatomic, readwrite) CGFloat height;

@property(nonatomic, readwrite) CGFloat top;
@property(nonatomic, readwrite) CGFloat right;
@property(nonatomic, readwrite) CGFloat bottom;
@property(nonatomic, readwrite) CGFloat left;

@end