//
// Created by JP McGlone on 4/19/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JPKitAdditions_FrameShortcuts)

@property (nonatomic, readwrite) CGPoint jp_origin;
@property (nonatomic, readwrite) CGSize jp_size;

@property (nonatomic, readwrite) CGFloat jp_x;
@property (nonatomic, readwrite) CGFloat jp_y;
@property (nonatomic, readwrite) CGFloat jp_width;
@property (nonatomic, readwrite) CGFloat jp_height;

@property (nonatomic, readwrite) CGFloat jp_top;
@property (nonatomic, readwrite) CGFloat jp_right;
@property (nonatomic, readwrite) CGFloat jp_bottom;
@property (nonatomic, readwrite) CGFloat jp_left;

- (void)jp_beginFrameUpdates;
- (void)jp_endFrameUpdates;

- (void)jp_bringToFront;
- (void)jp_sendToBack;
// TODO: - (void)jp_bringForward;
// TODO: - (void)jp_sendBackward;

@end