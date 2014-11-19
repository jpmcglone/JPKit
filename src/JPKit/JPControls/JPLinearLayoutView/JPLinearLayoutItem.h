//
// Created by JP McGlone on 11/15/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JPLinearLayoutAlignment) {
    // Both
            JPLinearLayoutAlignmentCenter,

    // Horizontal
            JPLinearLayoutAlignmentLeft,
            JPLinearLayoutAlignmentRight,

    // Vertical - purely semantic
            JPLinearLayoutAlignmentTop = JPLinearLayoutAlignmentLeft,
            JPLinearLayoutAlignmentBottom = JPLinearLayoutAlignmentRight
};

@interface JPLinearLayoutItem : NSObject

+ (JPLinearLayoutItem *)itemForView:(UIView *)view weight:(CGFloat)weight;

+ (JPLinearLayoutItem *)itemForView:(UIView *)view;
+ (JPLinearLayoutItem *)itemWithWeight:(CGFloat)weight;

- (id)initWithView:(UIView *)view;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, assign) UIEdgeInsets margin; // defaults to UIEdgeInsetsZero

// Only used when there's a view
@property (nonatomic, assign) JPLinearLayoutAlignment alignment; //defaults to center

// Only used when there's no view
@property (nonatomic, assign) CGFloat weight;

@property (nonatomic, assign) BOOL autoSizes; // defaults to YES

@end