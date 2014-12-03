//
// Created by JP McGlone on 11/15/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JPLinearLayoutViewOrientation) {
    JPLinearLayoutViewOrientationVertical,
    JPLinearLayoutViewOrientationHorizontal
};

typedef NS_ENUM(NSUInteger, JPLinearLayoutViewMode) {
    JPLinearLayoutViewModeNormal,
    JPLinearLayoutViewModeFitted
};

@interface JPLinearLayoutView : UIScrollView

@property (nonatomic, assign) UIEdgeInsets padding; // around the whole view

@property (nonatomic, assign) JPLinearLayoutViewMode mode; // defaults to normal
@property (nonatomic, assign) JPLinearLayoutViewOrientation *orientation; // defaults to vertical
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) CGFloat weightSum; // set to 0 for automatic mode that uses the items weights intelligently

- (void)refresh;

@end