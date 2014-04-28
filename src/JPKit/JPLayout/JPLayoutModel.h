//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModel.h"
#import "UIView+JPKitAdditions_FrameShortcuts.h"

/**
 * This class allows you to set up your view's frame without actually making a view.
 * When your view is connected and you're ready to set it, simply call 'commit'.  This 
 * method should work in an animation block as well. 
 * Set up as many layout models as you want, link them to your view(s), then commit away
 * and see them move! 
 */
@interface JPLayoutModel : NSObject

// Supported in JSON serialization
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

// Not supported in JSON serialization
// TODO: make it not break if someone tries to serialize these
@property (nonatomic, assign) CGRect frame;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGAffineTransform transform;

@property (nonatomic, weak) UIView *view;

- (id)initWithRect:(CGRect)rect;

// Applies the model to the view
- (void)commit;

@end