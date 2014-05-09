//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModel.h"
#import "UIView+JPKitAdditions_FrameShortcuts.h"

/**
 * This class allows you to set up your view's frame without actually making a view first.
 * When your view is connected and you're ready to set it, simply call 'commit'.  This 
 * method should work in an animation block as well. 
 * Set up as many layout models as you want, link them to your view(s), then commit away
 * and see them move! 
 */
@interface JPViewPlan : NSObject

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGAffineTransform transform;
@property (nonatomic, assign) CGFloat alpha;

// Helpers
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;

// Link a view to commit changes to
@property (nonatomic, weak) UIView *view;

// Also links the view
- (id)initWithView:(UIView *)view;

// Doesn't link a view
- (id)initWithFrame:(CGRect)frame;

// Applies the model to the view
- (void)commit;

@end
