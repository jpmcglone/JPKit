//
// Created by JP McGlone on 9/21/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (JPKitAdditions)

- (void)jp_presentInView:(UIView *)inView animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)jp_presentInView:(UIView *)view animated:(BOOL)animated;
- (void)jp_presentInView:(UIView *)view;
- (void)jp_present;

- (void)jp_dismissAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)jp_dismissAnimated:(BOOL)animated;
- (void)jp_dismiss;

@end