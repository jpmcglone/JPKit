//
// Created by JP McGlone on 9/21/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIViewController+JPNavigationController.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (JPKitAdditions)

@property (nonatomic, assign) BOOL jp_showsNavigationBar; // tells a JPNavigationController whether or not to show the navigation bar

- (void)jp_endEditing;

- (void)jp_presentInView:(UIView *)inView animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)jp_presentInView:(UIView *)view animated:(BOOL)animated;
- (void)jp_presentInView:(UIView *)view;
- (void)jp_present;

- (void)jp_dismissAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)jp_dismissAnimated:(BOOL)animated;
- (void)jp_dismiss;

@end